Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99D8454F72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbhKQVkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhKQVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:40:16 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A02C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:37:17 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 7so9312256oip.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6s2y1fTtS8lf6NP+/c4Jj61w5cSCKIlT27IH4NZh8QY=;
        b=IzY64stNZSLG1jDnQarZT7E46remPFZ029D4S/vqqHEmD8VdCjr14Z3AcNv2AxIn3/
         UERbzYUIueJ9g5p26p7z0J3l+NTHYiB5wqouskDkVQwIiK5CmEbFy52Z03/rSc2qNf5K
         A94sZTzv9jrfUD7eoRjbvyInwpfHa6D7BngkfpgHy1JLKEVSgdKTFmVMaBUgEjUQHVB1
         Mcm04hz14NnzO0qzLtGwBbhU8lm9QS+OB5Liz6wnjs9mrtbpNmjmiZGJoqWQ9xO5FrPy
         hhokYy/HmWtCnnp/5TbMPAu/rnpucLtLbRC7flysMbBdBbpsATf1RHMgS1Ja7QGU4x4d
         vVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6s2y1fTtS8lf6NP+/c4Jj61w5cSCKIlT27IH4NZh8QY=;
        b=LyAj+caFUdo5xGchZOJOkvOJJIayiPNj/HJKcw5EcUPHCnrQIrZ+M7TrV73nXCM1Ke
         lAMWRc1ctDNcs6x8cCl0zUKISRLJfEmXAFsR91q8KotcIoSY4pEPscQ3kmIUWMuK3xvZ
         FqJPWY7x2MSTMoTGLTQey9cz4nmWCZ9fi169McFMRRekPztpEswsc20kLvFcI1/MVkWV
         wms9Ckgbcw+26BovMXwybj0WKf2jADKO2HUofMewEo84CGB+c9T1RyOjEI9OXURt/V/j
         TK6Wg7HI10fpx9yUDpQN7jMvgqg3MRe3oUwwBCzGC4k6MEdCuojR9th39q6reRjxkhBG
         uzBg==
X-Gm-Message-State: AOAM530S7DjxWpfy2Md9idDf0C3S7Rx4gz4WqGFq0DUY0Vy2fQs7hqlb
        8CpWuSBY2A01ptp6jzHLezdTJHEVgMGS9RX8xtE=
X-Google-Smtp-Source: ABdhPJxRBhq8/gv8eMPKGOit+nrmHWfUJX84g36vbajBhRrGeBC4A7eR2tqOn3eN842fWjlV1756/kPkDXA0fJuG49E=
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr2874414oic.123.1637185036704;
 Wed, 17 Nov 2021 13:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20211116013438.26517-1-bernard@vivo.com> <88328288-ef1f-ef8b-987f-43dc8dc69ee7@gmail.com>
In-Reply-To: <88328288-ef1f-ef8b-987f-43dc8dc69ee7@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 17 Nov 2021 16:37:05 -0500
Message-ID: <CADnq5_O+A8WaZv_+avrmvzt9Jjr7vwkYqnZx7-wkNtzRx0pc9A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: cleanup the code a bit
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Nov 16, 2021 at 4:19 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 16.11.21 um 02:34 schrieb Bernard Zhao:
> > In function dc_sink_destruct, kfree will check pointer, no need
> > to check again.
> > This change is to cleanup the code a bit.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> This one and the other patch are Acked-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_sink.c | 10 +---------
> >   1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_sink.c
> > index a249a0e5edd0..4b5e4d8e7735 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
> > @@ -33,14 +33,6 @@
> >    * Private functions
> >    ********************************************************************=
**********/
> >
> > -static void dc_sink_destruct(struct dc_sink *sink)
> > -{
> > -     if (sink->dc_container_id) {
> > -             kfree(sink->dc_container_id);
> > -             sink->dc_container_id =3D NULL;
> > -     }
> > -}
> > -
> >   static bool dc_sink_construct(struct dc_sink *sink, const struct dc_s=
ink_init_data *init_params)
> >   {
> >
> > @@ -75,7 +67,7 @@ void dc_sink_retain(struct dc_sink *sink)
> >   static void dc_sink_free(struct kref *kref)
> >   {
> >       struct dc_sink *sink =3D container_of(kref, struct dc_sink, refco=
unt);
> > -     dc_sink_destruct(sink);
> > +     kfree(sink->dc_container_id);
> >       kfree(sink);
> >   }
> >
>
