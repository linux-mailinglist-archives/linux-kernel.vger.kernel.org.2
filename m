Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34775315AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhBJAMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:12:49 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43822 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhBIUml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:42:41 -0500
Received: by mail-ot1-f47.google.com with SMTP id l23so7096045otn.10;
        Tue, 09 Feb 2021 12:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZZM67EhmMbZp5VJU7IlbmetXBbcl+XmdSzt7HSdY1U=;
        b=udX19a1tTkU1Q93yx/7H2lgDEIdSYVOyWPYiTYNizcf1sJCNMSGjZpQikTQQ2BtOyg
         u3q93YNES0y33lWOut5NpnhzaupW8zJOsvTPiln8NjaVYBJ7cd7WB3lu+eLMs7C5QXS2
         6Pf5Gx7fpLZ2ZxKRlwF2Eue6DmjrqUt6LidLovDSD6S24hv+ENthcpKnuUKJ59D2fFXU
         TGz5xiiJOHwlwWGZE11Ix8GXAXLs51oXjWsep17UOwNkypeOtmn8rmgKDsPkwYq9tSuX
         5CTZFe8nhTdxDmvX4L07x7D2mRivkQ6jxn+EpnnXptyXH6aNgNV/fgj69sAaFzrWMmls
         sDtw==
X-Gm-Message-State: AOAM531WRRn4Fhrv6nbPA7LIkEJcOnfDw7c7Hxd0TG5i+mbwOggAzY3O
        yad42reV/XCQUkxIckuVvg==
X-Google-Smtp-Source: ABdhPJxGCnWyUkTc1TkCgfXZaB6ldc17uw3AhgXdcQPL7wK34IO4FS5r2QxnYclB57pQ3y3rTJYVIQ==
X-Received: by 2002:a9d:7dda:: with SMTP id k26mr13308366otn.284.1612903321022;
        Tue, 09 Feb 2021 12:42:01 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r25sm1711758ota.42.2021.02.09.12.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:41:59 -0800 (PST)
Received: (nullmailer pid 139152 invoked by uid 1000);
        Tue, 09 Feb 2021 20:41:57 -0000
Date:   Tue, 9 Feb 2021 14:41:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yz.Wu@mediatek.com
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: nvmem: mediatek: add support for
 MediaTek mt8192 SoC
Message-ID: <20210209204157.GA139100@robh.at.kernel.org>
References: <1612151986-19820-1-git-send-email-Yz.Wu@mediatek.com>
 <1612151986-19820-2-git-send-email-Yz.Wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612151986-19820-2-git-send-email-Yz.Wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 11:59:45 +0800, Yz.Wu@mediatek.com wrote:
> From: Ryan Wu <Yz.Wu@mediatek.com>
> 
> This updates dt-binding documentation for MediaTek mt8192
> 
> Signed-off-by: Ryan Wu <Yz.Wu@mediatek.com>
> ---
> This patch is based on v5.10-rc7.
> ---
>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
