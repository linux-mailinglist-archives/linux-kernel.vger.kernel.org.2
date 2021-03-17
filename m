Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151B633F327
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhCQOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:40:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232163AbhCQOkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:40:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACA4FAD74;
        Wed, 17 Mar 2021 14:39:59 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:39:59 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com
Subject: Re: [PATCH 6/9] objtool: Add elf_create_undef_symbol()
In-Reply-To: <YFIOl/3NcnnV0jDa@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2103171539270.23081@pobox.suse.cz>
References: <20210312171613.533405394@infradead.org> <20210312171653.710872453@infradead.org> <alpine.LSU.2.21.2103171444570.23081@pobox.suse.cz> <YFIOl/3NcnnV0jDa@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021, Peter Zijlstra wrote:

> On Wed, Mar 17, 2021 at 02:52:23PM +0100, Miroslav Benes wrote:
> 
> > > +	if (!elf_symbol_add(elf, sym, SHN_XINDEX)) {
> > > +		WARN("elf_symbol_add");
> > > +		return NULL;
> > > +	}
> > 
> > SHN_XINDEX means that the extended section index is used. Above you seem 
> > to use it in the opposite sense too (assigning to shndx when shndx_data is 
> > NULL). While it makes the code easier to handle, it is a bit confusing 
> > (and maybe I am just confused now). Could you add a comment about that, 
> > please? elf_symbol_add() seems like a good place.
> 
> Yes, that was a horrible thing to do :/ And you understood it right.
> 
> Looking at it again, I'm not sure it is actually correct tho; shouldn't
> elf_create_undef_symbol() also look at gelf_getsymshndx() of symtab ?

Probably yes.
 
> What toolchain generates these extended sections and how? That is, how
> do I test this crud..

Sami might know.

Miroslav
