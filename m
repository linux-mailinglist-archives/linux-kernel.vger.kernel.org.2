Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700041060C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhIRLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbhIRLWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 07:22:45 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:21:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s20so6901455ioa.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ojab.ru; s=ojab;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vTIBq7OgcFSIUkKEdHY3wi/HPPALeiPsoDimZEmejs=;
        b=TB7+9svnr9db5eEQUcCbKnnthERxnsR3zGSst85Gue8c5XVSczZl73Z3IQ8pRQfT3c
         7ZoKYL6RyebbyeInS8PBtSlIu7ibrCwG32ouDax/Ezk8jYGrxqo3TndHw2eqAwfY13dN
         9V/+EThULN+urYK/0fnnBbnraXPIl/T8mbPIDcr6aRMwDh2KRjXt3ir27rUKwA7Wv+9S
         Y+VefQsIGKFPPmPRfFvFoYNP/CvB6FfBTp7Wv1rZQHFOKnkfhLFpELOwMOuiZye51uWT
         G5icb2n99Mcu+90RKzfpCg5SU68h27lE/XZhrc0SI9UfiWqxdidObJhBjP32Zgshluca
         plaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vTIBq7OgcFSIUkKEdHY3wi/HPPALeiPsoDimZEmejs=;
        b=c0Fm1+ZMNpW+70DokTP6QP0DwZwv1faiiAzIWDGa2ct20XOQu6wNSEmAKtxxBiLh3D
         ln8nSGuHoBrSIYZ81eHcVjIgQt4JV/A4LlfXqC3sXwM01tnEQa2r1fVgv+htlHTVNgoC
         Pqey7xb4dvIB8V1tWnim9+FZWdzt5hJ/+fsXTLmSlMb9fc2hBT3DkigEUcJm0zTjn7xD
         Kwxbycnl+Uz5qAoXemE332uIrC8AG2/rpfnzNXqoFVfL+IgN23HQHAC3Ynmom+8jfO9+
         yd4hHVEhwtyDWN353rLUR/0YeYWi/EgiekweuUgupe5Idy0SdolZ1HGT4e7c+S+iiKtS
         66jg==
X-Gm-Message-State: AOAM532lMys45ILPTywCMwbBbgYB3l7IuxbmLiXd/d2dnU1YIgHtaaIZ
        RFyD2CFlx21J7NDyKppdj22xtCzzliK8fT0yqdqfow==
X-Google-Smtp-Source: ABdhPJwawAEnPF7WRSLXu4E3brYMb0Nevsg4dHFpW+EkY/D0CNrUQ0zciPKvDG41wbFIpYfBR3EDXX6UubRwmQc25yE=
X-Received: by 2002:a6b:f007:: with SMTP id w7mr12181943ioc.112.1631964081521;
 Sat, 18 Sep 2021 04:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210722193459.7474-1-ojab@ojab.ru> <CAKzrAgRt0jRFyFNjF-uq=feG-9nhCx=tTztCgCEitj1cpMk_Xg@mail.gmail.com>
 <CAKzrAgQgsN6=Cu4SvjSSFoJOqAkU2t8cjt7sgEsJdNhvM8f7jg@mail.gmail.com>
 <CAKzrAgSEiq-qOgetzryaE3JyBUe3URYjr=Fn0kz9sF7ZryQ5pA@mail.gmail.com> <538825a2-82f0-6102-01da-6e0385e53cf5@gmx.de>
In-Reply-To: <538825a2-82f0-6102-01da-6e0385e53cf5@gmx.de>
From:   "ojab //" <ojab@ojab.ru>
Date:   Sat, 18 Sep 2021 14:21:10 +0300
Message-ID: <CAKzrAgQcT=X0JtqoVWiTEhqSDcN-4XSW2xW6dWLsVo_OZt+hEw@mail.gmail.com>
Subject: Re: [PATCH V2] ath10k: don't fail if IRAM write fails
To:     "sparks71@gmx.de" <sparks71@gmx.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oh, awesome. Thanks!

//wbr ojab

