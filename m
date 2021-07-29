Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178A53D9CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhG2EpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhG2EpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:45:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EDC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:44:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso5900951wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u83h2L86nsZYv8NbsUw74aEmeDWcUY3MuHoKCqJtf3Q=;
        b=osuOOAGzKZCQN2G6lLQxjelORkW+B702aR8NElkuPml+50JPAG1/hjCVIQuvpSDC6x
         xkhOX4ycDxb5l+LTI3Y7jd18fGTbG+Vy5qHmMc/UAS05vmYWu6agpe8oxhsTM0WmzDwR
         oKrWjZK/4zhTudepws6vmrRtbvk3kG8jaDP1DvrJ09MPljsU8NrfS2w5nDYYA0XuTHfA
         D/8VtQGvWSqx7bLPEcws5G4+6a/UOIJ/5beHmU4FwL6sx8NmTU6VnrPLWmFP0KB7tvgj
         mln5JvqQsNOGMEIkxZBbEwGB98HLaUnokYNopUabJOTvMOD3nlyX7vlwXWDUKnHpXGj3
         56Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u83h2L86nsZYv8NbsUw74aEmeDWcUY3MuHoKCqJtf3Q=;
        b=OzLw4Hop30SEKVQhzvGeLS/0O70DEaCCfJLgS7fG+0FQonPjdh9wydnrcvRT6JAQfj
         67ZQuCroudsT7afywjvME1CBH4fE2dZnNiqZksBHDEAABLgPwV0VT0jASc6tsImihtBP
         kX2jNpwvlbh842hHeDTnzmLe0I51QywQwQK8yrfJSVQ7cHoZmm3+8bXm8hNO7y5tdcqg
         +AkwcAu8+3KXIXLuX3csQeRS3sLUNhe9zRWQIK2pNjzf0UvRIoRcav+wbowna7Bqm2f3
         PUYyPjpueUcVWu40NwXMqrW9wB8OhRvct+DmUyUuWqwo+29Pb4/EOjhO6B9D0UOLAnnX
         /VAw==
X-Gm-Message-State: AOAM532UeD9TPUg6+giVtdhnfFz38XisIoEylOeqIo6Ml0IIhIgSQhZ0
        evZBQiYTySsiMoXUZB2KiY7Bmm+7kvklqKXlNKYWeQ==
X-Google-Smtp-Source: ABdhPJx3AQqf4zvFFpHRKjBF4rtaCGTSInvaYCd5ZKGhNsldGk+5Zhf+1VA69+8ubyBIdHyyBLnabPeEhNqmszyblZM=
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr2719010wmr.134.1627533896307;
 Wed, 28 Jul 2021 21:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-6c25dda6-4c85-447c-ad9c-7641f2858b10@palmerdabbelt-glaptop> <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
In-Reply-To: <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 29 Jul 2021 10:14:44 +0530
Message-ID: <CAAhSdy2rvi1v4Txbd18JE6pad+iW8resE8_6+7ZnNiQKUMhgkQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 10:00 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sun, 11 Jul 2021 11:59:33 PDT (-0700), Palmer Dabbelt wrote:
> > On Fri, 09 Jul 2021 22:01:02 PDT (-0700), Anup Patel wrote:
> >>
> >>
> >> =EF=BB=BFOn 08/07/21, 9:22 AM, "Anup Patel" <anup@brainfault.org> wrot=
e:
> >>
> >>     On Wed, Jul 7, 2021 at 1:57 AM Palmer Dabbelt <palmerdabbelt@googl=
e.com> wrote:
> >>     >
> >>     > On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.org wr=
ote:
> >>     > > Hi Palmer,
> >>     > >
> >>     > > On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.com>=
 wrote:
