Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B403AA0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhFPQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:07:27 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:41979 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFPQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:07:25 -0400
Received: by mail-io1-f49.google.com with SMTP id p66so3575960iod.8;
        Wed, 16 Jun 2021 09:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gjt5TgUjmD4/SF56LtNHdLISeh3ChooHvQtDSrTLxB0=;
        b=kFtGDPqf5QjN76j4ckmGPAYFG4tgAlYSZNzyELanV+f9sPjod3FcNrH0alHqohvorR
         CxVDygFIKyoZOjG6a/El3kH4eqsnUk6fbXT45aLgmZoJym62vYLR910auoe7uvNonezY
         mYcuG80mlOPaiZVJfi4KWxUnNDkixiFf0X+M/vivZ3jnFLTI8kYgTZ3otble29VxvBxL
         8PLnKCZgGlmp1CyPmxxulpoDeC7IMDdziftROkvi767APURHPn8ylNV44gaNwCSW/ZXZ
         OEkcZY57/HAntiluldBgN08yg/As8nEkoCVWpP0Xs8dKR3Td1kLQrix5wcnTAvtAXR3+
         zygg==
X-Gm-Message-State: AOAM532sLy0vmrp/geiKAa7OODmQBEcxzoTgbQh1b0gELAQjV3yRK6EY
        VWdDu0B14oj0+kFhqK+ZLkYsC/iq7g==
X-Google-Smtp-Source: ABdhPJzoDC30EjCRs3xXFHKbzRMx72I/5Od33bQ+d7S/F9QrcEmh3Ch+lVrpkgJejoynu1ihWBKo+Q==
X-Received: by 2002:a02:9f05:: with SMTP id z5mr138111jal.63.1623859518346;
        Wed, 16 Jun 2021 09:05:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z3sm1378126ior.14.2021.06.16.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:05:17 -0700 (PDT)
Received: (nullmailer pid 3474124 invoked by uid 1000);
        Wed, 16 Jun 2021 16:05:14 -0000
Date:   Wed, 16 Jun 2021 10:05:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: arm: Convert optee binding to
 json-schema
Message-ID: <20210616160514.GA3472903@robh.at.kernel.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
 <20210616103649.2662395-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616103649.2662395-3-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:36:44PM +0200, Jens Wiklander wrote:
> Converts the optee binding to use DT schema format.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ------------
>  .../arm/firmware/linaro,optee-tz.yaml         | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml

Other than the indentation,

Reviewed-by: Rob Herring <robh@kernel.org> 
