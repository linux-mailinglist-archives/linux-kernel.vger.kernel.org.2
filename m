Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B38340AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhCRREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhCRREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:04:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67535C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Xe7zwmlgGzSOHd/wCg1g8Gl8QpxPFqOs1EqrRyWaFg=; b=OL/6ipAcXHtNK8oK9oZ0RUCAoA
        ZaIOKrX0j6vihHNCkDAbR/e48uADSFKmxmWJ0crz1HrL+yPoO0kDpOIFL0GcA0QagRzyKVCtPbYMe
        dIwL+6ZPy8YQiHWXuxJw/0y1zyzD6UIMTm0XNUB3s169xSXpeZ4tUm8QKOs+wt7Fi7JiyRZ71EYWp
        k+CIz+PvtqyVIMHAPZxGeqOz0rPuOQPZTE4dUeYCQR5lvcRivFDKGw98PUIyXH4oaWWT6JLxymh5o
        uG5JhmMYJ7XnK0j085IKJgBBGVPiEtSaVNIg0FftjQBVCfRYTDO18qEGb22BD+Vx58VUjt8xJnh85
        3Xbp0KVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMw4Q-005eRl-57; Thu, 18 Mar 2021 17:04:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6827E305C10;
        Thu, 18 Mar 2021 18:04:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4DBA720D38741; Thu, 18 Mar 2021 18:04:25 +0100 (CET)
Date:   Thu, 18 Mar 2021 18:04:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <YFOIGYblhHTqp/fa@hirez.programming.kicks-ass.net>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
 <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
 <20210318004917.sytcivxy5h2ujttc@treble>
 <YFNOH1m+FrFK8TRN@hirez.programming.kicks-ass.net>
 <20210318163640.5u6rucdk66aodun7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318163640.5u6rucdk66aodun7@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:36:40AM -0500, Josh Poimboeuf wrote:
> > I was thinking you could get a section changed without touching
> > relocations, but while that is theoretically possible, it is exceedingly
> > unlikely (and objtool doesn't do that).
> 
> Hm?  This is a *relocation* section, not a normal one.  So by
> definition, it only changes when its relocations change.

The way I read this code:

 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
+			if (sec->reloc &&
+			    elf_rebuild_reloc_section(elf, sec->reloc)) {
+				WARN_ELF("elf_rebuild_reloc_section");
+				return -1;
+			}

is that we iterate the regular sections (which could be dirtied because
we changed some data), and if that section has a relocation section, we
rebuild that for good measure (even though it might not have altered
relocations).

Or am I just totally confused ?
