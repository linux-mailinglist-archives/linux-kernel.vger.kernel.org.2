Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F573FD0C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 03:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbhIABd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 21:33:27 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:37521 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbhIABd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 21:33:26 -0400
Received: by mail-oi1-f181.google.com with SMTP id y128so1761752oie.4;
        Tue, 31 Aug 2021 18:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FPQW4ZAVGJNxRy/TVDBlUl+1peECfC+I9o8RMPrW6tI=;
        b=gD5o4BOxypwOH/LfodN/zeN4sRPzeCZIAmVNxlkUDCDrePYbc2uDCBxoHcXEw13LSu
         IcxhhxKTBobE4eCw4f2pC/rrWsHag6CKsodaTpAucfq+teaUUEpdjRNfwVkLXbPmjva7
         bl/Ve+jxoRVpPNtzAoa4Cf4cV0gSxqbf6+AnGu8xhLO3tnrKv0kj0Omn+OFv0BftjOwz
         naotE2c94nDi63yEACUNxMIERvfKtiSA9nOfuelQVJWhlSkbF1Vi7VT/OcPu4/ZdRD/Q
         LtFig2RTRbXYYfKyS7OZTsuc2ifJA+liEK3TQVl/NwI2apI0p0GihhpETjDcNPjBr2Qn
         sxwQ==
X-Gm-Message-State: AOAM530qxD6jVflqr0Am2guZ+hXU1KK3gLsdcX3wUQ1be902ZjwMxUGj
        Zi/OUaHQaprNes9y9RuaehK1RbMDNw==
X-Google-Smtp-Source: ABdhPJxtK7AHE7nJVM3FAhLSR8ZOYj32gY3gK1DBdqgnHNU6undyLnsod5UTsebFKeMmecFIbMIOcQ==
X-Received: by 2002:a05:6808:1513:: with SMTP id u19mr5661184oiw.109.1630459949772;
        Tue, 31 Aug 2021 18:32:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o126sm3394119oig.21.2021.08.31.18.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:32:29 -0700 (PDT)
Received: (nullmailer pid 1000893 invoked by uid 1000);
        Wed, 01 Sep 2021 01:32:28 -0000
Date:   Tue, 31 Aug 2021 20:32:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: sound: max98927: Add reset-gpios
 optional property
Message-ID: <YS7YLHWcCXT1WWnk@robh.at.kernel.org>
References: <20210830104426.487246-1-atafalla@dnyon.com>
 <20210830104426.487246-3-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830104426.487246-3-atafalla@dnyon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 12:44:24 +0200, Alejandro Tafalla wrote:
> Add the reset-gpios as an optional property because some devices might
> not need it to work properly.
> 
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
