Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40A432770
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhJRTVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:21:25 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43585 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhJRTVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:21:21 -0400
Received: by mail-oi1-f174.google.com with SMTP id o4so1180139oia.10;
        Mon, 18 Oct 2021 12:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzZA50mc4BjmpmEztRaxMISR4WRQ5FsdiLAiBdxZMQ8=;
        b=JrjjPvpoEBrZk44FEZZU0P510jJjzEq+0Nh9wmZvEsatnI0gCF6fhvYLDL73YspuD/
         mP32yHYXZEUa9sjbR10K0eK/YKmQQQ/yj8zmaTfhyR/udanmDPXUA6cgTt1CYPb2wVS/
         qHN2XJFq0RbEMY+ClDZWONgxtwAHwFCjmKbjTuvtEhM0oBHp03AVu17af8HjIQioOaZB
         tBMiLLvoeYW+loe/CzxDD010vGMhcoIQzelUyALMJYfPUm4M+mEY3SlqKnY1X/uek6a8
         zXQryvtQ3xbsCpHuaUWzfaC49iDeCVTNXKaXxcKVWOzwY6tCFW9AeB99FN4dHZ/Vn+0W
         icVg==
X-Gm-Message-State: AOAM533K0eqXLQ+o9ES1ccWkGx+EEeGKcpEeGvtb/1pnjaa3wFh0Dz7T
        zPvSBsZp0C42cJE2aHdMAg==
X-Google-Smtp-Source: ABdhPJzi5oIzQvFFsTJQzRG1M4YHxjr7RvG38AEuCWK4MXFxFyARyWTLHNWWGxwh4ifKNHkYHkbDVA==
X-Received: by 2002:a05:6808:20a6:: with SMTP id s38mr563895oiw.149.1634584745423;
        Mon, 18 Oct 2021 12:19:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l26sm3248993oti.45.2021.10.18.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:19:04 -0700 (PDT)
Received: (nullmailer pid 2788566 invoked by uid 1000);
        Mon, 18 Oct 2021 19:19:03 -0000
Date:   Mon, 18 Oct 2021 14:19:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        hminas@synopsys.com, devicetree@vger.kernel.org,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: dwc2: Add reference to
 usb-drd.yaml
Message-ID: <YW3Ip4gxMnYSIsUg@robh.at.kernel.org>
References: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
 <1634133425-25670-2-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634133425-25670-2-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 15:57:02 +0200, Fabrice Gasnier wrote:
> Add a reference to usb-drd.yaml, in order to:
> - extend possible supported properties
> - avoid duplicated definitions of standard properties
> Remove definitions for dr_mode and usb-role-switch standard properties.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
