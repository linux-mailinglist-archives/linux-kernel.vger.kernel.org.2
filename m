Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1F3C8BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGNTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:30:21 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:43537 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGNTaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:30:20 -0400
Received: by mail-il1-f170.google.com with SMTP id w1so2690874ilg.10;
        Wed, 14 Jul 2021 12:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X7kTm5gxPH5p4R1974v+PBm/+rts1oxk8UnzwjXHDvI=;
        b=NWRevJ9GB1BHJoFC48m7s+1NpShHo6wqorhyzsNq3uvV3QNKmEzGThCaDb8LZJWbad
         keXr9hXX2emLdNvAkR/9ntVuHEcUTMSsGNAY0gI6elFKRGkMUI9YlWYASRyb3//2cCo2
         wNzFfTFIwGPcjr6bx6VtOECNt8Nn9iZBDzos15rXCM3k/zBt/PHt9OWAeF8L7tE6RpNx
         fVc2vFEUmWg5+rYX2pY6ak1l0Sto0zedrP+haJTsofGNrz7nm9NxEXsiua+pLujbAbr7
         8dlZVt3wk/vk3GC0TwkoheMVYbfAV3JaxB4rruZVmMhE5w0pY6uQ3+t4nJFUHXbjBqn6
         wZ2w==
X-Gm-Message-State: AOAM5312d4NNIiVMQnbwVn3JmsbRjLVXFCERg3D9rkzfIxEjYbfl8qZk
        pf0MguYr+rb7HxrhwJusvw==
X-Google-Smtp-Source: ABdhPJwLfEEHxMq4jIi852lj9hsvLGqB9q7nGImJXGLliWf7IlphmFLzkEsu0O9EBURvHVmbKq0Rqw==
X-Received: by 2002:a92:2a10:: with SMTP id r16mr7384739ile.223.1626290847246;
        Wed, 14 Jul 2021 12:27:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h13sm1514223ila.44.2021.07.14.12.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 12:27:26 -0700 (PDT)
Received: (nullmailer pid 3080414 invoked by uid 1000);
        Wed, 14 Jul 2021 19:27:25 -0000
Date:   Wed, 14 Jul 2021 13:27:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     cl@rock-chips.com
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lee.jones@linaro.org,
        jbx6244@gmail.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, zhangqing@rock-chips.com
Subject: Re: [PATCH v1 1/3] dt-bindings: arm: rockchip: add rk3568 compatible
 string to pmu.yaml
Message-ID: <20210714192725.GA3080254@robh.at.kernel.org>
References: <20210624114719.1685-1-cl@rock-chips.com>
 <20210624114719.1685-2-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624114719.1685-2-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 19:47:17 +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> add "rockchip,rk3568-pmu", "syscon", "simple-mfd" for pmu nodes on a
> rk3568 platform to pmu.ymal.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
