Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3A543D397
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhJ0VOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:14:44 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:45014 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhJ0VOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:14:43 -0400
Received: by mail-oi1-f182.google.com with SMTP id y207so5275202oia.11;
        Wed, 27 Oct 2021 14:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k3QbaEEwsED/cBYuJpMYmPOuATHo/hhXNN4M6qAU9G4=;
        b=cFQDCbl8GOSSH05hpW3JhSUswCO2bfHo8BAL1QFFVygDtNehaV3UpbRicYGumcMBeA
         XJccUseRfVSbiV4hSRtEGCl6CAv00i/M1okTRNCboWCc1jwiOFl+GbAW4V9eJGtbUfnB
         qMrjbdJh3CU8U3k/+p7cME04apjKZr1180+j4HQ3pprDZQQlyaMbMf+03enRbaci47+V
         5iExKJFbD21jGXk8rnnUYUAM7Svh7l5KFe80Ia+HOlnJx1M4RcuJr6+eVP0AuiDIwvDf
         wnRJk0sy5UzO5XPi5Z2WfDkZvgOJa/9zNtxHO8EuKWNl9SmEmNLYLHXwGHS9q/pEtnvu
         Zg4Q==
X-Gm-Message-State: AOAM531gwH8LkASd7OlQzQpvOSbTYI4q3FJoAgioi5BfYd4GRYuNI54/
        /nLSxG1Q29leFYyyQUFi6gNvLxcvvA==
X-Google-Smtp-Source: ABdhPJxe2ua1/gV81De27mOC9lJwqcKmxLbHs05qHWaf/qz4cHIdZnnQ1ssNAf0BJpeFxKvm5ffOhg==
X-Received: by 2002:a05:6808:2189:: with SMTP id be9mr40292oib.145.1635369137058;
        Wed, 27 Oct 2021 14:12:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l7sm381352oog.22.2021.10.27.14.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:12:16 -0700 (PDT)
Received: (nullmailer pid 2169171 invoked by uid 1000);
        Wed, 27 Oct 2021 21:12:15 -0000
Date:   Wed, 27 Oct 2021 16:12:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Add the Amlogic Meson8 HDMI TX
 PHY bindings
Message-ID: <YXnAr0nIuzeKFhLm@robh.at.kernel.org>
References: <20211020195107.1564533-1-martin.blumenstingl@googlemail.com>
 <20211020195107.1564533-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020195107.1564533-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 21:51:06 +0200, Martin Blumenstingl wrote:
> Amlogic Meson8, Meson8b and Meson8m2 all include an identical (or at
> least very similar) HDMI TX PHY. The PHY registers are part of the HHI
> register area.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../phy/amlogic,meson8-hdmi-tx-phy.yaml       | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
