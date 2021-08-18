Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51F73F0B19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhHRSex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:34:53 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41852 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhHRSep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:34:45 -0400
Received: by mail-ot1-f47.google.com with SMTP id w22-20020a056830411600b0048bcf4c6bd9so5221354ott.8;
        Wed, 18 Aug 2021 11:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y6xxQgaQG8j61EQ4yuUC3VS5wpVpA7eoTa8n1oYpFBA=;
        b=HmQ47sapG8g0tzfI3SO7k+bwBPl+dDizFrNsoygN4L7JaxnBA8aFpq+GkHAY5y9bOg
         b1rI/eSeiLRACol/9Vd51vYLL9YaIU2ni4F9hjOK1J2FNkcshQV3VfLUD3xwowT77jvQ
         e/KbApsnLbP3JJy9VDtX6lQ1WY+rr7gEgOCPR7FtTs9nmnk3WzwVFYXN3dtVmCtV7zcU
         XeI7eY9J0IkA+kydOfV28gp6D0/dBIuGKkPlcu27sviUCe/N6rdu5trdVkKP//iNRyfn
         7kNRmaFU7ttknXaZYTnlfPlNAKBFIcfo3t8LuxpaKzzEW5hv99i2PDuhDOhMmvilWQ27
         /NKQ==
X-Gm-Message-State: AOAM533hhk8BHw8bDgNDKEakpjMRd9xuNk9Vnl1yME7n4NTVTyZRvA0U
        MDFLk726l3ARjD+H+Tb8sg==
X-Google-Smtp-Source: ABdhPJyl9zeX3iSD4HzkmMLjuIXAFKX1KCG7J77Vc/AsRWwUSlykYRkWdOi1XrZCcuzZ4YSd/mm5lw==
X-Received: by 2002:a05:6830:411a:: with SMTP id w26mr8095722ott.127.1629311650017;
        Wed, 18 Aug 2021 11:34:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j70sm169666otj.38.2021.08.18.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:34:09 -0700 (PDT)
Received: (nullmailer pid 2880609 invoked by uid 1000);
        Wed, 18 Aug 2021 18:34:08 -0000
Date:   Wed, 18 Aug 2021 13:34:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        devicetree@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: arm: optee: add interrupt property
Message-ID: <YR1SoO/GRao00Ugg@robh.at.kernel.org>
References: <20210818101849.602257-1-jens.wiklander@linaro.org>
 <20210818101849.602257-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818101849.602257-3-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 12:18:45 +0200, Jens Wiklander wrote:
> Adds an optional interrupt property to the optee binding.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
