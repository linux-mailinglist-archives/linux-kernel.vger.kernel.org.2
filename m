Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7246C305015
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbhA0Do3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbhAZWYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:24:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1136A2068D;
        Tue, 26 Jan 2021 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611699839;
        bh=NkXN+L+8iyIlAKPft4v6rZMUGxnSOffa491D61R1whA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=At289oMxLQNUwHAJs4AQDWij3EeNKTLBbt1i0D2ws3tEW1LvYPw4K/rpUmie/GsXf
         tuL9ugR4oRXsCOhS1/tpb+E3MDGJ/4Aau+DFhiRCrtoDQQyOAt3q93oa2l8wy7Aldh
         BN5OFdDXSnTyakM22d7EgUxqYxg0FGzK2Vy0iedR0Ofr11LShTohrOJ+rvJH3wmstr
         L2vWLW509YWsvfDetji81zGqKyTvFmvX4oxGPCn5Fko3eCHQVXMnMoCcq56SOEwJdb
         GIfbpHHmn80LlgK55EyYiVTxur4jlHayiVoSbVTQC6o1SHlPV5oJOwWrKEeS9Mo86F
         OuuegsW6LwAew==
Received: by mail-ot1-f43.google.com with SMTP id i20so17886657otl.7;
        Tue, 26 Jan 2021 14:23:59 -0800 (PST)
X-Gm-Message-State: AOAM532e5fpRzNQiwm+/rt+GZES6g77ciC/y54TSCiXGxencQE/zjYkM
        S29JzttAB3o1aVsxknf/XQfWYkvAgwOgBnUeP9E=
X-Google-Smtp-Source: ABdhPJwQupZYv7n4Uglws8oEtTR4FjjYUwdD9OeK7zjDxyL4f5IKB59OT2WpYu4cYL7I0h04inMqQL8z5/Vzu6rlseY=
X-Received: by 2002:a9d:3bb7:: with SMTP id k52mr5673345otc.251.1611699838382;
 Tue, 26 Jan 2021 14:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20201208124641.1787-1-thunder.leizhen@huawei.com> <20201208124641.1787-3-thunder.leizhen@huawei.com>
In-Reply-To: <20201208124641.1787-3-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 26 Jan 2021 23:23:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com>
Message-ID: <CAK8P3a3xie1-rLzKY+Y3Z2VKEJkDqAco6b75Af6FgyhsnzorsA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: correct vendor prefix hisi to hisilicon
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
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

On Tue, Dec 8, 2020 at 1:46 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> stated in "vendor-prefixes.yaml".
>
> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I see this change in the pull request I got, but I'm a bit worried about the
incompatible binding change. Wouldn't the correct path forward be to
list both the correct and the incorrect properties, both in the dts file
and in the driver that interprets the properties?

The binding file in this case would need to list the old name as deprecated,
though I'm not sure how that would work without causing a warning about
the unknown vendor prefix.

        Arnd
