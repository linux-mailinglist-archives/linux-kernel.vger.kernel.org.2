Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC06444EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhKDGfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKDGfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:35:03 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC079C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:32:25 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id l43so8970660uad.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXnPAB3AiBWrY7SU8k+mx2QdDTS+Fxkn/CtfTF2GojQ=;
        b=eczselLNEhFBMle12JjPVn4CXc0ejYxMnkpeCQWhy2+uu85TAv5xBPI5w7Sg6KM2v5
         aeJmwjLhWaJcDh8QLY+lAOxBC34RugJQgrPcvPuCXlzhJNDtPdMaY+piD19HHRPFMPhd
         ZDz9C2NmtqaKAzs9A0IBA8ib5nrh19O8rUar/2jeovtwfW8J6NJA2hADuM05Mv2rIPKK
         JXZZObJ5btcIu3rCHrksGMCWtFQFrN+BjxcbNvHvm7WP/s8TRKtEZfUiEvL9drvDcNq1
         +rtm3993TkKiBMe3dcwZkFgV1Ge7hf/s1P7xaPfDaasHx+LvRgdvh/lqQthyxlz9wM2s
         PFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXnPAB3AiBWrY7SU8k+mx2QdDTS+Fxkn/CtfTF2GojQ=;
        b=0Rqn6WOVpw4FNmmA84YX2x0lOAFZqXsYYYci+YHvw1fKbAfszctYdXwGL1kfo6o4Wq
         oPhDzjXuPADAPUTwIIiPkvZR38IYqO3NDLhdbRFPl7i+vC6NJ79Qtkw0mKaocX5lSZL4
         WKp5JrAW5PQgq/XKzupeuvnXOA1oy8xhCReKHm5fE5/iy9uUCz3SAeJwButo7IOTNQLU
         vjOQmImHEIeHGa5RG/h1OE2/uJmo+e7oL7SgCcEwrMMCwOmfKp5tQpyuuzy6P0It0J6b
         VMO2MdCO/tal6N77peWpeeUeTQeGti0Hixr5uoxCqn/s4W7LxUOBK9QNiJLCMdk64jvZ
         IM5A==
X-Gm-Message-State: AOAM531V8WygLRs1de5nV8gvWlKKA0DLQy6venysOuwFLu3xQ8yNa48G
        DTiPdLYbtCgl11aDue2Q49qbVVyFanSojWWbJq4=
X-Google-Smtp-Source: ABdhPJwnwimOYTTmodrLByGFncVyeNmazEftmcNcyXiRSrc+/9K5LypExo+SZI7+7QlNp8TCpTBhp8bDClQJYErw360=
X-Received: by 2002:a9f:234a:: with SMTP id 68mr54022717uae.13.1636007544779;
 Wed, 03 Nov 2021 23:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211027043645.153133-1-jim.cromie@gmail.com> <20211027043645.153133-11-jim.cromie@gmail.com>
 <3a55ab9c-8109-8025-21e3-e3635bd891b2@akamai.com>
In-Reply-To: <3a55ab9c-8109-8025-21e3-e3635bd891b2@akamai.com>
From:   jim.cromie@gmail.com
Date:   Thu, 4 Nov 2021 00:31:58 -0600
Message-ID: <CAJfuBxyMeC5_H-RakOpqH9jDuh07gn4cjCuJ=ebQ8tLQVOTGrg@mail.gmail.com>
Subject: Re: [PATCH v9 10/10] drm: use DEFINE_DYNAMIC_DEBUG_TRACE_CATEGORIES
 bitmap to tracefs
To:     Jason Baron <jbaron@akamai.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 9:58 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 10/27/21 12:36 AM, Jim Cromie wrote:
> > Use new macro to create a sysfs control bitmap knob to control
> > print-to-trace in: /sys/module/drm/parameters/trace
> >
> > todo: reconsider this api, ie a single macro expecting both debug &
> > trace terms (2 each), followed by a single description and the
> > bitmap-spec::
> >
> > Good: declares bitmap once for both interfaces
> >
> > Bad: arg-type/count handling (expecting 4 args) is ugly,
> >      especially preceding the bitmap-init var-args.
> >
>
> Hi Jim,
>
> I agree having the bitmap declared twice seems redundant. But I like having fewer args and not necessarily combining the trace/log variants of
> DEBUG_CATEGORIES. hmmm...what if the DEFINE_DYNAMIC_DEBUG_CATEGORIES() took a pointer to the array of struct dyndbg_bitdesc map[] directly as the
> final argument instead of the __VA_ARGS__? Then, we could just declare the map once?
>

indeed. that seems obvious in retrospect,
thanks for the nudge.

also, Im inclined to (uhm, have now done) bikeshed the API in patch 1,
and  change _CATEGORIES to something else,
maybe  _FMTGRPS
or  _BITGRPS  < -- this one

ISTM better to be explicit wrt the underlying mechanisms, (least surprise)
let users decide the meaning of "CATEGORIES"

also, HEAD~1  added DEFINE_DYNAMIC_DEBUG_CATEGORIES_FLAGS
which could be used directly for both purposes (after a rename).
TLDR: flags exposes the shared nature of the decorator flags,
the trace and syslog customers of pr_debug traffic should agree on their use.

redoing now...




> Thanks,
>
> -Jason
>
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_print.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> > index ce662d0f339b..7b49fbc5e21d 100644
> > --- a/drivers/gpu/drm/drm_print.c
> > +++ b/drivers/gpu/drm/drm_print.c
> > @@ -73,6 +73,25 @@ DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug, __drm_debug,


static mumble-map
> >                               [7] = { DRM_DBG_CAT_LEASE },
> >                               [8] = { DRM_DBG_CAT_DP },
> >                               [9] = { DRM_DBG_CAT_DRMRES });
> > +
> > +#ifdef CONFIG_TRACING
> > +unsigned long __drm_trace;
> > +EXPORT_SYMBOL(__drm_trace);
> > +DEFINE_DYNAMIC_DEBUG_TRACE_CATEGORIES(trace, __drm_trace,
> > +                                   DRM_DEBUG_DESC,

                                mumble-map)
