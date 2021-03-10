Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D133328B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhCJAmk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Mar 2021 19:42:40 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39085 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCJAmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:42:12 -0500
Received: by mail-ot1-f45.google.com with SMTP id w32so866926ott.6;
        Tue, 09 Mar 2021 16:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B9kfS99u0SUZVlH5di3LiWPuAPpB4r2eN/dscB/4GLU=;
        b=pghLSR+TS6kGlpSIUfDedzHoTKr9kP6/r17m5XeQ0bAWy0MNf3Sy36H+VTR7sGQe0N
         OjoyLZZlYJ7cAjNxqweWZAMVWT7aF3uEumCbl45BdSqeYxLtD20XjNx4xzrv/Hfpxsbm
         8jynBEV9d/024fsqDQUIoWWiT4+HEFZtsLPPAW21HT6AuEdQydANO16MDIQd3xESK/3+
         dKMRo1p4gSZ0QJM0ti2Cp+BJ/0nSmt9pA1vJXo3wLM3/4HqWJ/BhHNOQvgWjMv3Bad9Z
         8fyOcsKazseLPfPPIlXRxkvGGJI0KyHxA0UlIOctKAojP2EH50H9LqkC+2eYHq52K1ed
         HVBQ==
X-Gm-Message-State: AOAM533hkfTK3Ho2z6TO4LD03WUsE+7Ony9tWGN2MedSJaetB6TY4XOy
        W/mYLafuyBuGiSnK1lIg7SWW4WCAE/g=
X-Google-Smtp-Source: ABdhPJw9TXqKU4gqcQcIXB6pwu/2Jtg5BkCANF4bsU5dUyARGZ/Bsb+wjcwX2ijLcY3zjCVQI9uspg==
X-Received: by 2002:a9d:2062:: with SMTP id n89mr609451ota.297.1615336931403;
        Tue, 09 Mar 2021 16:42:11 -0800 (PST)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id t3sm3716836otb.36.2021.03.09.16.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 16:42:11 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id n19so3504124ooj.11;
        Tue, 09 Mar 2021 16:42:11 -0800 (PST)
X-Received: by 2002:a05:6820:60c:: with SMTP id e12mr337980oow.67.1615336930987;
 Tue, 09 Mar 2021 16:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20210307204737.12063-1-horia.geanta@nxp.com>
In-Reply-To: <20210307204737.12063-1-horia.geanta@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 9 Mar 2021 18:41:59 -0600
X-Gmail-Original-Message-ID: <CADRPPNQ7JAx9N_VqoG3q9w_0DQbgia6z1Jgxrw0hh7+a8WXcNQ@mail.gmail.com>
Message-ID: <CADRPPNQ7JAx9N_VqoG3q9w_0DQbgia6z1Jgxrw0hh7+a8WXcNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: ls: mark crypto engine dma coherent
To:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Ungerer <gerg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 2:26 AM Horia Geantă <horia.geanta@nxp.com> wrote:
>
> This patch set adds "dma-coherent" property to the crypto node
> for NXP Layerscape platforms where the IP (CAAM) is configured
> HW-coherent.
>
> Horia Geantă (3):
>   arm64: dts: ls1046a: mark crypto engine dma coherent
>   arm64: dts: ls1043a: mark crypto engine dma coherent
>   arm64: dts: ls1012a: mark crypto engine dma coherent

For the series

Acked-by: Li Yang <leoyang.li@nxp.com>

>
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
>  3 files changed, 3 insertions(+)
>
>
> base-commit: da1a6b8bec881b67f0e234ed19e8b7e2fb1e7812
> --
> 2.17.1
>
