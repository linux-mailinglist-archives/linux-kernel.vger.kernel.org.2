Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E54432454
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhJRQ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:59:19 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45641 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhJRQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:59:17 -0400
Received: by mail-ot1-f42.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so574340otq.12;
        Mon, 18 Oct 2021 09:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D+B8b5bbxhUiTGoID7MYBXJe2bOTiDSmsfXz64eHuGQ=;
        b=GBWylszHd0EewlfR9T77iLUr2OtWPiBju0RyWa3lXGrQWS3aqkNIVg9D+Yign3Q/VB
         nF2EScKsnW6PWiEbjlbUdXk7NtTrXDbz2z1M23kDk/bNWnxXX2WCv3xNW9lOR+sT9tmW
         eVRq5b5sYNL4wBYOgEC/LJaZJjX6MCMv2xU9i2qIzSso5WMe3faFd4GMZNA04p8FYwbH
         HqoXe476ht/wVEmr1NxqhdZF/AQmdiSRKIdkTPoKNOe1LEWxMqNu5mrwjdHtrSeVC45W
         c3gobTIHLM7OUn2+13nrl1vwz472WDM8OcXc9jfK15RvMFkkYvBImHrNITaDqv1pF9aI
         5BCg==
X-Gm-Message-State: AOAM5313gfaP1QZcAUYFKd2z/Igd/W7K0Wrej9+j3bnOqk52fqII1nVX
        UTMwhpuWHd8SubWeWJrfcw==
X-Google-Smtp-Source: ABdhPJy/S1AyVmdohYRVGHuwV71k02ACwtcObvmeFNBQlM3z9ts6ppfdYlvZuVkUOV5uEys6tr3MKw==
X-Received: by 2002:a9d:4f1a:: with SMTP id d26mr773520otl.65.1634576225628;
        Mon, 18 Oct 2021 09:57:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh39sm3295951oib.42.2021.10.18.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:57:04 -0700 (PDT)
Received: (nullmailer pid 2555173 invoked by uid 1000);
        Mon, 18 Oct 2021 16:57:03 -0000
Date:   Mon, 18 Oct 2021 11:57:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     neil@brown.name, john@phrozen.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: bus: add palmbus device tree bindings
Message-ID: <YW2nXwvNZ0mkawSc@robh.at.kernel.org>
References: <20211016203323.9165-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016203323.9165-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 22:33:23 +0200, Sergio Paracuellos wrote:
> Add device tree bindings for palmbus controller present in all the MIPS
> ralink based SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> changes in v5: Sent wrong patch in v4. Hence, properly sent it.
> Changes in v4: The node name pattern is already checked elsewhere. There is only need to
>                define the unit-address part which should be lowercase hex.
> Changes in v3: change sample to use child node which its bindings are
>                already in YAML format to make dtschema happier.
> Changes in v2: fixed missing semicolon in example.
>  .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  .../devicetree/bindings/bus/palmbus.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml
> 

Applied, thanks!
