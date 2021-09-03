Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81F40043B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349030AbhICRmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:42:07 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38592 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhICRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:42:06 -0400
Received: by mail-oi1-f172.google.com with SMTP id u25so127334oiv.5;
        Fri, 03 Sep 2021 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I5aqBhpR9mUox8VcYbsiI0dM1OA2egSfhrZLllSSLmM=;
        b=fz4NZ1zWa5jla+mNLmqazpTR3q8wuTDdImfQqA7+LlbGKjJ2GJqmoZVTqgskRZ880d
         va3RGHbsMjWuoPASqyj/jgrCdLQOs/TfeSWn5OlsAuesxfBx+rx/AnhX3m7AvSJGhYwJ
         84SK3smQlcTDodAq+Z0kXgdgaGevRftLHjA4/XWLVB/Ydvm8kq9zsZ69fytWUZ3spkVQ
         4Nv3oLqkrreIgHSSgz1JebjOgTwK4A3ChclsQ11LaY+lFem5+aW73+/uG7hkDveWmLeO
         K4AXDARKGexm0VtTCdpsCYND3YtZ57q5VN+ZyxbLKK3EX5Xq1Rg3xaNfQbMpjzeUm0Zh
         TZEA==
X-Gm-Message-State: AOAM533exYvAEGWpTgc+7COXiSuCUrfh1MPMqzyX4IP2VkLScIZFNvsH
        inygk+eVLwo5xskSOkT1tw==
X-Google-Smtp-Source: ABdhPJzz37ev7x13NbSOO6OMOr70qaGSmIr8sgijivR2rjTcC2e0rQkE2jhNkpGOOSomWhNdmRnIeg==
X-Received: by 2002:a05:6808:8e3:: with SMTP id d3mr23334oic.92.1630690865918;
        Fri, 03 Sep 2021 10:41:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z26sm511oih.3.2021.09.03.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:41:05 -0700 (PDT)
Received: (nullmailer pid 3150072 invoked by uid 1000);
        Fri, 03 Sep 2021 17:41:04 -0000
Date:   Fri, 3 Sep 2021 12:41:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alejandro <atafalla@dnyon.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: sound: max98927: Add reset-gpios
 optional property
Message-ID: <YTJeMGMAeRjmI5Mu@robh.at.kernel.org>
References: <cover.1630632805.git.atafalla@dnyon.com>
 <102ae6df3b5398e8c66b954ac5e13a9d565fab6f.1630632805.git.atafalla@dnyon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102ae6df3b5398e8c66b954ac5e13a9d565fab6f.1630632805.git.atafalla@dnyon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2021 03:49:51 +0200, Alejandro wrote:
> From: Alejandro Tafalla <atafalla@dnyon.com>
> 
> Add the reset-gpios as an optional property because some devices might
> not need it to work properly.
> 
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

