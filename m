Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2E3F88DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbhHZN1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:27:11 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44745 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbhHZN0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:26:54 -0400
Received: by mail-ot1-f47.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so3418244otg.11;
        Thu, 26 Aug 2021 06:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2o4OhJ2JQkPtoaQGdSaMZ6wV1LKdoU5Xo2BeBtn6dQo=;
        b=MKcnI26r7TqYm1xoDQA6kaM54GqIvIjKKWJc22zoj7HNYGGsI2tiYiaM7ni2B1IavS
         97WceNTwlvCL9Lk2RtmtPBVmQAoub//lTwFWr6FDG3b9j9MefxK9DT6JTMQhtyU1voFG
         fvqY2/umbTyKAHB5Pz+3giK8emdcP7IDezR6tnTDbcwtcxzWZ4IbIsSr7bm4JhTN4TD4
         MV7YhjEI+UhXECb5DvIbQRK6kvpO7Nsf76C1MnStoHHO0annX5b4itrrm6c0SIVSiH3l
         2MZYl31/veKnC5cFxxjQ0amFnXWxg8axhg2y3+b9EdydDWWcHiMpcW9HSWPvvp2/1VT5
         HgXQ==
X-Gm-Message-State: AOAM532jrhXLyvRzdDM8HO3OWzcXTYq4vhBYUY6KwPc+ZNfR4WnKu9vO
        8WpSqrpvzO7o/S9+BbqjpQ==
X-Google-Smtp-Source: ABdhPJwgIxeiiEIYRJSGhRksrfozuX03sL79KteMqhx3Q4ivlxzWPU1LZCt26qy+FhsGzG9JshpPpA==
X-Received: by 2002:a9d:798c:: with SMTP id h12mr3034753otm.215.1629984366555;
        Thu, 26 Aug 2021 06:26:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b3sm634202oie.1.2021.08.26.06.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:26:05 -0700 (PDT)
Received: (nullmailer pid 1033388 invoked by uid 1000);
        Thu, 26 Aug 2021 13:26:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, dianders@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
In-Reply-To: <20210826110311.613396-3-yangcong5@huaqin.corp-partner.google.com>
References: <20210826110311.613396-1-yangcong5@huaqin.corp-partner.google.com> <20210826110311.613396-3-yangcong5@huaqin.corp-partner.google.com>
Subject: Re: [v3 2/2] dt-bindngs: display: panel: Add BOE tv110c9m-ll3 panel bindings
Date:   Thu, 26 Aug 2021 08:26:01 -0500
Message-Id: <1629984361.395478.1033387.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 19:03:11 +0800, yangcong wrote:
> Add documentation for boe tv110c9m-ll3 panel.
> 
> Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../display/panel/boe,tv110c9m-ll3.yaml       | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.example.dts:25.42-43 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1521039

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