> >>     > >>
> >>     > >> The SBI SRST extension provides a standard way to poweroff an=
d
> >>     > >> reboot the system irrespective to whether Linux RISC-V S-mode
> >>     > >> is running natively (HS-mode) or inside Guest/VM (VS-mode).
> >>     > >>
> >>     > >> The SBI SRST extension is available in the SBI v0.3 specifica=
tion.
> >>     > >> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v=
0.3.0-rc1)
> >>     > >
> >>     > > Can you please consider this patch for Linux-5.14-rc1 ?
> >>     > >
> >>     > > The SBI v0.3 spec is already frozen and this patch has been
> >>     > > floating on LKML for quite a few months now.
> >>     >
> >>     > I didn't realize that SBI-0.3 had been frozed.  That link is to =
a RC,
> >>     > the cooresponding v0.3.0 tag isn't in that repo.  Can you give m=
e a
> >>     > pointer to the frozen spec?
> >>
> >>     Here's the link to SBI v0.3.0 tag:
> >>     https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0
> >>
> >>     We treat RC tags as frozen in SBI spec because no functional
> >>     changes are done in SBI spec after it is tagged as RC. We only
> >>     do typo fixes and clarifications on SBI spec RC release.
> >
> > Treating the 0.3.0-rc1 as frozen as soon as it's released is a
> > terrifying policy: some of the fixes I sent in after I saw rc1 released
> > change the actual meaning of the text, even if they were meant to chang=
e
> > them to what I thought the intended meaning was supposed to be.  That
> > means the actual text of 0.3.0-rc1 and 0.3.0 conflict with each other.
> > Given that frozen comes with a guarntee of backwards compatibility, doe=
s
> > that mean that the behavior allowed by 0.3.0-rc1 is compliant with the
> > SBI, even if it was likely just allowed by a wording mistake?
> >
> > If you're going to freeze things at rc1 then you really need to be quit=
e
> > explicit about that, as generally the point of RCs is to elicit
> > review/testing.  Looks like I was the only person to have provided any
> > review, so I guess I was the only one who assumed "We don't expect any
> > significant functional changes. We will wait for any further feedback
> > and release the official v0.3 in a month or so." actually meant "this i=
s
> > frozen".
> >
> >> Can you take this patch for Linux-5.14 ??
> >
> > No, sorry, it's way too late for that.  Please be specific about when
> > you freeze specifications in the future, so we can all stay on the same
> > page.
>
> I went and talked to Krste, and he says that there's a whole process for
> freezing extensions that this hasn't gone through.  They don't have
> anything written down that I can point to, but can you guys please just
> get on the same page about this?  It seems like every time I talk to
> someone from the RISC-V foundation I get a conflicting description of
> what's going on, and I'm entirely out of patience when it comes to
> getting blamed for all the chaos over there.

The RISC-V SBI is a pure software specification and not a ISA specification=
.
In fact, this is not even non-ISA specification dealing with a MMIO
(or hardware) device. There is no process defined for RISC-V software
specifications.

The last SBI v0.2 release was done by you (Palmer). At that time, you
simply tagged the SBI v0.2 release and announced it everywhere.

Regards,
Anup

>
> >
> >>
> >> Regards,
> >> Anup
> >>
> >>     Regards,
> >>     Anup
> >>
> >>     >
> >>     > >
> >>     > > Regards,
> >>     > > Anup
> >>     > >
> >>     > >>
> >>     > >> This patch extends Linux RISC-V SBI implementation to detect
> >>     > >> and use SBI SRST extension.
> >>     > >>
> >>     > >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >>     > >> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> >>     > >> ---
> >>     > >>  arch/riscv/include/asm/sbi.h | 24 ++++++++++++++++++++++++
> >>     > >>  arch/riscv/kernel/sbi.c      | 35 ++++++++++++++++++++++++++=
+++++++++
> >>     > >>  2 files changed, 59 insertions(+)
> >>     > >>
> >>     > >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/includ=
e/asm/sbi.h
> >>     > >> index 0d42693cb65e..289621da4a2a 100644
> >>     > >> --- a/arch/riscv/include/asm/sbi.h
> >>     > >> +++ b/arch/riscv/include/asm/sbi.h
> >>     > >> @@ -27,6 +27,7 @@ enum sbi_ext_id {
> >>     > >>         SBI_EXT_IPI =3D 0x735049,
> >>     > >>         SBI_EXT_RFENCE =3D 0x52464E43,
> >>     > >>         SBI_EXT_HSM =3D 0x48534D,
> >>     > >> +       SBI_EXT_SRST =3D 0x53525354,
> >>     > >>  };
> >>     > >>
> >>     > >>  enum sbi_ext_base_fid {
> >>     > >> @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
> >>     > >>         SBI_HSM_HART_STATUS_STOP_PENDING,
> >>     > >>  };
> >>     > >>
> >>     > >> +enum sbi_ext_srst_fid {
> >>     > >> +       SBI_EXT_SRST_RESET =3D 0,
> >>     > >> +};
> >>     > >> +
> >>     > >> +enum sbi_srst_reset_type {
> >>     > >> +       SBI_SRST_RESET_TYPE_SHUTDOWN =3D 0,
> >>     > >> +       SBI_SRST_RESET_TYPE_COLD_REBOOT,
> >>     > >> +       SBI_SRST_RESET_TYPE_WARM_REBOOT,
> >>     > >> +};
> >>     > >> +
> >>     > >> +enum sbi_srst_reset_reason {
> >>     > >> +       SBI_SRST_RESET_REASON_NONE =3D 0,
> >>     > >> +       SBI_SRST_RESET_REASON_SYS_FAILURE,
> >>     > >> +};
> >>     > >> +
> >>     > >>  #define SBI_SPEC_VERSION_DEFAULT       0x1
> >>     > >>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
> >>     > >>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> >>     > >> @@ -148,6 +164,14 @@ static inline unsigned long sbi_minor_ve=
rsion(void)
> >>     > >>         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK=
;
> >>     > >>  }
> >>     > >>
> >>     > >> +/* Make SBI version */
> >>     > >> +static inline unsigned long sbi_mk_version(unsigned long maj=
or,
> >>     > >> +                                           unsigned long min=
or)
> >>     > >> +{
> >>     > >> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> >>     > >> +               SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> >>     > >> +}
> >>     > >> +
> >>     > >>  int sbi_err_map_linux_errno(int err);
> >>     > >>  #else /* CONFIG_RISCV_SBI */
> >>     > >>  static inline int sbi_remote_fence_i(const unsigned long *ha=
rt_mask) { return -1; }
> >>     > >> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.=
c
> >>     > >> index 7402a417f38e..9a84f0cb5175 100644
> >>     > >> --- a/arch/riscv/kernel/sbi.c
> >>     > >> +++ b/arch/riscv/kernel/sbi.c
> >>     > >> @@ -7,6 +7,7 @@
> >>     > >>
> >>     > >>  #include <linux/init.h>
> >>     > >>  #include <linux/pm.h>
> >>     > >> +#include <linux/reboot.h>
> >>     > >>  #include <asm/sbi.h>
> >>     > >>  #include <asm/smp.h>
> >>     > >>
> >>     > >> @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const un=
signed long *hart_mask,
> >>     > >>  }
> >>     > >>  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
> >>     > >>
> >>     > >> +static void sbi_srst_reset(unsigned long type, unsigned long=
 reason)
