Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B2F351EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbhDASo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbhDASWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:22:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E2FC0613A7;
        Thu,  1 Apr 2021 10:40:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ce10so4076968ejb.6;
        Thu, 01 Apr 2021 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sa4bDFe6mIaoemCJgtMB/NPxmX+AQNUFt+wjs8t9sOo=;
        b=D62U/IshJFz7x3o9pOoXzRhEbHEr5ja98nd820fHNV+Z/NkUu4gsmsVXhZofbgxdB4
         oSaGl2RPU7Zbw5PF1dd4Xpk6evxBsHv/igGy8n1Ghr4YmC/jEvVYkO1fLMewf89y+niS
         roqYBSzlcM3NsZVvkXHPf7dOXWf5rJynBtLBhbjoYSgnoszPlJUooPHh+cdXw63DdZAs
         Sp88Uz7tWR5+ynp9rqmsNPXDzoG4lP3a/lvO+wpcgRpQwU+ppYuWCTVEUvshFoiFgLqV
         RqBCO4wGErcwvcxGi/pDLxGzMJgwR9xtW+7La4LR9ybjIZlKW5myG+xl4aZpJS6Jfx/p
         Mw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sa4bDFe6mIaoemCJgtMB/NPxmX+AQNUFt+wjs8t9sOo=;
        b=XP2+cxTQWTsiFn3igx+VQ72gFj3GyVYawJFb71obavC/S6aXFInNOS228V9M/dZb5r
         XrtDfbmFrllId8jsDZwO8OroJ3+lHMJx4CrmQRuHpHmo/ELuWaCYgETJJ701q6TOVYfL
         3+YXWDcFxKLkMNo/5p1gKanZslht+BLO0D9FLTUfxZ9olV9I863qCcqY1sSNH3Ea6b/D
         Sr1VjOPCSBEp6DtyHryNDsyG38aNw5ZKLqSx1oaQJmLnjEkcxaHjkCZOCqu2Kr+gdC1Q
         cy/6ZOzW3pHIJy61EDyMtXMlnOPAO/Z4jaj1eiJThEGtzwpuLBeOmzh4MWQpD7ovPCl9
         GRqg==
X-Gm-Message-State: AOAM533WCeBe2cVnUcuZ5FkfO6PA8SxTvocdl1XtM2QVvH/aC6LhSs4U
        mWqTPvVFf+U8rgVg5llBNNQ=
X-Google-Smtp-Source: ABdhPJy2sAfpdTqwT3vX1CHebqkSk0u+KeMsFGf5vdWgZRWS3RCD0iA1Np9fZT+Bd1eEgbWBo8bc0w==
X-Received: by 2002:a17:907:9863:: with SMTP id ko3mr10268034ejc.543.1617298805285;
        Thu, 01 Apr 2021 10:40:05 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id gb22sm3000106ejc.78.2021.04.01.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:40:04 -0700 (PDT)
Date:   Thu, 1 Apr 2021 20:40:01 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reserved-memory: Add Owl SoC serial
 number binding
Message-ID: <20210401174001.GA2016477@BV030612LT>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <fb74862bec15f1e9e0c4d8b70ebd6c07c6eb1a40.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401170704.GA610119@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401170704.GA610119@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:07:04PM -0500, Rob Herring wrote:
> On Tue, Mar 30, 2021 at 04:48:16PM +0300, Cristian Ciocaltea wrote:
> > Add devicetree binding for the Actions Semi Owl SoC serial number
> > reserved-memory range.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  .../actions,owl-soc-serial.yaml               | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > new file mode 100644
> > index 000000000000..41b71f47ee6c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reserved-memory/actions,owl-soc-serial.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Actions Semi Owl reserved-memory for SoC serial number
> > +
> > +maintainers:
> > +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > +
> > +description: |
> > +  Provide access to the memory region where the two parts of the Actions
> > +  Semi Owl SoC serial number (low & high) can be read from. This information
> > +  is provided by the bootloader, hence expose it under /reserved-memory node.
> > +
> > +  Please refer to reserved-memory.txt in this directory for common binding
> > +  part and usage.
> > +
> > +  This is currently supported only on the S500 SoC variant.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: actions,owl-soc-serial
> > +      - items:
> > +          - enum:
> > +              - actions,s500-soc-serial
> > +          - const: actions,owl-soc-serial
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +        ranges;
> > +
> > +        soc_serial: soc-serial@800 {
> > +            compatible = "actions,s500-soc-serial", "actions,owl-soc-serial";
> > +            reg = <0x800 0x8>;
> 
> You end up wasting a whole page of memory for 8 bytes. It may be better 
> to copy this to a DT property ('serial-number' is already a defined root 
> property).

Actually there is more information provided by the vendor bootloader
in this memory page, so we might use it once we are able to decode it.
For the moment I could only identify the serial number.

Thanks,
Cristi

> Rob
