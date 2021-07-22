Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533943D1C10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhGVCJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:09:51 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45885 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhGVCJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:09:49 -0400
Received: by mail-io1-f53.google.com with SMTP id z17so4673877iog.12;
        Wed, 21 Jul 2021 19:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ufJOt3s4xnD/zrL6wx1XOxKXgCd7sL0/12l79h4dyKQ=;
        b=MDz3lWpDZEZtaIi7YOLvYjPWmMTGVr2RXbjBmnMLhgj7lsrwz+iirlhbwHZmlCkOMH
         20kgCBi5zT+RvFNU+ukJN4PO9+RIUKEJ58xafH2A4gvbFdd/kBbTKdlS4iD6elv2/6Kp
         ND2BH/XdnNJKyHjcXgUHJnuimQLc9RP1Az3YqnSBjdjoAFlC1Wu2b7FbzPyyCLp7ZHtE
         7yA5XnaimgC1k07Y73w/lUy/9+686aG+XPzqUAxFCK8kGSlkROOw7Uue3AGbNRtRpT3/
         vkdrxrIF6/PfRaxGEM/w9RJstvBo2DK5sulGuDSL5MbsEeSjnWU0e4bfXWdd2jiZCAQT
         gOPA==
X-Gm-Message-State: AOAM532eKkKpuSiHbw1DNwm/st3B0kyMKsq0CScSMCKulzHKYhjTFzcc
        6jRkFSEUzfVDT6yLzUvpQg==
X-Google-Smtp-Source: ABdhPJyOeywBVnXkZ+x1O8LDM0zWz+/vkCtEewMhu1XJNVLdsdRM+UJVjTzN04GxJ5Mn128sIPTiJQ==
X-Received: by 2002:a5d:89d6:: with SMTP id a22mr6520811iot.178.1626922224652;
        Wed, 21 Jul 2021 19:50:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c16sm14583134ilo.72.2021.07.21.19.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:50:24 -0700 (PDT)
Received: (nullmailer pid 3202242 invoked by uid 1000);
        Thu, 22 Jul 2021 02:50:22 -0000
Date:   Wed, 21 Jul 2021 20:50:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org,
        Yuwen Ng <yuwen.ng@mediatek.com>
Subject: Re: [PATCH v3 02/13] dt-bindings: usb: mtu3: add optional property
 to disable usb2 ports
Message-ID: <20210722025022.GA3202212@robh.at.kernel.org>
References: <1626340078-29111-1-git-send-email-chunfeng.yun@mediatek.com>
 <1626340078-29111-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626340078-29111-3-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 17:07:47 +0800, Chunfeng Yun wrote:
> Add support to disable specific usb2 host ports, it's useful when
> a usb2 port is disabled on some platforms, but enabled on others for
> the same SoC, another case is that the different package may support
> different number of ports.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> Due to there is property 'mediatek,u3p-dis-msk', prefer to use
> a similar name for the similar opertions, not spell out 'mask'
> as suggested by Rob.
> 
> v2~3: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
