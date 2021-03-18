Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C943C340BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCRRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhCRRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616089131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cMYW+qc72OvUFSAB97G4d4IWQScq6KutjhVdo/e9mI=;
        b=ZkBvEpuUw/zVvRywPf+FoGT/qS3V4gUjc2XQjUorNh/TPp0ez5N/q1DVCvI75M/24dA4jc
        ydDE9AmlrYAkjBbNlEaTGL2/gKNACltbIzERn/MNmKhEnOQiMUtZdse+6XEq6xRWEQ2nvt
        NbuszpYZS3Cqg8mjXmiYJ3sa4+F/mDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-2IgyQOhsP4mZoEadaGvSPA-1; Thu, 18 Mar 2021 13:38:48 -0400
X-MC-Unique: 2IgyQOhsP4mZoEadaGvSPA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43B40801817;
        Thu, 18 Mar 2021 17:38:46 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD8F75D9C6;
        Thu, 18 Mar 2021 17:38:44 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:38:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <20210318173842.55rwasdbqlfx7a2i@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
 <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
 <20210318004917.sytcivxy5h2ujttc@treble>
 <YFNOH1m+FrFK8TRN@hirez.programming.kicks-ass.net>
 <20210318163640.5u6rucdk66aodun7@treble>
 <YFOIGYblhHTqp/fa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFOIGYblhHTqp/fa@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:04:25PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 18, 2021 at 11:36:40AM -0500, Josh Poimboeuf wrote:
> > > I was thinking you could get a section changed without touching
> > > relocations, but while that is theoretically possible, it is exceedingly
> > > unlikely (and objtool doesn't do that).
> > 
> > Hm?  This is a *relocation* section, not a normal one.  So by
> > definition, it only changes when its relocations change.
> 
> The way I read this code:
> 
>  	list_for_each_entry(sec, &elf->sections, list) {
>  		if (sec->changed) {
> +			if (sec->reloc &&
> +			    elf_rebuild_reloc_section(elf, sec->reloc)) {
> +				WARN_ELF("elf_rebuild_reloc_section");
> +				return -1;
> +			}
> 
> is that we iterate the regular sections (which could be dirtied because
> we changed some data), and if that section has a relocation section, we
> rebuild that for good measure (even though it might not have altered
> relocations).
> 
> Or am I just totally confused ?

Ah, you're right.  I'm the one that's confused.  I guess I was also
confused when I wrote that hunk, but it just happens to work anyway.

It would be cleaner to do something like

			if ((is_reloc_sec(sec) &&	
			    elf_rebuild_reloc_section(elf, sec)) {

so we process the changed reloc section directly, instead of relying on
the (most likely) fact that the corresponding text section also changed.

-- 
Josh

