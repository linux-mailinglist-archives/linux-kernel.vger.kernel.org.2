Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259543D9CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhG2EaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhG2EaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:30:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE4C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:30:20 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ca5so8382341pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yDEpBPL9hlQokMBesRFr+lpHjN7wWQlYeor+VTwxaEc=;
        b=s20sIvpYYBWN86SyBnX3bdw2f5dD8Twf+PXtilSzQg0HZuOF1O7fnKnZE/j/Nt0Yd1
         kmMn9Sd45rOkV0dNHx2S4ri5eY0+VhizOEokWM6oZejdfsiEZ1OOphPNVkfhX4V8+Kcf
         6bhxEjlDeq1Tj8IhfJjwIr1Tp9qwIEIejQf9HvNFPNlNHgtGjzxtaz4M3G2LRWJGCQJV
         JNSw0sIf+YNYVJz/emOx/OR/P2hdwor0wAfZdFssV4PDumNo0LXlejWl0687GfvUHmWJ
         Zp7o1im+VIzdngI2i2OCgyE2DADoKm6TRwE8W1sm+oZ3HEr90CNauWqTRPK0YzgjSZdr
         9BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yDEpBPL9hlQokMBesRFr+lpHjN7wWQlYeor+VTwxaEc=;
        b=DbcRkW3Pk9Wr3zM8QF6aGSwmfZ7VeCTo5jp2VsJwtakC2iMuVCnDQ6YbxTCNi4QNQW
         FH7rF3TZwjlUYEvq53lNmvOyUWdpOLWhlp2BSpDZptPEZTE5hRj2cfFRnvf+Jp6MHcma
         5Jdv+byfnaWlDC5wJnZzG6lo0P2dmTwKRvXoI3UbayxpRxiehdUHr1B/u02gzHCdLUcy
         mKQNTdhC1oP06eLfB57PwpdjJi9yG6nfHptS8oMPnIIq3KP/50qQI8lmPESjp11TWifI
         q1xMvHM8xUrgmdTOEarzAGfDW1icatHIp7im2BhlyMzP2o3omX4ThN26ulNj9V52AoT7
         oAXQ==
X-Gm-Message-State: AOAM531dOM4Cj/uBiW9gHHJ7h3xFQo07wpX+yoWp08Bx1NJo1ctEC/sa
        6Ov15ybfSwZePdn5G3tMAosgxA==
X-Google-Smtp-Source: ABdhPJxMIzSxIzWzi1Aj9OK8HqqUYZ5UcZ0saFuJR/95dTjy0Y12SJ0PZfPqOcZDiHwUqv9JXbp29A==
X-Received: by 2002:a17:903:30c3:b029:12c:1bf3:68d7 with SMTP id s3-20020a17090330c3b029012c1bf368d7mr2944405plc.73.1627533019577;
        Wed, 28 Jul 2021 21:30:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e23sm1652607pfd.26.2021.07.28.21.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 21:30:19 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:30:19 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Jul 2021 20:30:24 PDT (-0700)
