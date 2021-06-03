Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E973997C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFCB4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:56:25 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39808 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFCB4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:56:22 -0400
Received: by mail-oi1-f171.google.com with SMTP id m137so838547oig.6;
        Wed, 02 Jun 2021 18:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnkSyGJtydbOTw7eN1iAiXunldhukrszM8aeXuN8n7w=;
        b=gj506uNT3R9TmLBd9BOaNNrI2msAniXciNLKp4tY/xTA8PWzWzrobWhOXG0/oWJpjf
         9GJrLmvl7UBEq04NfRICUkhr6mglf1DyEFBrCqHtpwUhkipzM1tLPVvwXO9JeP8DDyqX
         jzPw/baGH3y8Prkmxc96ouMtQw9cpbCeQ56qa2bIHl/+dUmfDk+Bo7nYPLsG1vhMGxvU
         Uhr829lswV+wJOZTIpJarsF80xBjsPf34Yqz/S0iMLvJu/z60tEnAxFjTBIe9GggPAEG
         JPyEY/haPyJRq5FiCea1sBaph4M/WDpiGOPMr2hHcndSzB0OY2ZLwl8WvMECmEcwaFri
         55cQ==
X-Gm-Message-State: AOAM531pvH/dY51MlrWCvzSlya+4DoySffCRKstFCEucnfzLvkN7wCwc
        kO8jBIqD7KvkgRRI34eZJYCqp5Bdmw==
X-Google-Smtp-Source: ABdhPJwS9HkkVPjirrzAmBQT/udO89bk2u6gfshqxAGM5rYJBXhwrTSRQsRKuJnptLjbU7ZTYbtHbA==
X-Received: by 2002:aca:fcca:: with SMTP id a193mr6209865oii.40.1622685267669;
        Wed, 02 Jun 2021 18:54:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m1sm376635otq.12.2021.06.02.18.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 18:54:26 -0700 (PDT)
Received: (nullmailer pid 378473 invoked by uid 1000);
        Thu, 03 Jun 2021 01:54:25 -0000
Date:   Wed, 2 Jun 2021 20:54:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/12] dt-bindings: power: supply: cpcap-battery: update
 cpcap-battery.yaml reference
Message-ID: <20210603015425.GA378329@robh.at.kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <1d0c8d50db22d9e5540a42be874fcd39fb7fc2a7.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0c8d50db22d9e5540a42be874fcd39fb7fc2a7.1622648507.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021 17:43:07 +0200, Mauro Carvalho Chehab wrote:
> Changeset 3c5be0454972 ("dt-bindings: power: supply: cpcap-battery: Convert to DT schema format")
> renamed: Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> to: Documentation/devicetree/bindings/power/supply/cpcap-battery.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 3c5be0454972 ("dt-bindings: power: supply: cpcap-battery: Convert to DT schema format")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/motorola-cpcap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
