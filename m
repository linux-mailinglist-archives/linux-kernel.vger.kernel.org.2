Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDC3231A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhBWTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:55:13 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43632 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBWTzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:55:10 -0500
Received: by mail-wr1-f51.google.com with SMTP id w11so1136386wrr.10;
        Tue, 23 Feb 2021 11:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1Hcd6QRdKXXlEYw6zHLnq2SBm16aJnAi+TIykLMZ1w=;
        b=W2cHHPVlztbDon38vyGKbuZYO4mRggBrzXpZ2j9txcV8kJs8YbE6CjYtkUSirxVph+
         N5B+s1W8EcX3igoBxllNm3kudqFZtptgahVkuwhuLoweGwFq75IZMQy0F89Oi3ZoCDHp
         Aha+a1a1MkqrLzzObixbWA5xSoUAw3mDYKmYCaqqwEXKKSEKgQPand/CZgTVEV9+hNX8
         VXZcFZhPT0/vdoGP2bsZlChHt6PkK+Iff8fnSRZ+yxngXe3t3CklD68KGawSdDvls2hQ
         q46WZqfrREMQKOczJVwe7LUTUJtxwXx0Aqec+Gr0ifxzO9PvrT5W60cVUS1WrNAfnkPZ
         3xxQ==
X-Gm-Message-State: AOAM532R1DKx7sKruOAI8f/e9avGXhORSyD8+hnSMxslfnsbUwLpmbO5
        RfggICoifRWo1b7Z3ZElHhU=
X-Google-Smtp-Source: ABdhPJy7zTjADGpUaZXVMTOg3Dugy9wFFMQkD0vZ8NE/irXeTO7Ma/hyCsHc/R3XfqhumMZMU6LmIg==
X-Received: by 2002:adf:818a:: with SMTP id 10mr24721411wra.31.1614110068917;
        Tue, 23 Feb 2021 11:54:28 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a186sm3847508wme.17.2021.02.23.11.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:54:27 -0800 (PST)
Date:   Tue, 23 Feb 2021 20:54:25 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
Message-ID: <20210223195425.zzzkupwqnwidz3rx@kozik-lap>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
 <20210223191652.436397-2-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223191652.436397-2-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 08:16:44PM +0100, Adrien Grassein wrote:
> Add usdhc3 description which corresponds to the wifi/bt chip
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
