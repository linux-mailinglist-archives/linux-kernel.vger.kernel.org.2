Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920E6379305
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhEJPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:50:17 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45638 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhEJPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:50:10 -0400
Received: by mail-ot1-f41.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so14805396otf.12;
        Mon, 10 May 2021 08:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjFTnr2ss94r3eVYPl4F/ux/Btl6LxwVw7EUSBfq9+4=;
        b=AXkd0G7c/MizatO8EZJlDfOaf2gClbcSN4Yr/5Zxo2dS2z0CrWhV+XowZPq1Kq5j1e
         tq9SaWJQlKePasPbxEgD2EsRs97ZE4ajrsP8lp5LhfdctRuWTUxRgRITHwgUclVR90MJ
         hobimjXCmWhm+/iZra20PhJvpH96yZDY1MaI0PfH+nFPjcvU8VlLB39NTgrtL9AN4uLG
         fiyMv5p+GQKCCkz1BtbTyS54CTWbbaP+HNcMEhPYZMzjOb9opJhsZsIeAQYJzR20x3Yw
         e1k6nHTkBhz+qkItc09Av8kLhqIVBInQm6T1XtMWbHznTEuO/C5s2Xr3iIqC8JN7Sprb
         vm4A==
X-Gm-Message-State: AOAM531rPMeI3o+ZtUPcI1X+6O4qZGKVA1t+rychg347MgKhdTY0TEtg
        D99ow7x6I2FIMMJoYRqucA==
X-Google-Smtp-Source: ABdhPJzGh+54d47wlGAFGJ5ZKyOixmiNnsV9Vl+5LPb0AAql97v0QhZKcko4HxaFJ9pHqobuJ4x6VA==
X-Received: by 2002:a9d:4115:: with SMTP id o21mr21894427ote.52.1620661745739;
        Mon, 10 May 2021 08:49:05 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 129sm1045104ooq.34.2021.05.10.08.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:49:05 -0700 (PDT)
Received: (nullmailer pid 185446 invoked by uid 1000);
        Mon, 10 May 2021 15:49:03 -0000
Date:   Mon, 10 May 2021 10:49:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        festevam@gmail.com, aisheng.dong@nxp.com, s.hauer@pengutronix.de,
        robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        shawnguo@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
Message-ID: <20210510154903.GA185393@robh.at.kernel.org>
References: <20210507101926.25631-1-peng.fan@oss.nxp.com>
 <20210507101926.25631-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507101926.25631-2-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2021 18:19:23 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The register layout and bits definition of i.MX8ULP MU is different
> compared with others, let's add the compatible for the new MU.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
