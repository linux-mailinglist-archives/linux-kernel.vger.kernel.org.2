Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990133C5ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhGLPH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:07:57 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:44869 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbhGLPH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:07:57 -0400
Received: by mail-il1-f177.google.com with SMTP id r16so12855224ilt.11;
        Mon, 12 Jul 2021 08:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQrxpX8YYl6VoTfdvJSNcghMFZX/hFzAgQgraiuHOJ0=;
        b=Ui2KXkD0a0RJcXVuxRguatcvQraEAZ6WNfVC5QOsd0swyR5nxtQ4aYaybu+/KDvCjt
         cAkn6Oc99f/MonvJwO9oFDmu6aw8q2OIYCYXEEyjpjxWrL8jkDeXKfZEtisbZMvQKfsZ
         tyku97s55FDeo92LH/TBU0kr0SZ1d+++2GyG/nRyuAP3kcvoZP4Miyje0SFKDQboDRcU
         0JzZi8OLIaSJMa7xQKFvKR+kf2CA/jJKE94/HlYJ627X/wqjExEgwb9EkFs8Uda2ZbsV
         2q30oljHbNUjG9Noacwf0rYueU2DkPbwzQM2bUErmiQKShHJIScykHj/5nr96FPLKbLK
         X/0w==
X-Gm-Message-State: AOAM533ryvq16S697/7BQSPE/xgpfD5Ert46lXj75Icyynn5tSqh3O4H
        a3GDoCS4bqMgxpkUMXv6Nw==
X-Google-Smtp-Source: ABdhPJwtzIgpMoURXaDZ8JILC1RD7IpKSIcAw/P9qBVtWBCvHRE3WS22wzdQA/MB5/jMI9iHSCAlkQ==
X-Received: by 2002:a92:d943:: with SMTP id l3mr16628674ilq.37.1626102307482;
        Mon, 12 Jul 2021 08:05:07 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v9sm2014150iop.14.2021.07.12.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 08:05:06 -0700 (PDT)
Received: (nullmailer pid 1930813 invoked by uid 1000);
        Mon, 12 Jul 2021 15:05:05 -0000
Date:   Mon, 12 Jul 2021 09:05:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 2/5] dt-bindings: spmi: document binding for the
 Mediatek SPMI controller
Message-ID: <20210712150505.GA1930783@robh.at.kernel.org>
References: <1625368018-17505-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1625368018-17505-3-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625368018-17505-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Jul 2021 11:06:55 +0800, Hsin-Hsiung Wang wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
> changes since v8:
> - Add MT8195 compatible name for spmi support.
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
