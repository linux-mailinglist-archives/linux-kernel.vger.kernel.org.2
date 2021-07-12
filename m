Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD73C6334
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhGLTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:10:10 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:37378 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbhGLTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:10:08 -0400
Received: by mail-io1-f52.google.com with SMTP id l18so19047381iow.4;
        Mon, 12 Jul 2021 12:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VmcRJht2x/uN0knUjln6QgNgSrdkyqiua1j8QRrNut0=;
        b=bAc08CLT5ghs9XD6g4yjkvABYRJklS5rQrOLiOQNBWDh81ofLRsM1Nd+VDwSvbXf8t
         7yGKb41L4t79dtrW6+JcxIyQqHASKVto7Lbq9i7OdUddsJ2HcmK37r3O6g9fJAVBpueK
         tlQq/AE80OyjrslHYsUz5Ob5XdjnmXDDultLBYhgIqpWRmCicC7iwwf8OFpWqp/MF9VN
         vDJOTGwKzy8l5FK1ngvJ2LeZPQ2uSbLKqbZnFkajQv0lG5iJziO52DiXDXtH676AmpCF
         YQG3NoSyercPhxfkMsLH7/OT/QDCMpQ93OTER5iJSL0x4CIXHgLVhcufjszi5do5GtE5
         vTiw==
X-Gm-Message-State: AOAM532aoE8z7dowIPotmToitdheedtG57AvVOMSfJUG2ChHT4Ipxs4g
        vDQoOXb9NL1K+4Jvy3AoeA==
X-Google-Smtp-Source: ABdhPJwAC+XS9JfOz2h1JYILI1SxRdnRBCsJxMoNWOPCYSdzKKl0qZBUqROHqRvEsywCbKS7YHsZ3w==
X-Received: by 2002:a5e:8e44:: with SMTP id r4mr332283ioo.124.1626116838853;
        Mon, 12 Jul 2021 12:07:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y22sm1553509ioy.50.2021.07.12.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:07:18 -0700 (PDT)
Received: (nullmailer pid 2310216 invoked by uid 1000);
        Mon, 12 Jul 2021 19:07:14 -0000
Date:   Mon, 12 Jul 2021 13:07:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 01/13] dt-bindings: usb: mtu3: remove support VBUS
 detection of extcon
Message-ID: <20210712190714.GA2310182@robh.at.kernel.org>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
 <1624008558-16949-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624008558-16949-2-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 17:29:06 +0800, Chunfeng Yun wrote:
> Due to no platforms use a multi-funtion pin to detect VBUS
> status until now when support dual role mode, prefer not to
> support it anymore;
> Another reason is that the controller doesn't support idle status,
> the dual role port works as device or as host, using an IDDIG pin
> is good enough, this will help to save another multi-function pin;
> And fix a typo of 'neede';
> Last modify example using VBUS to turn on/off device, for device
> only mode, the driver doesn't get extcon.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  .../bindings/usb/mediatek,mtu3.yaml           | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
