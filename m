Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF8330E55D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhBCV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhBCV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:59:12 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00032C061786
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 13:58:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so707543pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 13:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:to:date:message-id:user-agent;
        bh=NZyBJaM1wJYJrM3N9nWdphIUZzNaZF7K0cw+Alsw60s=;
        b=YuOUTknzG6QCCWY+6/9xwyK6R03ljdXy/eo0oFI/N+6GwosnDa5CyqQSfRHomVRq5Y
         /QU7kuuwvyKHdo8lw5/0kfKeynARxii+bcfHMWHLjs9pAUBAC1hEJdjvZFQ4lTU08YcK
         JPPSVfydjzgAxHpwSzs/Slc3zbOWlaxSXZv/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:to:date:message-id:user-agent;
        bh=NZyBJaM1wJYJrM3N9nWdphIUZzNaZF7K0cw+Alsw60s=;
        b=s7H32sW6z3zEhs55qoPaqiQi5zd+UN0qwac9l/udWRLJ2qbaFw46DiSB0FWs6yWex6
         Myg7dA6kSXSZMG8E3v8f+eo5GpEZnC3d29U1Q1j5w3/2PB4XcR0lR9/64q1DVV1Nkzwo
         vR79umex/KorI+9LDtTp7BoR9e8uzCu/Z+14OFXOj/KefHLljZiigwLC20hzaAiC2YZm
         khGLLJjMOJiNork0iwO7sluL748IFsEq4RnuENrxmTbQqyJqZK5lk3HYvUSfzcqUrkLm
         Facap87RpHVDfATwd/DstrK9WgxBp5k+6BFBPtPu9Vk6ghKmQowyZqyg2GfX/IZs5vuT
         w5jw==
X-Gm-Message-State: AOAM531pkGxfQGnMDxOHXBfgHzEH1qt8+rYI278T/q+l87GrXH5oT1Fk
        2FvrDpPl0AS1Gw5wFsRCbv12h7vB3kW6Lg==
X-Google-Smtp-Source: ABdhPJzk7PmvKQQrV2P9s6wrj8xy2r8VnWspZmZ4jUzlRnhKwjl19rpVf2Q70wAcSJtijokb8iTr1w==
X-Received: by 2002:a65:6207:: with SMTP id d7mr6025724pgv.92.1612389511562;
        Wed, 03 Feb 2021 13:58:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id o20sm3953813pgn.6.2021.02.03.13.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:58:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAF6AEGvTrfYYTfReGbAm9zcBNhjZvX0tko4kZUeQcyNZv4cM6w@mail.gmail.com>
References: <20210125234901.2730699-1-swboyd@chromium.org> <YBlz8Go2DseRWuOa@phenom.ffwll.local> <CAF6AEGuWhGuzxsBquj-WLSwa83r+zO7jAQ9ten2m+2KtoGpYSw@mail.gmail.com> <YBp2h2cVXrF6lBno@phenom.ffwll.local> <CAF6AEGvTrfYYTfReGbAm9zcBNhjZvX0tko4kZUeQcyNZv4cM6w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/kms: Make a lock_class_key for each crtc mutex
From:   Stephen Boyd <swboyd@chromium.org>
To:     Krishna Manikandan <mkrishn@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Date:   Wed, 03 Feb 2021 13:58:28 -0800
Message-ID: <161238950899.76967.16385691346035591773@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2021-02-03 09:29:09)
> On Wed, Feb 3, 2021 at 2:10 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Feb 02, 2021 at 08:51:25AM -0800, Rob Clark wrote:
> > > On Tue, Feb 2, 2021 at 7:46 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Mon, Jan 25, 2021 at 03:49:01PM -0800, Stephen Boyd wrote:
> > > > > This is because lockdep thinks all the locks taken in lock_crtcs(=
) are
> > > > > the same lock, when they actually aren't. That's because we call
> > > > > mutex_init() in msm_kms_init() and that assigns on static key for=
 every
> > > > > lock initialized in this loop. Let's allocate a dynamic number of
> > > > > lock_class_keys and assign them to each lock so that lockdep can =
figure
> > > > > out an AA deadlock isn't possible here.
> > > > >
> > > > > Fixes: b3d91800d9ac ("drm/msm: Fix race condition in msm driver w=
ith async layer updates")
> > > > > Cc: Krishna Manikandan <mkrishn@codeaurora.org>
> > > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > >
> > > > This smells like throwing more bad after initial bad code ...
> > > >
> > > > First a rant: https://blog.ffwll.ch/2020/08/lockdep-false-positives=
.html
> >
> > Some technical on the patch itself: I think you want
> > mutex_lock_nested(crtc->lock, drm_crtc_index(crtc)), not your own locki=
ng
> > classes hand-rolled. It's defacto the same, but much more obviously
> > correct since self-documenting.
>=20
> hmm, yeah, that is a bit cleaner.. but this patch is already on
> msm-next, maybe I'll add a patch on top to change it

How many CRTCs are there? The subclass number tops out at 8, per
MAX_LOCKDEP_SUBCLASSES so if we have more than that many bits possible
then it will fail.
