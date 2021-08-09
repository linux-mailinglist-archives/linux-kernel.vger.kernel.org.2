Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D53E4961
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhHIQDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:03:18 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhHIQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:03:14 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Zfg-1n0fzU3HF6-00wUZW for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021
 18:02:52 +0200
Received: by mail-wr1-f53.google.com with SMTP id n12so12083652wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:02:52 -0700 (PDT)
X-Gm-Message-State: AOAM530sz4YPNr35PtdHl49k6m/E1ssAOnRg0iD+3pjgw1PLfUBBpbDx
        mP46wMw/hjJ9LgWoDcNZ/Q/pjP1Wqfif9lQs1Gw=
X-Google-Smtp-Source: ABdhPJygMEbjaqfBmCIQRo6I5LvrFqxs9XJj3F0q7SiXzCojl7u4H9/sCbLIq4bI2EsrkutG6kdGgfc4U3lbdZUDf9M=
X-Received: by 2002:adf:f446:: with SMTP id f6mr26961544wrp.361.1628524972261;
 Mon, 09 Aug 2021 09:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210809151021.5137-1-david@ixit.cz> <20210809152421.GU22278@shell.armlinux.org.uk>
In-Reply-To: <20210809152421.GU22278@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Aug 2021 18:02:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0qB3Nj8-wKPiAJvPrnH9LZjeXdkQA1MfS998RYk5foRA@mail.gmail.com>
Message-ID: <CAK8P3a0qB3Nj8-wKPiAJvPrnH9LZjeXdkQA1MfS998RYk5foRA@mail.gmail.com>
Subject: Re: [PATCH] ARM: atags_to_fdt: don't warn about stack size
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     David Heidelberg <david@ixit.cz>, Arnd Bergmann <arnd@arndb.de>,
        Jon Medhurst <tixy@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JHbLjBvBEkhCf/gZ9up+jTdcITXZ3jckpbAQ0yRHxqo16N/DNbC
 OIiALZPwn4uNoGPUG2AFFrYDpv7Mfa7oj2P3jMjpE+w0HyVZf0NQgLWQ2NEgtwnoAh/gTR7
 49jRaYVaT+fK+g/l0ZJfMsMAmw4OdC0710GWeuWqZy/2auDKCTnRNAmjLzgKp7E7JheJIuh
 MYmFiZCevSNP2aDyTgiLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TlLvCqvG8A0=:I+nR5dESaFJIAl4KNvhVmK
 ZXay8kdyJGrWfcf0bWlIplvVp0iEoFseuBeEzGAjMiKVs/f8avyzmyC61luuSfXC1CRYydMer
 afLkuvCq7jf3/mBp6SVRG74KwbkGshEZWztc35CjQLZiDPdGddndX54vm18IVENi7AvjTBKSI
 H0cxFX2yQTdbzs9VjTQwjrA3smFOP8fmVuZv814oLfFzssPdV/2nYbeZ7Veec6L16o3gV32x+
 12rFLSDP3D4H+60QxCKRWQm6QcdJqEaBPcugIklWUkJg+cnyW4CEH1w8m/I+D8dIe7koFVIj4
 PzwvbPFmcBUZEA5G6ny1qrbr+H93J3St497y+Ni3Mht6LDMa1ypr4cJj1DYvEcRV820PKCqj3
 tp4IOmO2zUrrlsWWDWOu5ur3tUXgTH7cmI2nSwhYZkJVyYt2RLFKjkfiFz9wMVzn80cr2Ys2P
 8XdPdItpR3MFKBsd4K6lyiavjlZfuiE8RpbC3mM4+3DYgPmfLZUhjvvO51fYu5CEktJzF2vi6
 vZ3bPWJSxIcQQTMvq1gIUB1o/4SxCDt/tV/MQHyqBCilFkeXe9cTXwC2mcdb9A5QiZ5AvQmor
 gtBMY8D/W6tx27tBmE44PzV1LY5vlEkLS7t6uB/+WVIgM7h19YNF24qHlWRoiEhZowywj4fQk
 xEopjqnj0KwqkQHwrBRIDQUbM+W8+rTYaJcqCzMPPElahXaCj2+fFbh+RoPvZB/3yW9lLxIhQ
 mgjBk83eHr1IqcpdrdT84w/IlBExTtPqp8SgZCmtJx5ablHVbpcpl9jw77ePfXAwWOqdtiqL4
 /hzVSbuwX0egRplaWjm43AFP4h5PKl54F7oYgLm53y/oK63yc0GoaZNgpf2L2LjDBgVm8N/LY
 WyRXu7cBZm/4rQ+2Ppy2cTyxJmUZWJeg+i5zW+5Srw3EsTCtTRVsdJyUlJPNfp/yMqihki8Kw
 XPI0AATbwbi2l5yt30gcfubX1UbqkN8QVEt6tjaBM7MI45oFBOeYi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 5:24 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Mon, Aug 09, 2021 at 05:10:21PM +0200, David Heidelberg wrote:
> > Signed-off-by: David Heidelberg <david@ixit.cz>

Acked-by: Arnd Bergmann <arnd@arndb.de>

(or keep my original Signed-off-by if you like)

> I assume Arnd never sent his v3 from what I see in the thread you link
> to above.

Yes, it's in my ever-growing backlog of things I plan to eventually resubmit.

In this case, I actually have a different patch in my tree, but that in turn
depends on other stuff I have to submit first (reorganizing the way that
warning options get handled based on compiler version etc), and the
version here is what works on current mainline kernels.

     Arnd
