Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BC3B3675
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhFXTDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:03:08 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:41933 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXTDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:03:07 -0400
Received: by mail-io1-f54.google.com with SMTP id i189so9577154ioa.8;
        Thu, 24 Jun 2021 12:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZHZcSl+Guo3A0OrRHLgNwuNNClqAUIEzAWDeV6zDBmk=;
        b=SaGrmYTu5OWAHL+Cs+OdUmgUksEI24onb5nodAVeaDpPTibLxyipL3TfMwvUGDEKd1
         hhRtfErxzKSYpA0Js8/fyCfPf4X4JbNyVoNJrLADJSOErJId5TxcEOdXonBOMWmLP3sB
         0uIYb09tt0zmLEQa4Ebqc+oZrWDIK7cuKYl3/btlNrwoA0aOSjPlI6+fosiUKJfYkK8O
         iAe/d0wt0pwIpPaPEol3ESSPnn0e90HVIt/2xjfSrzr/R32p3tdq2pDB1tYdB0p5GWvh
         Lpw1eXtDWB3rU64KNQGMf9az1XJ3OukTXMycsVxpRgh2aZooPPdcT7bgjmQjaP75uG3L
         BlZg==
X-Gm-Message-State: AOAM530mCheMN/TyklA3KIA2ajCqIz53jxtsTcEOiFCaXFM7QwwHaMDJ
        mfbm5Z5kNKcwyn0DhgjLaA==
X-Google-Smtp-Source: ABdhPJwptZl0dxHJRiEiwRYoF2dskkv7QQG/ROjfj2h9FwMHBWV0BmFqhNAaIwFQyYw19Rf80IV0Kg==
X-Received: by 2002:a6b:d001:: with SMTP id x1mr5146231ioa.171.1624561246872;
        Thu, 24 Jun 2021 12:00:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 17sm1418742iog.20.2021.06.24.12.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:00:45 -0700 (PDT)
Received: (nullmailer pid 1812831 invoked by uid 1000);
        Thu, 24 Jun 2021 19:00:41 -0000
Date:   Thu, 24 Jun 2021 13:00:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Xing Zheng <zhengxing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-rockchip@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clk: Convert rockchip,rk3399-cru to DT
 schema
Message-ID: <20210624190041.GA1812802@robh.at.kernel.org>
References: <20210610175613.167601-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210610175613.167601-1-nfraprado@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 14:56:13 -0300, Nícolas F. R. A. Prado wrote:
> Convert the rockchip,rk3399-cru binding to DT schema format.
> Tested with
> ARCH=arm64 make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> ARCH=arm64 make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> 
> One caveat is that this node expects certain external clocks, mainly 'xin24m'.
> 

Reviewed-by: Rob Herring <robh@kernel.org>
