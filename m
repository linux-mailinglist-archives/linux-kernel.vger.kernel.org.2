Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A4942A74B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhJLOgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbhJLOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:36:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A2C061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:34:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p16so17916853lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5yMuto80JoFAdSRxuic6aOBW+rt2vFNHvAzZQ/3FNs=;
        b=KaqGYXutI6Ybc4eg29VuD7PIlDdKsedh63dB1OtY4vC0jTHTXnN1YEal2Ix/9QGRcg
         AOZtpFM4Co8vmi1m9wsSbOCEyz8neyZrNzuzzVHRym/ePYiGBiS/iuZGPRfn0wSyQwZe
         CUBRDuW45fmObbSWMGOtawFt1in94Lb2uZgJaA+AUeQR801b3SbmwDtISoyJJK6MI6j9
         USB44iK/uzJyHQD4BmTGauqSyh7Bt8cRPiA/6kbqCUnu/2w1A7cGSBNRkpaF7itjoMS/
         Nr6aa766kd99/XGHA+B3Qr7aeYUxfupm7hatK0TugtdI7nDpRiuFbtTxvkxNtmLBeDCk
         FeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5yMuto80JoFAdSRxuic6aOBW+rt2vFNHvAzZQ/3FNs=;
        b=lOT62yloSfaGSU++js6OVH2F3MFxz44Gbc/DRJ2Z/RbewL2najGDgUDlU2RUkb1rmQ
         6JHVuI5YghGfoVy1DdJIHhtxZDcfQ/PqQRDiqRvCxXNiGTVfWXJ5f9x5Y/kG4j8Cc3lJ
         sAFYBOqMIIJeAemJ2DFrAGTkITGqI1J2TpDkxN1Xm2K7YKaSpxwb4202tU4TTHFG2qGm
         I6FMB6VOAPUfnMIMoGq6QmZfTrMCCjtzvOLwLGbVikZ8tkyFgAGfsPEPcuG2P7xl2C35
         a6iT2RGbX6TA7qyq09nPeIT7rvMAzsB7ZlP+xLWbubIwXLsIeX833zSCWwTSpM+JXY8G
         DBWg==
X-Gm-Message-State: AOAM531GyuH6IE5ooKvoTko3+ardK8eg47JdCiXndz6MQCoJYzmBV3Vz
        sDTJ3H4Kzxu2KXeLZInPT9l2l0H24qRgU1D2OM4sxA==
X-Google-Smtp-Source: ABdhPJx4XYPBQn3R3kuVR9Ymld5M9oRjbA9SN6AgSqmBTCXLMQ62j7215pABtzQ6meOMLmIqE40l5TbiIU9/CjNehgI=
X-Received: by 2002:a05:6512:398a:: with SMTP id j10mr33390426lfu.402.1634049285215;
 Tue, 12 Oct 2021 07:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211005195213.2905030-1-pgonda@google.com> <fdf0c263-38e9-7780-d0ac-943b6d2dd3a3@amd.com>
In-Reply-To: <fdf0c263-38e9-7780-d0ac-943b6d2dd3a3@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 12 Oct 2021 08:34:33 -0600
Message-ID: <CAMkAt6piNiJdHDMzSqgm-aQ0o-xxM=ax4qMgn81fKzVuaNukPg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp - Consolidate sev INIT logic
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 9:52 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
>
> On 10/5/21 12:52 PM, Peter Gonda wrote:
> >
> > +static int sev_init_if_required(int cmd_id, bool writable,
> > +                             struct sev_issue_cmd *argp)
> > +{
> > +     struct sev_device *sev = psp_master->sev_data;
> > +
> > +     lockdep_assert_held(&sev_cmd_mutex);
> > +
> > +     if (!writable)
> > +             return -EPERM;
> > +
> > +     if (cmd_id == SEV_FACTORY_RESET || cmd_id == SEV_PLATFORM_STATUS ||
> > +         cmd_id == SEV_GET_ID || cmd_id == SEV_GET_ID2)
> > +             return 0;
> > +
> > +     if (sev->state == SEV_STATE_UNINIT)
> > +             return __sev_platform_init_locked(&argp->error);
> > +
> > +     return 0;
> > +}
> > +
> >  static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> >  {
> >       void __user *argp = (void __user *)arg;
> > @@ -840,8 +825,11 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
> >
> >       mutex_lock(&sev_cmd_mutex);
> >
> > -     switch (input.cmd) {
> > +     ret = sev_init_if_required(input.cmd, writable, &input);
> > +     if (ret)
> > +             goto copy_out;
>
> We need to call this function only for the SEV commands (i.e input.cmd
> >=0 && input.cmd <= SEV_GET_ID2). Otherwise a invalid command may
> trigger SEV_INIT. e.g below sequence:
>
> 1) SEV_FACTORY_RESET   // this will transition the fw to UNINIT state.
>
> 2) <INVALID_CMD_ID>   // since fw was in uninit this invalid command
> will initialize the fw and then later switch will fail.

Good catch, I took Marc's suggested approach for a V2. Does that sound
reasonable?

>
> thanks
>
>
