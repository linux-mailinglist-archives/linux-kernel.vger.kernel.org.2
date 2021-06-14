Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395193A6E96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhFNTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhFNTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:11:40 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96410C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:09:34 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id az3so4396679vkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMc4URnnV+tfXvNhamKWfB2liJJVFr5aYUr1EsM52gA=;
        b=tiKwMdAaMX3CQD5jTxTChA0MD3dY/jEv8DUJFllkv59ExYYvlbiw3kXxGb7/PN0gkH
         kt0rlzo0k+xB/ol8V+Gwx/CIW1KIEr40B5NxaGGDPQh4QmB8O2zvUCs9sMAOervWV5QU
         jmXeCa7C8zFqEzkESA32yxjXRePmNFbStsAe7yulacEN85HJWKd5/GGfgtdejSHiWgXN
         5Ji4Ia+M2zaVyvO3w7WP9ofssgfOfQ9rDTg+fWZO1BrOLdWwZ1XCScm5dpjTyEIZseI5
         b9yoiIoo7P93rKELTQPxXqQOdeFyVFuCuObfAhnpWHer2MKf5+/gTpJY33q+gpgkkusw
         3nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMc4URnnV+tfXvNhamKWfB2liJJVFr5aYUr1EsM52gA=;
        b=sJQ/VfQFYrQ8327Vpfg2dT8PsBeGVnKZPdwUFb11oHkI2HSNI4Iw+Uqn6FjB3+6kG1
         T1IQ9kT0eVhOpBfaiOyPU9eMidTuJtBVNbrnlZwMWfuL8PWa7G24BJEz7gbGiSMSUCkC
         3jR+i/8LRZNPlTu1hG6p+XEvyN4jCRupmoFFsfmUK6/2rzu1k2QM0thd6txPpyx2nHdc
         3XQpRfl7Ipk/BsP+PWjD4qHvzzsZZn0eMCH6H3m1R73BqqqDxkwefbg8oMyZaBCLSeX7
         qVRpVBUUSLbRj2Uz2uPqBduXA45IEZFwjoC1awlr0NjQBxpgzCi5EMgJ0sigX9KAZSVK
         zsIQ==
X-Gm-Message-State: AOAM531E2SCaD2hFk1TWbGu+TFC4kvQU9puzxVumVwislkeJ2s0GSoc1
        yqQAk6/BmyARJzHyPe0l8WcF1jF7mwIT5RRTONY=
X-Google-Smtp-Source: ABdhPJxNPk2Ta8ZZVvy0EEGmzM9l4SHEbYT66VTYgFz6piDBUXdGTwFY1Ytf6VseBiX971f4q0QCfFpWPyVZyaci6ek=
X-Received: by 2002:a1f:4594:: with SMTP id s142mr542586vka.16.1623697773669;
 Mon, 14 Jun 2021 12:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210612125426.6451-1-desmondcheongzx@gmail.com> <20210612125426.6451-2-desmondcheongzx@gmail.com>
In-Reply-To: <20210612125426.6451-2-desmondcheongzx@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 14 Jun 2021 20:09:22 +0100
Message-ID: <CACvgo50kL=0dz6Jpt5BDLXYq+XTMhMy9=Pu7qeqDmsy_bgKsdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: Add a locked version of drm_is_current_master
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 at 13:55, Desmond Cheong Zhi Xi
<desmondcheongzx@gmail.com> wrote:
>
> While checking the master status of the DRM file in
> drm_is_current_master(), the device's master mutex should be
> held. Without the mutex, the pointer fpriv->master may be freed
> concurrently by another process calling drm_setmaster_ioctl(). This
> could lead to use-after-free errors when the pointer is subsequently
> dereferenced in drm_lease_owner().
>
> The callers of drm_is_current_master() from drm_auth.c hold the
> device's master mutex, but external callers do not. Hence, we implement
> drm_is_current_master_locked() to be used within drm_auth.c, and
> modify drm_is_current_master() to grab the device's master mutex
> before checking the master status.
>
> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

-Emil
