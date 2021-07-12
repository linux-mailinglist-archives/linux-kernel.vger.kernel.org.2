Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25E3C6347
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhGLTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:12:02 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:47033 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbhGLTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:12:00 -0400
Received: by mail-io1-f42.google.com with SMTP id y8so24029087iop.13;
        Mon, 12 Jul 2021 12:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ryL66cZ8Fxa8J8T2kT+ROKwZPDNvqOBInHf/KU5Wb9Q=;
        b=kSxJ3+F+F97DuxgvTdvt/8hgSL6fCdNdT6OGixJjHsSK/izxpjJOTx62APPiCvRma4
         fZVRg9E45xbWsK70Xm+TsP+zxdQC81oAXkSUDQJ6n5coyBv5Xwi2u97MbU7Mo8wMB+tq
         6oLyDJ5QPgz9L/JCa8hoJZv/nHF3KXZdg5bS7xlASGiPKCvY7gxZ2PFJ9FXrHxaPyGrL
         TN3mdUujVZeIm6k4xrUwLmFAYO9k2DuD4fjYBLOU82OFMKsaKGUmYb9h0d6yY2+17wM7
         0dG9E6AEkTMQkKmspeYF5eSWAF4GWisxO7mXYRPegsGsbQwJsUzTj+Galpv9KzsMclea
         Xrzg==
X-Gm-Message-State: AOAM530qIc8bSAYnixtbqNX1y3ZMkg+4IhRMD6e83ijpEaV77ks+m2iB
        ieDi1GVyR1QcNABD5waLIA==
X-Google-Smtp-Source: ABdhPJy39M69RtfgFiUmpHIfZOMl8DpTTtviRMPj97/AnkFI0/PdUC4voQTnLuHSilmE5r2HP20Wtg==
X-Received: by 2002:a6b:f013:: with SMTP id w19mr336514ioc.182.1626116951298;
        Mon, 12 Jul 2021 12:09:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 15sm8577700ilt.66.2021.07.12.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:09:10 -0700 (PDT)
Received: (nullmailer pid 2313419 invoked by uid 1000);
        Mon, 12 Jul 2021 19:09:07 -0000
Date:   Mon, 12 Jul 2021 13:09:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 04/13] dt-bindings: usb: mtu3: add wakeup interrupt
Message-ID: <20210712190907.GA2313362@robh.at.kernel.org>
References: <1624008558-16949-1-git-send-email-chunfeng.yun@mediatek.com>
 <1624008558-16949-5-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624008558-16949-5-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 17:29:09 +0800, Chunfeng Yun wrote:
> Add an dedicated interrupt which is usually EINT to support runtime PM,
> meanwhile add "interrupt-names" property, for backward compatibility,
> it's optional and used when wakeup interrupt exists
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  .../devicetree/bindings/usb/mediatek,mtu3.yaml      | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
