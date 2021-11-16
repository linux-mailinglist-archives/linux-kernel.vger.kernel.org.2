Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543B24535C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbhKPPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbhKPPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:31:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E0C061746;
        Tue, 16 Nov 2021 07:28:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m20so43751933edc.5;
        Tue, 16 Nov 2021 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIxAulZGhe8FSNRDbe6lspOQRntq7iKkrQ7YJUamTrE=;
        b=H2dRB1tmub7FmqAf+2gPesNCCZvWpw4VPXLBEH3IyZufX087WhaOzcQvx9RRB5dhz8
         jm6a7eG+nG58ciNzZzcPOfWA0ldnPB0I9tKH+QyF53WjqVdp3xX/anon2r3lFAH1aCat
         Mt+VG1xt5lk/tKcbkTPTkXay5sSImHyFtoPEnvpKNIoAonqxJ8v7uYvZpYISw9RQzkwx
         OjUHaA9/mMBNijIO+xXfMRx87bn/fq7zrY6bk8E1aNNbIK1xhR58qGmu0+8KioqVCvw2
         gach2cQ3C1ns2QY93ng+KlhaApfHQ+Elj2e3sf93Ri5Gri9DhpWlXzFfLa8mnEghEni/
         aEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIxAulZGhe8FSNRDbe6lspOQRntq7iKkrQ7YJUamTrE=;
        b=mrEzoK7yKUcba+sdbGKuYM8qLvhD0veQ1FOWNdfZeL3Cs1wWc2lAC+4047aXGzZ9R9
         r4LP7HqJHZCSmgCh+F6hUebBaSC31kJezuDoFFN78b9l2O7UMZEnGJyEVCywpe/zg9rR
         xABTK0ewx8/kapUCOos3GdZ9d8cWseNLY/c9sRXfjsxX9PPG0dU8hjloS6//jbqP/5id
         EBrfnI2SHGRFwa2rnhqP0XwoMCmS90VpuSLtUytMBDW3MQoc3NmS0wEbGVz+V0JwlUp3
         32wSq+EuzO7PL6FG1yLMyzYzdxXZMFFp/xRq1rbxrjUjuS4BpXJRsisxyxVvkyzT47ZT
         RbsQ==
X-Gm-Message-State: AOAM531i5W35lY8sSQWwzrQTPOr9qmp+O+uIGp8AKTEX7DoJrsdHxIbM
        0rlogYrREghKjwV4uYoF7RJZ16Ox27zno4AOyWrbvPq+8kICOg==
X-Google-Smtp-Source: ABdhPJxlCHMzmmqISOAsV2eJDLJviURmzDXeBzNZwNN8hZzEgPRRxrFwjjzdnsheotK2EQMxfb+RQN7ch3mo1H3A5O4=
X-Received: by 2002:a17:907:60d0:: with SMTP id hv16mr10742076ejc.425.1637076482742;
 Tue, 16 Nov 2021 07:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20211115210842.11972-1-pauk.denis@gmail.com> <CAHp75VcPHi1XyZr=CFbUhiUXK0q-10iBx5U3d==aG8pMG27k1Q@mail.gmail.com>
 <c016d0ca-b8b1-fb06-50f3-06a7b1c4aaea@roeck-us.net> <YZOKLDg582dQPzVN@smile.fi.intel.com>
 <d2943033-e701-f719-5da6-c00dc431dff9@roeck-us.net>
In-Reply-To: <d2943033-e701-f719-5da6-c00dc431dff9@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 17:27:21 +0200
Message-ID: <CAHp75Vdh+Fv_mV6VunzzndzXBONjbxMYKrii6We9Y+jD+NsYDQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] Update ASUS WMI supported boards
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 4:32 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 11/16/21 2:38 AM, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 03:15:39PM -0800, Guenter Roeck wrote:
> >> On 11/15/21 2:01 PM, Andy Shevchenko wrote:
> >>> On Mon, Nov 15, 2021 at 11:09 PM Denis Pauk <pauk.denis@gmail.com> wrote:
> >>>>
> >>>> Add support by WMI interface provided by Asus for B550/X570 boards:
> >>>> * PRIME X570-PRO,
> >>>> * ROG CROSSHAIR VIII HERO
> >>>> * ROG CROSSHAIR VIII DARK HERO
> >>>> * ROG CROSSHAIR VIII FORMULA
> >>>> * ROG STRIX X570-E GAMING
> >>>> * ROG STRIX B550-I GAMING
> >>>> * ROG STRIX B550-E GAMING
> >>>>
> >>>> Add support by WMI interface provided by Asus for X370/X470/
> >>>> B450/X399 boards:
> >>>> * ROG CROSSHAIR VI HERO,
> >>>> * PRIME X399-A,
> >>>> * PRIME X470-PRO,
> >>>> * ROG CROSSHAIR VI EXTREME,
> >>>> * ROG CROSSHAIR VI HERO (WI-FI AC),
> >>>> * ROG CROSSHAIR VII HERO,
> >>>> * ROG CROSSHAIR VII HERO (WI-FI),
> >>>> * ROG STRIX Z390-F GAMING
> >>>> * ROG STRIX B450-E GAMING,
> >>>> * ROG STRIX B450-F GAMING,
> >>>> * ROG STRIX B450-I GAMING,
> >>>> * ROG STRIX X399-E GAMING,
> >>>> * ROG STRIX X470-F GAMING,
> >>>> * ROG STRIX X470-I GAMING,
> >>>> * ROG ZENITH EXTREME,
> >>>> * ROG ZENITH EXTREME ALPHA.
> >>>>
> >>>> I have added "ROG STRIX Z390-F GAMING" to list of supported boards in
> >>>> asus_wmi_sensors.
> >>>
> >>> Guenter, what is your plan about this patch series? It seems it
> >>> missed, by unknown (?) reason, the v5.16-rc1 (I remember seeing it in
> >>> some of your tree branches at some point).
> >>>
> >>
> >> I don't see it in my record. Earlier I was simply waiting for some
> >> Reviewed-by: tags, which I have never seen.
> >
> > Ah, understood. Thank you for clarifications.
> >
> >> Looking into the commit log,
> >> I do see:
> >>
> >> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
> >> Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> >> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> >> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>
> >> Did you and Eugene indeed sign this off, ie did you write it, and
> >> Eugene and Denis signed it off ? If so, the tags are in the wrong order.
> >
> > I'm not sure I follow. I have helped Denis with the code and according to
> > Submitting Patches documentation the order should be chronological with the
> > main author to be first in the list. Here the committer (submitter) is the
> > same as the original author IIUC. (I can't speak for Eugene, though)
> >
>
> I got the patch from Denis. At the very least, Denis' signature should be
> last. It is first.

"...the ordering of Signed-off-by: tags should reflect the
chronological history of the patch insofar as possible, regardless of
whether the author is attributed via From: or Co-developed-by:.
Notably, the last Signed-off-by: must always be that of the developer
submitting the patch."

Okay, "must" obviously takes precedence over the "as possible".

> >> On the other side, if the code is ultimately from Denis, with your input,
> >> the tags should be either Acked-by: or Reviewed-by: for both Eugene
> >> and yourself.
> >
> > I'm fine with either Co-developed-by+SoB or Reviewed-by.
> >
> >> Note that v11 of this patch series is missing from
> >> https://patchwork.kernel.org/project/linux-hwmon/list/
> >> for some reason.
> >
> > Hmm... Denis, please check locally how you prepare your patches.

-- 
With Best Regards,
Andy Shevchenko
