Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B90458CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhKVK7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:59:41 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:40891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhKVK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:59:40 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0WsG-1mUGEX0SQO-00wWTK for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021
 11:56:33 +0100
Received: by mail-wm1-f51.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso16350060wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 02:56:33 -0800 (PST)
X-Gm-Message-State: AOAM533w84+hz/87m0xKRtJ7kX6+N09CB0Jy+ePhcrsuyP/4HoQggLeH
        UQ8FP/QOmmN1wiwZD3uoDXrNw+7k3p9nLNk9rIM=
X-Google-Smtp-Source: ABdhPJziQEqCSH5vF1E9A/Net6pOMxGTiMMk1GZx0eSSK8x6r+KARZXWJ6/jqXbo+ZDMlfF5bQMueo5xxmeRCbBdz4w=
X-Received: by 2002:a7b:c007:: with SMTP id c7mr28317707wmb.82.1637578592762;
 Mon, 22 Nov 2021 02:56:32 -0800 (PST)
MIME-Version: 1.0
References: <1637365141-16823-1-git-send-email-mikelley@microsoft.com> <20211122083503.umkqv2t75osypsbx@bogus>
In-Reply-To: <20211122083503.umkqv2t75osypsbx@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Nov 2021 11:56:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2c_Cw1p_3GpnwJ9ycRjAEDyLSsRMuK12w0TYNYQ2xh7Q@mail.gmail.com>
Message-ID: <CAK8P3a2c_Cw1p_3GpnwJ9ycRjAEDyLSsRMuK12w0TYNYQ2xh7Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] firmware: smccc: Fix check for ARCH_SOC_ID not implemented
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:q8KxFExTOLPKWq/rEepWfqgLSYkgv8HmrZyRDN3cvs4g/Scd8/y
 j+F2sKKxPWWC9a74VePy9P0/EpaUKTnn3FqtImsRDIDVJSmT6iqeNso5c8A8AmlkVOZYRMa
 BRPERnXBJRA08EirX6ncvrtJsFeCV2LF3A+3RMTavfS62B6Kh21G44Vxu3+KgRwOSKhSu6Z
 dUqVj31IZhl335E7RCAcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J3Dv5ZYepNw=:VGJqWhiXyUJNrA+wbna5Ie
 cXJnG8E2WbxC+dimw+eXJhl6DxkGLMMpcDMGKo5rl5geCtzixwd8H5aO06NO8E3jyRHMXemU4
 zG3xmmDT3wgCDn14Bm7SoXaPeJ3qE88qTCzDL2VbmLIc2MNrd2I/WdEYVUC9/fRaDXc/yT0h+
 yjy7K8TkjlDDENYKuQ59q18xYHEyfQbI24cTTStE9uN2buMke0l1q9QSnw0RHBph/cexI0XJc
 zhWQ/SHvl5vuhgrb2/kSWRFT2S9l7S3233f504Xr1cUZYigQ3O/conMFnXZoaL7xIp8BlwIEK
 ZyqJr6WMEFP3mL9DgfMQeAjsvjBpU+A6R33NmweZhhQ0ph1X51fnr6j7xOoqm5R08vhqZv6dU
 coNS2ZgUGVfeYZF4z8zJ1KfrQBsk50C6+novsrXWRSQGDeXATHrfO7hb17NaRGoTafnd8QYsb
 KoihxdEf1mcI5Npupz11o72IYvw/gVnsmKlOTxYr70vNeQCPJ7pmIZl1+SzyAuKMNKwSIKz2T
 W8vl9Nf2GoKNNxL/X9RCJUU2VlaK5tdz9c4Z8eKocz9Lc5NAuTqYau0TPnp0l89ZL3Cp3o0dn
 9mLpHeM/giFS7gLmwHSTC8mMoqjo1d0XYzWLbugz7LqlNi1CJSoeaaEDn34qOemHDRiJoxL0f
 k4ZODPUIF0kwVAdzKwA4UgqoKpt0dyDsoRAS3uBAgM+qawyqQYJJg55a77+ddEYfDij8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 9:35 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Fri, Nov 19, 2021 at 03:39:01PM -0800, Michael Kelley wrote:
> > The ARCH_FEATURES function ID is a 32-bit SMC call, which returns
> > a 32-bit result per the SMCCC spec.  Current code is doing a 64-bit
> > comparison against -1 (SMCCC_RET_NOT_SUPPORTED) to detect that the
> > feature is unimplemented.  That check doesn't work in a Hyper-V VM,
> > where the upper 32-bits are zero as allowed by the spec.
> >
> > Cast the result as an 'int' so the comparison works. The change also
> > makes the code consistent with other similar checks in this file.
> >
> > Fixes: 821b67fa4639 ("firmware: smccc: Add ARCH_SOC_ID support")
>
> Good catch.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Can you please re-post with my review tag keeping arm@kernel.org and
> soc@kernel.org ? I don't have any other fixes at the moment, we can
> ask SoC maintainers to fix this up directly.

In general, I think the easiest way would be for you to forward the
patch with your Signed-off-by, when you don't have other material
for a pull request.

I've applied this patch from the list now.

       Arnd
