Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7F420309
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhJCRL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 13:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhJCRLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:11:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC48C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 10:10:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w14so232297pll.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Ebwf//kDSCRWsaKE4C3R7KVBDklhHZsQtL6HPnfLiEs=;
        b=GVPpTIs8wH2fgMQ0VWyPcncf99M8HLdjqwgr6454UbGZhtowCPpQMug9Nom1w81Wpl
         dqWRAmdGLJNlb/FB2PbcPszJQEw95XgbzhJxVv5rMRjVDagzvn5eFAFTI4zbPiQ1w2qZ
         tMtqm5Rs/yn7T4/Y1Q3zQo06g3tvU+5kcthryQ4ypuxuw2YkehJcs29+bo0rYR8gZ4G7
         peLdlwWBBU5cqKIC8QQGxA/v3buS1ugWfqY2LHkC74U37j/DrIQIFxP1FMwevTK8mIsh
         DBjUMmWFna/+eLV+ZlkK+k7djv9GTAkemrOlrtYKUaPtvlJTBT9ysLCzPSs7oveHRG7V
         cvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Ebwf//kDSCRWsaKE4C3R7KVBDklhHZsQtL6HPnfLiEs=;
        b=OaV70J27IZxalqS9pHcFgTMATrs8TKi4MTcPWoSnNIZd9ArkvsSo04L1hRQwsoXMIt
         dxz2doJmf/6YEmXfUSPlm3vqYc8Ug0J7Xk4XNZdfiq95M9vV4F54L3kcG5CEpJ/uiufJ
         U67gyeTMuLilP84MfiMe5MUtmK3DChA/I8xB4APYBteVOSUQK+vfrGHxlLnhQ6pcqkZ6
         mZwltVr3jSekzlJnXFDS2qOGdmdHJK/Gwb99NCXw1XsyowCFYIgjB5pdXxcxXjFvrWfQ
         0K/LUNtOE7ngsCB5RIy3Qfl6uu51Lllyx2PxOpYperufulmyPe+F+pECOFQjqcqsRUfX
         m7tQ==
X-Gm-Message-State: AOAM530H26tywrdejl6dXim9LHXHVTeDadroSfErXfqqyqvyOqe+MdcV
        tfweLFQLTtTJW/iq3EXEAZ3sa8Mivt5lGQ==
X-Google-Smtp-Source: ABdhPJywWTBeDxgOuo5UqA0zlwr4rsIdwHUVVHpjVrZOS42HB2BJdC5PDykZPcKAgb2G7y7mmaUvPQ==
X-Received: by 2002:a17:902:8488:b029:129:97e8:16e7 with SMTP id c8-20020a1709028488b029012997e816e7mr19458630plo.39.1633281006908;
        Sun, 03 Oct 2021 10:10:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 130sm12265255pfz.77.2021.10.03.10.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 10:10:06 -0700 (PDT)
Date:   Sun, 03 Oct 2021 10:10:06 -0700 (PDT)
X-Google-Original-Date: Sat, 02 Oct 2021 17:56:22 PDT (-0700)
Subject:     Re: [PATCH] riscv: set default pm_power_off to NULL
In-Reply-To: <20210907002847.111633-1-dimitri.ledkov@canonical.com>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dimitri.ledkov@canonical.com
Message-ID: <mhng-4f99a87e-9ed6-4d0b-a5b1-596e67198c1a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Sep 2021 17:28:47 PDT (-0700), dimitri.ledkov@canonical.com wrote:
> Set pm_power_off to NULL like on all other architectures, check if it
> is set in machine_halt() and machine_power_off() and fallback to
> default_power_off if no other power driver got registered.
>
> This brings riscv architecture inline with all other architectures,
> and allows to reuse exiting power drivers unmodified.
>
> Kernels without legacy SBI v0.1 extensions (CONFIG_RISCV_SBI_V01 is
> not set), do not set pm_power_off to sbi_shutdown(). There is no
> support for SBI v0.3 system reset extension either. This prevents
> using gpio_poweroff on SiFive HiFive Unmatched.
>
> Tested on SiFive HiFive unmatched, with a dtb specifying gpio-poweroff
> node and kernel complied without CONFIG_RISCV_SBI_V01.
>
> BugLink: https://bugs.launchpad.net/bugs/1942806
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  arch/riscv/kernel/reset.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index ee5878d968..9c842c4168 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -12,7 +12,7 @@ static void default_power_off(void)
>  		wait_for_interrupt();
>  }
>
> -void (*pm_power_off)(void) = default_power_off;
> +void (*pm_power_off)(void) = NULL;
>  EXPORT_SYMBOL(pm_power_off);
>
>  void machine_restart(char *cmd)
> @@ -23,10 +23,16 @@ void machine_restart(char *cmd)
>
>  void machine_halt(void)
>  {
> -	pm_power_off();
> +	if (pm_power_off != NULL)
> +		pm_power_off();
> +	else
> +		default_power_off();
>  }
>
>  void machine_power_off(void)
>  {
> -	pm_power_off();
> +	if (pm_power_off != NULL)
> +		pm_power_off();
> +	else
> +		default_power_off();
>  }

Thanks, this is on for-next.
