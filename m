Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B20D34103C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 23:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhCRWNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 18:13:36 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:39710 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCRWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 18:13:30 -0400
Received: by mail-io1-f42.google.com with SMTP id v17so3988652iot.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 15:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HaptGymR4HUOwxLozKPr7kvb5gQ52Lg7qMvwGbqUcM=;
        b=Np4OP8W/1fsnI0O26zXqUJcixfN0Z+/iCHfLi3cL0FbtW7gL5fKoIgDrscBLRMN0Kv
         PuXvV/unz7VjodX5QQoCcVT0Ry4Quo6yqs6Jtq+4w1m7NTlSPgqhujFCdLI2ma+QF4Sp
         lyU2oarOikOOgKnZuaqHgwF0w9AiKFDESV+MD5XWRKMnA7j/spyNcGr2ZLgC/CxV4HZf
         QmdjRIOkcMC1DftVYFO5dQcHOph0LWI2YS/wgNxCVnmFiJouSsgt79GK1UgBUhfwuKv5
         jWuMqnrMAchPAeNrNrtDMrqbIGuOsLTRwaF4hF7SV/nZBjuzh3nfrUgRtaNKGaBZPVT7
         royQ==
X-Gm-Message-State: AOAM5314sLzKK0ts24Zi8CUAJ/vCZ7xUmdss+QeoeuoJ+LQcC+wf5ZQt
        v3OF2gR7aBiVGb/N7xnTKr/HHrpENrxvG+HNPGo=
X-Google-Smtp-Source: ABdhPJzimODivNmwJaUshkKgqrcjmqOF6+4Kx/whpZFqBBwNy4oMZMDvYwBQF1nFpKOUPKPriy9wpbI7GKUegZDKJZs=
X-Received: by 2002:a05:6638:635:: with SMTP id h21mr8593715jar.97.1616105610156;
 Thu, 18 Mar 2021 15:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210318215545.901756-1-lyude@redhat.com>
In-Reply-To: <20210318215545.901756-1-lyude@redhat.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 18 Mar 2021 18:13:19 -0400
Message-ID: <CAKb7UviTpAva-kc4-=1oCV_CxHJrZE7mWec0rNrgQ4r-RG8e7w@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms/nv50-: Check plane size for
 cursors, not fb size
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Peres <martin.peres@mupuf.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 5:56 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Found this while trying to make some changes to the kms_cursor_crc test.
> curs507a_acquire checks that the width and height of the cursor framebuffer
> are equal (asyw->image.{w,h}). This is actually wrong though, as we only
> want to be concerned that the actual width/height of the plane are the
> same. It's fine if we scan out from an fb that's slightly larger than the
> cursor plane (in fact, some igt tests actually do this).

How so? The scanout engine expects the data to be packed. Height can
be larger, but width has to match.

  -ilia
