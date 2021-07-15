Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAFA3CA1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhGOPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:54:17 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:40633 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGOPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:54:15 -0400
Received: by mail-io1-f41.google.com with SMTP id l5so7020868iok.7;
        Thu, 15 Jul 2021 08:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JpZLiCBQnZ2+MHl1nUW2ILJ6GK8TQMEgnso1fyfpgW4=;
        b=HOnJayphy1geKWltBulmDz/ZiUN0Ya71BwhgIt/PWlJhMFFAAyXcivj7rrzO3UTuEi
         AlOVljyS6lNKQW/F1STsXVVH8YlG9P9lxGMN5eshRW1yleelrAhleBOUJ1y4HEn4MqHZ
         iWf7cI9W48DHHZijmqFxois64lcWYFHYKy9H2QcE78dAFM59nUpGIcGBC7NyiD57A2A5
         xlXlIS27S7hgUoiUpvZ2jgNSkJ1DmgJ1OGh5kqSSnoqZR/nd1Yv/WrPXapUmZAcw26+o
         +ABK6cDdy3YLtAPi7TGmueyOMrYu2smkmoUEK8CytNjnRtVDZGB8SwJy2l0LyozapSCv
         403A==
X-Gm-Message-State: AOAM533JWPKoeuOmy7q5q7BPTYNTuw2Lf1IZRYUhqsGrmo44dkWHL32Q
        2eLoJ05p8eCKVkM1nYdV0zcu74GtxA==
X-Google-Smtp-Source: ABdhPJyfy6RNCVwpCt8/P77LlZHhH+LauiplhwP3w//gzu1aeDj+fIQWDdVj7YoLFnX7maRUNnZD0g==
X-Received: by 2002:a05:6638:13ca:: with SMTP id i10mr952178jaj.90.1626364280999;
        Thu, 15 Jul 2021 08:51:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k10sm3374997ion.38.2021.07.15.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:51:19 -0700 (PDT)
Received: (nullmailer pid 1138776 invoked by uid 1000);
        Thu, 15 Jul 2021 15:51:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        robh+dt@kernel.org, perex@perex.cz, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>, daniel.baluta@gmail.com,
        tiwai@suse.com
In-Reply-To: <20210715141802.880911-4-daniel.baluta@oss.nxp.com>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com> <20210715141802.880911-4-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 3/3] dt-bindings: dsp: fsl: Document newly introduced fsl,properties
Date:   Thu, 15 Jul 2021 09:51:17 -0600
Message-Id: <1626364277.745081.1138775.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 17:18:02 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> Document firmware-name, tplg-name and machine-drv-name properties.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: dsp@596e8000: 'tplg-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: dsp@596e8000: 'machine-drv-name' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1505740

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

