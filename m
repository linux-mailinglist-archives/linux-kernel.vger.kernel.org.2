Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADECD42A75E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhJLOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhJLOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:39:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF4C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:37:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r19so85887236lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyfxFfQ29ROHZol1VMdaKnHP6P4gMsfULjj1+m/4MaM=;
        b=YrtlqeuCN6IWRNuB2ujdIUHQIolsoXhaJ0O7htStVpuDM8BONJCfF0xI3nMg5ivB+3
         jXWyKA0qNV3zsdwYK5NYePCrNuAqMQyZ5SodrbWf3fpZkAPg//LVYh5A/T7Fa3PhvJUg
         q60fQmoFMsZyT7EsjPXAaMMSFuJ8l6k9xQjnPaP1xWVHsiciYwuQ/T2TzJNb+/bAmBVG
         L6o92Jy1rGYVlw2OsB4DGhivcddYnXK4kmMwRTRgIRj7kSVwAOGSB/ol22VuAvb7mVOE
         77Mp2PndE7X0gu6P9hiSR4sqrPRhG6Q3Dl7n0YgMMfPTpQEe/tSyHnPK2vO98TDfM94M
         LaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyfxFfQ29ROHZol1VMdaKnHP6P4gMsfULjj1+m/4MaM=;
        b=NUy2tMDUegwb20aJgl3RSBy+HX9Nu0kWdFQp+diyYQhjP45Vv2tOkTzCwq62b0ASXF
         0UYkHdAnFTcEl0SiOQaDja1Qhc6drPoiRCNE07bfAwnu1QEd7YMsvA+h+vJY1HqoixYU
         bi7FpknElBFmgmB1LJK/c/839V4RS5d1QYnWDUQ9qvC9rUAW85q/BArWc/25XdI769fl
         15IKZz0slQ4Pc8yU4GrSKyAaKjIIV0x9vHUYuIF4uWaBDQfxGV+g3Hjyg7fFkRtJes2b
         BIBqz0kSOMTW4Brh36a9WSAf2S/apTwpTtd2T7jJoaJT8hsHTOwL3YeGW++6MxYOpaux
         v6VQ==
X-Gm-Message-State: AOAM530mE1Q2THus4+KqjRAkhR85uEL+VCDvPAw0odIgEoeMw2cK36CW
        1hLXslJFKG+0CH+302HFC5vnwzCAO++SSu6NG/asjg==
X-Google-Smtp-Source: ABdhPJxHQxMsqqpIKcw7mjbBnam07xkvLQIYnRjIbmwjzmUUOVLcQ0G+Lt+Q1Xx2fNsLx19MxixmT81Kq/VnE3fHeTo=
X-Received: by 2002:a05:6512:3614:: with SMTP id f20mr9774374lfs.685.1634049431614;
 Tue, 12 Oct 2021 07:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211005195213.2905030-1-pgonda@google.com> <CAA03e5FpP2XbWB5T=aM7jE9FTHHwJ04Kqc0PAz07F2f2ux6RuA@mail.gmail.com>
