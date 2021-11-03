Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85B14441A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhKCMhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhKCMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:37:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5266DC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 05:34:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e136so2734879ybc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 05:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MpA1Tb/ZSh9gS8Lr083i/yua35MUY6dI1yr07S+xRu8=;
        b=PXgi4S/Znn2BLSS6qaiA/608BiZGv3BW8+T6/7cgGbJzk4AGyaovDRVu6YWfzhfRAZ
         o2kKYwMt09RplerQbA/m7LJXw4z2EsbHzvUqEaICt05dgQbLjNEbX+2DgE5yr7SFeK6j
         M/bu4hrtDD49mYmA3GylD6ABmUyl/PLe6iZIlPQYX7DRtMi/joL3cLdvg/5t+eNfBio0
         pxxQuR1VWbbY3MG1aPBrMW8AeCWearDhvzHVSadG+BFia4dbIAdTXVrejooIRugbttLE
         oCv0P+CRCeUKNVNmwIlpISXFyExYHplTOz0XmmgooxrV64jIFIt0HfpcRDzKyiy5ZMXD
         W6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MpA1Tb/ZSh9gS8Lr083i/yua35MUY6dI1yr07S+xRu8=;
        b=ISmAOPXqVOO9+RKHEGrxxr+iC9bUebxmbgMnMjl332OnVOZa57pjy4JK7Wf9an9rxs
         1CdE5UdjDkoBXvUg9bjnKp5+F+MEhkqhP4JYt38WX6n+kj235fxR/tPwcwwov1gLf47q
         xtoi7HyoOMjyGq3H9SrquZrjw+D48MIBmbxNmEafFDy0nwJmvfIBLoIaDCOP7LO9qJmY
         +Mpp66qK3tWVjFvXcSX9UcWPek7q1UplGLMqTjYlu5mEh6GA5u1KDEJCns5M45ShS+7o
         EpK7iAruXwf1Qirgyc8qC3I1X7yTQw/KQUrLWnZ4lMGFscYw0tpGQU+9bKCn1SyjXnmh
         bttw==
X-Gm-Message-State: AOAM532+LqhjL7HV7H9y/s5M0c+lU0sBbrNmOXugSErMijkR0SyjYhQB
        /zu1C23HwrvIZBDNjoq4ZNRJFuDr5hVscrN6bqU=
X-Google-Smtp-Source: ABdhPJw5CqcuP4ka6/OYnTROeaibGnBrUNlp94O+koFnFkp1/p7yF55PdIZlTyHXhz+o20NwafJmDbJ0CinsOUNHXIY=
X-Received: by 2002:a25:5d4:: with SMTP id 203mr31233901ybf.290.1635942896360;
 Wed, 03 Nov 2021 05:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211103104812.1022936-1-javierm@redhat.com> <20211103104812.1022936-3-javierm@redhat.com>
 <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com> <1dbc7d15-a314-677b-1870-276b0cca1705@suse.de>
In-Reply-To: <1dbc7d15-a314-677b-1870-276b0cca1705@suse.de>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 3 Nov 2021 08:34:20 -0400
Message-ID: <CAEg-Je-mmwZOGR-J-dTcOs-8x2BfgCtv5GwFy_d9rBkxOZ1YBg@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm: Move nomodeset kernel parameter handler to the
 DRM subsystem
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 8:32 AM Thomas Zimmermann <tzimmermann@suse.de> wrot=
e:
>
> Hi
>
> Am 03.11.21 um 12:05 schrieb Neal Gompa:
> > On Wed, Nov 3, 2021 at 6:48 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >>
> >> The "nomodeset" kernel cmdline parameter is handled by the vgacon driv=
er
> >> but the exported vgacon_text_force() symbol is only used by DRM driver=
s.
> >>
> >> It makes much more sense for the parameter logic to be in the subsyste=
m
> >> of the drivers that are making use of it. Let's move that to DRM.
> >>
> >> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> >> ---
> >
> > Please no, I'd much rather have a better, more meaningful option
> > instead of "nomodeset". If anything, I would like this option to
> > eventually do nothing and replace it with a better named option that's
> > namespaced by drm on the command-line. That was part of the feedback I
> > gave in the original patch set, and I still stand by that.
>
> This was nack'ed for now during irc chats with others. There was no
> clear semantics for the new parameter and nomodeset is good enough for
> now. I agree that nomodeset is badly named, though.
>

Where are these chats happening? I'm mostly talking to Javier in the
#devel:fedoraproject.org Matrix room, so I don't know about anything
else...



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
