Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521D044EF88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhKLWpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:45:15 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42922 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhKLWpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:45:13 -0500
Received: by mail-oi1-f174.google.com with SMTP id n66so20531405oia.9;
        Fri, 12 Nov 2021 14:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cE5j89IV27G1+Hz1HGRqjfFvBhvHOIVY7ybB7XNim04=;
        b=sHGZhgk1ycHqWJCNeHCjQBonMHVtg6kZCJMVCjT1due8whqmw55E0zruJVwiliPVfW
         7M6RXPhlo4ArSdH+E1JaQQcAONTxZtE9Z3/u4MVbs0HbgmIHQ26NkIn9XujSMjk7/Qlc
         pl3P2joT0US+WsFN8UUznVk4yuGEy1OiYoVhqNXzaNtpHc08jEy6RmpopxFmTHpTTWh5
         Up2Xz11YKQAS9ZaO/dH3CFdewy0nCup+8cr9XsUuz5La7SRv6BbfbhbgnnrAryQtSVhV
         bk0LQmSTiE3vizklkHtGSkvI1Q9yozRmV8KoIDpgKpwKmBxQ5E2Zowjody80s0z7GWJQ
         WDng==
X-Gm-Message-State: AOAM530n7YBikaBeYGChG5vPq6VkKH38PWIH12ESY8S6m8wD83+52wbt
        G736EqrSeZ9S+M0g6y7mfQ==
X-Google-Smtp-Source: ABdhPJzzp9Z+nqh/yiMnZerIuh4tTuAS+BBJ9c80ZGtmguqyRwSZKkxg4y+MwV+sB+/Vq3z49RyBKQ==
X-Received: by 2002:a05:6808:220f:: with SMTP id bd15mr24005740oib.73.1636756942129;
        Fri, 12 Nov 2021 14:42:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q63sm1567040oia.55.2021.11.12.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:42:21 -0800 (PST)
Received: (nullmailer pid 3509956 invoked by uid 1000);
        Fri, 12 Nov 2021 22:42:20 -0000
Date:   Fri, 12 Nov 2021 16:42:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yz Wu <yz.wu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: phy: mediatek: tphy: support software
 efuse load
Message-ID: <YY7tzF8Dpv/hne+u@robh.at.kernel.org>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
 <20211107075646.4366-4-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107075646.4366-4-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Nov 2021 15:56:44 +0800, Chunfeng Yun wrote:
> Add optional property nvmem-cells and nvmem-cell-names to support
> software efuse load, this helps to fix the efuse bit shift issue
> on mt8195 etc.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/mediatek,tphy.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
