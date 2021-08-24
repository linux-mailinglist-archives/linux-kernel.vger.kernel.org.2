Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3E3F5DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhHXM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:29:23 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38829 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHXM3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:29:22 -0400
Received: by mail-ot1-f54.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso34245752ots.5;
        Tue, 24 Aug 2021 05:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cdwtS2+itIfFHyhhEYB6WadzvAnlM7aA3DO6pUVcIwk=;
        b=SDOAF4Fq3HfvHO8Mki6OyUFoKjFbdJFD785MQEant5k7jpwqCM5f715i0r8oG13Pyy
         +9I1WP3pa9RlvOMekWYjWZ+FN64rK2T0g3z+fjD0uKERKGGMCo7nNnUzJ5A/dbVzJftz
         tKK7YL7y0gsLitp9Hj3HWtGmOogO4Fra4GlORSx4ZtLmJzhHLE2kpyAkzFLHXitFDUXK
         TpIGxCMTUn2yI50mmaVW9voVsolRJ1wAnIbA3u3jegv4O/LOpvnwkDPfm8mlbYRxZHie
         klcfbbdp/sPxpmfhlqEtsOGwbT9jKpJ0S3t12fF5B+ertgHDfFSRBWtVx9T9f0K+01tv
         4PSg==
X-Gm-Message-State: AOAM5311yizcTE0iQvl88Tcuur6TQbb+F+F2pMQmwKg7CQtGA1axn1Lo
        eTt5tE4dAoujk8Nx1D1ENA==
X-Google-Smtp-Source: ABdhPJwBlJ/557XHToZbkG4RiHHSizrDlfCrQtKLOX4/13hERWlkFtAoMj7gZtJzpw45/W9f6ePgIg==
X-Received: by 2002:a05:6808:220e:: with SMTP id bd14mr2542275oib.41.1629808118045;
        Tue, 24 Aug 2021 05:28:38 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q10sm4615114otn.47.2021.08.24.05.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:28:37 -0700 (PDT)
Received: (nullmailer pid 59517 invoked by uid 1000);
        Tue, 24 Aug 2021 12:28:36 -0000
Date:   Tue, 24 Aug 2021 07:28:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v3 1/4] dt-bindings: perf: marvell: cn10k ddr performance
 monitor
Message-ID: <YSTl9PQpwP9OiCbY@robh.at.kernel.org>
References: <20210823065121.19494-1-bbhushan2@marvell.com>
 <20210823065121.19494-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823065121.19494-2-bbhushan2@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 12:21:18 +0530, Bharat Bhushan wrote:
> Add binding documentation for the Marvell CN10k DDR
> performance monitor unit.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v2->v3:
>  - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000
> 
> v1->v2:
>  - DT binding changed to new DT Schema
> 
>  .../bindings/perf/marvell-cn10k-ddr.yaml      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
