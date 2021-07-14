Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B43C9293
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhGNUzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:55:23 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38491 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhGNUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:55:21 -0400
Received: by mail-io1-f45.google.com with SMTP id k11so3813176ioa.5;
        Wed, 14 Jul 2021 13:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1BjMiFm/xS6B+fxE+xnjxZgvS0rjMUop/UpczXhIRU=;
        b=AUlDcWB9Qn0numGYySriFLb/5yJJ1dhkCvku3MyTuwQKieDIgQr9Plv2CSgsp+chWf
         kRUzy0gb/9rtaAuyCsFddzrm1MlTQWo1vygPPwW5H9gQ2J/2RW9uwthTMI2M/9IozSOg
         nix1fYIz6iIRdf5ptHXyoUjPSZDqshHeYJwpjouc/ejeEQ6kraZ1Yt2l8Ipir9ZpB8yW
         WJ34W4up8oDpg13w3Zhy+Rj9S3m8iR1wEuNaJ99GRpKDKH/EyWAbiregWdgYgEVXfdxy
         VuiBFKutaYZuWIN/7sTYgyruLXREF6Iobn0zaqzIMZnjhQMe5dMTC0StoaHgUICAi+yD
         ExPg==
X-Gm-Message-State: AOAM530NtXLilobtYvP1qmY4LJMhOENF/TFbnv4HmbGE0DX008v7G5RW
        GeIgTO3Lgh5yM0F9rbaamLmq+UKjIe9C
X-Google-Smtp-Source: ABdhPJzx/mstRn2IXdCjC+oslK6tvpCMxnRGPLU8xCC2kA2scrk6HyIlrAdk7TZMLBdoO+P1sG+RPA==
X-Received: by 2002:a5d:9958:: with SMTP id v24mr51618ios.4.1626295949319;
        Wed, 14 Jul 2021 13:52:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j24sm1832785ioo.16.2021.07.14.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:52:28 -0700 (PDT)
Received: (nullmailer pid 3501321 invoked by uid 1000);
        Wed, 14 Jul 2021 20:52:25 -0000
Date:   Wed, 14 Jul 2021 14:52:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     djw@t-chip.com.cn
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Liang Chen <cl@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wayne Chou <zxf@t-chip.com.cn>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Kongxin Deng <dkx@t-chip.com.cn>, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        David Bauer <mail@david-bauer.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v0 1/2] dt-bindings: add doc for Firefly
 ROC-RK3399-PC-PLUS
Message-ID: <20210714205225.GA3501265@robh.at.kernel.org>
References: <20210628035402.16812-1-djw@t-chip.com.cn>
 <20210628035402.16812-2-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628035402.16812-2-djw@t-chip.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 11:54:01 +0800, djw@t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Add devicetree binding documentation for the Firefly ROC-RK3399-PC-PLUS.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
