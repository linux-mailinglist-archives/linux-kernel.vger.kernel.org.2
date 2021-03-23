Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825B2346D78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhCWWoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:44:21 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:43579 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhCWWoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:44:05 -0400
Received: by mail-il1-f178.google.com with SMTP id d2so19663016ilm.10;
        Tue, 23 Mar 2021 15:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=To9cZZSfsdpSpDQw0W+UmnGEzxUUpkZfOtO0q/U8W/s=;
        b=GIyvNIiwTfwRmEeLlTzY4pPcvecm5nE/Ne3soULwTb/WUaneMSjnOF70nxneqU12Tc
         LZisoHc68HomibfqP5FOrLXAZc2f0qVXnVhq2s6SKHnqBFYBwdF+f2v5uCakQ/+mCM9m
         WWHsqemKMUwyfR49Y2gDDS9l1UUVGBcjYd6472vvkI2Ap1HSVdrssSe3Lok9r5g0NhaF
         dqOGwN0TbmQ1bRJ11yd1daRTPXGNeIlChUGSEj0dMYxFq35LUJd8h+mcb9mbp4Rj6Wu4
         Bq3M09Gbf07tDneF+/13CLao2ygj5+1W7BwaSigSJRI5p7CmyYB6hzuS+lJ6+Rf01556
         +FKg==
X-Gm-Message-State: AOAM531Y2/ozgo28lZr9XlvtFYKoMc0+dCGvOSWL6TXoYrO425zxsnGr
        z0k1xMVPPtzzU76PxeET1sfZ/aVEMg==
X-Google-Smtp-Source: ABdhPJxqGs67jhtTLty5OdHwPAGfKZPUCrN5SvDX5Ss4Kn3MzXOQEUOV8Zjk+93kV8LZiGFtHI0xuw==
X-Received: by 2002:a92:874d:: with SMTP id d13mr372236ilm.214.1616539445175;
        Tue, 23 Mar 2021 15:44:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i3sm116018ilu.67.2021.03.23.15.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:44:04 -0700 (PDT)
Received: (nullmailer pid 1485445 invoked by uid 1000);
        Tue, 23 Mar 2021 22:44:02 -0000
Date:   Tue, 23 Mar 2021 16:44:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jie Qiu <jie.qiu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Cawa Cheng <cawa.cheng@mediatek.com>
Subject: Re: [PATCH v5 01/13] dt-bindings: usb: fix yamllint check warning
Message-ID: <20210323224402.GA1485389@robh.at.kernel.org>
References: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316092232.9806-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 17:22:20 +0800, Chunfeng Yun wrote:
> Fix warning: "missing starting space in comment"
> 
> Fixes: 23bf6fc7046c ("dt-bindings: usb: convert usb-device.txt to YAML schema")
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v5: add Fixes tag suggested by Greg
> v2~v4: no changes
> ---
>  Documentation/devicetree/bindings/usb/usb-device.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