> >>     > >> +{
> >>     > >> +       sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, rea=
son,
> >>     > >> +                 0, 0, 0, 0);
> >>     > >> +       pr_warn("%s: type=3D0x%lx reason=3D0x%lx failed\n",
> >>     > >> +               __func__, type, reason);
> >>     > >> +}
> >>     > >> +
> >>     > >> +static int sbi_srst_reboot(struct notifier_block *this,
> >>     > >> +                          unsigned long mode, void *cmd)
> >>     > >> +{
> >>     > >> +       sbi_srst_reset((mode =3D=3D REBOOT_WARM || mode =3D=
=3D REBOOT_SOFT) ?
> >>     > >> +                      SBI_SRST_RESET_TYPE_WARM_REBOOT :
> >>     > >> +                      SBI_SRST_RESET_TYPE_COLD_REBOOT,
> >>     > >> +                      SBI_SRST_RESET_REASON_NONE);
> >>     > >> +       return NOTIFY_DONE;
> >>     > >> +}
> >>     > >> +
> >>     > >> +static struct notifier_block sbi_srst_reboot_nb;
> >>     > >> +
> >>     > >> +static void sbi_srst_power_off(void)
> >>     > >> +{
> >>     > >> +       sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
> >>     > >> +                      SBI_SRST_RESET_REASON_NONE);
> >>     > >> +}
> >>     > >> +
> >>     > >>  /**
> >>     > >>   * sbi_probe_extension() - Check if an SBI extension ID is s=
upported or not.
> >>     > >>   * @extid: The extension ID to be probed.
> >>     > >> @@ -608,6 +635,14 @@ void __init sbi_init(void)
> >>     > >>                 } else {
> >>     > >>                         __sbi_rfence    =3D __sbi_rfence_v01;
> >>     > >>                 }
> >>     > >> +               if ((sbi_spec_version >=3D sbi_mk_version(0, =
3)) &&
> >>     > >> +                   (sbi_probe_extension(SBI_EXT_SRST) > 0)) =
{
> >>     > >> +                       pr_info("SBI SRST extension detected\=
n");
> >>     > >> +                       pm_power_off =3D sbi_srst_power_off;
> >>     > >> +                       sbi_srst_reboot_nb.notifier_call =3D =
sbi_srst_reboot;
> >>     > >> +                       sbi_srst_reboot_nb.priority =3D 192;
> >>     > >> +                       register_restart_handler(&sbi_srst_re=
boot_nb);
> >>     > >> +               }
> >>     > >>         } else {
> >>     > >>                 __sbi_set_timer =3D __sbi_set_timer_v01;
> >>     > >>                 __sbi_send_ipi  =3D __sbi_send_ipi_v01;
> >>     > >> --
> >>     > >> 2.25.1
> >>     > >>
> >>
