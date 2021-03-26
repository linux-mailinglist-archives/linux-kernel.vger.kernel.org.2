Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A1B34AB06
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCZPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:11:31 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:39536 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCZPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:10:59 -0400
Received: by mail-il1-f176.google.com with SMTP id y17so5293744ila.6;
        Fri, 26 Mar 2021 08:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=V6kxHAMFGHc90myISo6VM6ueaBvRJahf0rAQgZck3Fs=;
        b=QfqD78Aew0F67Y2f7i3gJmmZPDEn6nIgJlRbPWFlxYEelCD6SD4baLeJ7iGOOntSdn
         llMgDKOgE1Sk/BqWCpoKo4XDHBEmh3CQaIdjZ0qfXNktVk3sIlqEvJNMEK+24DfcqsK2
         T2ky/lNxkiEQZng1/9d3Dt/dgoFXbme8LeYjp2qbCrNTfYwxqQVKvyA0CdIuV4wBdkV1
         PJ1qpgopCx7JB82GdiC+n3hnZ2JTwjZPTOEd0s11Z2iDF3fRledNSvfyhO4rDUd/cYl1
         HxnENY258HWrAikrkEQXwGEFCNcv47zGcOuDKtxcZiaq47XKp80FTotzfulIm90/cHAX
         RV8A==
X-Gm-Message-State: AOAM530llm0AnzUOtAcr7aCO/X/PsjQfydUWK+ySc6Ks1QWDuCZpKTy5
        JuHfGPUIsXPr9LUDf6uBOQ==
X-Google-Smtp-Source: ABdhPJyStqL3NEZY7qbA5kS67RsQZxAe37NEbUFsqr6MXsMcQqzUF92vBsQzYpDKLriZ49f0Rmz3wQ==
X-Received: by 2002:a92:c56f:: with SMTP id b15mr10756598ilj.41.1616771458456;
        Fri, 26 Mar 2021 08:10:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l14sm2530159ilj.14.2021.03.26.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:10:57 -0700 (PDT)
Received: (nullmailer pid 3384057 invoked by uid 1000);
        Fri, 26 Mar 2021 15:10:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nina Wu <nina-cm.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Neal Liu <neal.liu@mediatek.com>,
        Nina Wu <Nina-CM.Wu@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jackson-kt.Chang@mediatek.com
In-Reply-To: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
Date:   Fri, 26 Mar 2021 09:10:54 -0600
Message-Id: <1616771454.300082.3384056.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 15:31:10 +0800, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> To support newer hardware architecture of devapc,
> update device tree bindings.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/devapc.yaml   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml: properties:version:enum: False schema does not allow [1, 2]
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml: properties:slave_type_num:enum: False schema does not allow [1, 4]
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml: ignoring, error in schema: properties: slave_type_num: enum
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
Documentation/devicetree/bindings/soc/mediatek/devapc.example.dts:51:18: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
   51 |         #include <dt-bindings/clock/mt8192-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/soc/mediatek/devapc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1458687

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

