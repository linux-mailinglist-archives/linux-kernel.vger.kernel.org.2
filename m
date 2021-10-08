Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53296426EF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhJHQbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhJHQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cktPHwlIBduk1qQVHtfl/KFOQmkbO6KNVrz0QKkt91g=;
        b=SeddzSHOlXcy8jgLujPgODzbH2TA4O4rIHAdCyfi1CQpIGEyzN1sfTNYEbG4Lmh2nyEQy+
        BeCimx3QlDoo285PpGwQ+Ld2UggmXbUlpw1OdnIuy1HdQZbQzjwemoucVv38PWAvHbZr/2
        yUc0PRGRPAbPTcricMyMkdXzDmBDIjk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-cA56lQxTM7WPFeczoVrfcg-1; Fri, 08 Oct 2021 12:28:29 -0400
X-MC-Unique: cA56lQxTM7WPFeczoVrfcg-1
Received: by mail-oi1-f200.google.com with SMTP id i1-20020aca2b01000000b0027684cd508cso5738516oik.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cktPHwlIBduk1qQVHtfl/KFOQmkbO6KNVrz0QKkt91g=;
        b=wh8KXHOJhUGp4drlxIVwIlTtBp6QBKdjHI8C2Nff9A8sPeS1Y6KvremO57f5vUzjas
         tQi1WlN9FL7wZBW7DzFUW9Y9qIM3eFKZH+E9UXR6jIaNBNoNXpQpoPdMh2UZLJ2igIES
         au3kwaaZJbvmXX2mpqVJj4ve/gB+BbaxhfirjC0zGMeaOO0vRWyoj2A9BaHtEa0k3RVs
         ZMJbVdzXQKYhrk7Bc3c7qKa3FI7dsiAoisq7prf40qUfop4SUh85j3eJBYoW4gogbgmt
         v5u+EJMYJlZqqiczJVh72kcLyCwS+B1gcPPo8Clh3JuYbbcn/26q/SFPQyvLFlPJsUrv
         XS9g==
X-Gm-Message-State: AOAM531X3MAWNtMXNwRnfYZhfHHTt/G6mhEPns3xCfd7CBxRHTWL9799
        QcbAEd+Bwjz9O1cSzn/1wDwv2oXJpSa7Xkd1CKYNsnV4dYk/djpSHwki1XfScwyWFT2c9LWagOd
        2PGADIMIMO0ZBGiYj1NZLgBkz
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr8034484oiy.169.1633710508681;
        Fri, 08 Oct 2021 09:28:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkA5uy58Xhmtao8Geu63nTK1ydF+t8XY9oicv5BwA74nDAJhaBqK3GejSGZEKjXx0By48i5Q==
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr8034462oiy.169.1633710508428;
        Fri, 08 Oct 2021 09:28:28 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id q39sm750898oiw.47.2021.10.08.09.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:28:28 -0700 (PDT)
Date:   Fri, 8 Oct 2021 09:28:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 1/2] objtool: Optimize re-writing jump_label
Message-ID: <20211008162825.7gdqriaxxbeyylwa@treble>
References: <20211007212211.366874577@infradead.org>
 <20211007212626.950220936@infradead.org>
 <20211008065550.zge5zkbfrki5osv2@treble>
 <YWAXc2bhu/iTI4pv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWAXc2bhu/iTI4pv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:03:31PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 07, 2021 at 11:55:50PM -0700, Josh Poimboeuf wrote:
> > On Thu, Oct 07, 2021 at 11:22:12PM +0200, Peter Zijlstra wrote:
> > > There's no point to re-write the jump_label NOP when it's already a NOP.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  tools/objtool/check.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -1397,7 +1397,7 @@ static int handle_jump_alt(struct objtoo
> > >  		return -1;
> > >  	}
> > >  
> > > -	if (special_alt->key_addend & 2) {
> > > +	if ((special_alt->key_addend & 2) && orig_insn->type != INSN_NOP) {
> > >  		struct reloc *reloc = insn_reloc(file, orig_insn);
> > >  
> > >  		if (reloc) {
> > 
> > While you're at it, a comment would be very helpful for that whole
> > clause.
> 
> Like so?
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1397,7 +1397,16 @@ static int handle_jump_alt(struct objtoo
>  		return -1;
>  	}
>  
> -	if (special_alt->key_addend & 2) {
> +	/*
> +	 * When, for whatever reason, the jump-label site cannot emit a right
> +	 * sized NOP, then it can use Bit-1 of the struct static_key pointer to
> +	 * indicate this instruction should be NOP'ed by objtool.
> +	 *
> +	 * Also see arch/x86/include/asm/jump_label.h:arch_static_branch(),
> +	 * where we leave the assembler to pick between jmp.d8 and jmp.d32
> +	 * based on destination offset.
> +	 */
> +	if ((special_alt->key_addend & 2) && orig_insn->type != INSN_NOP) {
>  		struct reloc *reloc = insn_reloc(file, orig_insn);
>  
>  		if (reloc) {
> 

Much better!  Can you also mention why it's checking INSN_NOP?  The "run
objtool twice" case is far from obvious.

-- 
Josh

