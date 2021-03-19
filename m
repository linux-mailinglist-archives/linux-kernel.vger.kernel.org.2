Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF31A341169
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 01:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhCSATs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 20:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232421AbhCSATj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 20:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616113178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2V2pQj02pPAgifyXEGeju01snHtnruCBK7rlJYcZE5Y=;
        b=QdD/Hb0dyYpBQnUCmAsefaykzkQXul4orssuwNknwq/V83uSmxqDNflS3DeA7VRarWt2nU
        HOMxsqmShqgIJgRPsGYIQAhZfRC3aa8bEok3kPpUK+a4slz7oUzZ2iE342w3uyo8KBPrTm
        hgcuoc2wiv5/zo8Q3Y/8bq+srek/XSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-x7RB7LyyPJKFTjltZtcf1A-1; Thu, 18 Mar 2021 20:19:37 -0400
X-MC-Unique: x7RB7LyyPJKFTjltZtcf1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D267814256;
        Fri, 19 Mar 2021 00:19:35 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04BA660C13;
        Fri, 19 Mar 2021 00:19:33 +0000 (UTC)
Date:   Thu, 18 Mar 2021 19:19:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <20210319001931.f5uqd42agkvkxlnc@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
 <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
 <20210318004917.sytcivxy5h2ujttc@treble>
 <YFNOH1m+FrFK8TRN@hirez.programming.kicks-ass.net>
 <20210318163640.5u6rucdk66aodun7@treble>
 <YFOIGYblhHTqp/fa@hirez.programming.kicks-ass.net>
 <20210318173842.55rwasdbqlfx7a2i@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318173842.55rwasdbqlfx7a2i@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:38:42PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:04:25PM +0100, Peter Zijlstra wrote:
> > On Thu, Mar 18, 2021 at 11:36:40AM -0500, Josh Poimboeuf wrote:
> > > > I was thinking you could get a section changed without touching
> > > > relocations, but while that is theoretically possible, it is exceedingly
> > > > unlikely (and objtool doesn't do that).
> > > 
> > > Hm?  This is a *relocation* section, not a normal one.  So by
> > > definition, it only changes when its relocations change.
> > 
> > The way I read this code:
> > 
> >  	list_for_each_entry(sec, &elf->sections, list) {
> >  		if (sec->changed) {
> > +			if (sec->reloc &&
> > +			    elf_rebuild_reloc_section(elf, sec->reloc)) {
> > +				WARN_ELF("elf_rebuild_reloc_section");
> > +				return -1;
> > +			}
> > 
> > is that we iterate the regular sections (which could be dirtied because
> > we changed some data), and if that section has a relocation section, we
> > rebuild that for good measure (even though it might not have altered
> > relocations).
> > 
> > Or am I just totally confused ?
> 
> Ah, you're right.  I'm the one that's confused.  I guess I was also
> confused when I wrote that hunk, but it just happens to work anyway.
> 
> It would be cleaner to do something like
> 
> 			if ((is_reloc_sec(sec) &&	
> 			    elf_rebuild_reloc_section(elf, sec)) {
> 
> so we process the changed reloc section directly, instead of relying on
> the (most likely) fact that the corresponding text section also changed.

i.e., in actual code:

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 66c49c2e20a6..3b3d19a5e626 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -948,8 +948,7 @@ int elf_write(struct elf *elf)
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
-			if (sec->reloc &&
-			    elf_rebuild_reloc_section(elf, sec->reloc)) {
+			if (sec->base && elf_rebuild_reloc_section(elf, sec)) {
 				WARN_ELF("elf_rebuild_reloc_section");
 				return -1;
 			}

