Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79FA34B887
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC0Rfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:35:46 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43906 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhC0Rff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:35:35 -0400
Received: by mail-oi1-f177.google.com with SMTP id n8so9029593oie.10;
        Sat, 27 Mar 2021 10:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=25P/Vw77APXHM7n2Xqj5ck3FsVjFQywnfAb5jywvj38=;
        b=Gp2Ay0kK6xFwY+XI2ilpgjmQr+UWymqenoR2oAH1vkFgLzOsXlIq7iL3K/ZZYUVsqa
         i/UOPSCjfD5CUVKRy261WyZ9dkqrZnAEIugIVXUwvcEaQgumcfIO00dbU+VyDZiMFr5u
         I4RRQsX72DP01Za9kYx/D0zeu6tVruqwn2TDtIAG6SGljnyfoWmu6ZQ4D8Tf0lbhbYbR
         lpBFs+2yB1jOwerU4HCUcFvH5xAj+le1sghKsqBQ/3v6ywE2iOTP4ss8ywLKlC+ACjC+
         nuwdjbuchRqNwEh+aA/ASi+I2FcyEtj6d4/7j0HecB3V+bRyV5tx1Ib2JHnpIZS27ILD
         G1Pg==
X-Gm-Message-State: AOAM530ZbVErQnHrr6AadJxR4UXj31ikzaNoePZaXhaemcWDU9cA2Yhz
        x/spXZzHp1arW1JisO/KDVHD92GEJA==
X-Google-Smtp-Source: ABdhPJxF3RhDsmB4TqzujEY30IJoh0fHFBGAU1hY0iSjlYrgQU0DILZeB+yHHlN2R5DQh0CxUXSGUw==
X-Received: by 2002:a54:4419:: with SMTP id k25mr13850625oiw.141.1616866535274;
        Sat, 27 Mar 2021 10:35:35 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id y10sm2437554oih.37.2021.03.27.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:35:34 -0700 (PDT)
Received: (nullmailer pid 290905 invoked by uid 1000);
        Sat, 27 Mar 2021 17:35:30 -0000
Date:   Sat, 27 Mar 2021 11:35:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oliver =?iso-8859-1?Q?St=E4bler?= <oliver.staebler@bytesatwork.ch>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        shawnguo@kernel.org, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, festevam@gmail.com
Subject: Re: [PATCH v2] arm64: dts: imx8mm/q: Fix pad control of SD1_DATA0
Message-ID: <20210327173530.GA290859@robh.at.kernel.org>
References: <CAOMZO5B_uHS_Z2LuMwHDmn9erORrsrNBMHMjkW-hW+pnfHZThQ@mail.gmail.com>
 <20210324132841.5841-1-oliver.staebler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324132841.5841-1-oliver.staebler@bytesatwork.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 14:28:41 +0100, Oliver Stäbler wrote:
> Fix address of the pad control register
> (IOMUXC_SW_PAD_CTL_PAD_SD1_DATA0) for SD1_DATA0_GPIO2_IO2.  This seems
> to be a typo but it leads to an exception when pinctrl is applied due to
> wrong memory address access.
> 
> Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