In-Reply-To: <CAA03e5FpP2XbWB5T=aM7jE9FTHHwJ04Kqc0PAz07F2f2ux6RuA@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 12 Oct 2021 08:37:00 -0600
Message-ID: <CAMkAt6rm4tKrNJ7BT2zor47u=a7TmMXoaomFb6BmqDtjqBrYWQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp - Consolidate sev INIT logic
To:     Marc Orr <marcorr@google.com>
Cc:     "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 4:30 PM Marc Orr <marcorr@google.com> wrote:
>
> On Tue, Oct 5, 2021 at 12:52 PM Peter Gonda <pgonda@google.com> wrote:
> >
> > Adds new helper function sev_init_if_required() for use in sev_ioctl().
> > The function calls __sev_platform_init_locked() if the command requires
> > the PSP's internal state be at least SEV_STATE_INIT. This consolidates
> > many checks scattered through out the ioctl delegation functions.
> >
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: John Allen <john.allen@amd.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: linux-crypto@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/crypto/ccp/sev-dev.c | 63 +++++++++++++++---------------------
> >  1 file changed, 26 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index e09925d86bf3..071d57fec4c4 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -386,24 +386,14 @@ static int sev_ioctl_do_platform_status(struct sev_issue_cmd *argp)
> >
> >  static int sev_ioctl_do_pek_pdh_gen(int cmd, struct sev_issue_cmd *argp, bool writable)
> >  {
> > -       struct sev_device *sev = psp_master->sev_data;
> > -       int rc;
> > -
> >         if (!writable)
> >                 return -EPERM;
>
> This check can be removed because it's is handled by
> `sev_init_if_required()`. Same is true for all the other commands.

This check is still needed on commands that "write" to the PSP I
think. Since the command SEV_CMD_PEK_GEN makes the PSP write a new PEK
to its storage I think this command still needs the file to be open
writeable. Same with the other commands.
>
> >
> > -       if (sev->state == SEV_STATE_UNINIT) {
> > -               rc = __sev_platform_init_locked(&argp->error);
> > -               if (rc)
> > -                       return rc;
> > -       }
> > -
> >         return __sev_do_cmd_locked(cmd, NULL, &argp->error);
> >  }
> >
> >  static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
> >  {
> > -       struct sev_device *sev = psp_master->sev_data;
> >         struct sev_user_data_pek_csr input;
> >         struct sev_data_pek_csr data;
> >         void __user *input_address;
> > @@ -435,12 +425,6 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
> >         data.len = input.length;
> >
> >  cmd:
> > -       if (sev->state == SEV_STATE_UNINIT) {
> > -               ret = __sev_platform_init_locked(&argp->error);
> > -               if (ret)
> > -                       goto e_free_blob;
> > -       }
> > -
> >         ret = __sev_do_cmd_locked(SEV_CMD_PEK_CSR, &data, &argp->error);
> >
> >          /* If we query the CSR length, FW responded with expected data. */
> > @@ -586,7 +570,6 @@ static int sev_update_firmware(struct device *dev)
> >
> >  static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
> >  {
> > -       struct sev_device *sev = psp_master->sev_data;
> >         struct sev_user_data_pek_cert_import input;
> >         struct sev_data_pek_cert_import data;
> >         void *pek_blob, *oca_blob;
> > @@ -617,17 +600,10 @@ static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
> >         data.oca_cert_address = __psp_pa(oca_blob);
> >         data.oca_cert_len = input.oca_cert_len;
> >
> > -       /* If platform is not in INIT state then transition it to INIT */
> > -       if (sev->state != SEV_STATE_INIT) {
> > -               ret = __sev_platform_init_locked(&argp->error);
> > -               if (ret)
> > -                       goto e_free_oca;
> > -       }
> > -
> >         ret = __sev_do_cmd_locked(SEV_CMD_PEK_CERT_IMPORT, &data, &argp->error);
> >
> > -e_free_oca:
> >         kfree(oca_blob);
> > +
> >  e_free_pek:
> >         kfree(pek_blob);
> >         return ret;
> > @@ -730,7 +706,6 @@ static int sev_ioctl_do_get_id(struct sev_issue_cmd *argp)
> >
> >  static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
> >  {
> > -       struct sev_device *sev = psp_master->sev_data;
> >         struct sev_user_data_pdh_cert_export input;
> >         void *pdh_blob = NULL, *cert_blob = NULL;
> >         struct sev_data_pdh_cert_export data;
> > @@ -738,16 +713,6 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
> >         void __user *input_pdh_cert_address;
> >         int ret;
> >
> > -       /* If platform is not in INIT state then transition it to INIT. */
> > -       if (sev->state != SEV_STATE_INIT) {
> > -               if (!writable)
> > -                       return -EPERM;
> > -
> > -               ret = __sev_platform_init_locked(&argp->error);
> > -               if (ret)
> > -                       return ret;
> > -       }
> > -
> >         if (copy_from_user(&input, (void __user *)argp->data, sizeof(input)))
> >                 return -EFAULT;
> >
> > @@ -819,6 +784,26 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
> >         return ret;
> >  }
> >
> > +static int sev_init_if_required(int cmd_id, bool writable,
> > +                               struct sev_issue_cmd *argp)
> > +{
> > +       struct sev_device *sev = psp_master->sev_data;
> > +
> > +       lockdep_assert_held(&sev_cmd_mutex);
> > +
> > +       if (!writable)
> > +               return -EPERM;
> > +
> > +       if (cmd_id == SEV_FACTORY_RESET || cmd_id == SEV_PLATFORM_STATUS ||
> > +           cmd_id == SEV_GET_ID || cmd_id == SEV_GET_ID2)
> > +               return 0;
>
> I really like this patch and would like to see it get reviewed and
> merged. I've often thought of writing up a similar patch every time I
> look at the PSP code, but never took the initiative to do it myself.
> Overall, I wonder if it's trying too hard to reduce redundant code. In
> particular, we could avoid this awkward check if we put this helper
> inline, in the command helpers themselves. Perhaps we split this out
> into two helpers or instead add a parameter to this helper to control
> whether to check if `state` is `SEV_STATE_UNINIT`. What do you think?

That sounds good. I've moved calls to sev_init_if_required into the
command functions.

>
> > +
> > +       if (sev->state == SEV_STATE_UNINIT)
> > +               return __sev_platform_init_locked(&argp->error);
> > +
> > +       return 0;
> > +}
> > +
> >  static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> >  {
> >         void __user *argp = (void __user *)arg;
> > @@ -840,8 +825,11 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> >
> >         mutex_lock(&sev_cmd_mutex);
> >
> > -       switch (input.cmd) {
> > +       ret = sev_init_if_required(input.cmd, writable, &input);
> > +       if (ret)
> > +               goto copy_out;
> >
> > +       switch (input.cmd) {
>
> nit: Not sure what changed on this line. Was there an unintended
> whitespace change here?

Fixed for V2.

>
> >         case SEV_FACTORY_RESET:
> >                 ret = sev_ioctl_do_reset(&input, writable);
> >                 break;
> > @@ -875,6 +863,7 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> >                 goto out;
> >         }
> >
> > +copy_out:
> >         if (copy_to_user(argp, &input, sizeof(struct sev_issue_cmd)))
> >                 ret = -EFAULT;
> >  out:
> > --
> > 2.33.0.800.g4c38ced690-goog
> >
