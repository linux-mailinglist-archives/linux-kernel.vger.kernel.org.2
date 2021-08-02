Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF633DDF6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhHBSlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:41:10 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF967C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:40:59 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id e4so10032820vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JDTciPhpsppEZzll6/Pi+0di+r/qXoRaAHXje8rJcU=;
        b=S3aODv0PgPYOT/8F/bbj3dquc+grd5ZpsnpETdDqus+QDd2kunXjqcW/H3wovrtZ7U
         +p/U+UlX4tS+va3Vh4kEG1jnTdJm/dSxz2OKt0fiETASvNNpHjkhhOtNzXlyK8DLN12v
         kS3rjNgLkrexKp6uqhITyyaNgkWIJlivez5QIAA98ltBCV/OXBpgtJOMZppFm5RyK7Jt
         7nRy1cd1pCvjH1FzxVDLnu4OLtlg+LuAbmUwgY9uWq6zgsay/t2dSTyJCw0No+lgsGBp
         zge03tBYC1O8JzoQev7AiQ9oBKwUCI8SQQ5TcoQRjvuqMJ8DWuwlUJnh8vyqHjkCog1v
         BPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JDTciPhpsppEZzll6/Pi+0di+r/qXoRaAHXje8rJcU=;
        b=gHIFTIQyT6Cpt0rtq96N9ibdsh+UwOCjWeP2N+F2fLZvcNJ9tc1+iId/xVLmV2hloX
         sFryoPnoVsD6o0dWLG9H4GnZcw7+zzEiUBCIrsgPp6avQ7vhQN/Ttyt+0gBJ+SlnrRwV
         aFcUaBT8FiL3AZ0f0PATXb+A5wLFQZU22zDNZce/5cPjaHvNVe3FSi5somSiIyzC+Ll3
         +hQccW8WRWQQHTXdWjOxjouPU/hmeJpfyO0V9Swl1lC6hx2T5on95jpokcLbgEe5Unhq
         BsV5paWtOr45XjT7RXxQP9ohnxqX6KZD0BMrNxOsWlHp+t9irP30qSOwInWT5GsR4VuD
         GIfQ==
X-Gm-Message-State: AOAM533tHfL0VugkcwWtyABGr7nAJQ5zsLvtuqM2eRH5SSfH925NkoU3
        oXPlJCigfjxeADqniS7n7mY+UVoWwKYdqTVjq3k=
X-Google-Smtp-Source: ABdhPJzaPWXcRFrinBModzRbebP+orB2U9FIw0YukoKvhxHaw/U/+j7xcsCnnRbrJfcujheOgU/OYeK28C0hEWg237I=
X-Received: by 2002:a05:6102:2325:: with SMTP id b5mr7459900vsa.56.1627929658962;
 Mon, 02 Aug 2021 11:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210731214211.657280-1-jim.cromie@gmail.com> <20210731214211.657280-4-jim.cromie@gmail.com>
 <CACvgo509FWgNcBP9SPyuZV0Wey9sApmgB2Xa_+LJ4r91Cgqhgg@mail.gmail.com>
In-Reply-To: <CACvgo509FWgNcBP9SPyuZV0Wey9sApmgB2Xa_+LJ4r91Cgqhgg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 2 Aug 2021 12:40:32 -0600
Message-ID: <CAJfuBxzbKKnjfw72GVy531TOQjd9znqkoxOq_UTRZyxOyxXPXg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v4 3/7] dyndbg: add dyndbg-bitmap definer and callbacks
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 10:24 AM Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> Hi Jim,
>
> On Sat, 31 Jul 2021 at 22:42, Jim Cromie <jim.cromie@gmail.com> wrote:
>
> > +struct dyndbg_bitdesc {
> > +       /* bitpos is inferred from index in containing array */
> > +       char *prefix;
> > +       char *help;
> AFAICT these two should also be constant, right?
>
>
> > +int param_set_dyndbg(const char *instr, const struct kernel_param *kp)
> > +{
> > +       unsigned int val;
> > +       unsigned long changes, result;
> > +       int rc, chgct = 0, totct = 0, bitpos, bitsmax;
> > +       char query[OUR_QUERY_SIZE];
> > +       struct dyndbg_bitdesc *bitmap = (struct dyndbg_bitdesc *) kp->data;
> > +
> > +       // pr_info("set_dyndbg: instr: %s curr: %d\n", instr, *kp->arg);
> Left-over debug code, here and below?

yup, all fixed up locally, with a version that fully works.
thanks.

>
> -Emil
