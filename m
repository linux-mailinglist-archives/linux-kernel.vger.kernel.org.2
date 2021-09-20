Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200344129AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbhIUABT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 20:01:19 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42774 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhITX7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:59:18 -0400
Received: by mail-oi1-f178.google.com with SMTP id x124so3560123oix.9;
        Mon, 20 Sep 2021 16:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UruuD629pXbAo8v51EOt1Q9Zypsx+qAnm2GEsYAK93o=;
        b=tdKhzAtIS/wMlZcm+jLhh3oMX7/pIQn/tJxpYnNTJu6ONwqjF1Iu6XMUuTw3qAMkWr
         IanzSzg3vMqX4+xr2qH+CMcTIVZA9TExuCAzoFNP8styJKuUUkV6jrx/1agjcztQq2FF
         x96NNy+zPEJLYiYXnl1wptqMTEy4/ZqS9YgytBJ3Bn8Q07n0CN8ZIzguVatMJj++mX8x
         AA6hZ35c/aClYZZEWgwZ281OxWglCDC8wX5d1S9wPZnD7Y6g1QQRCL3Rmv58lLBfQL7N
         nxnTgw6va9pUEXD2N5irr39l/pvptHkT2pYJyMJWW3iZTikEZZzuCyyQezV1jLmB6RuT
         LivQ==
X-Gm-Message-State: AOAM532Y6ujJbx1S8Ap0G0uszrgUOOcDDLvkgJwnoHSKkev2QyQpOpzH
        pbcc6hkqBGkO08kKVUqA/+7A5kJAmA==
X-Google-Smtp-Source: ABdhPJz9yGQMN0ETSzATgC1fFl7Gk+YmDyRvnasrnXBZtB7PIUHnbjTmy4Pj/SBG727Ip3A7z4DE2Q==
X-Received: by 2002:a05:6808:168e:: with SMTP id bb14mr1318190oib.121.1632182270390;
        Mon, 20 Sep 2021 16:57:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i27sm3792076ots.12.2021.09.20.16.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:57:49 -0700 (PDT)
Received: (nullmailer pid 1071558 invoked by uid 1000);
        Mon, 20 Sep 2021 23:57:48 -0000
Date:   Mon, 20 Sep 2021 18:57:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     lokeshvutla@ti.com, kishon@ti.com, a-govindraju@ti.com,
        vkoul@kernel.org, devicetree@vger.kernel.org, mparab@cadence.com,
        robh+dt@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v2 14/15] dt-bindings: phy: cadence-sierra: Add clock ID
 for derived reference clock
Message-ID: <YUkf/Kld7zgZ0yss@robh.at.kernel.org>
References: <20210908122930.10224-1-sjakhade@cadence.com>
 <20210908122930.10224-15-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908122930.10224-15-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 14:29:29 +0200, Swapnil Jakhade wrote:
> Add clock ID for Sierra derived reference clock.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  include/dt-bindings/phy/phy-cadence.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
