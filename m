Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39A53C64C1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhGLUJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 16:09:59 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:40729 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhGLUJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 16:09:58 -0400
Received: by mail-il1-f180.google.com with SMTP id b14so7711819ilf.7;
        Mon, 12 Jul 2021 13:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XaY5P13QTe8euUqHWNilvxRWXAenzeNcAcuUtAh0nfg=;
        b=Adr6xfzQCQpRLVZ7NkcMZn/aZPTovIRz2nBAcGZj09wvq/qgM/yXEWudU8id1hhb/L
         dlPq/EYhECl+oksWcBGUmZjtZjbc2bcGMKB6rSLKW5Y3t4mHdsBIPuLH3OvewvZY3Iyj
         6njkgRAruLQaJQRFOnsTRW3XmcqKVoWqdoIWBX4iQH5i+w+AjJyJkhDrGdaxGUJyIbTo
         iS3Geuj+mMqav0U5Pj0fKYM+a+mPqLCIoT1mtOn7orRPZxMtIxgLYsm14/29YaCX/iER
         hA3yl6PCx8fbVudGwXnP6dT29g6iQDH6pJWvb348aACKFJbPzyDpmoGKJnHUXdDMv5Tm
         QVMA==
X-Gm-Message-State: AOAM53065UYCrzqc3IzueJkVE0kknUyov8RLq89H34R/C0I1G2dNJ/Qj
        tPW1N0ZILN3GrtO6tScnwA==
X-Google-Smtp-Source: ABdhPJxtJIaEfT9Jfk2r9Q+q7xvAKbTSyWLDAuftGR8HZNIueK4kNBCA72i9T2wC8qD9sW/Xk3exTw==
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr412433ilh.9.1626120429493;
        Mon, 12 Jul 2021 13:07:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k19sm7559760ilh.60.2021.07.12.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 13:07:08 -0700 (PDT)
Received: (nullmailer pid 2401065 invoked by uid 1000);
        Mon, 12 Jul 2021 20:07:06 -0000
Date:   Mon, 12 Jul 2021 14:07:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: Add doc for ROCK Pi 4 A+ and B+
Message-ID: <20210712200706.GA2401021@robh.at.kernel.org>
References: <20210618181256.27992-1-knaerzche@gmail.com>
 <20210618181256.27992-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618181256.27992-2-knaerzche@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 20:12:52 +0200, Alex Bee wrote:
> ROCK Pi 4 got 2 more variants called A+ and B+.
> Add the dt-bindings documentation for it.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
