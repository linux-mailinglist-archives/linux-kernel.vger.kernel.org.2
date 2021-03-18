Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDB833FC61
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCRAql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhCRAqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616028383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsl2J/7tfHLnsgGQ2/BfzqOCUj0BNFOfLD1ez79dkKw=;
        b=SShBES1un0Phsqgivi/y5qpPOJwZ0nooPQGMkdsrZJt5VNvEXPuvyip+KayL/4wbDb8w8p
        ku4DCS4mdXj1J3ebkBcxsZbixYYuF+w+f7J/y4I4TRxCMWqCENnurxJwkmFAEaATUPVwH1
        9SdEAi+p1GZUpMoUXLnOg8XXFtGl8gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-l6h6ssXmPCKr8TLy6mTuOw-1; Wed, 17 Mar 2021 20:46:19 -0400
X-MC-Unique: l6h6ssXmPCKr8TLy6mTuOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B81CA180FCA2;
        Thu, 18 Mar 2021 00:46:18 +0000 (UTC)
Received: from treble (ovpn-112-220.rdu2.redhat.com [10.10.112.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48A135D6AC;
        Thu, 18 Mar 2021 00:46:17 +0000 (UTC)
Date:   Wed, 17 Mar 2021 19:46:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miroslav Benes <mbenes@suse.cz>, x86@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] objtool: Add elf_create_undef_symbol()
Message-ID: <20210318004614.thfvkh3oickkgk4q@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.710872453@infradead.org>
 <alpine.LSU.2.21.2103171444570.23081@pobox.suse.cz>
 <YFIOl/3NcnnV0jDa@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFIOl/3NcnnV0jDa@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 03:13:43PM +0100, Peter Zijlstra wrote:
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
> 
> What toolchain generates these extended sections and how? That is, how
> do I test this crud..

SHN_XINDEX is basically a special-case extension to original ELF for
supporting more than 64k sections.

-- 
Josh

