Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105F340EB78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhIPUPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:15:17 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34689 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIPUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:15:16 -0400
Received: by mail-oi1-f176.google.com with SMTP id p2so10762225oif.1;
        Thu, 16 Sep 2021 13:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkjlCbdJ+/1asKmrWsWvetw+Vl0IFwVHJ8pm/ixnUJ0=;
        b=GiB6mJ64ZKzKVyTK7p4SxBZKWmlG+ePLP6+TExkCgTpov9k3DYzbN9Wrgr49Hcieuz
         7TRJYW93bcugMM1daMr44HXsI24vg5/vgFW7LeDf5Qk8b+2bQl7EqR5SUwFTfBoH4UKT
         cJUcm7h1Fr6Nf0w3BGVgPPb0RRXlz046g+yXTLya1FZ/Gav2dpT1wZsirMLqCfS6zHer
         Tio67lWT53t93e8VWDAaVpby6tG6N8S+O9pqdYsAoPcHQ4uBDl8kLd3Jvm4kDb4rC4ma
         H2qfn354fBlEHi36E023Z9QXAtDT3lyI0xt/4CT2CtUBjoHaTv+t2j0SydThrkUbGySZ
         EAiQ==
X-Gm-Message-State: AOAM533n64a6ipX7tdrDod5cLvFYt7wfXWkrKI+XVHIKSzG0aPxhYv75
        A/ZUOumHZNSU3CcPsY8SGcrfNGHDbw==
X-Google-Smtp-Source: ABdhPJypkToC1MJEJpn8Xj/+02g+RldDXoc1hjYx0aMlQb2vDjNw3JYQQwtuw7XqKuuLAMKUuLu2Cg==
X-Received: by 2002:a54:4812:: with SMTP id j18mr10847011oij.55.1631823235172;
        Thu, 16 Sep 2021 13:13:55 -0700 (PDT)
Received: from robh.at.kernel.org (107-211-252-53.lightspeed.cicril.sbcglobal.net. [107.211.252.53])
        by smtp.gmail.com with ESMTPSA id s8sm952199otd.76.2021.09.16.13.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:13:54 -0700 (PDT)
Received: (nullmailer pid 1420373 invoked by uid 1000);
        Thu, 16 Sep 2021 20:13:51 -0000
Date:   Thu, 16 Sep 2021 15:13:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vyacheslav Bocharov <adeep@lexina.in>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: vendor-prefixes: add jethome prefix
Message-ID: <YUOlf+LDMXewucbW@robh.at.kernel.org>
References: <20210915085715.1134940-1-adeep@lexina.in>
 <20210915085715.1134940-3-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915085715.1134940-3-adeep@lexina.in>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 11:57:15 +0300, Vyacheslav Bocharov wrote:
> JetHome is trademark of IP Sokolov P.A., manufacturer of home automation
> devices.
> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
