Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6736E404250
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348714AbhIIAdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbhIIAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:33:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D767C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:32:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t20so142099pju.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBJZ+xd67CiFIsbUo5ZILupshCxiGwC5Wpwkm3BLH6k=;
        b=QFvS6izIE+d1GGVRGHR1QEMy4lxOUpUzI8cdpEPvcnmHg6ncVokDncdiZFJpdPUMfv
         a8I1A8s8Vi1L61d1h9JgrEGyy6LFUztBBvesIm5nHaDH6EXFqKtgt5okUQHR7jxF5sC6
         3L1eCO4Ec7roeo/DZl0f2C7fNach3w+CA9UlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBJZ+xd67CiFIsbUo5ZILupshCxiGwC5Wpwkm3BLH6k=;
        b=tmkw1RDlBSkl6O4HjPnWvbXq6xCu4tq+BBgW+OEwARv4IoTzXKdS44bFWF1XRHAL7T
         xSW9gptBGYfR1YhElzGywYG2AhNEkSIq2kg3uKw9EkVBt3DflBDnfcz6K+DIrwzt0h3f
         7derYeCs1ql8faEiOHZZO0lZxcFH3P2kHkdKShaEfsxFDKXeTuaw2HVcfgtzbIUp/QC6
         HSRbEygDGMR7IzVEgtmOoLX9obGV+Ep2ziZY/WRUx+RpZYrlte9gUV50TN7mF9AlZ24z
         A87P6N0ffvwOsxldEDoZt/5C/tRO0sCT+l4osSiDaVGKyTdlCj99ox2kNc633NNICbAg
         z4lg==
X-Gm-Message-State: AOAM531RdMyNm7Yt6NRVDYoGr8o5HIeCLIQ2b3vk0UK56E3BUPhtpFTo
        gowTxSEvdjbFl8oSBndedXAW9ZayTfF9ig==
X-Google-Smtp-Source: ABdhPJxO3eEZjFxxqoEtqYkV67Om+yWmPqly/1+F7ZwDXsf2RytSeb0mXzFkbk5MBW4ze9vFBNr8+A==
X-Received: by 2002:a17:90a:1c81:: with SMTP id t1mr279265pjt.170.1631147550667;
        Wed, 08 Sep 2021 17:32:30 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id d22sm92413pgi.73.2021.09.08.17.32.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 17:32:30 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id e16so208064pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:32:30 -0700 (PDT)
X-Received: by 2002:a92:6b0a:: with SMTP id g10mr141704ilc.27.1631147057200;
 Wed, 08 Sep 2021 17:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210901201934.1084250-1-dianders@chromium.org>
 <20210901131531.v3.3.I4a672175ba1894294d91d3dbd51da11a8239cf4a@changeid> <87h7ey81e9.fsf@intel.com>
In-Reply-To: <87h7ey81e9.fsf@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Sep 2021 17:24:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-d8XH5bmcAhDGnbs-DHgQ7D6G9g3gRsjo7RN1xQ1kNA@mail.gmail.com>
Message-ID: <CAD=FV=X-d8XH5bmcAhDGnbs-DHgQ7D6G9g3gRsjo7RN1xQ1kNA@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] drm/edid: Allow the querying/working with the
 panel ID from the EDID
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Steev Klimaszewski <steev@kali.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 6, 2021 at 3:05 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> > +{
> > +     struct edid *edid;
> > +     u32 val;
> > +
> > +     edid = drm_do_get_edid_blk0(drm_do_probe_ddc_edid, adapter, NULL, NULL);
> > +
> > +     /*
> > +      * There are no manufacturer IDs of 0, so if there is a problem reading
> > +      * the EDID then we'll just return 0.
> > +      */
> > +     if (IS_ERR_OR_NULL(edid))
> > +             return 0;
> > +
> > +     /*
> > +      * In theory we could try to de-obfuscate this like edid_get_quirks()
> > +      * does, but it's easier to just deal with a 32-bit number.
>
> Hmm, but is it, really? AFAICT this is just an internal representation
> for a table, where it could just as well be stored in a struct that
> could be just as compact now, but extensible later. You populate the
> table via an encoding macro, then decode the id using a function - while
> it could be in a format that's directly usable without the decode. If
> suitably chosen, the struct could perhaps be reused between the quirks
> code and your code.

I'm not 100% sure, but I think you're suggesting having this function
return a `struct edid_panel_id` or something like that. Is that right?
Maybe that would look something like this?

struct edid_panel_id {
  char vendor[4];
  u16 product_id;
}

...or perhaps this (untested, but I think it works):

struct edid_panel_id {
  u16 vend_c1:5;
  u16 vend_c2:5;
  u16 vend_c3:5;
  u16 product_id;
}

...and then change `struct edid_quirk` to something like this:

static const struct edid_quirk {
  struct edid_panel_id panel_id;
  u32 quirks;
} ...

Is that correct? There are a few downsides that I can see:

a) I think the biggest downside is the inability compare with "==". I
don't believe it's legal to compare structs with "==" in C. Yeah, we
can use memcmp() but that feels more awkward to me.

b) Unless you use the bitfield approach, it takes up more space. I
know it's not a huge deal, but the format in the EDID is pretty much
_forced_ to fit in 32-bits. The bitfield approach seems like it'd be
more awkward than my encoding macros.

-Doug
