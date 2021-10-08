Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B05D426281
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhJHCsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:48:14 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:42679 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhJHCsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:48:11 -0400
Received: by mail-ot1-f51.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso9944514otu.9;
        Thu, 07 Oct 2021 19:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WCH/ZvRJ095r2piVpiKap3cip9CDgRowlgzYoYtODk4=;
        b=77jS+fI1VaA16kMEJLcg6k44CjRGkXayFA5yQq869kdn98ACyLX0pdiL6RFi9Nne9I
         2Qzo+J4xgaiGBuj/6rfBx5QMM/9lK0peE7sohdDNgNktw6U341JR+2v+Wriv3E9PT+99
         9XOQBeRNkehFp0Urne/DYvXRER6ITY2vC+MfmsAlrVRNm4EOlubc3FURX4/QmSETROPW
         xre53S0HhBMHJ4ypw9XEmtazQN3m2i0ambhawe5vOfAy8zeohky2wiWFAZ3x9Ym/5QuX
         sqLblLDjV5SHCQg1MCKPVPHnYs4o3TLtToVtQXEzvMM3i3+5wlL5FdCzLT55JYJhWZX9
         jZIg==
X-Gm-Message-State: AOAM530a8+x84DnCvJdjlhz/o8p6efo97HfhfD4uq17KuRNiIptBtIky
        igIvtlXIGj6T8OQYhoDdXw==
X-Google-Smtp-Source: ABdhPJw8aJTGTodhqaaRkMnbiMqq4zA5AnxSIR1dPlLXmJWPLZqAbAhjdJcXjZcWpq2dhcYcnx7A1w==
X-Received: by 2002:a05:6830:2781:: with SMTP id x1mr6391596otu.349.1633661176215;
        Thu, 07 Oct 2021 19:46:16 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h91sm261506otb.38.2021.10.07.19.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 19:46:15 -0700 (PDT)
Received: (nullmailer pid 1409598 invoked by uid 1000);
        Fri, 08 Oct 2021 02:46:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
In-Reply-To: <20211007130641.3589-1-Allen-KH.Cheng@mediatek.com>
References: <20211007130641.3589-1-Allen-KH.Cheng@mediatek.com>
Subject: Re: [PATCH] dt-bindings: mediatek: add adsp-mbox document
Date:   Thu, 07 Oct 2021 21:46:12 -0500
Message-Id: <1633661172.621831.1409597.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021 21:06:41 +0800, Allen-KH Cheng wrote:
> This patch adds document for mediatek adsp mbox
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  .../bindings/mailbox/mtk,adsp-mbox.yaml       | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.example.dts:22.44-31.11: ERROR (node_name_format): /example-0/adsp_mailbox@adsp_mailbox@10816000: multiple '@' characters in node name
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.example.dt.yaml] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1537694

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

