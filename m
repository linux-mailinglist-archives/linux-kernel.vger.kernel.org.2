Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699E33BDE6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGFUaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 16:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 16:30:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E5DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 13:27:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f11so12750959plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hlvwZrSaQ0bab3fEbUJ05OGNLxsUWlPkkNWMAazZmgk=;
        b=PxU01lc2ujMAED/QRZ5N7vVS6BuKrpsWwgpQl/H5924T0Mktcl/xBhwm3PhR2MJz9V
         dlRoQi2rb14C8Tb9N5kM/Q6U/MeUdQjoJw7p3RiTY/uvWO/kRyCUSEOhffc7J9nkusmL
         kL2ipaO159Y25p1tw5SudRgtaj3dVzLVChCn2D0yWFwC8We18piB5GUzuPHbII/51B4g
         bkV/u1FuCJsw/7IqOYnz135skV3ABkEoudJEsBfzez5onCLyioS6QQN1v5wJnsKWK+xy
         6Q8+fI2EeFMuD8ZXLPhmDb3vquthlKhxOWDjc0VIXx2jOX0VZJAn4QF5GoiZD8yELOKN
         kVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hlvwZrSaQ0bab3fEbUJ05OGNLxsUWlPkkNWMAazZmgk=;
        b=X6QriHu9/8LRIE6VnhNyUJyXR1OORRzfXNpUbaiplzqlDyBV4gpzvbiaT+xR6K/3Ee
         zJeSMk22wpUpLhOMTlgLiPGeISfiv0E7dxxgjmBvwAJLbEdq2Z2wRESAX9EW3LMGS2+c
         qD3NSgr+aH8CMq+Y7FbDuyJeRGnFeLaGj1/bVDWdfdw4YYORxQJafsjll+s7zQwSBhkJ
         Gzs20V5fONgUOIw6KpEC7JfI+5WbCGb+dp93UXrSyBy4Hob9J688Gf5LjZijzOeIp8z/
         lpItUZ9W802YpZ7FqkqWx1u6hL54TpEoByE8EU8mtH2b5sT7nLDqEgdtQVFjwzrlbTsm
         Xy6g==
X-Gm-Message-State: AOAM533FKeNh16chQwsLDKGBZAdu/XmNfp6sZTKbJOmrY2ZHMo3pFRhB
        PyK8NzFXR03pi9DM2+5n/KRFKg==
X-Google-Smtp-Source: ABdhPJzdx5xzvFr4fU8hhcVcOKB2ZIAqoNLQu2qcOI+io1NHaGkhU6wqh5fUFnfCgsvb148aic1STw==
X-Received: by 2002:a17:902:8484:b029:101:7016:fb7b with SMTP id c4-20020a1709028484b02901017016fb7bmr18027986plo.23.1625603251017;
        Tue, 06 Jul 2021 13:27:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f5sm9026140pfn.134.2021.07.06.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:27:30 -0700 (PDT)
Date:   Tue, 06 Jul 2021 13:27:30 -0700 (PDT)
X-Google-Original-Date: Tue, 06 Jul 2021 13:27:26 PDT (-0700)
Subject:     Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
In-Reply-To: <CAAhSdy0=XANwm4Vr5qbpvJdqwYNCfDRNTDf3cyAOGp-NuqF_Ag@mail.gmail.com>
CC:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     anup@brainfault.org
Message-ID: <mhng-b2af24ea-608a-4e2c-af51-6dc7e415bf30@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.org wrote:
> Hi Palmer,
>
> On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.com> wrote:
>>
>> The SBI SRST extension provides a standard way to poweroff and
>> reboot the system irrespective to whether Linux RISC-V S-mode
>> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>>
>> The SBI SRST extension is available in the SBI v0.3 specification.
>> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0-rc1)
>
> Can you please consider this patch for Linux-5.14-rc1 ?
>
> The SBI v0.3 spec is already frozen and this patch has been
> floating on LKML for quite a few months now.

I didn't realize that SBI-0.3 had been frozed.  That link is to a RC, 
the cooresponding v0.3.0 tag isn't in that repo.  Can you give me a 
pointer to the frozen spec?

