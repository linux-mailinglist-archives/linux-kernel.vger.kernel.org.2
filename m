Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9598E38BBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhEUBtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:49:41 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44661 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhEUBtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:49:39 -0400
Received: by mail-ot1-f53.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so16644443otp.11;
        Thu, 20 May 2021 18:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jmKAWY+ilzE9n7Zwbge048gHMsOHlB/JocEpo9sP+mI=;
        b=Be4XnduKw5ESkjnQyq9fh0Dosg5Q7f/js3hL7JxHYWuA4q3LpuvdmNS8dz2rvPPtaS
         KBQdxLjz6RVofkqJMV5OdntqDIykV5xXdu8BlQb2LrNnzx2zgVzkh6YvcjTVRMLoQ1Kl
         p6gPnOb9K6uRarHIzAwMq4sbGdPNAhNCkph+NGDRRwq4qu14D0TyLIK3JcbvJ69sX5mk
         uAuGghyQMSXbU15D2FprnzT1RanhJWu+CPKhcNe0G9Uv37h6ErZofUVP3QZt3OC8NhyB
         LD6INiD4TbeZc5TytgSiu1pefc+TjVg5bE+UiEg5ID1ydvhoj4fPR1x5VAHxAZyZWp+F
         IKAg==
X-Gm-Message-State: AOAM5326a/Bcyi/wMoqxlgZi3qR6XIUUH7Box8JEqByQAfTpJB6cJ2Y3
        12vk0EJB7rUS8SGER78hUGsxZ/Np/g==
X-Google-Smtp-Source: ABdhPJwpOly0AdzhSkZhR+HO/LhEwVqZO/Cu3mihGksiE00ZNUpIOJwE81lyGZGnoqna4ai+qKLm9g==
X-Received: by 2002:a9d:6944:: with SMTP id p4mr6039375oto.157.1621561697448;
        Thu, 20 May 2021 18:48:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t26sm1011673otc.23.2021.05.20.18.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:48:16 -0700 (PDT)
Received: (nullmailer pid 2476836 invoked by uid 1000);
        Fri, 21 May 2021 01:48:15 -0000
Date:   Thu, 20 May 2021 20:48:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, mkorpershoek@baylibre.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: mediatek: mmsys: convert to YAML
 format
Message-ID: <20210521014815.GA2476751@robh.at.kernel.org>
References: <20210519161847.3747352-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519161847.3747352-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 18:18:44 +0200, Fabien Parent wrote:
> Convert the mmsys bindings to the YAML format.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 31 ----------
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> 

Applied, thanks!
