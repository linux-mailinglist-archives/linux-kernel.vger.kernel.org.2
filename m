Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12A4331076
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCHOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCHOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:11:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC03C06174A;
        Mon,  8 Mar 2021 06:11:24 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b18so11611832wrn.6;
        Mon, 08 Mar 2021 06:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTef0XwSiS+ITTfBhqEPLgvaNiPtWRdiBsFJY7ShmIM=;
        b=X9C1III8bCfwUtnCfA4R9rMaomdTnXofkZ4Admh0Yq1L5nF8s9iTWx0F+OrtHHSzoS
         zVx8ZxBdf5XnO29/I/nSV0tq3cgJKRWDfqDaX1mw/iRgMtq7lWtPZgcGPr/eQb+wCrB7
         kYAshrf1gA8/UBHjGz9QeVpTCmkAIBOGwCmBVxwgSDwDfb464MbJCpOmeg+87Kawbze+
         cGRh3ppQ8S0ans6cruWUf9XSz9na5ohZHE4Pf3SrryJL5UlVrP8UAeFlJjdROSgq6gC6
         Udns0UpFo3D9lkkfXJcEqlWPNKnkPnBSO4Jeb0xRBEk11n32ESL81tgDeBPLeULMba0+
         ATLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTef0XwSiS+ITTfBhqEPLgvaNiPtWRdiBsFJY7ShmIM=;
        b=mdGpczMKXrdvsqBeKmbyE/gqoVAt2CtGO/SVRzUQA/6ZvzK9IZxFC5LFAMCFz+rcUe
         JgDuraCcuJcD6/D/3Wdw86E8S4xrJkCqjIo0xyjJYLE8d4UCCglYRsgaNJh92EGY0Uh1
         O2up/ylS0DcmEOKHHR9EF2MIyAaFS7ZbTh6mprcqsT00+0BX8WVLzlNKeBA22bQpF5pe
         ffrFumw67Cig7sY5Cf4s8bqi414Ax5L/mrb6stNk/nFn180LFXJ/6Qf7VF1Trf+3hfr0
         /APwAdTHJcCcL4xQxSlvrZOcZ5WSPi36zrLEGR1i25dqu4mUPZBynZS7FiAYx56PEJtG
         00uw==
X-Gm-Message-State: AOAM530pOBhevMT4VHARoLT4NJqcgkMaHsnzBjYU/3xSM4G8P+zSuh5V
        76Ju9FSnbS9T207S5sLFdip5N/yrn0Xd3n8SjomnQRSgb5U=
X-Google-Smtp-Source: ABdhPJxDr3aburrMXnPsUcxTef1b3AicT8sv/0USXfAysKSAww9xf0XGxHN+EdTDIU5qKWXCTm9a1TsYfVjmPJS6iKE=
X-Received: by 2002:adf:f509:: with SMTP id q9mr23175738wro.342.1615212682732;
 Mon, 08 Mar 2021 06:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20210305190608.1834164-1-david.e.box@linux.intel.com> <CAE2upjSkN6R_MNxNOwT+sTREGXRq0RVehnG3gCD5Wx9_-D41vg@mail.gmail.com>
