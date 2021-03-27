Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2197B34B837
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhC0QhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:37:25 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38510 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhC0QhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:37:22 -0400
Received: by mail-ot1-f53.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so8199728otk.5;
        Sat, 27 Mar 2021 09:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vgFEHGoYmLfdBLAiP7XDtRZUaEmAlO6eOy14gTHW2m4=;
        b=b1PKYTAzEPZBO7SCybwqGfp5SH8MdU+8qE58HKvoOXhidABHCFLOkcUn3ZdDxRij8N
         GdZAQQBl4RPkw1dMLexAM1/sU1WhbyW8qKve6SA3DjN76J7gdcvqI7G6BlpkMcD7Xc9B
         XsfuVtE9xKDU2NcbVZDf/1aj7Luo+QgcXVQ/oXUJcFJkeHWXVqGISjQ17Jz1I8ZPe22k
         2zywRn7ji0a1sTQ9KzaVPqmBUDwB8aIRZ98SkXGVAhSbUZaWfy1IgqFbHhXor7wCUzJa
         p+iinUTm1M4TeHU1/IorigOpLqoWyusXEDAAj+KhjKuS3W2iy2MBXfO8PAg8sQ4nH52h
         YYNQ==
X-Gm-Message-State: AOAM532CNf3sG6vwS4zc7xSIhkP7iw0Mhw/pTJWRr02BZnavJJykWnr/
        wDOT/lKZLsjm9an+seqEZg==
X-Google-Smtp-Source: ABdhPJy5jLXhU+gItOWEzaeGYu0Cpa2unmGzWLkGH1VfRQypN0ck9cBpQp1VmdkOoH/lBtGW5GYcZA==
X-Received: by 2002:a05:6830:109:: with SMTP id i9mr16302124otp.47.1616863041915;
        Sat, 27 Mar 2021 09:37:21 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id z199sm1643158ooa.39.2021.03.27.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:37:21 -0700 (PDT)
Received: (nullmailer pid 212517 invoked by uid 1000);
        Sat, 27 Mar 2021 16:37:16 -0000
Date:   Sat, 27 Mar 2021 10:37:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>, Marc Zyngier <maz@kernel.org>,
        Patrick Venture <venture@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/14] dt-bindings: interrupt-controller: Add nuvoton,
 wpcm450-aic
Message-ID: <20210327163716.GA212468@robh.at.kernel.org>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
 <20210320181610.680870-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210320181610.680870-4-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 19:15:59 +0100, Jonathan Neuschäfer wrote:
> The WPCM450 AIC ("Advanced Interrupt Controller") is the interrupt
> controller found in the Nuvoton WPCM450 SoC and other Winbond/Nuvoton
> SoCs.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../nuvoton,wpcm450-aic.yaml                  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nuvoton,wpcm450-aic.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
