Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEF42E0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhJNSSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:18:36 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41917 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhJNSSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:18:35 -0400
Received: by mail-ot1-f43.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so9387716ote.8;
        Thu, 14 Oct 2021 11:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q0HbPoa/SmLtlcbL4A98vA90nfo5N87+w7YnhWCZ1+o=;
        b=3QiJET6KzZj7paiqiE+C4XnD9WMK6oTBydRV2xfsMuH19+zvTq7uSivFWqM/iCyht4
         hm3vq8U8TjHrjBcmnyqVCltgZoVNnTDVDR9Ft1pY5Llj5i62WsizzD5CytiZcDmwVtAG
         +yUqwVhAlW1a7j9X4hHHNrJ1JLyfY1QNgvcUhHUcumSz0H5y6fCOvKCw15NrhM5NWxOD
         7QLdzfT6yS9/ZS880VGVK7WrW9QYcnDJD/xF0WvvFPTO2jcXDtRcoKU6tC0haAulRJ5u
         0fB9z8nbBcrswNEMu0gc74jI1+GEz2w5SPuTUf1KIcsaBTRs3ESoNDfh1FApPfWeu35P
         /oxg==
X-Gm-Message-State: AOAM5305sIQ8K3S5BfZiHKXGtInePQyPE4hnBnoLy4Ee0sLbcTNmCflD
        FbeZ3Zc5Al300Lj4pfT2x2Hsdf2EAw==
X-Google-Smtp-Source: ABdhPJxKfM3iXQ0zI911tswBcyLS7YVr4ZTJq7hvniXYOhLyYuHoLue+Q56bsDP/2yc8QCkCgynuuA==
X-Received: by 2002:a05:6830:4487:: with SMTP id r7mr657269otv.251.1634235389846;
        Thu, 14 Oct 2021 11:16:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f1sm553273oos.46.2021.10.14.11.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:16:29 -0700 (PDT)
Received: (nullmailer pid 3663089 invoked by uid 1000);
        Thu, 14 Oct 2021 18:16:28 -0000
Date:   Thu, 14 Oct 2021 13:16:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: phy-stm32-usbphyc: add optional
 phy tuning properties
Message-ID: <YWhz/AsfDX24iUR3@robh.at.kernel.org>
References: <20211005152453.89330-1-amelie.delaunay@foss.st.com>
 <20211005152453.89330-3-amelie.delaunay@foss.st.com>
 <1633473959.465401.106809.nullmailer@robh.at.kernel.org>
 <491ab475-e7dc-eb71-85aa-6d82543b74db@foss.st.com>
 <CAL_JsqLEPd9_4SgmDh8GakyNxQeuMKhJeGzaLbZSdxDJ_-dZYg@mail.gmail.com>
 <2a07f03d-ffaa-77f6-c223-74bae60eb3f1@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a07f03d-ffaa-77f6-c223-74bae60eb3f1@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 02:58:21PM +0200, Amelie DELAUNAY wrote:
> 
> 
> On 10/6/21 2:38 PM, Rob Herring wrote:
> > > Disable child nodes while parent node is already disabled fixes the
> > > warning. But it means to add status = "okay"; in child nodes everywhere
> > > usbphyc is enabled.
> > Presumably, you already have to add phy-supply everywhere.
> >  >> Is it normal dtbs_check checks in child nodes when parent node is
> disabled?
> > I'll look into doing that.
> 
> Should I wait for your potential dtbs_check update or should I disable child
> nodes in .dtsi (and enable them along with parent node in .dts using
> usbphyc) ?

I pushed a fix to dt-validate for this.

Rob
