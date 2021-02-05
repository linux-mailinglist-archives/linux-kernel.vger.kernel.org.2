Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8927A3117AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBFAMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhBENGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:06:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266CAC06178C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:05:33 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id f6so6781509ots.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=meHuzs6N41tZwNz5Z8o9DqX2fcdLCbhLwuuynzEyeWM=;
        b=caNcsbg+cluV4xsl+wtBGBB0+tBVxphrCq08ie5y62VKKrrvFqHJl4eLA753W6yxcx
         +DsfIeed0slxZgU+awR4rrvFavZxYfvGEqGNS7qi3cj7ZT7FTuj9kwiuXEmbea+Uklvt
         S+/Onew+8DaR2I0iNwiG8CXgsWbaVu9d9oMHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=meHuzs6N41tZwNz5Z8o9DqX2fcdLCbhLwuuynzEyeWM=;
        b=YHwh+KVN8EImW3gheyRvfFwqHxVE0mKztNkyCjlOowwxavQEn50JLnTHtpfa9KzwLw
         ubgesl2D5jCAykpCr90WJPPSgcZhJep36kj+IW5/9kbFD240QZU2XHmpNDEBP0CO8R7B
         vPhPUR9H/uvBFKU0QLCQy9CYDaSXa9V0HTo0b0qyz3aCfugzJh4+hDy/mu7QglbVIKHy
         qt4/m7BrNIB5yRDIomlqKuwOicX/tVmO1BvxsLEl9BCFVQjBd/vy9wsH0YbTgtji52za
         j/1QSWvUvRzdH8nUM0R+V7mHpc9TpQ1Bv8C9Bk3JmIJDQ2zj1+rWNmrUhFIcO9FSwaV+
         CL4w==
X-Gm-Message-State: AOAM531i5g3zS0MHe2++8nbzmP+dwv9OLRe+CtOT3dmM/vMrqg111Ajp
        TDsWcMuQBgSqkqWlc5CM9jPUnuOcOWHIng7wxkScZw==
X-Google-Smtp-Source: ABdhPJzng89M/HFnFqHXCqLK/NUEuD1p6NqDzjg+NI3npAgpIIrnhRIkeejWN9f+opFyGRDm7xIyl4Yf2/s72s+33io=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr3221863otr.303.1612530332640;
 Fri, 05 Feb 2021 05:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20210204155846.5aef94a8@canb.auug.org.au> <CAHp75Vct=jSQxu187hwz4Wrc_xRKiTmKFt_bgT-m-z=iW31drg@mail.gmail.com>
 <CAHp75Vc_xJFpUECZenOYEyJ6YDzfDFmJe9cTeGh0x-c_fKQPHw@mail.gmail.com> <CAMeQTsYK5GoL=VNB0CPrGi0Y-804N1q24dkii20OuV8=ckhmuA@mail.gmail.com>
In-Reply-To: <CAMeQTsYK5GoL=VNB0CPrGi0Y-804N1q24dkii20OuV8=ckhmuA@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 5 Feb 2021 14:05:21 +0100
Message-ID: <CAKMK7uFSF0cHZh6KikMf2MmBykZazE5HGA1ejJU++GWyfuTmfQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drivers-x86 tree with the
 drm-misc tree
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mark.gross@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:14 PM Patrik Jakobsson
<patrik.r.jakobsson@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 12:07 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Feb 4, 2021 at 11:04 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >> Today's linux-next merge of the drivers-x86 tree got a conflict in:
> > >
> > > Thanks. I already asked Patrik yesterday day if DRM missed to pull an=
 immutable tag I provided. I think they can pull and resolve conflicts them=
selves. Alternatively it would be easy to resolve by Linus by removing Kcon=
fig lines along with mentioned files,
> >
> > Patrik, I have sent a PR again, so you may consider pulling it, thanks!
>
> Daniel, is this something you can pull into drm or ask one of the
> drm-misc maintainers to do?

We've already created the conflict, and my understanding is that Linus
wants to have visibility into conflict-y stuff and doesn't mind at all
resolving conflicts. Hence for 5.12 I think we're fine as-is.

Thanks, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