Subject:     Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
In-Reply-To: <mhng-6c25dda6-4c85-447c-ad9c-7641f2858b10@palmerdabbelt-glaptop>
CC:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2021 11:59:33 PDT (-0700), Palmer Dabbelt wrote:
> On Fri, 09 Jul 2021 22:01:02 PDT (-0700), Anup Patel wrote:
>>
>>
>> ﻿On 08/07/21, 9:22 AM, "Anup Patel" <anup@brainfault.org> wrote:
>>
>>     On Wed, Jul 7, 2021 at 1:57 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>     >
>>     > On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.org wrote:
>>     > > Hi Palmer,
>>     > >
>>     > > On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.com> wrote:
>>     > >>
>>     > >> The SBI SRST extension provides a standard way to poweroff and
>>     > >> reboot the system irrespective to whether Linux RISC-V S-mode
>>     > >> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>>     > >>
>>     > >> The SBI SRST extension is available in the SBI v0.3 specification.
>>     > >> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0-rc1)
>>     > >
>>     > > Can you please consider this patch for Linux-5.14-rc1 ?
>>     > >
>>     > > The SBI v0.3 spec is already frozen and this patch has been
>>     > > floating on LKML for quite a few months now.
>>     >
>>     > I didn't realize that SBI-0.3 had been frozed.  That link is to a RC,
>>     > the cooresponding v0.3.0 tag isn't in that repo.  Can you give me a
>>     > pointer to the frozen spec?
>>
>>     Here's the link to SBI v0.3.0 tag:
>>     https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0
>>
>>     We treat RC tags as frozen in SBI spec because no functional
>>     changes are done in SBI spec after it is tagged as RC. We only
>>     do typo fixes and clarifications on SBI spec RC release.
>
> Treating the 0.3.0-rc1 as frozen as soon as it's released is a
> terrifying policy: some of the fixes I sent in after I saw rc1 released
> change the actual meaning of the text, even if they were meant to change
> them to what I thought the intended meaning was supposed to be.  That
> means the actual text of 0.3.0-rc1 and 0.3.0 conflict with each other.
> Given that frozen comes with a guarntee of backwards compatibility, does
> that mean that the behavior allowed by 0.3.0-rc1 is compliant with the
> SBI, even if it was likely just allowed by a wording mistake?
>
> If you're going to freeze things at rc1 then you really need to be quite
> explicit about that, as generally the point of RCs is to elicit
> review/testing.  Looks like I was the only person to have provided any
> review, so I guess I was the only one who assumed "We don't expect any
> significant functional changes. We will wait for any further feedback
> and release the official v0.3 in a month or so." actually meant "this is
> frozen".
>
>> Can you take this patch for Linux-5.14 ??
>
> No, sorry, it's way too late for that.  Please be specific about when
> you freeze specifications in the future, so we can all stay on the same
> page.

I went and talked to Krste, and he says that there's a whole process for 
freezing extensions that this hasn't gone through.  They don't have 
anything written down that I can point to, but can you guys please just 
get on the same page about this?  It seems like every time I talk to 
someone from the RISC-V foundation I get a conflicting description of 
what's going on, and I'm entirely out of patience when it comes to 
getting blamed for all the chaos over there.

