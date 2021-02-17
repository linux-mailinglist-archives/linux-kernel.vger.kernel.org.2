Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38331DB57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhBQOVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:21:07 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46426 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhBQOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:20:58 -0500
Received: by mail-wr1-f53.google.com with SMTP id t15so17521667wrx.13;
        Wed, 17 Feb 2021 06:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SpFoReJdNEGD86El5ZXTEJu+pV2heWh3CZI0tQJ5pzI=;
        b=a6KgTvzwKYQhAP1gQKbkRWZ1lk3yWg3hLe0f5qVRb9/z1RAlfs44Hqav823XZjsZGa
         fdC8ZUfi98F0Vi2oD7yGsEkdQ0iAGsZc0hcPLqp+15Ks+/KB0DCo5xR8MIQ54cVjP7rI
         PqBw+i/Bs6ZLXsc4m7yl0E4C3QdErlWXjB16yYwbCwdDM5K1cLGXA1utxNWaq98QE75Q
         sZa6n8Gau3IGm955C1xq59CZxNLyPalns4Ig2mIn0KWAvk0TNfV+FeyKBpSiLZhcbIai
         VCMwK2ob0+tUtlAcrlgP6jVJUuLlfABxDvurO/4sssdFSyfx7wuu0XHgtApUHVW7C+HI
         mKtg==
X-Gm-Message-State: AOAM530TQkIJTv3TxqCvJTWyxBgnyvaTLq6vp4XXe2eesnkfft66h9nx
        2udxXlnyPH2AZEp0i57d8HLJZBb7HTs=
X-Google-Smtp-Source: ABdhPJxWfdk5xDNsMEj2STtorO7DZ5dmBde+V6Ge+bEcalLZHHorzva/0+IiwgL/O+lP4I4aKPbSFA==
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr29086998wrx.239.1613571616770;
        Wed, 17 Feb 2021 06:20:16 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p1sm3806388wru.86.2021.02.17.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:20:15 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:20:13 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Message-ID: <20210217142013.vofplwopvpwfbdwc@kozik-lap>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-4-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215231943.36910-4-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:19:38AM +0100, Adrien Grassein wrote:
> Add the description for espi support.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index 1b29d8a12d04..22acde0f3ba8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -10,6 +10,14 @@ / {
>  	model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
>  	compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
>  
> +	clocks {
> +		clk16m: clk16m {

Node name: clock or clock-16m.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
