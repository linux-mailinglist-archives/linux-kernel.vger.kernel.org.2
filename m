Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB2402E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbhIGSau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:30:50 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39564 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhIGSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:30:49 -0400
Received: by mail-oi1-f174.google.com with SMTP id v2so66689oie.6;
        Tue, 07 Sep 2021 11:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WBm3/RVc74JuFx//faY79xyo3QlJCEJNAqjGkmkQ+8w=;
        b=IYtqZTcJiGIdFSEAmshK8pduMrdC4dsID496wheEwbh/fpgDR4Rqxx7hnZI7HGzPnD
         Go1gKutlcVOBVSrQUmveUygZD9z/t7vPwWPkh/eY5blo+Nf/uEC+qCW/HRi68kuZipu3
         76vE/ZOTK4q9zd/2i6U0kqwatXL72VDZDWKM1YZeMLVGt3/2plAFjUXSJa8jmwGx4vvm
         8Lnl8H0gvxMcO7JBS97O4WD8aZtKpKm+zayAr/1y/jIbF+12x79hXlHsEtc81vZRBRYl
         YtLtJqHOAyprx7K+JOiLpeTOYNnJZJBoo4rUM1gqL/OmdsCoFRq56J8pcCnEj2a6ewko
         VlVw==
X-Gm-Message-State: AOAM530CvrUWAdPKGng0f6NN8drtUwzaACyzBCha3y2xPbn2qdbfSNNT
        Gq73au61ho6JWdyE/1ptqg==
X-Google-Smtp-Source: ABdhPJyYC9hHrsEvwSbpnoLjACNQhcERTQQfgkhoJWHhla+NVH53kaUnth9ZlD2f5Ggaf968yJgYBg==
X-Received: by 2002:a05:6808:1481:: with SMTP id e1mr3945250oiw.5.1631039382328;
        Tue, 07 Sep 2021 11:29:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v19sm2246925oic.31.2021.09.07.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:29:41 -0700 (PDT)
Received: (nullmailer pid 108976 invoked by uid 1000);
        Tue, 07 Sep 2021 18:29:40 -0000
Date:   Tue, 7 Sep 2021 13:29:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     marijn.suijten@somainline.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        martin.botka@somainline.org, sam@ravnborg.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        thierry.reding@gmail.com, daniel@ffwll.ch,
        paul.bouchara@somainline.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: Document BOE BF060Y8M-AJ0
 panel compatible
Message-ID: <YTevlAXUHcw0Db0w@robh.at.kernel.org>
References: <20210901173115.998628-1-angelogioacchino.delregno@somainline.org>
 <20210901173115.998628-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901173115.998628-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2021 19:31:15 +0200, AngeloGioacchino Del Regno wrote:
> Document the boe,bf060y8m-aj0 panel.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../display/panel/boe,bf060y8m-aj0.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
