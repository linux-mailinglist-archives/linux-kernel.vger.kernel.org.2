Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2EE315B64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhBJAhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:37:55 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46233 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhBIUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:16 -0500
Received: by mail-ot1-f44.google.com with SMTP id r21so10265420otk.13;
        Tue, 09 Feb 2021 12:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5HDCmk8HBTM9QYaMpmV4OtJzJOSSem/5EjbeVWW3FGw=;
        b=J8208Vn0GI73IWGFs9CKccDW3UyGWqbuowNVGpQjtz8dG43vNt8THgzxMx/ow21aTv
         nNsfapXw/tFjGh3TXmf8ZxDvwgTav4jJFgdYN2MSF+Yj4u4n42KQep9hZFMUOZvNfdDk
         +IgkW3+Yy33dggG6wObXKtSBgswpmvzBqSyA0KnpXllwZNAjNZk7osZDsRdlu8SJJJuZ
         aPNWrOMqPSv/rKl22XtN9eleq/1fqmfMyASxWNOfkGtOa/sMAfi6YVHoW5m7ANwgkxdZ
         QRzbR9UnMoSwGe5yNu07aN//EYT80yj2WR5xMcJnZ0sCjnN+tkx4NuWPQg+NfZ2tVON/
         0pUw==
X-Gm-Message-State: AOAM533uN4o8LGPrZLfKwgrVr+j2B2+cSNIgUxS4uMNK13pghV44nzMe
        i7OhBpRbn7wKR4hbZYY4Sg==
X-Google-Smtp-Source: ABdhPJxkotZonO+874h4WPiv2w64CIW3eRlhi0d7O06Ay6TB0wtv2vO2vPPy61Xz3lTrRWMgINfgxw==
X-Received: by 2002:a9d:191:: with SMTP id e17mr871646ote.127.1612903655607;
        Tue, 09 Feb 2021 12:47:35 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l4sm4384051oou.8.2021.02.09.12.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:47:33 -0800 (PST)
Received: (nullmailer pid 149246 invoked by uid 1000);
        Tue, 09 Feb 2021 20:47:32 -0000
Date:   Tue, 9 Feb 2021 14:47:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-usb@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH next v3 03/16] dt-bindings: phy: mediatek: dsi-phy:
 modify compatible dependence
Message-ID: <20210209204732.GA149190@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
 <20210201070016.41721-3-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-3-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 15:00:03 +0800, Chunfeng Yun wrote:
> mt7623-mipi-tx is compatible to mt2701-mipi-tx, and use
> "mediatek,mt2701-mipi-tx" instead on MT7623, so modify
> the compatible items to make dependence clear.
> 
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: modify commit message suggested by CK
> v2: separate two patches suggested by CK
> ---
>  .../devicetree/bindings/phy/mediatek,dsi-phy.yaml   | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
