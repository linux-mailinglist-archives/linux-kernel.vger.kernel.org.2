Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981DB3C92D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbhGNVMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:12:47 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:36776 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhGNVMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:12:46 -0400
Received: by mail-io1-f48.google.com with SMTP id u7so3873792ion.3;
        Wed, 14 Jul 2021 14:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i1vfhn+CRUOHYGpYKbityrVIovO4erqwqnKHptg/N30=;
        b=R/dnMhlSWDgn0GNUZqr5+OgrFWQSa46FItQHl67lkhKom9rW/PMysKtK3VqmFtzo6E
         3Thso54zZngCN/S7a+jhgXTiBwGxFC7luEo+cikxq/PR6eduTHG+7D3mrpLrzlsiBOzY
         QUAaqFCABl1cxAV/bVQcxD2hEmwhSCFk49DHyO7Y4MqWvy6Cuwc799YGJmuPiEmdrNOW
         XQSCurLc/W6Sj2wgUmNbLc1UEkJ4GMmuK2vf3dvhuYC46ezHhafWEO4UTywMcvCIjs/K
         RPzREZ/06m/Hbq8KXHW1C7OUb38cu+kxMuW3LU8ofEMvAJ2IsXR+nSpNzUKzTv863lsz
         +5Hg==
X-Gm-Message-State: AOAM531arpk5w74rAlD4QyrTlv3pye5+XF6sWa7ZFXuJSzJOlEk1LPd2
        tC+ikKydZdzx9dF1FzwOWw==
X-Google-Smtp-Source: ABdhPJz7iMkOpKxv+9qy0XrhTd1+HIsoMrLD7EmQMOatdz2vJMZUodErwzMhE5Hr2jtWY1ej2fSMSg==
X-Received: by 2002:a05:6638:2726:: with SMTP id m38mr181470jav.115.1626296994336;
        Wed, 14 Jul 2021 14:09:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e14sm1859050ile.2.2021.07.14.14.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:09:53 -0700 (PDT)
Received: (nullmailer pid 3528907 invoked by uid 1000);
        Wed, 14 Jul 2021 21:09:49 -0000
Date:   Wed, 14 Jul 2021 15:09:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     vkoul@kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add the Amlogic Meson8 HDMI TX
 PHY bindings
Message-ID: <20210714210949.GA3528846@robh.at.kernel.org>
References: <20210629182047.893415-1-martin.blumenstingl@googlemail.com>
 <20210629182047.893415-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629182047.893415-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 20:20:46 +0200, Martin Blumenstingl wrote:
> Amlogic Meson8, Meson8b and Meson8m2 all include an identical (or at
> least very similar) HDMI TX PHY. The PHY registers are part of the HHI
> register area.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../phy/amlogic,meson8-hdmi-tx-phy.yaml       | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
