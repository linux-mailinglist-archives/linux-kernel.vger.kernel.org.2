Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF0399079
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhFBQui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:50:38 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43990 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhFBQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:50:26 -0400
Received: by mail-ot1-f54.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso2993761otu.10;
        Wed, 02 Jun 2021 09:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSTyN6UdfxrpswIXdEEMvpztyfRMf6Iwj0IzM0dJ04g=;
        b=lkfqSnjKlMfP+ufZH0IE+LKXsbBqWtE147Hev7uqM97imCj0ZLjIP5ccLhhM7NO3m9
         h0kLR1gij3OvaVdBEPfymoiWeiX4L3wW2zIealaXXbnZaz0vXW2q4LLhk7hM5R0PYU/B
         VMgUQsxBdQtgO7W5ib/n0dZb1isnZ4qPa1kuTqlq1oc6Lc8P0y9pWRqnZ8qF2Gj3dDfJ
         Qkl3jmk6tw9zgcgz6Nbx/KyORcQguYXBgsN1O6fZVWogONh7IUJ0Uw7OXTFNvoImbDkc
         0lQodkQGyl6MhH42acHRpIXASxhaKpPuHJ+mDjnI1oFmrXEdsqp/mTK1HbgcfQxgZGFN
         ZaRg==
X-Gm-Message-State: AOAM530skU1HbMXd4idmzPHfaMK4BeNgmEjmKl+4vQ05gChx7GahIlZw
        +p7tAdB2lULeppXqUlpAiQ==
X-Google-Smtp-Source: ABdhPJy9ycvTGvt3iyFRuhOSjd10om0oaJHX1x3csb/ToPEINf9dNc1eIDihO3ndiNYjdM+SYE3ziw==
X-Received: by 2002:a05:6830:110c:: with SMTP id w12mr27442506otq.91.1622652506710;
        Wed, 02 Jun 2021 09:48:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i4sm93588oih.13.2021.06.02.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 09:48:25 -0700 (PDT)
Received: (nullmailer pid 3544893 invoked by uid 1000);
        Wed, 02 Jun 2021 16:48:24 -0000
Date:   Wed, 2 Jun 2021 11:48:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: extcon: sm5502: Convert to DT schema
Message-ID: <20210602164824.GA3544831@robh.at.kernel.org>
References: <20210531133438.3511-1-stephan@gerhold.net>
 <20210531133438.3511-5-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531133438.3511-5-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 15:34:36 +0200, Stephan Gerhold wrote:
> Convert the extcon-sm5502 device tree bindings to DT schema.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/extcon/extcon-sm5502.txt         | 21 --------
>  .../extcon/siliconmitus,sm5502-muic.yaml      | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-sm5502.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
