Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6931C0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBORtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:49:43 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40397 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhBORpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:45:21 -0500
Received: by mail-wm1-f52.google.com with SMTP id o24so10040328wmh.5;
        Mon, 15 Feb 2021 09:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PnA3I4tNzKQkmDNsKQRjhd/8+Vk4a9EnP1XaMm5fKQ8=;
        b=PSFeeUA1EQVH0I5PaKYP+LuYafA7uvQSMxp4kwEDl4vL5Giczx2+oojAoOJUwGrleS
         EsCZZW8aEHVhqW/uYlyaz9dnnPg5mC8orUNPatMbM9SNr3VIHmeaA2xxIGejKs8O+JxZ
         23tnfTxFJHNU1x3s2fgtwUkk7eLnRgHOfYi8N8goPbvcQoX4MHJ/CNn16AjPupz8Rzjv
         RcTAhevA8rvubW5uk5I/F9tfL7+M2bmzRKemOgt/vrhpb6rCfcVxlc9ScUYDhYWjhIX6
         YWDggDm4cxtIACRHAA/38jeRSY77hG4s+goBl/sk9zWiIxlq7OJA5ta0wQHyDNLaKsKi
         CqkQ==
X-Gm-Message-State: AOAM530mJTAAD34YpAdDpn5P2PKBDnpLv29bsRJLp/3zu3fnH2oXjrSm
        7X1MtAm+LFlbdS19/VKNl+Y=
X-Google-Smtp-Source: ABdhPJw1TLASUhuhatOOQUpk+ZB7iEl8DLP1WzOMmJV1LOPG7BUTtHEWBR2KXSvTcq+Aa379IZtToA==
X-Received: by 2002:a1c:25c2:: with SMTP id l185mr43489wml.62.1613411079487;
        Mon, 15 Feb 2021 09:44:39 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n187sm29953wmf.29.2021.02.15.09.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:44:38 -0800 (PST)
Date:   Mon, 15 Feb 2021 18:44:37 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/25] dt-bindings: vendor-prefixes: Add apple prefix
Message-ID: <20210215174437.5bly3owzhxweudwt@kozik-lap>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215121713.57687-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:16:49PM +0900, Hector Martin wrote:
> This is different from the legacy AAPL prefix used on PPC, but
> consensus is that we prefer `apple` for these new platforms.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
