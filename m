Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023DE365F37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhDTS3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:29:41 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36858 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbhDTS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:29:39 -0400
Received: by mail-oi1-f182.google.com with SMTP id v6so12079339oiv.3;
        Tue, 20 Apr 2021 11:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5MkXHWl0zc2TSHsinyPIxBJm93V7hB1LB+FDLNh37w=;
        b=DAPKGdPqs7fF9S0M8u87u6MHdZXgnUZHgYQkHyllveDhUOsNzmAZHBw2+bKZzDRgAg
         iZUhnCx66Y6ujA8oT7dhx5jVMwELXxURRMJn4a+7YD/JmANDRy6zW2Z8iSHyivNdVRQq
         hOE1KPB3bmUM5R7gQWwAW+2BYAuhOJGxLBiBkWyGPDqa17b6R58icbmPu6xwmbRfjgYk
         NfsYV3L+hw0asTQeJxd9Fk4nFCJJ0BwrQx0R1qNvOJ4jFkfOj26zIgl5gfhZ7lWTUxuN
         4QHKoseUe+IGNa7Kq/MsAD2xhnAIpUbCCA2NCDP78X9/uqE9oyV+2byrLfbDy6c0oqtS
         SifQ==
X-Gm-Message-State: AOAM532TdnEWYlpnQrAA6mCsFBIZwpCoknLJx+453gNmcQHHQx3IwCSF
        MNENGxEc1kOpL9WXhYfpjA==
X-Google-Smtp-Source: ABdhPJyWfQQTsfMzmr5Px8/cbjW5ZxSI3He90hBuTHgIf8csNl32Cm13WWv8w49Khb9CZtOOXpU5rQ==
X-Received: by 2002:a05:6808:b26:: with SMTP id t6mr3951139oij.74.1618943347884;
        Tue, 20 Apr 2021 11:29:07 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q24sm3907334otg.81.2021.04.20.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:29:07 -0700 (PDT)
Received: (nullmailer pid 3595364 invoked by uid 1000);
        Tue, 20 Apr 2021 18:29:06 -0000
Date:   Tue, 20 Apr 2021 13:29:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     devicetree@vger.kernel.org, Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-kappa
Message-ID: <20210420182906.GA3595334@robh.at.kernel.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416164055.3223088-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2021 00:40:48 +0800, Hsin-Yi Wang wrote:
> Kappa is known as HP Chromebook 11a.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
