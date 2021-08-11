Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2514E3E97CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhHKSlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:41:06 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:39729 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:41:05 -0400
Received: by mail-pj1-f46.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so11046888pjn.4;
        Wed, 11 Aug 2021 11:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YgL5QZA+nttpaayeuohalxKILerIeWnfwKqrpAxGEV8=;
        b=Xbw75G3rL0OV/OcYpmsUGoSt8qhnLSh6vfQVdiYuM5rAH4aht7qZycDZsnkxoV23Q3
         GPQkDbz1tYi7Z4TmMa9Cn8GAn/MNHj7d/WABtrckpsH5y3/zLceLwlk/c7RkJEiVY6Ae
         AvGLNAwuNJm62KUPxhMp9wSf5eeQAE9wbj5T/UK8NOu7JGePP2ZC04NC35tM42z37JCV
         prM7pHtQvxvXpoPMEt3gEcVeY9PYPDc17vcJygB0Zs9uhcPFFg+co1aO6eEV7WayTr1Y
         0BEZ9ctKCNThJc2TydCYJiW37bBYfYKP55QaK0IomMZ06xQ9c9gvmsYgGENbkeCuMkdO
         Do+Q==
X-Gm-Message-State: AOAM5317ZKlnyUXLu6xZSSZu7J7i02hryXWUFG74p5XKpTzmRSThRK5o
        fEtK1AwQyOAr3Slf5/DMcw==
X-Google-Smtp-Source: ABdhPJwnahoo1EM8pHpP+QSc3xuGsCPXqSQ/jRidO7xuzVac8Xmgh3XG//7qIy7NBtmcjC/sj/1XOQ==
X-Received: by 2002:aa7:9906:0:b029:3c7:a6a1:c73d with SMTP id z6-20020aa799060000b02903c7a6a1c73dmr199239pff.1.1628707241447;
        Wed, 11 Aug 2021 11:40:41 -0700 (PDT)
Received: from robh.at.kernel.org ([208.184.162.215])
        by smtp.gmail.com with ESMTPSA id d9sm224216pfv.161.2021.08.11.11.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:40:40 -0700 (PDT)
Received: (nullmailer pid 67452 invoked by uid 1000);
        Wed, 11 Aug 2021 18:40:36 -0000
Date:   Wed, 11 Aug 2021 12:40:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Shawn Guo <shawnguo@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Fabio Estevam <festevam@gmail.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: fsl: add SKOV imx6q and imx6dl
 based boards
Message-ID: <YRQZpGn/+XfDy4Gj@robh.at.kernel.org>
References: <20210804043439.11757-1-o.rempel@pengutronix.de>
 <20210804043439.11757-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804043439.11757-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 06:34:38 +0200, Oleksij Rempel wrote:
> Add SKOV imx6q/dl LT2, LT6 and mi1010ait-1cp1 boards.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
