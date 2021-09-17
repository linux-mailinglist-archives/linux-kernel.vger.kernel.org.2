Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2799F40EEED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhIQBxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:53:23 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:33356 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhIQBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:53:21 -0400
Received: by mail-io1-f54.google.com with SMTP id f6so10384653iox.0;
        Thu, 16 Sep 2021 18:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7w/jw8KCV18lQz7p2av57lC9INYphWvSiOrkUIeJBQU=;
        b=N3wDmckLqcuJ5bF/JIbzcWuT379OnVRzBPcNvprKvwnbXek48G4M+TtcmDrmEU2s1W
         k8tGus+ING1k3rPiqIjtpNsflApcVV9pVgFwgCmuAfJ/8YOOdHKykhhvypk1HM9tSSRi
         FrpiT/EPnqrUiWOvTBFYOOukyl+Ufj14TfnvofSsbhrnd8nobEc09ZRnQ0hj0qhCPtpL
         n4oxhi4YXCPXMnioeg4LBaxQX7wE7pJyhvlqimrG4cxsbJn8o0Okfr0kt8rcL7wSEXGL
         UuUt6VQ1mi8HEdZcgvmK3Dqt+LO9tfxKTsdrnMU4Ure+neDkakWL+KHLXAuMS3KVV7GY
         VfdA==
X-Gm-Message-State: AOAM533myUHYkwHTSYcNMxPBEh06jsou0d0Dqneuzp9QZJ9pX2uRpGYP
        9KRtdT0CTwME/IH1F8P1Iw==
X-Google-Smtp-Source: ABdhPJzgaz1PIrzqWVSwvxEkPzEFkn69nevEqfJXYtepNRlHCE1xYChJoxYKd8FUY5drEC5WGoIAYg==
X-Received: by 2002:a05:6638:4103:: with SMTP id ay3mr6752299jab.76.1631843520364;
        Thu, 16 Sep 2021 18:52:00 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id q11sm2689474ilg.85.2021.09.16.18.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 18:51:59 -0700 (PDT)
Received: (nullmailer pid 1598934 invoked by uid 1000);
        Fri, 17 Sep 2021 01:51:59 -0000
Date:   Thu, 16 Sep 2021 20:51:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/23] dt-bindings: w1: update w1-gpio.yaml reference
Message-ID: <YUP0v3XRl88zsf5S@robh.at.kernel.org>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
 <0b415b5e05bcf9d593cb421c96996d914528e732.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b415b5e05bcf9d593cb421c96996d914528e732.1631785820.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 11:55:03 +0200, Mauro Carvalho Chehab wrote:
> Changeset dd2c898bc20b ("dt-bindings: w1: Convert 1-Wire GPIO binding to a schema")
> renamed: Documentation/devicetree/bindings/w1/w1-gpio.txt
> to: Documentation/devicetree/bindings/w1/w1-gpio.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: dd2c898bc20b ("dt-bindings: w1: Convert 1-Wire GPIO binding to a schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/w1/masters/w1-gpio.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
