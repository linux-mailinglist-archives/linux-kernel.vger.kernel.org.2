Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BB5426280
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJHCsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:48:12 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40823 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJHCsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:48:08 -0400
Received: by mail-ot1-f54.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so9967042otq.7;
        Thu, 07 Oct 2021 19:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZiN7i9gSKdNstbHdeYWwXVbEFyTvnEpUijhN0u+SjzA=;
        b=QJg0MkxNr3wBMCuA9aMaIGZddlrMjC5eD2dU4Sfdh/pBQlsqqi32brXX1a10N3bhJo
         fLpA3TJaQTKAqga8OGkgDzYf+1J+yqsChLne8dZshyaabOeJAQjhBqAo+9K7pfnOaqp5
         1AQ8QwMYQOzbPaGmXKxeIIVk7ffzq1eV815tFSkwptlqyjyDDlWNbLDtj9m+SWjSOiFb
         YioyvCVNlTgNmGEso/tk6xZ7YBJgUxY4+D70NUj4TB+tTB9T/bFIekU3/y5PJ51GTDBv
         0P+a+GNfg82DbhAPHk2OCJ5Lkeof+0MYKBvrAa8Oa0SF3qSoGbdTel1oe/6gz1XiHZAL
         6qag==
X-Gm-Message-State: AOAM531q9RxHud7IXSjn7Ac6zHAQLprY12rdDT/DQnwdz3ZHQwjR4TqS
        LX9/eSoTqWjY2nWJSqin5fCaXluHtQ==
X-Google-Smtp-Source: ABdhPJyIx2Q9OE86cxQ0eVI2Glqtq0+kpx6vwhQ0UPF5Nvt73XPVNCEaryUeqd8Gmb2c/5tTSaJKVQ==
X-Received: by 2002:a9d:5a8e:: with SMTP id w14mr6830870oth.322.1633661174072;
        Thu, 07 Oct 2021 19:46:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d26sm305260oij.49.2021.10.07.19.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 19:46:13 -0700 (PDT)
Received: (nullmailer pid 1409591 invoked by uid 1000);
        Fri, 08 Oct 2021 02:46:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atish.patra@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org
In-Reply-To: <20211007123632.697666-6-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com> <20211007123632.697666-6-anup.patel@wdc.com>
Subject: Re: [RFC PATCH v4 05/10] dt-bindings: interrupt-controller: Add ACLINT MSWI and SSWI bindings
Date:   Thu, 07 Oct 2021 21:46:12 -0500
Message-Id: <1633661172.595534.1409590.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021 18:06:27 +0530, Anup Patel wrote:
> We add DT bindings documentation for the ACLINT MSWI and SSWI
> devices found on RISC-V SOCs.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>  .../riscv,aclint-swi.yaml                     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml:34:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml:39:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1537678

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

