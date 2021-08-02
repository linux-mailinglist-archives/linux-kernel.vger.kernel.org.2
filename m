Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32183DE1B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhHBVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:33:54 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:33374 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhHBVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:33:52 -0400
Received: by mail-il1-f174.google.com with SMTP id y4so17825487ilp.0;
        Mon, 02 Aug 2021 14:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLC52aVmhVqOoSJPVdgHBVvoFp1F65OwU5dq/ORkoP8=;
        b=NCMPPykjVIZk8HrBQzpt4xorKwVbrlzIlRHLoWLFJPoPwF1Nef8SHt7rN5pM3xWlxh
         2F1HUTyFZoioh0tuqg/IyCVNI8Z6iKjdkIBlng/O1HLJFEBkbRVCKNcjNQ9MARJpj5JX
         tswqkuHUcJxutawg4T3q1Iode/Skde6TPG8Gl0WG2U+BdWEoEsGLlVVC1g6WsqZppaNk
         fyrHTw4BzkzloozVQkfgYGBDZNMyAt9G+YqSVevSZ6nuXjQYtYpm9LK/116hBtK92DM/
         +7DrCLtCIoEj+1vIOyt98kUdZYLUODuX4meRWshihWLRMsHT/rWzG0xcv4Ug6layQ93i
         z15Q==
X-Gm-Message-State: AOAM533ehfkP9ynD+R3/ahcmP43Ynuvk2tC1Z5IyPIV5zb0n+vydyGQ8
        wVU+ZOqyMmORDoGeW7RQ3w==
X-Google-Smtp-Source: ABdhPJygm1FsYa2OLberNAFdX6BFy+261rfNgtOBH/qYn8FKixCDRx1Jt1immveovcKjithPmbWfnQ==
X-Received: by 2002:a05:6e02:1bc7:: with SMTP id x7mr1130854ilv.116.1627940021943;
        Mon, 02 Aug 2021 14:33:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v1sm1142730ilm.57.2021.08.02.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:33:41 -0700 (PDT)
Received: (nullmailer pid 1653417 invoked by uid 1000);
        Mon, 02 Aug 2021 21:33:39 -0000
Date:   Mon, 2 Aug 2021 15:33:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/9] dt-bindings: phy: mediatek: tphy: support type
 switch by pericfg
Message-ID: <YQhks7ca6Gr5gAPC@robh.at.kernel.org>
References: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627459111-2907-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 15:58:23 +0800, Chunfeng Yun wrote:
> Add support type switch by pericfg register between USB3, PCIe,
> SATA, SGMII, this is used to replace the way through efuse or
> jumper.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/mediatek,tphy.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
