Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC89A348C97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCYJRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCYJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:16:47 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82173C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:16:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id c16so1451650oib.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXOKWywYABw9gNC/Cfe6LcUrbMnuPsaMy+ZmXW6+jwk=;
        b=VS0a8U0oOPLleG0c1Q1cJZCd6WJNc/wWetmbvouXkWTxkiwqSGZAbHnfyNDbPbXQAz
         jIQtk4leA6dx9wSun9/f0ZbtMH3ncHZ5EQJ3dw552SkTe6WXmaEoJWQR6G+eIsfOx4TS
         Qj00SO7qND7yhQto43yY/IJkGAudEz33CQXuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXOKWywYABw9gNC/Cfe6LcUrbMnuPsaMy+ZmXW6+jwk=;
        b=IMoKQEDYhj+k2hGbIKKBd+4DGTMQYCA//E5WL40B7ysgGCH65C8S8uH259eZy7Bs9/
         qFFUSjTk8NvTM8GmBbUkE06+PwjZnUTeWCQUbDrXgayzZ6HmeQc1xvh3B+uCXpa59Jq1
         2WO4ue8HumTxy/FMYDm70bTT91CpyZolHiY60+pP2oqebTb5w+3rlVOZlLknDBQqqNHA
         4AGQm8dsBYcuPMvCSJ+VlnXtN5crX8NuP3rNICSSU895jL1ZghvI2V0DHdG3bgGE+sSk
         iFFPqjKaVEka+f1SZ1+r8tUVYIESKDI/XdyEY0ylkPsiu9g6ODODMLfajemTbqDunqrE
         hjkA==
X-Gm-Message-State: AOAM531mAPUzvzrSMmEBTUWdkuRHBA9kPAd1qlRhXB4Yo6HByaHHN/sG
        Qzl3IbsJFfL19d090EqMLxklCS6dbjcXjj3wQWR1iw==
X-Google-Smtp-Source: ABdhPJytsJjbKqMJCBkhVZVEz6znKYYwTbAL/6ddw6ajhG9nL40C06B20SHXzBy9ZL4KSWKD22wiqaFfQ7AsZO8Z0Es=
X-Received: by 2002:aca:4188:: with SMTP id o130mr5286825oia.101.1616663806913;
 Thu, 25 Mar 2021 02:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210325061901.851273-1-wanjiabing@vivo.com> <e45d6b24-5e74-17f6-eb18-c6e51fed923a@epam.com>
In-Reply-To: <e45d6b24-5e74-17f6-eb18-c6e51fed923a@epam.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 25 Mar 2021 10:16:35 +0100
Message-ID: <CAKMK7uEpNexmDYar36ZEX0hbHoxH3Y+_D42NqjRwAqxpiCXHRA@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: drm: xen_drm_front_drm_info is declared twice
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kael_w@yeah.net" <kael_w@yeah.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 7:53 AM Oleksandr Andrushchenko
<Oleksandr_Andrushchenko@epam.com> wrote:
>
> Hi,
>
> On 3/25/21 8:19 AM, Wan Jiabing wrote:
> > struct xen_drm_front_drm_info has been declared.
> > Remove the duplicate.
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>
> Thank you for the patch,
>
> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Will apply to drm-misc-next-fixes

drm-misc-next-fixes is the wrong tree, bugfixes outside of the merge
window belong into drm-misc-fixes. Please consult

https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#where-do-i-apply-my-patch

We need to hard-reset drm-misc-next-fixes back, please re-apply the
patches (both of them) to drm-misc-fixes. Also adding drm-misc
maintainers.
-Daniel

>
> Thank you,
>
> Oleksandr
>
> > ---
> >   drivers/gpu/drm/xen/xen_drm_front_conn.h | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.h b/drivers/gpu/drm/xen/xen_drm_front_conn.h
> > index 3adacba9a23b..e5f4314899ee 100644
> > --- a/drivers/gpu/drm/xen/xen_drm_front_conn.h
> > +++ b/drivers/gpu/drm/xen/xen_drm_front_conn.h
> > @@ -16,7 +16,6 @@
> >   struct drm_connector;
> >   struct xen_drm_front_drm_info;
> >
> > -struct xen_drm_front_drm_info;
> >
> >   int xen_drm_front_conn_init(struct xen_drm_front_drm_info *drm_info,
> >                           struct drm_connector *connector);



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
