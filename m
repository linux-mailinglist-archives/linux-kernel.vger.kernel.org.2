Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13FE317130
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhBJUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:20:28 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:46476 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhBJUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:19:39 -0500
Received: by mail-oi1-f171.google.com with SMTP id k25so3481658oik.13;
        Wed, 10 Feb 2021 12:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1V8t5Prsyy8S7mj+k1iwfG7SFJZpLRdBoSrJSVmZLDo=;
        b=SmGKYUHFV9pAKHh2civHRu39SsdPtOx2fK9MMOVTpYiZ8YbtLoCviuEsfmAxclzO3D
         UOU1+lTNlng2UD4Tdb/MZg8OMoCSvn+byPw3y3g/Lfhg3zJLRLoz4AWZrXeh/FOHL8O2
         o9dpL09NXnCBhnVsLmRujWZtLljUbzHdbiIRcUKbGCb8MBrmLDWECve3OkXJAiwdm3f7
         tyuvQ1nkCHScg9rmDHMWbL+bcKIDMlo6dm0H26d5mgn4fZoxnHQ7uJ9ugvpOrUVxQxi7
         B48sIZ3IOkqi/QBLKgOUbwhDBUC1D6Lg7883ZH7L89iCIFGnecz+fdQYZW6JsEILcD1x
         dImg==
X-Gm-Message-State: AOAM532miHik9VTmTpW/8ScMnZd1eugVsLMQv+faJthQHQday3BGe/Ja
        H0ebALuG4pGVS8WHdsRL6r51qwf3wA==
X-Google-Smtp-Source: ABdhPJyuS7VjbrxGJVv3iJ/xTI1HQADlXtLQ4n+iMb/j+EHT3Wlzn5vWyImtbs3aFTQgWbK0PwMUGw==
X-Received: by 2002:aca:c545:: with SMTP id v66mr532401oif.116.1612988338560;
        Wed, 10 Feb 2021 12:18:58 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l133sm654257oia.37.2021.02.10.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 12:18:57 -0800 (PST)
Received: (nullmailer pid 2690216 invoked by uid 1000);
        Wed, 10 Feb 2021 20:18:56 -0000
Date:   Wed, 10 Feb 2021 14:18:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     srv_heupstream@mediatek.com,
        Philipp Zabel <p.zabel@pengutronix.de>, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        airlied@linux.ie, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, stonea168@163.com,
        huijuan.xie@mediatek.com, linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, shuijing.li@mediatek.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mediatek,dpi: add mt8192 to
 mediatek,dpi
Message-ID: <20210210201856.GA2690160@robh.at.kernel.org>
References: <20210208014221.196584-1-jitao.shi@mediatek.com>
 <20210208014221.196584-4-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208014221.196584-4-jitao.shi@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Feb 2021 09:42:21 +0800, Jitao Shi wrote:
> Add compatible "mediatek,mt8192-dpi" for the mt8192 dpi.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
