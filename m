Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1E346D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbhCWWjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:39:39 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:37432 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhCWWjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:39:18 -0400
Received: by mail-io1-f50.google.com with SMTP id b10so19459404iot.4;
        Tue, 23 Mar 2021 15:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S92WaoQmPcxmAxIBLnQoheVRsS9Rb8meP+pvXtKihFw=;
        b=tr8W71FfZBXECa+5YZ7DM49zB6GJ6bp2aWCH5Ynj/pWox5KaJRPOVsDHDfGGNOpQeg
         a5kEn+7kPFua6WrWJVfZQurznr0EdQmdlndHpiN869BBf2oceZK9rHoz0DL2gABeWG5J
         XXWDKiiPMrAR4ADY1shTnetZ4+/v8K+vafkwB5i+mLxrD1ZSUjxcmpq4HdGPHdTVrL8B
         0zTR68eBc+CGl4xV8YUoEOgwXTNVG0aiaH0nG5UhhYJqUE56xQsoJ/z7LfghQivjhPnz
         608vzKzOrneHrsePFYHVKJIieMcRBzZl/d2t+rzms+AhGeh8kmEnaiSw6oM03DlCO5Oe
         9x3Q==
X-Gm-Message-State: AOAM533qHZiWHF1M0kr27TGRpoImuUNeW7VyUHOiv+SwoezIn1JHDDz2
        RzJzo7zLMqsM+9VR/ECzLmMpXs/N4g==
X-Google-Smtp-Source: ABdhPJzTz0RHCP/mlQKkbAuY9d/5ECm9T25BeyKEAEbjrgPyMttp0VO7FfegK4lvMEUjTSVv9LNoJA==
X-Received: by 2002:a02:9349:: with SMTP id e9mr230097jah.75.1616539157851;
        Tue, 23 Mar 2021 15:39:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s7sm118635ioj.16.2021.03.23.15.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:39:17 -0700 (PDT)
Received: (nullmailer pid 1477490 invoked by uid 1000);
        Tue, 23 Mar 2021 22:39:14 -0000
Date:   Tue, 23 Mar 2021 16:39:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-imx@nxp.com, alistair23@gmail.com,
        linux-arm-kernel@lists.infradead.org, olof@lixom.net,
        shawnguo@kernel.org, arnd@arndb.de, festevam@gmail.com,
        kernel@pengutronix.de, robh+dt@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: arm: fsl: Add the reMarkable 2 e-Ink
 tablet
Message-ID: <20210323223914.GA1477434@robh.at.kernel.org>
References: <20210322130928.132-1-alistair@alistair23.me>
 <20210322130928.132-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322130928.132-2-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 09:09:26 -0400, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