On Sat, 18 Sept 2021 at 13:12, sparks71@gmx.de <sparks71@gmx.de> wrote:
>
> Have you seen the new patch?
>
> https://www.mail-archive.com/ath10k@lists.infradead.org/msg13784.html
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=973de582639a1e45276e4e3e2f3c2d82a04ad0a6
>
>
> could probably have been communicated better
>
>
> best regards
>
>
>
> Am 17.09.21 um 21:30 schrieb ojab //:
> > ._.
> >
> > //wbr ojab
> >
> > On Thu, 9 Sept 2021 at 02:42, ojab // <ojab@ojab.ru> wrote:
> >> Gentle ping.
> >>
> >> //wbr ojab
> >>
> >> On Wed, 25 Aug 2021 at 19:15, ojab // <ojab@ojab.ru> wrote:
> >>> Can I haz it merged?
> >>>
> >>> //wbr ojab
> >>>
> >>> On Thu, 22 Jul 2021 at 22:36, ojab <ojab@ojab.ru> wrote:
> >>>> After reboot with kernel & firmware updates I found `failed to copy
> >>>> target iram contents:` in dmesg and missing wlan interfaces for both
> >>>> of my QCA9984 compex cards. Rolling back kernel/firmware didn't fixed
> >>>> it, so while I have no idea what's actually happening, I don't see why
> >>>> we should fail in this case, looks like some optional firmware ability
> >>>> that could be skipped.
> >>>>
> >>>> Also with additional logging there is
> >>>> ```
> >>>> [    6.839858] ath10k_pci 0000:04:00.0: No hardware memory
> >>>> [    6.841205] ath10k_pci 0000:04:00.0: failed to copy target iram contents: -12
> >>>> [    6.873578] ath10k_pci 0000:07:00.0: No hardware memory
> >>>> [    6.875052] ath10k_pci 0000:07:00.0: failed to copy target iram contents: -12
> >>>> ```
> >>>> so exact branch could be seen.
> >>>>
> >>>> Signed-off-by: Slava Kardakov <ojab@ojab.ru>
> >>>> ---
> >>>>   Of course I forgot to sing off, since I don't use it by default because I
> >>>>   hate my real name and kernel requires it
> >>>>
> >>>>   drivers/net/wireless/ath/ath10k/core.c | 9 ++++++---
> >>>>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> >>>> index 2f9be182fbfb..d9fd5294e142 100644
> >>>> --- a/drivers/net/wireless/ath/ath10k/core.c
> >>>> +++ b/drivers/net/wireless/ath/ath10k/core.c
> >>>> @@ -2691,8 +2691,10 @@ static int ath10k_core_copy_target_iram(struct ath10k *ar)
> >>>>          u32 len, remaining_len;
> >>>>
> >>>>          hw_mem = ath10k_coredump_get_mem_layout(ar);
> >>>> -       if (!hw_mem)
> >>>> +       if (!hw_mem) {
> >>>> +               ath10k_warn(ar, "No hardware memory");
> >>>>                  return -ENOMEM;
> >>>> +       }
> >>>>
> >>>>          for (i = 0; i < hw_mem->region_table.size; i++) {
> >>>>                  tmp = &hw_mem->region_table.regions[i];
> >>>> @@ -2702,8 +2704,10 @@ static int ath10k_core_copy_target_iram(struct ath10k *ar)
> >>>>                  }
> >>>>          }
> >>>>
> >>>> -       if (!mem_region)
> >>>> +       if (!mem_region) {
> >>>> +               ath10k_warn(ar, "No memory region");
> >>>>                  return -ENOMEM;
> >>>> +       }
> >>>>
> >>>>          for (i = 0; i < ar->wmi.num_mem_chunks; i++) {
> >>>>                  if (ar->wmi.mem_chunks[i].req_id ==
> >>>> @@ -2917,7 +2921,6 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
> >>>>                  if (status) {
> >>>>                          ath10k_warn(ar, "failed to copy target iram contents: %d",
> >>>>                                      status);
> >>>> -                       goto err_hif_stop;
> >>>>                  }
> >>>>          }
> >>>>
> >>>> --
> >>>> 2.32.0
> > _______________________________________________
> > ath10k mailing list
> > ath10k@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/ath10k
> >
> >
>
