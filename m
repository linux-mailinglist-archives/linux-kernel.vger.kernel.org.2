Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCDA35FDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhDNWUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 18:20:50 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40542 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhDNWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 18:20:47 -0400
Received: by mail-ot1-f49.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so20806170otb.7;
        Wed, 14 Apr 2021 15:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jFyrIpeFo5U8A0ub5rVfkRP1qf9ceKJAtWSaPoYqoA8=;
        b=liW0NkZTPn77KvqzQhXgV9JIO467JfLxrxwF5P8Yqj89k10k5kA1ucWfMj/If1gh/w
         ZbLtr8NNwlurhjAsEuHwCPS9ZoboHxPMuEcVtvSOY91pL0ntcDpcy7rHPuhENIHSJM88
         H+VZvZLpfS1oAmosLfL6QrlSq6UV5NIxME8NcE5elzTXkIEVYX4hi0vnK5iRdSKTgZSQ
         QKkWIWhzLOYeICtCzG4vhipR8cZ/Go3S4plfEN2sSIMkxxfsJNZdxA7i+6HXCXPhBPeU
         qdr3Ijo6Rp+VJq1AuTlOEaqO2/wUhpsnb4KCZtMHweE+MZLwLnNqjG8mT9y4UwXQGByz
         AprA==
X-Gm-Message-State: AOAM530CWzAevz0kIQGsxnr/Vh/pTmzwxGXh5BPBBmDeMBE9jLYriRiJ
        ds1wCmTD0YLZl3dCw1+elQ==
X-Google-Smtp-Source: ABdhPJzasy2C8tx84w/qIT/2CBlJzhuZBN+y3/61CKGEdRa99Ugdd+1UWwRCiRj4qKg1CHgwIOuJig==
X-Received: by 2002:a05:6830:2398:: with SMTP id l24mr201288ots.349.1618438824647;
        Wed, 14 Apr 2021 15:20:24 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l4sm188103oic.26.2021.04.14.15.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 15:20:24 -0700 (PDT)
Received: (nullmailer pid 70448 invoked by uid 1000);
        Wed, 14 Apr 2021 22:20:23 -0000
Date:   Wed, 14 Apr 2021 17:20:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, enric.balletbo@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhangqing@rock-chips.com,
        heiko@sntech.de, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 08/11] dt-bindings: add power-domain header for RK3568
 SoCs
Message-ID: <20210414222023.GA70402@robh.at.kernel.org>
References: <20210414211856.12104-1-jbx6244@gmail.com>
 <20210414211856.12104-9-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414211856.12104-9-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 23:18:53 +0200, Johan Jonker wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> According to a description from TRM, add all the power domains
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  include/dt-bindings/power/rk3568-power.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3568-power.h
> 

Acked-by: Rob Herring <robh@kernel.org>
