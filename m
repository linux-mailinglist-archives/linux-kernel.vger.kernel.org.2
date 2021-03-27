Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4334B3BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhC0C0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhC0C0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:26:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478ECC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Q7n4LsbPpDgM+lMF6CYITuIAo0WCqKTZ55m7Zh3PQUY=; b=ghf18BlICrN/P/QAwR9wBV7quM
        l9xc10FBUVT8T5yG3v3jDeD7qJY2seehqJv2trg7l1InmlOpXWmaqGd31ik3mV32VDxaU5teaWa9X
        WeHkag+3B0zs4taRyTSjEFCkDw43kmN2qnWv2/5aysFo+lTK9PmP35MUBKzoHylSQoHI59ehsbzh3
        1YTh9My1umZAHcFEQIb7k3QFQaIHU6yhdjXIJfx1/0F4fuN4hjs8jUnTiha/E5OlHNnUJN85KxUjd
        Gas9eH5w8sULgywnmhlz7ciPEVcKcreC637c2nwpt8vUQkG+v1NSRcdj9uP0hxQEtRGcsihr7TYIo
        bunz5AZQ==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPydn-00FoR1-Mf; Sat, 27 Mar 2021 02:25:34 +0000
Subject: Re: arch/x86/kvm/hyperv.c failing to compile: frame size of 1048
 bytes is larger than 1024 bytes
To:     Logan Devine <bbhclinux@gmail.com>, linux-kernel@vger.kernel.org
References: <5932e10b-b890-c48a-3ab6-abe93ef97721@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <922ee155-7b28-5098-ac64-d4d1430684cf@infradead.org>
Date:   Fri, 26 Mar 2021 19:25:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <5932e10b-b890-c48a-3ab6-abe93ef97721@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 7:18 PM, Logan Devine wrote:
> Compiling the kernel for the second time, and now kvm/hyperv.c is failing to build:
> 
> 
>   AR      kernel/built-in.a
>   CC [M]  arch/x86/kvm/ioapic.o
>   CC [M]  arch/x86/kvm/irq_comm.o
>   CC [M]  arch/x86/kvm/cpuid.o
>   CC [M]  arch/x86/kvm/pmu.o
>   CC [M]  arch/x86/kvm/mtrr.o
>   CC [M]  arch/x86/kvm/hyperv.o
>   CC [M]  arch/x86/kvm/debugfs.o
>   CC [M]  arch/x86/kvm/mmu/mmu.o
>   CC [M]  arch/x86/kvm/mmu/page_track.o
> arch/x86/kvm/hyperv.c: In function ‘kvm_hv_send_ipi.isra’:
> arch/x86/kvm/hyperv.c:1799:1: error: the frame size of 1048 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>  1799 | }
>       | ^
>   CC [M]  arch/x86/kvm/mmu/spte.o
>   CC [M]  arch/x86/kvm/mmu/tdp_iter.o
>   CC [M]  arch/x86/kvm/mmu/tdp_mmu.o
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:271: arch/x86/kvm/hyperv.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [scripts/Makefile.build:514: arch/x86/kvm] Error 2
> make: *** [Makefile:1851: arch/x86] Error 2
>   CC [M]  kernel/kheaders.o
> 
> 
> (Sorry if I did this wrong, it's my first time on the list.)
> 
> 
> I'm on gregkh/staging branch staging-testing.


Hi,
Just edit the kernel .config file and change
CONFIG_FRAME_WARN=1024
to
CONFIG_FRAME_WARN=2048

and it will be good.

-- 
~Randy

