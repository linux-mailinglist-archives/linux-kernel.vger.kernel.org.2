Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF0315B01
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbhBJAUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:20:10 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41272 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhBIUvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:51:33 -0500
Received: by mail-oi1-f181.google.com with SMTP id v193so15464424oie.8;
        Tue, 09 Feb 2021 12:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyA+qCsazc52oAKumArtDLQD8XEJcIjUgmnOrxxcUf0=;
        b=ujWCMZh5r5nmzqIn2RzTHaGnFzJWyWIMlcJvoA0bkc+3i3STx/PTAFMyD4SfsUehr0
         44H4D/l0Gnf0L6jbN7TPoDXFnXRXwL1ZhqauYeZXza6ZEKu9sgD35lsG8Y/UymBo0r5Z
         BGQZBip6okjTg7+LDE2SHWWLJHPpCr3oINNz4THKrmGVblaK+3L8RE8mjOq44V7wr0in
         9W7Dwmvq2LOKv5U51n99MTrDLUFRU7dHzVh7iEbpbTYaZtPlPdyp8aCgoBvPkZXAirp7
         cXmscGdavumJ9CgiRK27PRBzRhagD6OhfqvTkgbmH+0t0J7ZCMOj/Zn2CCM6sW7VMVsS
         ui7Q==
X-Gm-Message-State: AOAM530TJ5pA7TqnJrfgjqZVCdc+gRSVSxyPHbDm272zFUCKfUvl7J0Q
        Dc47CM7qg0B5JQtRAy1dtQ==
X-Google-Smtp-Source: ABdhPJz8eyLdumE+mXi76VfQL1/mw3L+CaM/2X4xAHMFrRU3hUywv3Ksqi6nGj8PUvySAv+/J0Ydfg==
X-Received: by 2002:aca:f044:: with SMTP id o65mr3668527oih.142.1612903851765;
        Tue, 09 Feb 2021 12:50:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w13sm115063otp.51.2021.02.09.12.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:50:49 -0800 (PST)
Received: (nullmailer pid 155548 invoked by uid 1000);
        Tue, 09 Feb 2021 20:50:48 -0000
Date:   Tue, 9 Feb 2021 14:50:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Min Guo <min.guo@mediatek.com>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH next v3 07/16] dt-bindings: usb: mtk-xhci: add compatible
 for mt2701 and mt7623
Message-ID: <20210209205048.GA155491@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
 <20210201070016.41721-7-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-7-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 15:00:07 +0800, Chunfeng Yun wrote:
> Add two compatible for mt2701 and mt7623;
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: no changes
> v2: new patch separated from [6/15]
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