In-Reply-To: <CAE2upjSkN6R_MNxNOwT+sTREGXRq0RVehnG3gCD5Wx9_-D41vg@mail.gmail.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Mon, 8 Mar 2021 09:10:55 -0500
Message-ID: <CAE2upjQgQFLiU-mPR3aYdvXHh4Cd0byH0-MWhppYE4K+UwbpcQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc: Ignore GBE LTR on Tiger Lake platforms
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        sasha.neftin@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 9:04 AM Rajneesh Bhardwaj
<irenic.rajneesh@gmail.com> wrote:
>
> Hi David
>
> Overall, it looks like the right thing to do but i have a few
> comments. See below.
>
> On Fri, Mar 5, 2021 at 2:07 PM David E. Box <david.e.box@linux.intel.com> wrote:
> >
> > Due to a HW limitation, the Latency Tolerance Reporting (LTR) value
> > programmed in the Tiger Lake GBE controller is not large enough to allow
> > the platform to enter Package C10, which in turn prevents the platform from
> > achieving its low power target during suspend-to-idle.  Ignore the GBE LTR
> > value on Tiger Lake. LTR ignore functionality is currently performed solely
> > by a debugfs write call. Split out the LTR code into its own function that
> > can be called by both the debugfs writer and by this work around.
> >
>
> I presume this must be the last resort to use such quirk and you've
> already considered a user space tuning program or fw patch is not an
> option on this generation of SOCs.
>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Sasha Neftin <sasha.neftin@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org
> > ---
> >  drivers/platform/x86/intel_pmc_core.c | 55 ++++++++++++++++++++-------
> >  1 file changed, 42 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> > index ee2f757515b0..ab31eb646a1a 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -863,34 +863,45 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
> >
> > -static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> > -                                        const char __user *userbuf,
> > -                                        size_t count, loff_t *ppos)
> > +static int pmc_core_write_ltr_ignore(u32 value)
>
> This sounds a bit confusing with pmc_core_ltr_ignore_write.
>
> >  {
> >         struct pmc_dev *pmcdev = &pmc;
> >         const struct pmc_reg_map *map = pmcdev->map;
> > -       u32 val, buf_size, fd;
> > -       int err;
> > -
> > -       buf_size = count < 64 ? count : 64;
> > -
> > -       err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> > -       if (err)
> > -               return err;
> > +       u32 fd;
>
> lets just call it value

I meant a different name than fd is better. I see both value / val are
already used here.

>
> > +       int err = 0;
> >
> >         mutex_lock(&pmcdev->lock);
> >
> > -       if (val > map->ltr_ignore_max) {
> > +       if (fls(value) > map->ltr_ignore_max) {
>
> I am not sure why you're considering a bit position here. We rather
> use absolute value for this and we already preserve (OR) previously
> programmed LTR while changing to the new desired value.  Current
> modification would allow users to supply even bigger values than the
> MAX IP ignore allowed. This can be useful when you want to ignore more
> than 1 IP at a time but that's not how we usually use it for debug.
> This is more for a user space debug script to deal with.
> https://01.org/blogs/rajneesh/2019/using-power-management-controller-drivers-debug-low-power-platform-states
>
> >                 err = -EINVAL;
> >                 goto out_unlock;
> >         }
> >
> >         fd = pmc_core_reg_read(pmcdev, map->ltr_ignore_offset);
> > -       fd |= (1U << val);
> > +       fd |= value;
> >         pmc_core_reg_write(pmcdev, map->ltr_ignore_offset, fd);
> >
> >  out_unlock:
> >         mutex_unlock(&pmcdev->lock);
> > +
> > +       return err;
> > +}
> > +
> > +static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> > +                                        const char __user *userbuf,
> > +                                        size_t count, loff_t *ppos)
> > +{
> > +       u32 buf_size, val;
> > +       int err;
> > +
> > +       buf_size = count < 64 ? count : 64;
> > +
> > +       err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> > +       if (err)
> > +               return err;
> > +
> > +       err = pmc_core_write_ltr_ignore(1U << val);
> > +
> >         return err == 0 ? count : err;
> >  }
> >
> > @@ -1189,6 +1200,15 @@ static int quirk_xtal_ignore(const struct dmi_system_id *id)
> >         return 0;
> >  }
> >
> > +static int quirk_ltr_ignore(u32 val)
> > +{
> > +       int err;
> > +
> > +       err = pmc_core_write_ltr_ignore(val);
> > +
> > +       return err;
> > +}
> > +
> >  static const struct dmi_system_id pmc_core_dmi_table[]  = {
> >         {
> >         .callback = quirk_xtal_ignore,
> > @@ -1244,6 +1264,15 @@ static int pmc_core_probe(struct platform_device *pdev)
> >         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> >         dmi_check_system(pmc_core_dmi_table);
> >
> > +       /*
> > +        * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
> > +        * a cable is attached. Tell the PMC to ignore it.
> > +        */
> > +       if (pmcdev->map == &tgl_reg_map) {
> > +               dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
> > +               quirk_ltr_ignore(1U << 3);
>
> Can this be made a part of *_reg_map itself if intended to be used for
> more future platforms? Otherwise we just leave it as a one time quirk.
>
> > +       }
> > +
> >         pmc_core_dbgfs_register(pmcdev);
> >
> >         device_initialized = true;
> > --
> > 2.25.1
> >
>
>
> --
> Thanks,
> Rajneesh



-- 
Thanks,
Rajneesh
