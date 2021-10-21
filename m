Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB94436027
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJUL1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJUL07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:26:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DA7C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:24:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d3so503743wrh.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 04:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=823GhYmXbttbJwIVURhuPlV/kHfvN4T6Ehf+eMAd4qg=;
        b=nfEfrSbCk1e42MxpttkQclQWIW+uGKdG0+QuvEJZcTOkz8qazuzf5znHkZAPhC2hU8
         fsZmSzj21VYm0rLGPCAQsri62ycKeT1JWBOvqxD0LDbgmXKOJr9z3EdntJiRNDUdYrqH
         4NFYkpq6ejFL8fDyiwRe932cdHINEFAe4B2BpWxcEFPZIb1T+VmZFn+vtnX1+h1PfFtC
         Wt7h/3irpBfE4hMC6yezfWvv6EHZms1tONuiAwHoC7vpOXD4zyJ1ht7+5GXJ+Hcgco9S
         cSOMGqXn6Sfr0iCGs+0KqHThxqQAjfZoix70tBXFaULNLMNWlETPB+BY7s6BBmDMFCjP
         F8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=823GhYmXbttbJwIVURhuPlV/kHfvN4T6Ehf+eMAd4qg=;
        b=R35CxTToNzaQdRPuNH9g8c7/xKeL5XhyUFb0dePUNoyIr02QmBZLE1a6AR7oVWhWWV
         Zdwd6NPFcmQT3sZOATmBW4j7i4VuXQVDT+5jZ2US8bZjmOUPHHWP6TFhf/hgVGree7Kq
         UU5qIlIUxh7gKwilfj1pwr/DDl89nSwIRYwkHESuwCePXIj18AMQ+l+al+yUkt5DoJWZ
         lVVFsRBhwkGGVJyQiawJOZXZKECVxe+B6UiEbJzXGwCW+CQQNyZ2xKkXyLxYHxIXBevD
         jN9Dqvo61dRM0p/6ohtImEAnf3oiOI+mvcAk6/d3MO9hjlquPTlHlytCuAb5daByg/8I
         w+4g==
X-Gm-Message-State: AOAM533B5MYaHqJt+lr80bM4edHUkGALjlLxKKQzCPYf22VGdlpv0H/r
        yENRkJnMC1Yvz+vlyQbirZAcLy2HL+oWhw1nbgwzHw==
X-Google-Smtp-Source: ABdhPJw4/zb4/niggRe0zyZ/ENXV882FAHY78FWAaLNgfY/JPNI0A5fpTNtqBvIEMMQ4TnCeIIlENOKE9MKEK0amVZ4=
X-Received: by 2002:adf:e60a:: with SMTP id p10mr6498325wrm.306.1634815482401;
 Thu, 21 Oct 2021 04:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211021104536.1060107-1-ran.jianping@zte.com.cn>
In-Reply-To: <20211021104536.1060107-1-ran.jianping@zte.com.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 21 Oct 2021 16:54:29 +0530
Message-ID: <CAAhSdy3DWOux6HiDU6fPazZUq=FOor8_ZEoqh6FBZru07NyxLQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V:KVM: remove unneeded semicolon Elimate the
 following coccinelle check warning: ./arch/riscv/kvm/vcpu_sbi.c:169:2-3:
 Unneeded semicolon ./arch/riscv/kvm/vcpu_exit.c:397:2-3: Unneeded semicolon
 ./arch/riscv/kvm/vcpu_exit.c:687:2-3: Unneeded semicolon ./arch/riscv/kvm/vcpu_exit.c:645:2-3:
 Unneeded semicolon ./arch/riscv/kvm/vcpu.c:247:2-3: Unneeded semicolon
 ./arch/riscv/kvm/vcpu.c:284:2-3: Unneeded semicolon ./arch/riscv/kvm/vcpu_timer.c:123:2-3:
 Unneeded semicolon ./arch/riscv/kvm/vcpu_timer.c:170:2-3: Unneeded semicolon
To:     cgel.zte@gmail.com
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 4:15 PM <cgel.zte@gmail.com> wrote:
>
> From: ran jianping <ran.jianping@zte.com.cn>

Reduce the length of patch subject (preferable around 70 characters)
and move the rest of patch subject as patch description.

Regards,
Anup

>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
> ---
>  arch/riscv/kvm/vcpu.c       | 4 ++--
>  arch/riscv/kvm/vcpu_exit.c  | 6 +++---
>  arch/riscv/kvm/vcpu_sbi.c   | 2 +-
>  arch/riscv/kvm/vcpu_timer.c | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index c44cabce7dd8..912928586df9 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -244,7 +244,7 @@ static int kvm_riscv_vcpu_get_reg_config(struct kvm_vcpu *vcpu,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
>                 return -EFAULT;
> @@ -281,7 +281,7 @@ static int kvm_riscv_vcpu_set_reg_config(struct kvm_vcpu *vcpu,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         return 0;
>  }
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 13bbc3f73713..7f2d742ae4c6 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -394,7 +394,7 @@ static int emulate_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                 break;
>         default:
>                 return -EOPNOTSUPP;
> -       };
> +       }
>
>         /* Update MMIO details in kvm_run struct */
>         run->mmio.is_write = true;
> @@ -642,7 +642,7 @@ int kvm_riscv_vcpu_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
>                 break;
>         default:
>                 return -EOPNOTSUPP;
> -       };
> +       }
>
>  done:
>         /* Move to next instruction */
> @@ -684,7 +684,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                 break;
>         default:
>                 break;
> -       };
> +       }
>
>         /* Print details in-case of error */
>         if (ret < 0) {
> diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
> index ebdcdbade9c6..eb3c045edf11 100644
> --- a/arch/riscv/kvm/vcpu_sbi.c
> +++ b/arch/riscv/kvm/vcpu_sbi.c
> @@ -166,7 +166,7 @@ int kvm_riscv_vcpu_sbi_ecall(struct kvm_vcpu *vcpu, struct kvm_run *run)
>                 /* Return error for unsupported SBI calls */
>                 cp->a0 = SBI_ERR_NOT_SUPPORTED;
>                 break;
> -       };
> +       }
>
>         if (next_sepc)
>                 cp->sepc += 4;
> diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
> index ddd0ce727b83..5c4c37ff2d48 100644
> --- a/arch/riscv/kvm/vcpu_timer.c
> +++ b/arch/riscv/kvm/vcpu_timer.c
> @@ -120,7 +120,7 @@ int kvm_riscv_vcpu_get_reg_timer(struct kvm_vcpu *vcpu,
>                 break;
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
>                 return -EFAULT;
> @@ -167,7 +167,7 @@ int kvm_riscv_vcpu_set_reg_timer(struct kvm_vcpu *vcpu,
>         default:
>                 ret = -EINVAL;
>                 break;
> -       };
> +       }
>
>         return ret;
>  }
> --
> 2.25.1
>
