Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08B32E76C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 12:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCELtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 06:49:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhCELtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 06:49:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DsQy96jkXz9sWL;
        Fri,  5 Mar 2021 22:49:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614944979;
        bh=MFuEr/zpCREmU8rWGDeBRzuATbhdbCM1oGMnXg6xVJA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iqqfOFNX9EQlJSH/QhZZ0p6dE3IkuDgX/+x3w6yrBguuBdJT+jY7FX2diXMKV0ALl
         +keQy4Z341L6a8EZLdY7Gl8NJU5gZS0MAfOpTNZiAzBO2QKsrzfaiGylrzMQIPZQm3
         CSxGVfSC5Iw41blS8SDq2alD7gJzxyOUQf0AwLVw7+h+Ps7feiYoEJ/JVJ/gr/fxMj
         UtLYMOgbVPH16NxnEsyLRgZVmjPul7J53e1mOrzcI3Mt/hrBZc2Moqi3m3N9hqpVue
         yQDAjSKkliB/ApMNL2rDGxjiCxQ9sxw2Xi1NaGtkMwf/LJy+eKyHcKqwqOAypP9nXG
         VqDsphppeLQ5A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Alexander Potapenko <glider@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
In-Reply-To: <CANpmjNM9o1s4O4v2T9HUohPdCDJzWcaC5KDrt_7BSVdTUQWagw@mail.gmail.com>
References: <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu>
 <CANpmjNPYEmLtQEu5G=zJLUzOBaGoqNKwLyipDCxvytdKDKb7mg@mail.gmail.com>
 <ad61cb3a-2b4a-3754-5761-832a1dd0c34e@csgroup.eu>
 <CANpmjNOnVzei7frKcMzMHxaDXh5NvTA-Wpa29C2YC1GUxyKfhQ@mail.gmail.com>
 <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu>
 <CANpmjNMn_CUrgeSqBgiKx4+J8a+XcxkaLPWoDMUvUEXk8+-jxg@mail.gmail.com>
 <7270e1cc-bb6b-99ee-0043-08a027b8d83a@csgroup.eu>
 <YEDXJ5JNkgvDFehc@elver.google.com> <874khqry78.fsf@mpe.ellerman.id.au>
 <YEHiq1ALdPn2crvP@elver.google.com>
 <f6e47f4f-6953-6584-f023-8b9c22d6974e@csgroup.eu>
 <CANpmjNM9o1s4O4v2T9HUohPdCDJzWcaC5KDrt_7BSVdTUQWagw@mail.gmail.com>
Date:   Fri, 05 Mar 2021 22:49:36 +1100
Message-ID: <87tupprfan.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Elver <elver@google.com> writes:
...
>
> The choice is between:
>
> 1. ARCH_FUNC_PREFIX (as a matter of fact, the ARCH_FUNC_PREFIX patch
> is already in -mm). Perhaps we could optimize it further, by checking
> ARCH_FUNC_PREFIX in buf, and advancing buf like you propose, but I'm
> not sure it's worth worrying about.
>
> 2. The dynamic solution that I proposed that does not use a hard-coded
> '.' (or some variation thereof).
>
> Please tell me which solution you prefer, 1 or 2 -- I'd like to stop
> bikeshedding here. If there's a compelling argument for hard-coding
> the '.' in non-arch code, please clarify, but otherwise I'd like to
> keep arch-specific things out of generic code.

It's your choice, I was just trying to minimise the size of the wart you
have to carry in kfence code to deal with it.

The ARCH_FUNC_PREFIX solution is fine by me.

cheers
