Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA23CA230
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGOQY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:24:29 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:39519 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhGOQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:24:28 -0400
Received: by mail-io1-f54.google.com with SMTP id h6so1108821iok.6;
        Thu, 15 Jul 2021 09:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MORG+AZYmoVSmP90T7xMju1rDj3gu22dvginYkF/pWk=;
        b=rPEIJz4Zh//GWdBlqdraxa3MevS2v4t2O50k+om6rWVgDdALSXyKmH7+Kur0Hjkmah
         7IMbpKs3kA85eSg5izrIAV9V5mHu8qx8jv/91JNGOdca/YlwFdCdulF6p9gwKz/QyBnp
         IJ8zUe+kDonqvjcQhs8VH4U+DhPzAVMWe/1FM40GfApLN+chWkGL1BNCMGkO5VT3415Z
         qkfTBccWmlqM2cgalPkfi3SpRuektysWdZFn7uKxgwORF6BPYFzo1ju06gQKFlHjkO2n
         GGRnSDBnf1pA+pxht3QvTefE4N8IpSpszmikJ1XjvV/itdGUfvv9jVxaS3PpUCB8jnRD
         QGzw==
X-Gm-Message-State: AOAM533YD2/QbCqK7+eN+UNgQK/nIY73Eaovc5mFjXR3Lv2l8Gly0sfd
        xmaAoF219RR+yxuoYGHxOw==
X-Google-Smtp-Source: ABdhPJwZst+LtOnZztCRCAZJqe2310rBglhVaTzN0Q6Xqk3BEjd+Sd1wzFIvwvZvqbvTAAcJMXSxjg==
X-Received: by 2002:a5e:930e:: with SMTP id k14mr3782237iom.136.1626366094388;
        Thu, 15 Jul 2021 09:21:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t11sm3134538ilj.63.2021.07.15.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:21:33 -0700 (PDT)
Received: (nullmailer pid 1184602 invoked by uid 1000);
        Thu, 15 Jul 2021 16:21:31 -0000
Date:   Thu, 15 Jul 2021 10:21:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Liang Chen <cl@rock-chips.com>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] arm64: dts: rockchip: add basic dts for Pine64
 Quartz64-A
Message-ID: <20210715162131.GA1184545@robh.at.kernel.org>
References: <20210710151034.32857-1-pgwipeout@gmail.com>
 <20210710151034.32857-5-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710151034.32857-5-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2021 11:10:34 -0400, Peter Geis wrote:
> Add a basic dts for the Pine64 Quartz64 Model A Single Board Computer.
> This board outputs on uart2 for debug.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 321 ++++++++++++++++++
>  3 files changed, 327 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> 

Acked-by: Rob Herring <robh@kernel.org>
