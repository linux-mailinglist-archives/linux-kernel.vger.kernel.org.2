Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4240B6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhINScp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhINScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:32:43 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:31:26 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z1so18444604ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+vma+/6q1PCLBq1R/pn7+hiAdo2p9TNOImn3v6+f+E=;
        b=Y5lRNVAjSYwSWmKnEik3qpWm/iU4mMYqfkUUEll4nG+hRAlVIuYHtegamdA/04weNL
         icS4WvXXrm3lc4YxAXXc8RBLLVsCKZ9JUDssETyDHfmj3t4cHrKZRDPsAPBiUEDFV87/
         HlR/FVeS1f7Izg2Uv4fZNxKyS2iVszJAByNpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+vma+/6q1PCLBq1R/pn7+hiAdo2p9TNOImn3v6+f+E=;
        b=LbjJfB/+VUoGr16ROvFjYUB7/EPYY+y26yhY2uDkwAeqhR8fa55mxeiGNkMbOd3mW/
         jsPDQdm83BiJHsMda6Ne55OF0HYJrDLUYO5i29kMKCk7KibXF4/JKKZIKBsnOXxlTmUh
         DUV0tkqlZRlxbeLz13gTp8Rbpr64wVB10DxTgAn9A6lJMiHIM1FaRwL89z8iNeaD1RrF
         JsPPoyc73eq14m9glx5dHYOnANn38zyhx3QtXU4gMwDN81A8BwfK4zPqmWsNXIld4uVq
         tATODhbrntVfQYeApJiYcnGzyTMMr+Lo6ZNd3qhc0NR3upUtioBXbHFYLoSaeBDzLuQx
         zG/A==
X-Gm-Message-State: AOAM530iXiisOm1IBN2k7jKjBszL43tYNIOimrovgNtaNVx0la/T9Gah
        EEoy/zVasvVNnstFAfJEZ0LsSy3pbmXL/w==
X-Google-Smtp-Source: ABdhPJyL42D+1JCcBNspsMiCkhYdYUseFBtb3xMtyCEAFn7+ZTOFyOpl5I4sLZHIK2g2O0Mlqp7RNw==
X-Received: by 2002:a5d:9e09:: with SMTP id h9mr14934778ioh.164.1631644284894;
        Tue, 14 Sep 2021 11:31:24 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id z4sm6499903ioj.45.2021.09.14.11.31.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 11:31:24 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id a15so18432729iot.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:31:23 -0700 (PDT)
X-Received: by 2002:a5d:8458:: with SMTP id w24mr14646554ior.168.1631644283448;
 Tue, 14 Sep 2021 11:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210909210032.465570-1-dianders@chromium.org>
 <20210909135838.v4.4.I6103ce2b16e5e5a842b14c7022a034712b434609@changeid> <87ee9r10qw.fsf@intel.com>
In-Reply-To: <87ee9r10qw.fsf@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Sep 2021 11:31:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgLcOBOOp9kgShE4+T8g8UZcO_Ff3hhAbGTyLkdE7HNA@mail.gmail.com>
Message-ID: <CAD=FV=XgLcOBOOp9kgShE4+T8g8UZcO_Ff3hhAbGTyLkdE7HNA@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] drm/edid: Use new encoded panel id style for
 quirks matching
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 14, 2021 at 11:16 AM Jani Nikula
<jani.nikula@linux.intel.com> wrote:
>
> On Thu, 09 Sep 2021, Douglas Anderson <dianders@chromium.org> wrote:
> > In the patch ("drm/edid: Allow the querying/working with the panel ID
> > from the EDID") we introduced a different way of working with the
> > panel ID stored in the EDID. Let's use this new way for the quirks
> > code.
> >
> > Advantages of the new style:
> > * Smaller data structure size. Saves 4 bytes per panel.
> > * Iterate through quirks structure with just "==" instead of strncmp()
> > * In-kernel storage is more similar to what's stored in the EDID
> >   itself making it easier to grok that they are referring to the same
> >   value.
> >
> > The quirk table itself is arguably a bit less readable in the new
> > style but not a ton less and it feels like the above advantages make
> > up for it.
>
> I suppose you could pass vendor as a string to EDID_QUIRK() to retain
> better readability?

I would love to, but I couldn't figure out how to do this and have it
compile! Notably I need the compiler to be able to do math at compile
time to compute the final u32 to store in the init data. I don't think
the compiler can dereference strings (even constant strings) and do
math on the result at compile time.

I _think_ you could make it work with four-character codes (only
specifying 3 characters), AKA single-quoting something like 'AUO' but
I think four-character codes are not dealt with in a standard enough
way between compilers so they're not allowed in Linux.

If you like it better, I could do something like this:

#define ACR_CODE 'A', 'C', 'R'
#define AUO_CODE 'A', 'U', 'O'
...
...

...then I could refer to the #defines...


> Just bikeshedding, really. ;)

I'll take this comment (without any formal tags) as:

* You've seen this patch (and the previous ones) and wouldn't object
to it merging.

* You're not planning on any deeper review / testing, so I shouldn't
wait for more stuff from you before merging. Please yell if this is
not the case. I'm happy to wait but I don't want to wait if no further
review is planned.


In general I'm still planning to give this series at least another
week for comments before merging. ${SUBJECT} patch also is the only
one lacking any type of Review / Ack tags so I'll see if I can find
someone to give it something before merging, too.


-Doug