>
>>
>> Regards,
>> Anup
>>
>>     Regards,
>>     Anup
>>
>>     >
>>     > >
>>     > > Regards,
>>     > > Anup
>>     > >
>>     > >>
>>     > >> This patch extends Linux RISC-V SBI implementation to detect
>>     > >> and use SBI SRST extension.
>>     > >>
>>     > >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>>     > >> Reviewed-by: Atish Patra <atish.patra@wdc.com>
>>     > >> ---
>>     > >>  arch/riscv/include/asm/sbi.h | 24 ++++++++++++++++++++++++
>>     > >>  arch/riscv/kernel/sbi.c      | 35 +++++++++++++++++++++++++++++++++++
>>     > >>  2 files changed, 59 insertions(+)
>>     > >>
>>     > >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>>     > >> index 0d42693cb65e..289621da4a2a 100644
>>     > >> --- a/arch/riscv/include/asm/sbi.h
>>     > >> +++ b/arch/riscv/include/asm/sbi.h
>>     > >> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>>     > >>         SBI_EXT_IPI = 0x735049,
>>     > >>         SBI_EXT_RFENCE = 0x52464E43,
>>     > >>         SBI_EXT_HSM = 0x48534D,
>>     > >> +       SBI_EXT_SRST = 0x53525354,
>>     > >>  };
>>     > >>
>>     > >>  enum sbi_ext_base_fid {
>>     > >> @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
>>     > >>         SBI_HSM_HART_STATUS_STOP_PENDING,
>>     > >>  };
>>     > >>
>>     > >> +enum sbi_ext_srst_fid {
>>     > >> +       SBI_EXT_SRST_RESET = 0,
>>     > >> +};
>>     > >> +
>>     > >> +enum sbi_srst_reset_type {
>>     > >> +       SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
>>     > >> +       SBI_SRST_RESET_TYPE_COLD_REBOOT,
>>     > >> +       SBI_SRST_RESET_TYPE_WARM_REBOOT,
>>     > >> +};
>>     > >> +
>>     > >> +enum sbi_srst_reset_reason {
>>     > >> +       SBI_SRST_RESET_REASON_NONE = 0,
>>     > >> +       SBI_SRST_RESET_REASON_SYS_FAILURE,
>>     > >> +};
>>     > >> +
>>     > >>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>>     > >>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>>     > >>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
>>     > >> @@ -148,6 +164,14 @@ static inline unsigned long sbi_minor_version(void)
>>     > >>         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
>>     > >>  }
>>     > >>
>>     > >> +/* Make SBI version */
>>     > >> +static inline unsigned long sbi_mk_version(unsigned long major,
>>     > >> +                                           unsigned long minor)
>>     > >> +{
>>     > >> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
>>     > >> +               SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
>>     > >> +}
>>     > >> +
>>     > >>  int sbi_err_map_linux_errno(int err);
>>     > >>  #else /* CONFIG_RISCV_SBI */
>>     > >>  static inline int sbi_remote_fence_i(const unsigned long *hart_mask) { return -1; }
>>     > >> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>>     > >> index 7402a417f38e..9a84f0cb5175 100644
>>     > >> --- a/arch/riscv/kernel/sbi.c
>>     > >> +++ b/arch/riscv/kernel/sbi.c
>>     > >> @@ -7,6 +7,7 @@
>>     > >>
>>     > >>  #include <linux/init.h>
>>     > >>  #include <linux/pm.h>
>>     > >> +#include <linux/reboot.h>
>>     > >>  #include <asm/sbi.h>
>>     > >>  #include <asm/smp.h>
>>     > >>
>>     > >> @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
>>     > >>  }
>>     > >>  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
>>     > >>
>>     > >> +static void sbi_srst_reset(unsigned long type, unsigned long reason)
>>     > >> +{
>>     > >> +       sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
>>     > >> +                 0, 0, 0, 0);
>>     > >> +       pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
>>     > >> +               __func__, type, reason);
>>     > >> +}
>>     > >> +
>>     > >> +static int sbi_srst_reboot(struct notifier_block *this,
>>     > >> +                          unsigned long mode, void *cmd)
>>     > >> +{
>>     > >> +       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
>>     > >> +                      SBI_SRST_RESET_TYPE_WARM_REBOOT :
>>     > >> +                      SBI_SRST_RESET_TYPE_COLD_REBOOT,
>>     > >> +                      SBI_SRST_RESET_REASON_NONE);
>>     > >> +       return NOTIFY_DONE;
>>     > >> +}
>>     > >> +
>>     > >> +static struct notifier_block sbi_srst_reboot_nb;
>>     > >> +
>>     > >> +static void sbi_srst_power_off(void)
>>     > >> +{
>>     > >> +       sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
>>     > >> +                      SBI_SRST_RESET_REASON_NONE);
>>     > >> +}
>>     > >> +
>>     > >>  /**
>>     > >>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>>     > >>   * @extid: The extension ID to be probed.
>>     > >> @@ -608,6 +635,14 @@ void __init sbi_init(void)
>>     > >>                 } else {
>>     > >>                         __sbi_rfence    = __sbi_rfence_v01;
>>     > >>                 }
>>     > >> +               if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
>>     > >> +                   (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
>>     > >> +                       pr_info("SBI SRST extension detected\n");
>>     > >> +                       pm_power_off = sbi_srst_power_off;
>>     > >> +                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
>>     > >> +                       sbi_srst_reboot_nb.priority = 192;
>>     > >> +                       register_restart_handler(&sbi_srst_reboot_nb);
>>     > >> +               }
>>     > >>         } else {
>>     > >>                 __sbi_set_timer = __sbi_set_timer_v01;
>>     > >>                 __sbi_send_ipi  = __sbi_send_ipi_v01;
>>     > >> --
>>     > >> 2.25.1
>>     > >>
>>
