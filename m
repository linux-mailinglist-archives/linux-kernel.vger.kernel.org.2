Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E442CB2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhJMUlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229496AbhJMUlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634157572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UdI4k1G2xXQGGaDcm9O/XqTUCkeBotStzWD8zREaWSs=;
        b=MObN1WaAyaxvL79IOUUfjItTzDMzkGhrXcNKMSJvQ9uvVBSxf2Kggu9p5H0C1quK4deUSv
        n9L6gVqCbDkFEZTA0P1gcjTByrn7Y5yYUnFNvzhBafk41u8Mxwx01Vh3weMw+ZiiiQmxd0
        ITsVfj4KF1qIIM7L71PetQwWT9jpQKk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-gln0uujhMdGHxtAF8WZbmw-1; Wed, 13 Oct 2021 16:39:30 -0400
X-MC-Unique: gln0uujhMdGHxtAF8WZbmw-1
Received: by mail-oo1-f70.google.com with SMTP id u1-20020a4a6141000000b002b6d25c0103so1710017ooe.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdI4k1G2xXQGGaDcm9O/XqTUCkeBotStzWD8zREaWSs=;
        b=u/kGCA6kJCudZUin2/BBAIGgByVgGBxJOr3eUZGe9IMymbA6aC4Cig9o+HuHFHEZQK
         bnzGXHX9z7fs1OLpaQNZd+DHHn2236U+8TG+yROaxuFiG3TU+GxDZD5aliXaq3892j3X
         qvJ45e+A0lrN2BekvgeC3vay2nDOYkGUpFr0hYS+xa746Nj4YSa+agJfOv3v50j9GZsv
         MI9b2apuuA8kPpEUaikLF4VnbANF/qKFISvHTYwQNp+zySD9Bk5EoPdWDD7kMYv0edv1
         BgHn9clFl5ONjQLkTEjEnJgkJSGa3tYb1lL252+EdN8cJEHDsOwXBy6uaG2Jd8kZt27l
         RYcw==
X-Gm-Message-State: AOAM531hyMdGWTC7jVrEY1xRhP+AUj5dTYlJ48QS6P5CaGaXDDIL38fz
        YIXn7mfoyvD6kk+7Wo81/6AsHyHhnG6905eoruR3xf+YHOvBWppIKmvc3o+WynZYYxmkSv9C0iY
        EDR0FM6XHJWI5bpkC7IUrX0DE
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr1202464otg.147.1634157569987;
        Wed, 13 Oct 2021 13:39:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCuros2c5L43sNgHCDSJ3/7zPzaFVGKhxB8sgb1X0c7zEDyC8/G1xc2w59I3TvRaOej7Oyag==
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr1202447otg.147.1634157569760;
        Wed, 13 Oct 2021 13:39:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o8sm127626otk.76.2021.10.13.13.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:39:29 -0700 (PDT)
Date:   Wed, 13 Oct 2021 13:39:27 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211013203927.zbruy2ux7dug6ljk@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013123645.002402102@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> +{
> +	void (*target)(void);
> +	int reg, i = 0;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> +		return -1;

Better to do this check further up the call stack in apply_retpolines()
before looping through all the call sites?

> +
> +	target = addr + insn->length + insn->immediate.value;
> +	reg = (target - &__x86_indirect_thunk_rax) /
> +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> +
> +	if (WARN_ON_ONCE(reg & ~0xf))
> +		return -1;

It would be more robust and less magical to just have a basic lookup
table array which converts a thunk address to a reg.  Then you can just
avoid all the safety checks because it's no longer insane ;-)

-- 
Josh

