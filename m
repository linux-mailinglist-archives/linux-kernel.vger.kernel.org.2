Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0541422C19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhJEPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhJEPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:15:52 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39360C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:14:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y197so24692373iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sh8VNE4FCLdSm5VCdPfycmMPvw4PtVqb68V0H1ZpEUk=;
        b=HtcGpyyh2UUVNrAb5Igdog262j6GdlcgBCBggIlt8jnaHyk4jpyGysSyBfHZba0mdm
         pDC1Acu7d9xqLvWCmW3TynL/Iw1DjKCWed9Iw2sJZ/8HJ8dhcrJzRSHOsg1v8+xashTp
         skKhyltA89Q0HPRLVE510wa50TQNxyIKcppPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sh8VNE4FCLdSm5VCdPfycmMPvw4PtVqb68V0H1ZpEUk=;
        b=8QkcghaHv6mjAZJjpJfEqhSW5q8WKKP+iMNrFHhMoyj28e3Q4MLaJp9s0Leb/DQ0M/
         gliw6alx0GZERtFOt5DEU5enYfHBjcVUd9SLfAEhHDx9i0ZsOxJU/5frarLE1YdKxgfp
         Pm+p+t6J5GNdpXaItVe7uLnd7EL7jpVivvwgx7dDIWXEJJ/j91fLdd6nORoAukobKsR/
         k5LTYdmPSlYRSUqeienPpjOWt5LWiZ10qcIoPCgtxlsdnbsd9yfi8EW8wx2BUkpgrnOv
         9aNv0trSP5xPXDoM3qhBx3j9JnqRuE29gNK/21Cf6p4ZiVTY23jcnEvKMJEDqbhyS47L
         7ebQ==
X-Gm-Message-State: AOAM533NykAyxN3f+CoFSY2VkkEo29rPUuB5h/DWW95zT4FYbubegjMp
        7GcccfvU7zY2p8off/2m8cGi796Lcww24Q==
X-Google-Smtp-Source: ABdhPJzjyw+j0mRaR817oks1TqP8pTdZRH7fMrzspRm1/9+FjgkLTHcdsUenLxIQQuo1f8ePMcGmjA==
X-Received: by 2002:a05:6602:2e95:: with SMTP id m21mr280226iow.198.1633446841417;
        Tue, 05 Oct 2021 08:14:01 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id w11sm5231878ior.40.2021.10.05.08.13.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 08:14:00 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id b6so22249109ilv.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 08:13:59 -0700 (PDT)
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr3420583ilv.180.1633446839293;
 Tue, 05 Oct 2021 08:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211004092100.1.Ic90a5ebd44c75db963112be167a03cc96f9fb249@changeid>
 <YVtZstInQxXfPmsZ@intel.com> <DM6PR12MB49127B8B63079E6533197EA6E5AF9@DM6PR12MB4912.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB49127B8B63079E6533197EA6E5AF9@DM6PR12MB4912.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Oct 2021 08:13:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VvKsrB9RZKdB6vQJ-38BZEYLnuENxb1+1v-PahcdBtiQ@mail.gmail.com>
Message-ID: <CAD=FV=VvKsrB9RZKdB6vQJ-38BZEYLnuENxb1+1v-PahcdBtiQ@mail.gmail.com>
Subject: Re: connector_bad_edid() is broken (was: Re: [PATCH] drm/edid: Fix
 crash with zero/invalid EDID)
To:     "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "oliver.sang@intel.com" <oliver.sang@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 5, 2021 at 6:33 AM Zuo, Jerry <Jerry.Zuo@amd.com> wrote:
>
> > BTW I believe connector_bad_edid() itself is broken since commit
> > e11f5bd8228f ("drm: Add support for DP 1.4 Compliance edid corruption
> > test"). Before we've even allocated the memory for the extension blocks
> > that code now assumes edid[0x7e] is to be 100% trusted and goes and
> > calculates the checksum on a block based on that. So that's likely going to be
> > pointing somewhere beyond the base block into memory we've not even
> > allocated. So anyone who wanted could craft a bogus EDID and maybe get
> > something interesting to happen.
> >
> > Would be good if someone could fix that while at it. Or just revert the
> > offending commit if there is no simple solution immediately in sight.
> >
> > The fact that we're parsing entirely untrustworthy crap in the kernel always
> > worries me. Either we need super careful review of all relevant code, and/or
> > we need to think about moving the parser out of the kernel.
> > I was considering playing around with the usermode helper stuff. IIRC there
> > is a way to embed the userspace binary into the kernel and just fire it up
> > when needed. But so far it's been the usual -ENOTIME for me...
> >
> [AMD Official Use Only]
>
> Hi Ville:
>
>      Yhea, it is pretty old change from two years ago, and it is no long valid anymore. Please simply drop it.
>
> Regards,
> Jerry

I've cut out other bits from this email and changed the subject line
since I think this is an issue unrelated to the one my original patch
was fixing.

I don't actually know a ton about DP compliance testing, but I
attempted to try to be helpful and revert commit e11f5bd8228f ("drm:
Add support for DP 1.4 Compliance edid corruption test"). It wasn't
too hard to deal with the conflicts in the revert itself, but then
things didn't compile because there are two places that use
`real_edid_checksum` and that goes away if I revert the patch.

I've made an attempt to fix the problem by just adding a bounds check.
Perhaps you can see if that looks good to you:

https://lore.kernel.org/r/20211005081022.1.Ib059f9c23c2611cb5a9d760e7d0a700c1295928d@changeid

-Doug
