Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8891E3077B1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhA1OJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhA1OJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:09:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4579264D92;
        Thu, 28 Jan 2021 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611842899;
        bh=QSDli4q81ZPENBHiSIxqH32K2P7ZjDli7F2BOv1/r9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WqWHV57+phzaVBv77u51NcPbqZi/YOFjBMwRd2KxldHHJ7XFNYT5ed5VJkH4PPvAu
         l9bQ5NNu6pbrc+vgPpVUmfD5xWv3HnprgGCuk4swf/sZCj9BQYsgcFFe7gs/Vv6Ea6
         jrB2s9UsnUn6uH48aXrsLo5gTlhAaNBDyy7ksKGuNcJ3Z2/TkQ2OP0OHWBrohpozPc
         zK5VAZcNOuKY+UtFusmh1kn+3fjsJppXYfMmz4zHluuxmlfy9DAKjtLvjloeHWSCeY
         a5DfcrGiY9VyeNBi1Yei06EntAoq/olgB7Aewv6rj45FWZDqvR9vK1ixP/Jx//xx/F
         SVHp9W7+JhSmA==
Received: by mail-oi1-f182.google.com with SMTP id n7so6078635oic.11;
        Thu, 28 Jan 2021 06:08:19 -0800 (PST)
X-Gm-Message-State: AOAM53110fbfkeFxRtDUkdWHta/K7VWXxKu3PpsBFFM4AH0+7yWEcVb+
        3utAZcmhVLJdN94djG/CDRBvAkQ1pg0JOWZjaBA=
X-Google-Smtp-Source: ABdhPJzwEQxEnGH8Kd9EW4py7Vh8j/97czrumYSoCX4f5UnRR+EOHFO9iBqtwIJx05MPulf7muWpeVXN8Y1iYCWgGHI=
X-Received: by 2002:aca:d908:: with SMTP id q8mr84273oig.67.1611842898482;
 Thu, 28 Jan 2021 06:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20201208124641.1787-1-thunder.leizhen@huawei.com>
 <20201208124641.1787-3-thunder.leizhen@huawei.com> <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com>
 <6010B6DE.4060202@hisilicon.com>
In-Reply-To: <6010B6DE.4060202@hisilicon.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 15:08:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a31po51NtRhuMsruy2nbqhjguyGP8ZcXwPAwwEiGtLBkg@mail.gmail.com>
Message-ID: <CAK8P3a31po51NtRhuMsruy2nbqhjguyGP8ZcXwPAwwEiGtLBkg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: correct vendor prefix hisi to hisilicon
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 1:42 AM Wei Xu <xuwei5@hisilicon.com> wrote:
> On 2021/1/27 6:23, Arnd Bergmann wrote:
> > On Tue, Dec 8, 2020 at 1:46 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>
> >> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> >> stated in "vendor-prefixes.yaml".
> >>
> >> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
> >> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> Cc: Chen Feng <puck.chen@hisilicon.com>
> >> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > I see this change in the pull request I got, but I'm a bit worried about the
> > incompatible binding change. Wouldn't the correct path forward be to
> > list both the correct and the incorrect properties, both in the dts file
> > and in the driver that interprets the properties?
>
> Thanks for the comment!
> The reset driver will look for "hisilicon" firstly and fall back to "hisi".
> And the DTS is shipped with the driver together.
> So I think there is no compatible issue here.
> Please let me know if missed anything. Thanks!

There are three things that can go wrong here, and this is only addressing
one of them:

1. Updating the kernel on a machine with a dtb provided by the firmware
  is a problem if the new driver can not handle the old properties. This
  is correctly handled by the driver's fallback as soon as both trees
  are merged.

2. Updating the dtb while running an older kernel is now broken since
  the driver can no longer read the property. This is less critical, but
  it does seem easy enough to work around here by leaving both
  properties in place.

3. Bisecting through the git history across an incompatible change
  means you can run into broken commits. We try hard to avoid that
  if we are aware of a problem in advance. In this case it could be
  avoided by only merging the incompatible DT change in a following
  merge window after the driver change, or (better) by making it
  a backward-compatible change the same way as addressing 2.

         Arnd
