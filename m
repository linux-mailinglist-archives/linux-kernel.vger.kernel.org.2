Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773E342628B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbhJHCs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:48:26 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42854 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhJHCsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:48:16 -0400
Received: by mail-oi1-f181.google.com with SMTP id g125so5118026oif.9;
        Thu, 07 Oct 2021 19:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=d/DSBmhRsznzpWcfTu9Dz3MGhzpb5fEj4AuhwcCUbk8=;
        b=xytbjSttLmjMY+gWV+MAwC97j6mt/GlONGKO7lKvJd8ymuoaAjoVPlPvub/oXImLdG
         cdMdPlqetkSGOwgweT2XifYeKk4xPXttEkxUHAwPRV0ow7xVhmbFoTFePHWHY9RTdnJ5
         njMODtiY5+caKjJeFfW+Bbic8NxlzK3O4a0DQpClP7m0Hfeu/w6Yp5Qwbx/mEAtt/x+r
         IrqaHcDqCb74zPtzAONR7mntdWdntJ/Pi9AlTbgNOaaTu7mKSpyvAUfz/bgUAWuaiq1c
         1DJ/3+970DqWCyit5gGoIjU8wI0KubKR8h0BH7qPkeyhF3UiFRxGqCPg791i3Mi7Is+J
         SovA==
X-Gm-Message-State: AOAM530dY5kp0z+xadxO5dEvRlWMTA0UNh/Fa48yDpVRwIxY2rgMJQqw
        wU2CfxyAkAGXFjFwVnP9Aw==
X-Google-Smtp-Source: ABdhPJy1cC5Nx8AhMq2wtMPWY6DFxKO81NZcudRZwFFA99IYTe+JunWd29Ow26kJPmmMtcTTjhUixw==
X-Received: by 2002:aca:32c5:: with SMTP id y188mr13937282oiy.163.1633661181481;
        Thu, 07 Oct 2021 19:46:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a1sm259305otr.33.2021.10.07.19.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 19:46:20 -0700 (PDT)
Received: (nullmailer pid 1409594 invoked by uid 1000);
        Fri, 08 Oct 2021 02:46:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
In-Reply-To: <20211007123632.697666-9-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com> <20211007123632.697666-9-anup.patel@wdc.com>
Subject: Re: [RFC PATCH v4 08/10] dt-bindings: timer: Add ACLINT MTIMER bindings
Date:   Thu, 07 Oct 2021 21:46:12 -0500
Message-Id: <1633661172.604098.1409593.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Oct 2021 18:06:30 +0530, Anup Patel wrote:
> We add DT bindings documentation for the ACLINT MTIMER device
> found on RISC-V SOCs.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>  .../bindings/timer/riscv,aclint-mtimer.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml:31:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1537679

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