>
> Regards,
> Anup
>
>>
>> This patch extends Linux RISC-V SBI implementation to detect
>> and use SBI SRST extension.
>>
>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>> Reviewed-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>  arch/riscv/include/asm/sbi.h | 24 ++++++++++++++++++++++++
>>  arch/riscv/kernel/sbi.c      | 35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 59 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index 0d42693cb65e..289621da4a2a 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>>         SBI_EXT_IPI = 0x735049,
>>         SBI_EXT_RFENCE = 0x52464E43,
>>         SBI_EXT_HSM = 0x48534D,
>> +       SBI_EXT_SRST = 0x53525354,
>>  };
>>
>>  enum sbi_ext_base_fid {
>> @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
>>         SBI_HSM_HART_STATUS_STOP_PENDING,
>>  };
>>
>> +enum sbi_ext_srst_fid {
>> +       SBI_EXT_SRST_RESET = 0,
>> +};
>> +
>> +enum sbi_srst_reset_type {
>> +       SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
>> +       SBI_SRST_RESET_TYPE_COLD_REBOOT,
>> +       SBI_SRST_RESET_TYPE_WARM_REBOOT,
>> +};
>> +
>> +enum sbi_srst_reset_reason {
>> +       SBI_SRST_RESET_REASON_NONE = 0,
>> +       SBI_SRST_RESET_REASON_SYS_FAILURE,
>> +};
>> +
>>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
>> @@ -148,6 +164,14 @@ static inline unsigned long sbi_minor_version(void)
>>         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
>>  }
>>
>> +/* Make SBI version */
>> +static inline unsigned long sbi_mk_version(unsigned long major,
>> +                                           unsigned long minor)
>> +{
>> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
>> +               SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
>> +}
>> +
>>  int sbi_err_map_linux_errno(int err);
>>  #else /* CONFIG_RISCV_SBI */
>>  static inline int sbi_remote_fence_i(const unsigned long *hart_mask) { return -1; }
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index 7402a417f38e..9a84f0cb5175 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -7,6 +7,7 @@
>>
>>  #include <linux/init.h>
>>  #include <linux/pm.h>
>> +#include <linux/reboot.h>
>>  #include <asm/sbi.h>
>>  #include <asm/smp.h>
>>
>> @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
>>  }
>>  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
>>
>> +static void sbi_srst_reset(unsigned long type, unsigned long reason)
>> +{
>> +       sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
>> +                 0, 0, 0, 0);
>> +       pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
>> +               __func__, type, reason);
>> +}
>> +
>> +static int sbi_srst_reboot(struct notifier_block *this,
>> +                          unsigned long mode, void *cmd)
>> +{
>> +       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
>> +                      SBI_SRST_RESET_TYPE_WARM_REBOOT :
>> +                      SBI_SRST_RESET_TYPE_COLD_REBOOT,
>> +                      SBI_SRST_RESET_REASON_NONE);
>> +       return NOTIFY_DONE;
>> +}
>> +
>> +static struct notifier_block sbi_srst_reboot_nb;
>> +
>> +static void sbi_srst_power_off(void)
>> +{
>> +       sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
>> +                      SBI_SRST_RESET_REASON_NONE);
>> +}
>> +
>>  /**
>>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>>   * @extid: The extension ID to be probed.
>> @@ -608,6 +635,14 @@ void __init sbi_init(void)
>>                 } else {
>>                         __sbi_rfence    = __sbi_rfence_v01;
>>                 }
>> +               if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
>> +                   (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
>> +                       pr_info("SBI SRST extension detected\n");
>> +                       pm_power_off = sbi_srst_power_off;
>> +                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
>> +                       sbi_srst_reboot_nb.priority = 192;
>> +                       register_restart_handler(&sbi_srst_reboot_nb);
>> +               }
>>         } else {
>>                 __sbi_set_timer = __sbi_set_timer_v01;
>>                 __sbi_send_ipi  = __sbi_send_ipi_v01;
>> --
>> 2.25.1
>>
