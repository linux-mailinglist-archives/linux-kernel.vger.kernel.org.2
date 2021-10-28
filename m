Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E004943F1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhJ1VmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:42:10 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:37477 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhJ1VmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:42:09 -0400
Received: by mail-oi1-f176.google.com with SMTP id o83so10312635oif.4;
        Thu, 28 Oct 2021 14:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQ4SKNB7MnmkITYiKq9OaxL/6LE4iRf7G2BlLXaMFT0=;
        b=R1TLsmko/GK5kYcNdxuhzy3R60ELY0Azp/4uhBpZA76p2uxxNuX/jCyMQEiJTFq20a
         SWEhEjfK4hk76nLQlZ/ddDdUYEKsHJhS41Xd6ZiiDiK+cuChcdJDw3yO6eft3bdKVfU+
         W80a8bH4F9XQuKOJZhQYeh/yGEA2bg80vhobAW6HEeDhOsY+LhWbVTgSHB4bLnh9rqmB
         hmwch6Qdhsub7oaNZAh3RTEUMJ2asgO9e7jr2deeoxYEt5B2OIa85R+CVCLNcLDioSF1
         9cp1HhTKwxqSukX/vKJA5iwjSft5M1fXxdtGwAmRES/leYyY48xpF+S9MrmqLuwWXGfB
         qATA==
X-Gm-Message-State: AOAM533neS5cXkkf/zvgBo+omtZFijNLlIIWwCxQtah4omW7Mmlg7BCf
        05sshjqgwTOvWdx+BrTkd6OswzGVBA==
X-Google-Smtp-Source: ABdhPJzOT/3TCzv6UnPH4JVEx/wL3HRrNdHhCuWskSHZ+nZPafpkq4i3RmB5gl7enVIsnbiO+cEEdA==
X-Received: by 2002:aca:ac0f:: with SMTP id v15mr2038214oie.46.1635457181936;
        Thu, 28 Oct 2021 14:39:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d28sm1377732ote.7.2021.10.28.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:39:41 -0700 (PDT)
Received: (nullmailer pid 634348 invoked by uid 1000);
        Thu, 28 Oct 2021 21:39:40 -0000
Date:   Thu, 28 Oct 2021 16:39:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Message-ID: <YXsYnG+H8gQu4Prc@robh.at.kernel.org>
References: <20211020231701.278846-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020231701.278846-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 01:17:00 +0200, David Heidelberg wrote:
> Add missing compatible for the SDX55 SoC.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
