Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549FC39EE1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 07:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhFHF3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 01:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhFHF26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:28:58 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14578C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 22:26:54 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c124so19094263qkd.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhYoLxflbqy2x4T8u5cV5CjjD3rbffxuuzJaYyXO3gI=;
        b=cTDXmT/OQamLVrplThr/blFULqQGxorezrmdpj23q9cJGz0+DSZX4eumowxe0gpEsQ
         GizK7NYafbS03QJoFZ5YLXtPhhyMrIr7vl79lMShB9Gffu0ld+Jg8t29Sm9aeDqbWjtp
         Qh+t2e7ZDcilDqWs/+nl8Fw6ZFXuYzI6itTFciZE3+cSIMxrcsE+MLWb/748C5VYDpd4
         /r+2o0UkCSLDvS4aBqBMuy4M+legNCHEgpBMQ2QIfYnFBg7jXptLlnGItPYWz0zB/vVA
         KIoqzx4YSHFmzt2MtsPx2IGV+yW67IKU0saxGBJwh9427PtGoh/IBGNuiQdQ+JK2JPUL
         NrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhYoLxflbqy2x4T8u5cV5CjjD3rbffxuuzJaYyXO3gI=;
        b=e5+W5f6NJ+OpbKhrk7df+VoovA3ZDCayBaXkd39jKsGo8y9XK2E93cFNq5euBY2rFX
         Rlhg2Zya8g3ql5mMc2Rg914hgnupk3i/9iw6hyJBKZiFTHbtn1LL0dr9P3XJl+5+XSyN
         l4hujn6gKBB06YPCYDLAt39G61nF2XSeikoDlotYxaq4t8m5zmh9hKKTd8eJAE0lNpaY
         mYssK31YSOc1qlAOVkPce+b69bD/CqcDPcfHOTactYGMq9tSqwUfEwZb5SmdYjWB4RCa
         7d3gjUV+mHMHg9ijoJQkkXA6E55n3Js2ybw83lbYmmboCe4xwo7uW3CbiwXe16XL/2ol
         /RwA==
X-Gm-Message-State: AOAM5306MKIq0Qv95isnmF/B1EFxyEyYGeNmkA2B+xWkrJPxCXndQYmP
        ZFOWgQJGLBbsk3PvpDczZlUl6yWN+vhQRLmqq49Rwyc21d6wKA==
X-Google-Smtp-Source: ABdhPJyU2LS/EIzpbv0za8QUZs/k8bXIZynY+j4mB2wtvu36HqFZh1L4X3T4Vrxtvazt1WMmHZatFaL2SDr74LYEbow=
X-Received: by 2002:a37:d88:: with SMTP id 130mr8857254qkn.34.1623130012658;
 Mon, 07 Jun 2021 22:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210604092228.199588-1-heying24@huawei.com>
In-Reply-To: <20210604092228.199588-1-heying24@huawei.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 8 Jun 2021 15:26:41 +1000
Message-ID: <CAOSf1CELBh4F334LK6+zy+BPOXKcOm92QZw4g71hQ7oQNa68nw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix kernel-jump address for ppc64 wrapper boot
To:     He Ying <heying24@huawei.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 7:39 PM He Ying <heying24@huawei.com> wrote:
>
> From "64-bit PowerPC ELF Application Binary Interface Supplement 1.9",
> we know that the value of a function pointer in a language like C is
> the address of the function descriptor and the first doubleword
> of the function descriptor contains the address of the entry point
> of the function.
>
> So, when we want to jump to an address (e.g. addr) to execute for
> PPC-elf64abi, we should assign the address of addr *NOT* addr itself
> to the function pointer or system will jump to the wrong address.

How have you tested this?

IIRC the 64bit wrapper is only used for ppc64le builds. For that case
the current code is work because the LE ABI (ABIv2) doesn't use
function descriptors. I think even for a BE kernel we need the current
behaviour because the vmlinux's entry point is screwed up (i.e.
doesn't point a descriptor) and tools in the wild (probably kexec)
expect it to be screwed up.

ABIv2 (LE) reference:
https://openpowerfoundation.org/?resource_lib=64-bit-elf-v2-abi-specification-power-architecture
