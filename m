Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F2A42643C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 07:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJHFuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 01:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhJHFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 01:50:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250B3C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 22:48:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so25965616wrc.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 22:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xza3FZu4/45i3mPqxeQ2Q2oi0Y+FkLNAPOGd2b40l+w=;
        b=g75tY/NDC5XJY7BXDLhtUI+ly8rpIHUO0hAfLxt1Lqp0TuKXjBW2VpXfF5DB4muVTE
         TapcRhfi+n4hY2hJVfWQ7NCZgn8Y1NnhG8nqFHjPIgoYZrGPm3sfl+jzTD/4sqchekSQ
         Z84RnZPfXJb4euhKwhKR21JWlxMKAxmc/xuglDMYa9rnMBaAvuigGOiOAljwLUixTnVX
         TZUEkBDK3iGQAugiI3ys4ajhotgoSgQcBq5cqZLGZXS6TzqXhuCsTM3LlZ3iahdnRzgM
         BYW64aE7+OwwSceG8moDoPNHocI60+o6SmKvOvUENyLfWxLQsd69SBeB5u8AdBsm7pq0
         yVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xza3FZu4/45i3mPqxeQ2Q2oi0Y+FkLNAPOGd2b40l+w=;
        b=TedfbdHfyR8jdh6jvJOCXz1WJuSLMTECGJzXiqZUtwfpB+o3Owa4XukqdLN/ASf8/p
         h70LiS+Rm7EtNmDQ2tN3wCD2PY68EB5KppbEkAoeZ9xCnIlICxKUFXwS+5VlI/kZDtr7
         dtYZZnAia2pdPaQ/Vs1297fEuyawnXucKAd9fGHmefigb7qb8DgncGxo/AmSEJ1DV4hW
         VzJOKWgeuyk5d/11wFuqYEplV2PQjsGFiTuMFmQLGOujZastnc8dNhMpduWFVGBTEYJx
         krJAJPklfRiz/kJGzqR2LiaoVwr5aAjqj2JNrthpaucpg82S79x4K/7Z6jJJMJFAJ0W+
         BF/A==
X-Gm-Message-State: AOAM5304uvquZ+iMX7Rc7OqDWk6qg+zK76BcZSfNR+ef9bIwMGGcQ//5
        XbuH6hTrTCWLRENx5pvsr8y5zJNUi1lB0tSehL0nww==
X-Google-Smtp-Source: ABdhPJy9UbYUMVl4HBmsmA6GSsZCNVNCqohyBOf6eLhBVYwyPCiXWpaOFeF4fRn+cVVaHILtjVVGPf4oUNk8A3ScN7Q=
X-Received: by 2002:a05:600c:4111:: with SMTP id j17mr1359473wmi.59.1633672094680;
 Thu, 07 Oct 2021 22:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211007123632.697666-1-anup.patel@wdc.com> <20211007123632.697666-9-anup.patel@wdc.com>
 <1633661172.604098.1409593.nullmailer@robh.at.kernel.org>
In-Reply-To: <1633661172.604098.1409593.nullmailer@robh.at.kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 8 Oct 2021 11:18:03 +0530
Message-ID: <CAAhSdy1VnK9qKcJN42f9g5j7C1WNkzjpj6QQVFKD=2d9cYzDtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 08/10] dt-bindings: timer: Add ACLINT MTIMER bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>, Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 8:16 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 07 Oct 2021 18:06:30 +0530, Anup Patel wrote:
> > We add DT bindings documentation for the ACLINT MTIMER device
> > found on RISC-V SOCs.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  .../bindings/timer/riscv,aclint-mtimer.yaml   | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml:31:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
>
> dtschema/dtc warnings/errors:
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1537679
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

Sure, I will fix the "yamllint" warning in the next patch revision.

Let me know if there are any other comments.

Regards,
Anup

>
