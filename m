Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE443FD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhJ2Nqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:46:32 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46641 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJ2Nqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:46:31 -0400
Received: by mail-oi1-f177.google.com with SMTP id m11so8571090oif.13;
        Fri, 29 Oct 2021 06:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4j8kz+vDYmA/tiJro/01MgX0r2fELTiXn0N7Y88aTA=;
        b=MSvPEq+3shc1xxE93fSYhI1erm7IZ4EVlmgOqh53s6z++5eSuzEy/h8nf0uuvZp5/f
         ntQrOlqcIepRQ+rewjX4h37XKafvjRncXdNAHwFW0fe9RryUb1r3f/dk6eFd9GIrNe+s
         zRk7w5tTsT5Hx15ZaDuMT+e0nznYMcVlByzXL1V0gUFsuUdmpO0J4NVk4uGEP1ektbeI
         jPGtBAUCTfnuMts2l64ibd+uNuhM7g78VZ2zRgHs2J3yNPXx1krmQGhXLAeRi8EB/lvK
         DrsWAWv3R/H6dg9GbNBqtsABVFCPy+DYEv7PkXu5qrMPI1uOfvbniYAGH/+ALlPTNQDq
         l6aA==
X-Gm-Message-State: AOAM530xE39YztOwVcYcrb619fjsPeaxVrxza/8zIsmP9CEDzAJBVbPK
        uULPoKzFJy9fY80Au/f7DQ==
X-Google-Smtp-Source: ABdhPJxXlg3PkICo5KK9L0xBEvGyufxGFE4IcST0wAx/bcQ2X3qjfMkNzhIl5Qv/WmDQdG6kIWuXqw==
X-Received: by 2002:aca:3455:: with SMTP id b82mr13883274oia.102.1635515042228;
        Fri, 29 Oct 2021 06:44:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm1871463otl.19.2021.10.29.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:44:01 -0700 (PDT)
Received: (nullmailer pid 2250889 invoked by uid 1000);
        Fri, 29 Oct 2021 13:44:00 -0000
Date:   Fri, 29 Oct 2021 08:44:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, ~okias/devicetree@lists.sr.ht,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Message-ID: <YXv6oMe4pw6DgIha@robh.at.kernel.org>
References: <20211020231701.278846-1-david@ixit.cz>
 <YXsYnG+H8gQu4Prc@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXsYnG+H8gQu4Prc@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:39:40PM -0500, Rob Herring wrote:
> On Thu, 21 Oct 2021 01:17:00 +0200, David Heidelberg wrote:
> > Add missing compatible for the SDX55 SoC.
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Applied, thanks!

Now dropped. This conflicts with Will's tree, so he should take it. 

Rob
