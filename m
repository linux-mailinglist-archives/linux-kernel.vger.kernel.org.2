Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D53D3181
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhGWBXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhGWBXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:23:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE18C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 19:04:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v6so11487407lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWU9VPUi87pNrXCcR4PCrzd/Kzrus891hORmT5PC+zM=;
        b=eGNdTCrx6valxUE5ycbThNR4R02XvSCraZrOHIJQ3+uqYxLGjXSsd22UWXr8N8UOPD
         pTfRBCs/s/EKxTP63S4eW3pg+ooV0Y0g5l6l2r6t0UIosBihxBzwuMctSG+1emfQCfSE
         px9lck/vGt9WgFrHHUB99tl86i/uxoPbCAIgVSVpr/+N6v6cSOq37fum8aRsrqO7ACZJ
         nTK2PdPZtydq9eYLRimByBEr+6baMS+91ckZZ/T+wduT5gQD9zre78+/Eu79TJsACHbw
         ct2HMQmLl83gfQCVoDTYqZOIgZfE8fsaRlcVKLmHNhSi+3LRiz9+fY4hm+TfpU8IS/Kw
         5qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWU9VPUi87pNrXCcR4PCrzd/Kzrus891hORmT5PC+zM=;
        b=tFEIGM6xOvbuwVyC5P7Ww2sa4Zp/Ao1QhH7feMEGHVJpb9YrENHtbmEmiugacoacV2
         H9kS0wxOxn/tEHrnApnZXhllaQHEGd1f2KQ3+ie0prsz31epD6fpEzM6jweX77JXCa57
         jmGLx4d4r4XxRCLwiFYqaDLrCbLcF9z8L3KhA8HZpqYfuQ0jTAGHrT25WCKWux3YMihP
         xGNLp/QsqXMT6frBZnQd3gFfnG6pENlRPuQWWjKi0KT3sCJbilEtZUcUOJtfF/KFP5Wc
         g+gSqkEb7zAMNSzA1ryddNm++9YIO7aAHGUa6XmcBS+Bd3pi/SdabNVj44ZdZG8SeyUH
         OsXA==
X-Gm-Message-State: AOAM531INfEif2vybXQJgFQRIZBDVfHXuPRQ9T7ixwRAUbCc4m7ECMXT
        23sQARkvhUOKah6tjG0PLKINN7FXeb8UTU3IG22FuA==
X-Google-Smtp-Source: ABdhPJyBmT6ZL/CfKLSg3rGD/pmyxU4+PR/Rv/FDU5r/DAMR4iBuE7Qg4ScYmuWcXBXaW8hLAfCfxGHev47wUrR2oFI=
X-Received: by 2002:a19:e053:: with SMTP id g19mr1426820lfj.83.1627005847018;
 Thu, 22 Jul 2021 19:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com>
In-Reply-To: <20210723011436.60960-1-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Jul 2021 19:03:56 -0700
Message-ID: <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>, jengelh@inai.de,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 6:14 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
[...]
> +
> +       mmap_read_lock(mm);

How about mmap_read_trylock(mm) and return -EAGAIN on failure?


> +       if (!__oom_reap_task_mm(mm))
> +               ret = -EAGAIN;
> +       mmap_read_unlock(mm);
> +
