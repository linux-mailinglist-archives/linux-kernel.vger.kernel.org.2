Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA03D9D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhG2FSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhG2FSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:18:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00A0C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:18:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d8so5219102wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RHPWLTkSoa2xx4mUUm8mhXYYaRlEUTlsTCE72u9uRg=;
        b=H3BObp00YQ67TZV9hl/gMKZwK1u5FkKJUNO+0XwSfYH3Pp5t8HHxjQKAMnulpZdcnZ
         lRqr0mdLo9S6UaRFxWzDX2VBKhMltYV9Dkx+CXG75bHC2sIP2UEu7OklaElfsRYG2RZJ
         B6kq8s4JWIqYBq4cdg4DtoqBS8c7IzN0tq4VLWBdciqZHqooZQX7EKCaawQheKXYdCbR
         npP77CSrH4gK8hpRrCmkt1orN1KESEsuzardSo3uy3vTLulhQ9wcNSS40/8bGlXlkTtF
         6leD7kqEJX8yNAQSki0KBgCsWn+HE39utmZHo5fBiNJ9YOcZkfBLMdOnkRQUKfnNgmUi
         /VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RHPWLTkSoa2xx4mUUm8mhXYYaRlEUTlsTCE72u9uRg=;
        b=sth805miPI0Smv/DXOgJJhpTxLCe2QR55WejPF3kke8/6xqnlAao2sGt17lIDfRzUg
         8Q8hURdpZRFWKq8q2AtKH9Us9h8zSpeLP2elhHP/HV76sO/hw6yCt/unWpVqgORU2AIk
         Yoqj7st46W58z++3jbFiRYdjOHQbNBdVf1DrYjuOoZP08c1uJYlPNwp44ZLpQOPfOGIi
         K0X4LYXJh4F+Hur9uYJyJ2jnFJ0xNxZLqcxnIcH/tBeHQEfZg/4gyybdSghfakIo40qM
         i3MelXeghNyOBnTdW43Az2c0X1VkHieb4e0XEGnRWiSp28DnFzKUw/a59NVHOsUPWzmq
         U7rg==
X-Gm-Message-State: AOAM530ddIaRptJSRIhlqfG4Av97+J3QDO0JLm13sA5Y075dSLp3pAVK
        DgdXpVzDKavn6a0XstcvP9Lwg5oHxWsj1jZIGY9FwA==
X-Google-Smtp-Source: ABdhPJxHONHN2G/J2qhbV4R5tzOfcMuTS3OtRbLdvtfeXBiuxM97HckyMD+XS9yH19RyNgabP+4S0ktd3BM5LATpMZs=
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr2737744wro.390.1627535918435;
 Wed, 28 Jul 2021 22:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-6c25dda6-4c85-447c-ad9c-7641f2858b10@palmerdabbelt-glaptop> <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
In-Reply-To: <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 29 Jul 2021 10:48:26 +0530
Message-ID: <CAAhSdy09OyyRM07B1nF_RXb6kNNjkARs7zqhxSYq2_DVPWVPEQ@mail.gmail.com>
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

For your information, the SBI spec is owned by the platform HSC so
feel free to talk to the chairs Kumar Sankarn and Atish Patra.

The SBI v0.3 release has been approved by the platform HSC.

There are many working groups in RISC-V International and a lot of
activities happening so for any specification you should talk to the
people who are owning the specification first.

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
