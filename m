Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24B0371E35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhECRPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:15:20 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:42699 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhECRNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:13:13 -0400
Received: by mail-oi1-f176.google.com with SMTP id v24so6051691oiv.9;
        Mon, 03 May 2021 10:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mmR9lvM5KXaM8R/c2iAszsw0iEDqwRBTAho3NoMlYWw=;
        b=QwWBMIUBHppCBtqQ3+yDLzpDl4nAiCO80E0skZpKOVlIPca+DHk4Z6dY6L7uRZWZIg
         rtLHiX7vQjsPyzx87TVEcR63bQPlsHCjzDYJI6X2++ghYSYaNl49akZCUkF32idj/QFR
         yd34C4qpqZTfHTmu0KsIVrfgWa8Z1aseyS6tMUIpWOFFDqRUctY4zIyfN0kvbCVRdp5F
         dvXE7HpJpj/ufBRw2AnqrYJXf1moutJyIdSHvy7tJyES4Qt1Jrtku8NK/NzY9S5lyEC3
         C79YH+6x822y+GvO5trNTpEKLBqzt5FiNolZlNf9sAEV/Ha1hcTrZ+xnAwlkYAx0GVF5
         HDmQ==
X-Gm-Message-State: AOAM532d/c0UE1a6SyK70is/yd22+nrVexCXS3zp9SZLjUheny44aoBn
        G9zJ36lwToaZwwwG+Y+vOg==
X-Google-Smtp-Source: ABdhPJy4HRq/pQtrZ2XxdEnU6VfzL8Nh4FFoiBM9/hydl2ztAcXZDBd1tTKMnAGJf63FV4qhNeoZ7Q==
X-Received: by 2002:a05:6808:308:: with SMTP id i8mr2208636oie.95.1620061935675;
        Mon, 03 May 2021 10:12:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s131sm88588oib.14.2021.05.03.10.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:12:14 -0700 (PDT)
Received: (nullmailer pid 2026722 invoked by uid 1000);
        Mon, 03 May 2021 17:12:13 -0000
Date:   Mon, 3 May 2021 12:12:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: mtd: add OTP bindings
Message-ID: <20210503171213.GA2026691@robh.at.kernel.org>
References: <20210424110608.15748-1-michael@walle.cc>
 <20210424110608.15748-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210424110608.15748-4-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Apr 2021 13:06:06 +0200, Michael Walle wrote:
> Flash devices can have one-time-programmable regions. Add a nvmem
> binding so they can be used as a nvmem provider.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v1:
>  - drop "mtd-" prefix for the compatible strings
> 
> Changes since RFC:
>  - added missing "$"
>  - dropped first example
>  - use real device compatibles
> 
>    Please note, that this will lead to an error without patch 4/5, which
>    introduces that property for the jedec,spi-nor. Should I keep it
>    seperate or should I squash that patch into this one?
> 
>  .../devicetree/bindings/mtd/mtd.yaml          | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
