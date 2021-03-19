Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A231341824
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCSJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCSJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:23:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB162C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DJFcbKcT5dhNG/TQ4sVBcDU1msFLt/rR78fhe3zugu0=; b=OI8ZJ5sHX/qXfEFEe8J0uTkqD6
        BW9xaalmu0O+sQrKkJ19RO+a7BmNrBmKjRCvapH8u/cnhLwQoQJsr+jjV90FU/m1MsWj4uXRVZWnH
        kdZJ/sdM3oEjrkXsB6pIFQCpCZFaXQhroaSmVq2mojp7ND58QLCYuLbHp5pd+ZDigl6tDprGDfuAz
        1q2LSNcib1+18WGXc05pX/KAF5E8XY2Qu46S98iTQgY/UIZRtT7g/Er4NyK8+wm8xtD3MC7UdMK3y
        54dmmWWgvpA0TD8gQyPeuKAe9/I/EaHxoAnowfvniIEeObDmvrZiMw+pvoD3rmOiC8DM2pEiIHJPp
        ar+JWMZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNBLL-006wiq-Mg; Fri, 19 Mar 2021 09:22:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBE483006E0;
        Fri, 19 Mar 2021 10:22:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D09AB2B4C3BDE; Fri, 19 Mar 2021 10:22:54 +0100 (CET)
Date:   Fri, 19 Mar 2021 10:22:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <YFRtbkM9jA9iCWQm@hirez.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318173842.55rwasdbqlfx7a2i@treble>
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

Indeed. Done.

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -814,6 +814,11 @@ struct section *elf_create_reloc_section
 	}
 }
 
+static inline bool is_reloc_section(struct section *reloc)
+{
+	return reloc->base && reloc->base->reloc == reloc;
+}
+
 static int elf_rebuild_rel_reloc_section(struct section *sec, int nr)
 {
 	struct reloc *reloc;
@@ -948,7 +953,7 @@ int elf_write(struct elf *elf)
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
-			if (sec->reloc &&
+			if (is_reloc_section(sec) &&
 			    elf_rebuild_reloc_section(elf, sec->reloc)) {
 				WARN_ELF("elf_rebuild_reloc_section");
 				return -1;
