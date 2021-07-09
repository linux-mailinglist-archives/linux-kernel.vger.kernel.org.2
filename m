Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035BD3C1D40
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 04:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGICL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 22:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhGICLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 22:11:24 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 19:08:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id s4so7797538qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/0ERbBGzIyneS2vO1j+xM+9/bEQwTCuaveZZgS0gDs=;
        b=dFmK3QigIP75keveL3Tcq7IlNzDdBQseedtrx+FStZTK5l4sxfusNxR8Ak7Q8chCiO
         Jkq+XY/q+PO67ksfQ4XEWfOQb/W/yeTmHamo+Eb4npdyqT7+0xoaYim+42IzwcSv3AEm
         TMjEjYSe0hVqoiK4T1I11lbr8nM4jiVksc49ANSc2MQbNAsfX+OtYJ98pfTuX3iPvZ5p
         xJ+S3K0kyghFhUteXtiJYM5l+FkVVPSB7aIWBZvwq7+YO0J7xD6HwAABsxxoaJSlseHJ
         4fdYgI577Tkf9zsjsFTeino8k4P3TLNycz+ruzHPM27Rl/fdgUyn5YAkTY2tEWXA6v6r
         w1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/0ERbBGzIyneS2vO1j+xM+9/bEQwTCuaveZZgS0gDs=;
        b=Pu6yuiAx8mIxc2/+BlFfQIhOPCuPThSow+h0/scWL5I7MTjyh36YgkMW8LhE4dJhuH
         8Qc0syDoZxKpwwObakG7Pu5M1lHW2h8gGVG7WX8o3kresQ/1/xFAyxsm+T/QpY3K0XNR
         J0L02hMbJ577xrYVQIFSDEW3FyCXc+udWGDf/drQYOEubCnBZXTezQHCANH9OLR/ZQ/a
         dSyi+RdpfeGn4kgbqp3fd1KaaZl7hwjj1/wE1pwt5X9csSEiUe5AglCO8FJAL9v/ZETY
         TZRBYeOtnIi3LynaY6a8qPMFM3pIH8DluJNoGAsCYoZYUhARIsTOl9HKq2pt1Ymoebaz
         iZKw==
X-Gm-Message-State: AOAM5326a5UdqjTT/VZADg1sdKvth8Ar9Oo0RUCP9sgNzEUESTOr8VOx
        +P3OeJWNFw7bcpZDz6We74oAOcDQ0/VvtsphvnxB
X-Google-Smtp-Source: ABdhPJx6FQwc7egvSqXYoq7isUUDoHczhZPESZqsnwKgdS2sTsZF3gtCQA8AWynl7IS1pJ3FafB3qZc8U3GyMfXeTFA=
X-Received: by 2002:a37:8345:: with SMTP id f66mr34318319qkd.396.1625796519947;
 Thu, 08 Jul 2021 19:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210708020815.3489365-1-lerobert@google.com> <s5ho8bd59q4.wl-tiwai@suse.de>
 <CAOM6g_Cv6rsLOAb0+Lr_YkjHpKfw+zvWXH0X5LKR=Z4dtXGRng@mail.gmail.com> <e2705267-4400-bb7f-e96a-9b103872c0a1@perex.cz>
In-Reply-To: <e2705267-4400-bb7f-e96a-9b103872c0a1@perex.cz>
From:   Robert Lee <lerobert@google.com>
Date:   Fri, 9 Jul 2021 10:08:29 +0800
Message-ID: <CAOM6g_D4dkwDcQza9fVXn9=uXSYTBThNVHqWb0YjLWkc_eBwog@mail.gmail.com>
Subject: Re: [Patch v2] ALSA: compress: allow to leave draining state when
 pausing in draining
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.de>, vkoul@kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        carterhsu@google.com, zxinhui@google.com, bubblefang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela <perex@perex.cz> =E6=96=BC 2021=E5=B9=B47=E6=9C=888=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 08. 07. 21 15:47, Robert Lee wrote:
> > Hi Takashi,
> >
> > It is a little complex to describe the design in detail, but try to
> > explain simply
> > what issue we meet.
> >
> > If w/o the change,  after user resumes from the pause, our system would=
 call
> > snd_compr_drain() or snd_compr_partial_drain() again after it returns f=
rom
> > previous drain (when EOF reaches). Then it will block in this drain and=
 no one
> > wake it up because EOF has already reached. I add this change to return=
 from
> > the previous drain.
>
> It looks like that the driver does not call snd_compr_drain_notify() so t=
he
> state is not updated to SETUP on EOF.
>
We indeed call snd_compr_drain_notify() on EOF, but after return from
wait_for _drain there is another drain again immediately.
Looks like the system queue some states change on user space and need
to drain again after resume from pause.
I suppose there is different design on user space so I add the hook to
handle diffent usage.

> > Actually, I am wondering how the pause-during-drain can keep the state =
in
> > DRAINING. It should have a different design. :)
>
> I already proposed to add a new state (because it's a new state), but the
> conservative way was elected to avoid user space changes.
>
>                                 Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
