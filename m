Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667D9419E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhI0SjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:39:03 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41573 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbhI0Si7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:38:59 -0400
Received: by mail-ot1-f41.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso25647132ota.8;
        Mon, 27 Sep 2021 11:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SuxR2IvzQVEkyDLBWxJcO67m/+ONZAWmCGPQgvvSfpw=;
        b=XKmNfn5VnlT/7TxYsoGPrKRTTm2XXx3V+GVlsUevzNu2VOXDt7mgOeSSNNfCxJBDXr
         7GhZvP5BXR7RbadF4QOy+BXR2sWyx5GOozFS63debD0VJnb5m1S79Ix6+smX0gWlR5IZ
         VsjDfu0kN3cZmp5ydIqy/st/FdszcW4jypOfM4lNrTf36oX4RKVeLHqZMjXblTyMIV7b
         a7x/z14Ksgbihx/oNIO7m4OCscQdlKetkPXBB3otl/N4cA7TnvnEZvCYuR5bpLFEEhKC
         fqK04XSrtXMToMMIYiKVEaPvgGG/A7B50/5HNISdTxnNogiYz9Jz/HrwoK6qe6+jZvYA
         FmJg==
X-Gm-Message-State: AOAM533McIHhoqmfwxJB/2coGKFKaEOIIqlGMlKrOsASWJZ2lxutTRIL
        2hYwXwsXlwcCM7HJAtiwCQ==
X-Google-Smtp-Source: ABdhPJwkRNJVkLd+tuErpymK7l2Tzio+zqB0FOLe74K9baG82pc39/nCxvdnmBx/hiPlkp7PuzHAfg==
X-Received: by 2002:a05:6830:25d6:: with SMTP id d22mr1379151otu.50.1632767840510;
        Mon, 27 Sep 2021 11:37:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p8sm4086338oti.15.2021.09.27.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:37:19 -0700 (PDT)
Received: (nullmailer pid 3610993 invoked by uid 1000);
        Mon, 27 Sep 2021 18:37:18 -0000
Date:   Mon, 27 Sep 2021 13:37:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-jh Lin <jason-jh.lin@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH] dt-bindings: mailbox: fix incorrect gce.h file paths
Message-ID: <YVIPXvjcfHg1uZ+6@robh.at.kernel.org>
References: <20210922070845.5108-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922070845.5108-1-miles.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 15:08:45 +0800, Miles Chen wrote:
> A few *gce.h file paths are not in 'dt-bindings/gce/<chip>-gce.h'
> format. To fix it, replace 'dt-binding' with 'dt-bindings'
> 
> Fixes: 0553fb51686e ("dt-bindings: mailbox: add definition for mt8195")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
