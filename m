Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E246E432776
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhJRTVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:21:38 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41550 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhJRTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:21:37 -0400
Received: by mail-ot1-f49.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so1105601ote.8;
        Mon, 18 Oct 2021 12:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6arM/5Dhn7rx7N9waMT1O9TAGcCfI2K71aXcO+9YrY=;
        b=fuEXvhZApaYmYTp229TL3ymkzrOwm/4yL1zjFUapxM42vUCw66GkeEtWLjEe35GJFK
         tyktxJjotfuCshnFWGz2i2YV/Nr/JMRHq2UkXiN36uxdJuLSGdgyxVtmpxbHMnIoUOTJ
         HuvPsfxaJDyxVTrWfjxw+u8cHsnWoJ7EmdPHYuaHaOg3mqlu51BWns8NnB12O8Ajzv//
         DIL2xTb/H1t6xcizWHxTAvMYh66L+0RUHV+XGAae2uKBJwhFrai/9yW0JszaAva5Qh+2
         46BRkO1SReZpLW+R0FyxawRYrVEdcUlD2LQX+MBu6UkxiQhw62idpPKYrB6Uxj1SP3pZ
         I3RQ==
X-Gm-Message-State: AOAM530HU0oGw9F44kcNZaLBmRwnsFF8USoGW4hUIC+/Usp/g9Hustwu
        kiugrE96VYW4oN5FhyF8yQ==
X-Google-Smtp-Source: ABdhPJxTOuyFSpJchEpUgdmoQy3eg1rOqRBnMUqaBKjstriq7xNvJaPRWzlT80xCva6GiJzaYLK6vw==
X-Received: by 2002:a05:6830:440c:: with SMTP id q12mr1435350otv.84.1634584765960;
        Mon, 18 Oct 2021 12:19:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e22sm3189083otp.0.2021.10.18.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:19:25 -0700 (PDT)
Received: (nullmailer pid 2789232 invoked by uid 1000);
        Mon, 18 Oct 2021 19:19:24 -0000
Date:   Mon, 18 Oct 2021 14:19:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alexandre.torgue@foss.st.com, amelie.delaunay@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        gregkh@linuxfoundation.org, hminas@synopsys.com
Subject: Re: [PATCH v3 2/4] dt-bindings: usb: dwc2: adopt otg properties
 defined in usb-drd.yaml
Message-ID: <YW3IvEwPKvkyuBMM@robh.at.kernel.org>
References: <1634133425-25670-1-git-send-email-fabrice.gasnier@foss.st.com>
 <1634133425-25670-3-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634133425-25670-3-git-send-email-fabrice.gasnier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 15:57:03 +0200, Fabrice Gasnier wrote:
> Adopt some OTG optional properties as defined in usb-drd.yaml:
> - otg-rev
> - hnp-disable
> - srp-disable
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
