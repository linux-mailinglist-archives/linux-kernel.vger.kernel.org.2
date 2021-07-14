Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA673C88CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhGNQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:40:36 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:35440 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbhGNQkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:40:36 -0400
Received: by mail-il1-f179.google.com with SMTP id a11so2226489ilf.2;
        Wed, 14 Jul 2021 09:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvSV9DfDpsl5FoylhFtZyQDYFQqbILb6lth89U0RgXo=;
        b=eqU+kGuPYvB+vTueQhdU8Cx6fNymK5Qql3ki0ay0KWRKrR0mkPEVGBxs9rklUiN4AA
         ZIm+3QpGyMtt/mAW0KMvUA3HBdRfgY24QjBCU79YzeufGC2BepQdTlIHsuXlHHia8G+5
         xv8uMmPJtPSu9V7UYnYVxFCRXeI6AKTThaltxxgBCInUemJlWG2h6c1lY0PJ+z6Xi3JZ
         1vgZdLy6p6hoXrwvPk7a4EiNUjlfE5UhO2l2zSttAcjIOd/7+O/L6StRirayPOC/T4JT
         Jkl7YTEL7wIMY7RgeiH3KzbNzX5f2BzTKqFf7lRKcvGb0S5Af92HajCOFN5xJ7EZp2Ql
         EAQQ==
X-Gm-Message-State: AOAM531dsGok6vTxtVK9pqWIJq6yFNQtTNRSmrIcK59II5yBMGwbxBYX
        Zu5z35Q2fMmhddxszOEYPA==
X-Google-Smtp-Source: ABdhPJybfnKLyt3zWGR1Mz5MrmFhJLmJDYIPJ/v58lFR0tKBQH/gG7+vZ28acd295aiviIieUK1I9w==
X-Received: by 2002:a05:6e02:1091:: with SMTP id r17mr7232171ilj.160.1626280664250;
        Wed, 14 Jul 2021 09:37:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p6sm1543333ilg.4.2021.07.14.09.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:37:43 -0700 (PDT)
Received: (nullmailer pid 2720225 invoked by uid 1000);
        Wed, 14 Jul 2021 16:37:41 -0000
Date:   Wed, 14 Jul 2021 10:37:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: fsl: add SKOV imx6q and imx6dl
 based boards
Message-ID: <20210714163741.GB2719790@robh.at.kernel.org>
References: <20210714045349.10963-1-o.rempel@pengutronix.de>
 <20210714045349.10963-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714045349.10963-4-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 06:53:48 +0200, Oleksij Rempel wrote:
> Add SKOV imx6q/dl LT2, LT6 and mi1010ait-1cp1 boards.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

