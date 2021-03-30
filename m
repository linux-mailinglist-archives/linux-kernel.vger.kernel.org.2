Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E2434EB72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhC3PCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:02:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:57544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232271AbhC3PCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:02:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617116533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHJFXXCQfPF0s5VK69HhwHUUUg6FuGiZ78eVYwe8crc=;
        b=J34ZoPKbSbm1/AhxTH2LgxBRLlmDlSX3NnD4VYpbP+TW2XwBXS4wJ+sTcsIVY2J3PPqJwC
        sPKZFang50+H8/SnyGTq/XyaQHaSqn19VhuAzUym3jw/vPh0pcD2B0yAv8xTpACCSJwUzh
        hs4pdG4u1pETcV3taqk9ZN6DNFmUkws=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 552FBB30E;
        Tue, 30 Mar 2021 15:02:13 +0000 (UTC)
Date:   Tue, 30 Mar 2021 17:02:13 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.com>
X-X-Sender: mbenes@pobox.suse.cz
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/16] x86,objtool: Optimize !RETPOLINE
In-Reply-To: <20210326151159.128534163@infradead.org>
Message-ID: <alpine.LSU.2.21.2103301644250.11007@pobox.suse.cz>
References: <20210326151159.128534163@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021, Peter Zijlstra wrote:

> Hi, another week, another update :-)
> 
> Respin of the !RETPOLINE optimization patches.
> 
> Boris, the first 3 should probably go into tip/x86/core, it's an ungodly tangle
> since it relies on the insn decoder patches in tip/x86/core, the NOP patches in
> tip/x86/cpu and the alternative patches in tip/x86/alternatives.
> 
> Just to make life easy I'd suggest merging everything in x86/core and
> forgetting about the other topic branches (that's what I ended up doing locally).
> 
> The remaining 13 patches depend on the first 3 as well as on the work in
> tip/objtool/core, just to make life more interesting still ;-)
> 
> All except the last 4 patches should be fairly uncontroversial (I hope...).
> 
> There's a fair number of new patches and another few have been completely
> rewritten, but it all seems to work nicely.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

for the objtool changes. All looks much better in this version.

I have only one minor thing. There are only two call sites of 
elf_add_string(). The one in elf_create_section() passes shstrtab, the 
other one in elf_create_undef_symbol() NULL. elf_add_string() then 
retrieves it itself. I think it would be nicer to just call 
find_section_by_name() in elf_create_undef_symbol(), pass it down and make 
it consistent. Might be a matter of taste.

Miroslav
