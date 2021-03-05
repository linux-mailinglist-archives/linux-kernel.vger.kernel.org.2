Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86432F39E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCETN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:13:59 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33091 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhCETNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:13:41 -0500
Received: by mail-oi1-f169.google.com with SMTP id a13so3711104oid.0;
        Fri, 05 Mar 2021 11:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7j21bnY8V6XoojzoBkuZb1Em80loFildh8CKtjCoQFY=;
        b=YjhR0zhQOuDi8B6hlFlfTN2GWwV0YjD6D6S1kMhRPy5C0DoxrjGF6aCm3eoCSR+Evt
         mBI+9AqrJ2TbDc4df7bRU615bI3JozY6zzItwQNTSNhCJiTZoD/uIassja2sOMQDkPiC
         JgIes2QOCWrdlY+Hch8gFj1wgtgvofIBjmerR/GDow/BBH8y7YbT5Xgqd82MTHBLBbL8
         nN+xqIoUi6+PWrh9GJyGq4ooweBXulEv39DW4Y9ihcFYDDLogkkNpoWsdT0MpPk93rWX
         Dlv0cZULv4t/tbtBgy9SbxqDew/U/b2QoNPPiBZeuRMr9DvGgW5kVxPjAZ39YZWUsSv3
         rnkw==
X-Gm-Message-State: AOAM533U7duIaqYbnlwt2BbSe1fgMMgU7NFiXJjZYZOznj+VBaz8dArj
        PiQsoIFJ5NknJljAVUT6Pw==
X-Google-Smtp-Source: ABdhPJzdQQd2b6iohPA/qBq+VyyV2jEDmlGbzbgOGcsS+r86TXvBx5D0DH4bTuYrinqaApp6cKEM0w==
X-Received: by 2002:aca:5cd6:: with SMTP id q205mr8201202oib.94.1614971621083;
        Fri, 05 Mar 2021 11:13:41 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k21sm763429otl.27.2021.03.05.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:13:40 -0800 (PST)
Received: (nullmailer pid 494318 invoked by uid 1000);
        Fri, 05 Mar 2021 19:13:39 -0000
Date:   Fri, 5 Mar 2021 13:13:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     ezequiel@collabora.com, robh+dt@kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        cmuellner@linux.com, kishon@ti.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: add yaml binding for
 rockchip-inno-csi-dphy
Message-ID: <20210305191339.GA494261@robh.at.kernel.org>
References: <20210210214205.2496336-1-heiko@sntech.de>
 <20210210214205.2496336-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210214205.2496336-2-heiko@sntech.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 22:42:04 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Some Rockchip SoCs like the rk3368, rk3326, px30 use a CSI dphy
> based on an Innosilicon IP. Add a binding for them.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  .../bindings/phy/rockchip-inno-csi-dphy.yaml  | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
