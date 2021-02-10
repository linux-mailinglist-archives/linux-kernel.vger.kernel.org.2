Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55070317398
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhBJWps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:45:48 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39289 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhBJWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:45:45 -0500
Received: by mail-ot1-f48.google.com with SMTP id d7so3436449otq.6;
        Wed, 10 Feb 2021 14:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NTjPSQnNqlFRAkz0a6xaD4E0SOmzHGZrh2Mkjc0lXfA=;
        b=sThgNLYNS/Oeu+35g2ywHx83Dltl696R1riE5BO/OGjD1ZNxXebnCDfcZQ4pai2gjc
         38VrLZLOOvgTB8RtZ2xkt92lFzGLWxQWDJ8cf4t/1UeURatmunIlmwkbPsrL7isKZmEB
         XNzQt0z9rHLPpYjGfkrtSq2YrEwZadRnCTfrZcatuAhAnHKDmNP8ZF3hx8PjTqZzwS4O
         RCXCm75s7NuLQv1ZsRrLT94cw+zE7ttVrxNuriRTt/vc3CImp+VEhLuySHS4UvE4Jg23
         x9H3HOzkc/awDg5imMu4qpTLJOgqcdPUAHOvKpdbbgDel/R1yR8A0i5IdN5PcJyU7HZM
         LZ+w==
X-Gm-Message-State: AOAM532sLNSsMRIuBxA1wsleJim4nePz2+xlcMrkGqqggYqonAD3uRvP
        nW8LD9+8kwOTBYFNbdok3Q==
X-Google-Smtp-Source: ABdhPJyPJiR05AIrtKUTCS8xD+LsyHECj9z0LbPXixoaHK1zkj0KdQ/1Cl58xPOLrZ6Vlws8Zi/D8g==
X-Received: by 2002:a05:6830:140a:: with SMTP id v10mr3787221otp.355.1612997104577;
        Wed, 10 Feb 2021 14:45:04 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j25sm379707otn.55.2021.02.10.14.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:45:03 -0800 (PST)
Received: (nullmailer pid 2951110 invoked by uid 1000);
        Wed, 10 Feb 2021 22:45:02 -0000
Date:   Wed, 10 Feb 2021 16:45:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net,
        f.fainelli@gmail.com, Daniel Vetter <daniel@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, phil@raspberrypi.com,
        David Airlie <airlied@linux.ie>
Subject: Re: [RFC/PATCH v2 11/16] dt-bindings: gpu: v3d: Add BCM2711's
 compatible
Message-ID: <20210210224502.GA2951054@robh.at.kernel.org>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
 <20210209125912.3398-12-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209125912.3398-12-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 13:59:07 +0100, Nicolas Saenz Julienne wrote:
> BCM2711, Raspberry Pi 4's SoC, contains a V3D core. So add its specific
> compatible to the bindings.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
