Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ACA337A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCKQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:57:55 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:33914 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhCKQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:57:35 -0500
Received: by mail-io1-f43.google.com with SMTP id o11so22706775iob.1;
        Thu, 11 Mar 2021 08:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wsccf9tJR91KJ5EzGr3FBpTysn8pH+laeQstroeFNK0=;
        b=mOcVWWIKoaHNQBZt+cr3JsRePwg/GW24bl4Yg2x7oCX+ivePi0RK5mv2cGnPfJaj2M
         z/JMy2XfSR4H3U6cziXmXKccvcC4pK4afWMEPfGY9W1SCTRosjiZ9/fA7SNYN2DZ3UDl
         Npp8KQf4uOOZMlLyYYd7IPU/esR4nrPQVTwHkV11ncKfiZI1PF0hDdClTAO89+qGy/mf
         egHzqg6kMTWQlOKppbBqgTfaoNTWZPVvRKBTGQvcKRbZOuzmzroLzCS3Fbw7tutaGhoL
         E1jMVnzKlIDqZ+ZtjAfQY+AF2ALSL9FusOaaq1S05usVHv27FuN3vw72ksx7iLKpK07l
         x19g==
X-Gm-Message-State: AOAM533mm5afkxrIGiF0PF6pdm5w3+b97jYPzMw4wqvCUXAIZkl1rVez
        PcQTkgnWLKvtUwB6iX3smUGmp8GTBQ==
X-Google-Smtp-Source: ABdhPJzWQc1MQR1xAgqw0T954BKg4oec2Mq0FvSn/lekGONRtwNBJiowKlSxunCHDr2yO6pxc/sCjg==
X-Received: by 2002:a05:6638:144e:: with SMTP id l14mr4510651jad.76.1615481854566;
        Thu, 11 Mar 2021 08:57:34 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v19sm1519350ilj.60.2021.03.11.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:57:33 -0800 (PST)
Received: (nullmailer pid 867948 invoked by uid 1000);
        Thu, 11 Mar 2021 16:57:31 -0000
Date:   Thu, 11 Mar 2021 09:57:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
Message-ID: <20210311165731.GA866234@robh.at.kernel.org>
References: <20210311051309.16789-1-ansuelsmth@gmail.com>
 <20210311051309.16789-2-ansuelsmth@gmail.com>
 <1615480862.520618.841930.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615480862.520618.841930.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 09:41:02AM -0700, Rob Herring wrote:
> On Thu, 11 Mar 2021 06:12:48 +0100, Ansuel Smith wrote:
> > Document nvmem-cells compatible used to treat mtd partitions as a
> > nvmem provider.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/mtd/partitions/nvmem-cells.yaml  | 99 +++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.example.dt.yaml: art@1200000: $nodename:0: 'art@1200000' does not match '^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.example.dt.yaml: calibration@f00000: $nodename:0: 'calibration@f00000' does not match '^(eeprom|efuse|nvram)(@.*|-[0-9a-f])*$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

Looks like you need to reorder patches.

> 
> See https://patchwork.ozlabs.org/patch/1451109
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
