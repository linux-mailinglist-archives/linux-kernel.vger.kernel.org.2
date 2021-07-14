Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E953C88C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGNQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:40:08 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:33754 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGNQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:40:07 -0400
Received: by mail-io1-f53.google.com with SMTP id z11so2949777iow.0;
        Wed, 14 Jul 2021 09:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E4AvJhetNwASZem5dl8Fp/vANmJkc1r/xjwo+QbtJNI=;
        b=SmxSX7dN7b+AMmVcxi63JWOF+vk+g6OW4+pZzEnkpfvVC67rxMcoPH+H47JVL6TpaL
         eiFMG0K4LRp26bIofw67PIuY7bpTVbvn8AE0z3ImZjYTHrmVr7aUun0GW8tCZR65JDR4
         gGPf4rcSUiagovs1RHrf1rWqOi6LP9ot8iTWy+pf1Go3BGqoxHOgwLIQg3vMP+2T1+la
         eG5/HNcL1Afzbx9fVnAuFXdjIfgeRh7eXK5/mjT3YkPYgxN86aABirfjm7yhl/ICt0iL
         f2jvZnMlZZ4bGOsl5V/SUd/HGVmigzO28rVR028ekKHwVN1+cN/Kj/o2BaO5jvbNL0FU
         ZcAA==
X-Gm-Message-State: AOAM532l7INibQWErnJNbwtgMUrqoem3OXhYT3p+Q6VVW5rSIFV7TGqW
        QmIocaKj2kH3v3ixDla94w==
X-Google-Smtp-Source: ABdhPJyyqzjI4orQEKBGudclxA6i5CqYo1oBoYaIfnzXMXkj0ILABCTs+SeLuzpf8Is17w4C3VeFtg==
X-Received: by 2002:a02:ad08:: with SMTP id s8mr9861761jan.40.1626280634475;
        Wed, 14 Jul 2021 09:37:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r1sm1078472ilt.37.2021.07.14.09.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:37:13 -0700 (PDT)
Received: (nullmailer pid 2719225 invoked by uid 1000);
        Wed, 14 Jul 2021 16:37:10 -0000
Date:   Wed, 14 Jul 2021 10:37:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Fabio Estevam <festevam@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: simple: add some Logic
 Technologies and Multi-Inno panels
Message-ID: <20210714163710.GA2718995@robh.at.kernel.org>
References: <20210714045349.10963-1-o.rempel@pengutronix.de>
 <20210714045349.10963-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210714045349.10963-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 06:53:46 +0200, Oleksij Rempel wrote:
> Add Logictechno and Multi-Inno panels:
> - Logic Technologies LTTD800x480 L2RT 7" 800x480 TFT Resistive Touch Module
> - Logic Technologies LTTD800480070-L6WH-RT 7” 800x480 TFT Resistive Touch Module
> - Multi-Inno Technology Co.,Ltd MI1010AIT-1CP 10.1" 1280x800 LVDS IPS Cap Touch Mod.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml     | 6 ++++++
>  1 file changed, 6 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

