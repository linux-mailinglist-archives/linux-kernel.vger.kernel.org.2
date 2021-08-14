Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A083EC3FB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhHNQ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhHNQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:58:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E4C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:57:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j1so19957427pjv.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tu7497B1vudv4lRmDQxN1ly5NrWEwmYjdP9mT2Cvgv0=;
        b=DKPz5wKcMz1mCz5OVjtfc9sW+oS8xoy01mPR0Y/zUtgc6CvvLTP7SAdV+9ka5SpYUb
         ZY0C6tDMFiWofLJMFBlnyRnqPWfL98sGKkyzSPasrOZ7h8QhpP7RccWbsC5v2qe0N6fo
         11nRj6MAJt7gGjiz7ldDeLnjuqG19zjdd7JvyFSofBhhl6c1k1gTNTYLxWP2dM+t+uke
         64Cf09sGRIKXSsprdbPDgxQLQIHnmYiwl8o30uXc8EQfGfwR4Q0XhBZsLxYKNqw2mniI
         7M6qrnHegNCXvIIz9CLH0QrbTYXk+kKfwy4WCxCcpIPLCalTUj6Wheo6v2WowAE+Kj85
         L9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tu7497B1vudv4lRmDQxN1ly5NrWEwmYjdP9mT2Cvgv0=;
        b=WNz9lfiCfww1HUU2aLmewKJ9nvIGTE6iEw+qVDfjPy3OaPT/2/5zudPJHVKTtNkSxs
         xMBb9EHTZAUUPk1OXinFVg1I8dkWrVM9fVL3yi34hCeK5ty1uutaIHkxD4cGXKt49DpP
         NHbfRgmGaTZKOxDBvtM6LFmjeVDNuPWyuvcEs4neoT3cKLFFKQ0FD429ytbqW5nwxIMT
         cO0aGROIvtuXYsX0IZeD+zv+MPUrnTVcI5urSqXuxZLGL+YNjis7weD/I5Yivc0dQqY4
         jgaP8UimHiZAuon3y+loL6+oM/PD2E9Ur4+ZLbQpZIQPZOdLo2chimeO/3zJ2PIabqkd
         /qxg==
X-Gm-Message-State: AOAM5313YvJib1iCss6lFx2hNHWQYIp4wMxN8HbHllWBiJoJ2ua7fmtG
        TPpJixckrtDz7HPmbeEypPxUDL8dCstUZCVOYx0tFQ==
X-Google-Smtp-Source: ABdhPJwQuIkSGIO6VHBqWxbOrKA+S04JhZ0uPErL8a1doj3dR1ZbgxLauvSBaG0iDoX2GY8u3d4JJACLIAPRrfPoztY=
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr7779314pff.71.1628960271470; Sat, 14
 Aug 2021 09:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210812132725.18404-1-fabioaiuto83@gmail.com>
 <c2abe840-98b4-cddd-e427-2243d456ec19@lwfinger.net> <YRYS+4I58YRnAepF@kroah.com>
 <CAP71bdXD-AY985fFzjCFFt2NLr7Jsd+Ucow2D_EE-renCVXP6A@mail.gmail.com>
In-Reply-To: <CAP71bdXD-AY985fFzjCFFt2NLr7Jsd+Ucow2D_EE-renCVXP6A@mail.gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 14 Aug 2021 17:57:40 +0100
Message-ID: <CAA=Fs0mY6f-r8j=H-aQ80Krw_q4=50iM0+26X=PZj-ze0-hgNA@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: remove cfg80211 residuals
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 19:42, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
>
>
> On Fri, Aug 13, 2021 at 2:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > That's odd, I'll drop this from my queue, we should be using cfg80211
>
> I will be going dark for a while as I add the cfg80211 bits back in.
>
> One piece of good news. I dug out my PowerBook G4 with a PowerPC CPU and tested. Even with all the changes, the driver still works on a big-endian CPU.
>
> Larry
>
>

Thanks Larry, and awesome news - a PowerBook G4 - one machine I'm sad
I never owned back in the day :-)

Regards,
Phil
