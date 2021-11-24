Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A245C81B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349425AbhKXPAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343527AbhKXPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:00:03 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5320CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 06:56:54 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so4623789otm.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRNdgmKoGHd8G0IdZK2kJhuKe2APSp+LVa8VH3GbUIo=;
        b=ROINuAUVxy/ZbYmgWfHqBUzAuDwOQ6cqNQOfBVhy96Gry9ayUW0v2eAWocnQnqzx3v
         xgc65hVhfOFf2QyYOHtvwTkNw/gi7ENcARWpSUc8tTr1PgbR0vhK1mbBo7dmloWOedtW
         UEV/xNy8uprFwFS6gA4oIwhtzB0uMlUnBPPMIpu/w6ORmy8QrYL/n7wt6j3A80GfGrOw
         aGeIbUirqzK0slqUpZBhp9oUS8RL/fGa4ebYV8beZ3Si9FYiK4+2z4GZsVqQMSMw8AI2
         BcRuVz9lYpndNk5s+3smn0XoM4+Txn+jtQiDusTUa3GVwiYUH1hPVXmtuXdlQ0MJQneg
         SFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRNdgmKoGHd8G0IdZK2kJhuKe2APSp+LVa8VH3GbUIo=;
        b=B6oiG5nYqUBP1B0gT7ISyFbUuQm/8RIgwb2GoaIYckIGL/nT2pitkfQuUFYM41ysGt
         tRWHk4dGyKIJlMsUDNPHfpbycTTOH2WWk6PZZksJZhQs2G1XP4+gsJaaNuF4Sc0nFhSr
         N0aijvVvectkSx5tck3wmP6uwTks2e8qGfhQrASj2q2s2eVhlYJ7H3MF4RjhtJrT/orw
         vMJ9smEzYMTcPRuhrycK4JH0LDW91irASJd+Zw6cCeKVzH7LYqvXz+Jvy50o5sCtdi6P
         ed/YN6YT+BhEmhM25Gf7BAnt1ZkgrPI6IK9ZO+iC5zQKJj6fRsuhVisxLYxesmRTEnJg
         Ayeg==
X-Gm-Message-State: AOAM532rjJtY51KSlbWI5mXiDTfD2/Xxjmg1lp3dvpKzOt/i+vmwYRH6
        wZWV98l7KNycjPRqPlQvA9KQnLBQiXpqnG6vlWY=
X-Google-Smtp-Source: ABdhPJyqccrZCGcFmld4szOfDhBK9/E4Pq6QPLBGa5/rNNSCpHY0z5698ckRmlDMZ9GPhwZ2MvYxx3uekzO2OiCtwvA=
X-Received: by 2002:a9d:2486:: with SMTP id z6mr14024908ota.210.1637765813712;
 Wed, 24 Nov 2021 06:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20211123232551.210016-1-makvihas@gmail.com> <20211124131414.GJ6514@kadam>
In-Reply-To: <20211124131414.GJ6514@kadam>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Wed, 24 Nov 2021 20:26:41 +0530
Message-ID: <CAH1kMwRcEwc64XjPAXbJUPFsLTei2pmzP3r_6ZVWQ+NFkaa57g@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: use max() and min() macros
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>, straube.linux@gmail.com,
        nathan@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please run scripts/checkpatch.pl on your patches.

>> CHECK: Alignment should match open parenthesis
>> #41: FILE: drivers/staging/r8188eu/core/rtw_wlan_util.c:723:

Ahh sorry, my bad. Will resend v2 after fixing that.

On Wed, Nov 24, 2021 at 6:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Nov 24, 2021 at 04:55:51AM +0530, Vihas Mak wrote:
>
> > +
> > +                     min_MPDU_spacing = max(pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c,
> > +                                                     pIE->data[i] & 0x1c);
>
> Please run scripts/checkpatch.pl on your patches.
>
> CHECK: Alignment should match open parenthesis
> #41: FILE: drivers/staging/r8188eu/core/rtw_wlan_util.c:723:
> +                       min_MPDU_spacing = max(pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c,
> +                                                       pIE->data[i] & 0x1c);
>
> regards,
> dan carpenter
>


-- 
Thanks,
Vihas
