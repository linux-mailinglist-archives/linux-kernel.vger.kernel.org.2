Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7F310604
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhBEHnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhBEHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:43:04 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1CFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 23:42:24 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id i71so5856746ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 23:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSpfLkF/ij3s2gh42g+FyW7GPnjIVsUi/InXL83F+CI=;
        b=khu5n8zof/YLgW30jVewG+qIYV8ZJBFd+3TICC0xZsJ6LemvfI5SpqmDdgDVaTIgVo
         WSs7urrfCjqegA/eIQIYgFpYToi00Daufg070GieCRsRa9omiZ7LvH/pvwVJKc6SXpER
         VEa+5JHVV/cTKH/c+uWCOCnQoU0p7BjnYsEN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSpfLkF/ij3s2gh42g+FyW7GPnjIVsUi/InXL83F+CI=;
        b=oLSOvGXWCejZeEcWOoiKbIHR6thGCZjOH6aIilXZ+0ltoqhmXPfdS7HRQt6HD3k5lE
         lIoHvtzkO5qR6j7qe5hDpRqW+U5fW3CkDDcBWO94pmYsxVFUBmD0B5koCVyIOuva/8as
         WexiSlJeSJmXp0Uqo+9SjYPm5NPomDaJXmP4ZoYShbkZemwzp1vCuhAhNXvXLqJmyuNi
         P1UZtEVenyo9bmUxiEbfdUrcG4LDmnG4AnNQvcsIk0VhZf9rVoRm46WAr+sdJv7ujCCR
         N1cwHGtDyeLAtKrQkvDt5ioeJ9pGNJXz9f+kAfa/+pUWXUo2LTaGtT/U9SLrnz/pL4q3
         /Zdw==
X-Gm-Message-State: AOAM530nbgAcfTFTrXsTiI/Eg991vacpeNbdFk2W8GhW86u3DMbBmfOP
        mvBq49AV8+WzAo92EjCACcFKXnzSo+lo26wbu7UnIw==
X-Google-Smtp-Source: ABdhPJyDulVRWRAk44LiiNIGP31VHgLuAf9nUzaPY0lmq8bt2k5sXfIsCIM+MajnNZMD8VhID1SxvEMTGJYuRp+6AhM=
X-Received: by 2002:a25:6ad6:: with SMTP id f205mr4328880ybc.41.1612510943572;
 Thu, 04 Feb 2021 23:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200923121320.v3.3.I6c917ff82a1d2ae2253a3bd4d750d58879387cac@changeid> <a4a9ec24a6d4a646e22fb5c63e285d4d1bb50a0d.camel@redhat.com>
In-Reply-To: <a4a9ec24a6d4a646e22fb5c63e285d4d1bb50a0d.camel@redhat.com>
From:   Sam McNally <sammc@chromium.org>
Date:   Fri, 5 Feb 2021 18:41:46 +1100
Message-ID: <CAJqEsoBtYCSRvjKWMBKPyHV8StXbxvJQeJB1tfYFbyLfmkpW8g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm_dp_mst_topology: export two functions
To:     lyude@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 at 09:03, Lyude Paul <lyude@redhat.com> wrote:
>
> On Wed, 2020-09-23 at 12:13 +1000, Sam McNally wrote:
> > From: Hans Verkuil <hans.verkuil@cisco.com>
> >
> > These are required for the CEC MST support.
> >
> > Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> > Signed-off-by: Sam McNally <sammc@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 6 ++----
> >  include/drm/drm_dp_mst_helper.h       | 4 ++++
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 0d753201adbd..c783a2a1c114 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -62,8 +62,6 @@ struct drm_dp_pending_up_req {
> >  static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
> >                                   char *buf);
> >
> > -static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
> > -
> >  static int drm_dp_dpcd_write_payload(struct drm_dp_mst_topology_mgr *mgr,
> >                                      int id,
> >                                      struct drm_dp_payload *payload);
> > @@ -1864,7 +1862,7 @@ static void drm_dp_mst_topology_get_port(struct
> > drm_dp_mst_port *port)
> >   * drm_dp_mst_topology_try_get_port()
> >   * drm_dp_mst_topology_get_port()
> >   */
> > -static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
> > +void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
>
> Mhhhhhh-can you think of some way around this? I really don't think it's a good
> idea for us to be exposing topology references to things as-is, the thing is
> they're really meant to be used for critical sections in code where it'd become
> very painful to deal with an mst port disappearing from under us. Outside of MST
> helpers, everyone else should be dealing with the expectation that these things
> can disappear as a result of hotplugs at any moment.
>
> Note that we do expose malloc refs, but that's intentional as holding a malloc
> ref to something doesn't cause it to stay around even when it's unplugged - it
> just stops it from being unallocated.
>
>

Yes, it turns out we won't need this after all.

> >  {
> >         topology_ref_history_lock(port->mgr);
> >
> > @@ -1935,7 +1933,7 @@ drm_dp_mst_topology_get_port_validated_locked(struct
> > drm_dp_mst_branch *mstb,
> >         return NULL;
> >  }
> >
> > -static struct drm_dp_mst_port *
> > +struct drm_dp_mst_port *
> >  drm_dp_mst_topology_get_port_validated(struct drm_dp_mst_topology_mgr *mgr,
> >                                        struct drm_dp_mst_port *port)
> >  {
> > diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> > index c7c79e0ced18..d036222e0d64 100644
> > --- a/include/drm/drm_dp_mst_helper.h
> > +++ b/include/drm/drm_dp_mst_helper.h
> > @@ -754,6 +754,10 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
> >                        struct drm_dp_mst_topology_mgr *mgr,
> >                        struct drm_dp_mst_port *port);
> >
> > +struct drm_dp_mst_port *drm_dp_mst_topology_get_port_validated
> > +(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
> > +void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
> > +
> >  struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct
> > drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
> >
> >
>
> --
> Sincerely,
>    Lyude Paul (she/her)
>    Software Engineer at Red Hat
>
> Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
> asked me a question, are waiting for a review/merge on a patch, etc. and I
> haven't responded in a while, please feel free to send me another email to check
> on my status. I don't bite!
>
