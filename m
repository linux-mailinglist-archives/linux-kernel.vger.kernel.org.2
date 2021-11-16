Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDBB45342A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhKPObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhKPObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:31:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:28:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d27so38014807wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWhPuTZCeYFcjOd58uwQgszWNU0sTCldaG8fba7OiLc=;
        b=3mFsOvA5uHel7jOb/udYTc1PO/xSN11ULu2UYyqyvZVgkmYk+h2rX4Dh//fvuU255O
         SHt74aM3iQ/8yLRV6HUUrmWUO72BDRwEYf1Qid72F7RCDK8JDCdTHZ97qDlYLWGn6JMB
         7lloH7OVo9ZhWc/cSQb/ACWKgYk530kO6bwFAm75TkXIO/wqInG7huqFJq6NXc8Fiw4O
         kda1+if+KnDlh554y+9JLvCg3V0LEsEx0tHP986b87lU8DgbqGbI8+2HFowf+cuOe1E4
         wwO7m0t3ylRXqrL8tiT7DkKd3MX1VBD8xfA1cy5HRf0paVKPmrI3K147hTTb2/Q8IFNS
         pHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWhPuTZCeYFcjOd58uwQgszWNU0sTCldaG8fba7OiLc=;
        b=br099A8g6psy6QkK0VFNU0L+pwqkixvcyI4ObjNitf/mjdjWauDGDrRMZrMyl/V5Oh
         vtbp3ba1rNWk5mIWDw33aON9IaMdhLNTUXEI6udtAxV2/HafI3gXlyUXMu4/fXlnaaez
         JCdlmhBqyqTXHjQaKwE2TsWr9kFdTeexgGZWupbWIOZSivcTLwDJMqdY+cEzVet6gAX/
         LD9DAo1suvP29y5xrKXqfQxt/Ez2v2b6/h2Iz6T3M/tTjp0Z+7EREJ5ZgNDxZh/uzzE8
         S+oqIYdczyYKrEfyxr9TOBfJ78+/frtYZHmgcfMeMQ8XZ6uzEGcNDe7iFJUWqHPJjBJh
         tsHw==
X-Gm-Message-State: AOAM531b+7qngXGM3l34cNmvZbrXfc4JpylCaweUFGLTvZfMSfJoxmTH
        EzFzvU8CCVflAAxWdwkgVWpbLsHHmpam3voLc+en4Q==
X-Google-Smtp-Source: ABdhPJyRDHaoLZ0NSJJuQgeeiHMHfW8vt2fxAhUgZNG7UkoYMeWr2Oc6/hMlaDv8BYe/4nla2hhbe+NFAA0JueeQybk=
X-Received: by 2002:adf:8165:: with SMTP id 92mr10151797wrm.199.1637072891214;
 Tue, 16 Nov 2021 06:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20211103064458.26916-1-zhang.mingyu@zte.com.cn>
In-Reply-To: <20211103064458.26916-1-zhang.mingyu@zte.com.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 16 Nov 2021 19:57:59 +0530
Message-ID: <CAAhSdy3LvzR4H_rYvacER87n7fakU9EzE17vA3D+ASczR24=5g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM:Remove unneeded semicolon
To:     cgel.zte@gmail.com
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 12:15 PM <cgel.zte@gmail.com> wrote:
>
> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
>
> Eliminate the following coccinelle check warning:
> arch/riscv/kvm/vcpu.c:167:2-3
> arch/riscv/kvm/vcpu.c:204:2-3
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Thanks but this is already fixed by following patch:
https://www.spinics.net/lists/kvm/msg257614.html

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index e92ba3e5db8c..e3d3aed46184 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -164,7 +164,7 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_vcpu *vcpu,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
>                 return -EFAULT;
> @@ -201,7 +201,7 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         return 0;
>  }
> --
> 2.25.1
>
