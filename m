Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5963206E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBTTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:23:59 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46165 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTTXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:23:55 -0500
Received: by mail-wr1-f53.google.com with SMTP id t15so14508925wrx.13;
        Sat, 20 Feb 2021 11:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjcAAhp7e/J1VNiXN4Mtg1xfP+ppLRV9qlA7b1kEebM=;
        b=NHNmA1er/26nyyId5OycIPtM2sHlge41u6ZbHzWKkNs35VlpG/Vnhz2YxNRSkuq0v7
         oMHrC0pS85/sRIXS2t+HLjWcMM06SmmgxjLTSL2gwJd5JIu5PW73gweQjRuMqStFbJSd
         MF/bwNJMP02D4m+Ocpbe0Z0f+xVkW4xajqxB8KKSDlso20ev4dGpnIejdgSOpTfb2Hv7
         BE7kwGBrQZbmhGCc4I/fojpuhYYE+uEXq+YcwOpF6dPP5z3M3tVsyvrAGt9D0VU+pW6j
         BYYpqC24PgIpvUf+R1ypnld1c6vIdZfk8a1KsEryUkwEQ+2DfzH+c4tapjKc3qDGoASk
         Qnow==
X-Gm-Message-State: AOAM533Ni74ofT+L0HlgXbmzgqZ8EBWbnu9rDHDuOgOToRtRU9oE6f7o
        tE4TK9eS//4i4YQb2hpO19MdwLn+iK8=
X-Google-Smtp-Source: ABdhPJwtBkseTyta32gKfHH3bWGwGiMgjEfDcJ8t4+GH81KpIa4XTOEON2bSLXwcZQw/4SXsG8CZuA==
X-Received: by 2002:a05:6000:107:: with SMTP id o7mr14445651wrx.87.1613848993020;
        Sat, 20 Feb 2021 11:23:13 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y6sm18393789wma.10.2021.02.20.11.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:23:12 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:23:10 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] arm64: dts: imx8mm-nitrogen-r2: add UARTs
Message-ID: <20210220192310.dyufl3i3mzidahaw@kozik-lap>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
 <20210219143028.207975-5-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219143028.207975-5-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:30:23PM +0100, Adrien Grassein wrote:
> Add description and pin muxing for UARTs.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
