Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089233112D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhBETKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:10:36 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:46939 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhBETIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:08:53 -0500
Received: by mail-oo1-f43.google.com with SMTP id 123so1940852ooi.13;
        Fri, 05 Feb 2021 12:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7dpIcPNrn53fvnnVwCVgKpxpuzXaWSPTWVeWzDJnTbs=;
        b=UpJ9IUQtZXiXK0vcCX41lRetYNiPX0LOpOWg6Tl3cCYgbHvARY+LY1D6f6YVoBwprC
         siqDPNzNJZ3mshiOMXod+cEZLujNIQZ1bg7VJpG2I59A7N/OtbZPXnJENzqaunHE7L69
         0Anijy8bjDjy8aQIbSGHCQ0oGRBJqbTwt5qWrxrjchZZSZv1CXxEYAU6BsTUa9SrnCcR
         nZifUD4QP9C9BYYAK2qKhnFaKWpSI57QMGs1A+wZ2ockcMmGP5XI3ThXt3Anq/zcepcz
         Kcc6/aL/1UiH0vqC9IB9hwPICwb3u0TPq1U0RNuqbPSBx7iH3RGjnoYNU8TDiHx0TP/9
         82Fg==
X-Gm-Message-State: AOAM533BXsdWPwxYM/OhXXsomZYNYkVBmk+FLyRSc8MnfveiMhcowLNB
        c84vUcc4Dy6FcxTXDBE7Gw==
X-Google-Smtp-Source: ABdhPJyvwtwFGwOzKaVzlvCltLu1G83dbOuYAgS1Tt5BqgQt4uKQhLtYHxDwWm5BmVmuvr4CgjpIoA==
X-Received: by 2002:a4a:c896:: with SMTP id t22mr4892539ooq.8.1612558069392;
        Fri, 05 Feb 2021 12:47:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s26sm2044191otp.54.2021.02.05.12.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:47:48 -0800 (PST)
Received: (nullmailer pid 3705653 invoked by uid 1000);
        Fri, 05 Feb 2021 20:47:47 -0000
Date:   Fri, 5 Feb 2021 14:47:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v7 5/5] dt-bindings: usb: dwc3: Update dwc3 TX fifo
 properties
Message-ID: <20210205204747.GA3705591@robh.at.kernel.org>
References: <1611895604-4496-1-git-send-email-wcheng@codeaurora.org>
 <1611895604-4496-6-git-send-email-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611895604-4496-6-git-send-email-wcheng@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 20:46:44 -0800, Wesley Cheng wrote:
> Update the tx-fifo-resize property with a better description, while
> adding the tx-fifo-max-num, which is a new parameter allowing
> adjustments for the maximum number of packets the txfifo resizing logic
> can account for while resizing the endpoints.
> 
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
