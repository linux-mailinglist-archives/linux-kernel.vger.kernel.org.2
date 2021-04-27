Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51636CDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbhD0Vy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhD0Vy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:54:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:53:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so7583517wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkeYn6z2BUHqc6XgfJVYCdk+CBeiH5WfHZBBMCqIsd8=;
        b=CXTtKQxiQiQlPcygDiVfZWQC46DNLLBJObC0TOy/PMhajxmqTTsPGA7cETgaFPDwX5
         GQPIkRPGM9Nux7l611NMUTp3K619UgqqFlcTzMCoI28bq41GeYBg6Yq8cvBvdC6kjLTR
         m4asNcWn2QkbUarnItOCoq9VGULm74SbbYUKWHcJPh6Uj4aXg1lMmKbBW5pO5WoWvjEQ
         WBPliGVdR8mYrew5wtOT4lOUpldElagdVixCLtIu0a0bofeFG2boVjyR1UCSHHgMG7PY
         Z5t41kCfUtfvoRp+qonTBdPvEwbphT1LAIqoPZu1CwWNOP8dMTweGWdC9UWPruAwbJT3
         HpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkeYn6z2BUHqc6XgfJVYCdk+CBeiH5WfHZBBMCqIsd8=;
        b=Pw8G2UjcRkDG/GclVZowbDzEQECtJYJnQrDPTZMJIi9FdwRY6MvNj0iCP+VAaIPaBM
         UHeQdb9UjH8T+HQCOSkwZWe6x5QB5DzscYvPSjlWyq8k8IV2F/y22G08OsxHBMIs4rYy
         4P2H5aoaLFOaF9rWgWALOi/Ek7JXs2D3syVXEPTW1tuLihV/dv1ac6bmcF1lgqMbWeNv
         rBCXbTyim8onSSvYrcd8fXtoLZA2jnUz6PIih2ohO2N8PKEI1isjetiKuH2UDnC1Bto1
         JCrh/40dKZ3s3ngkWCdPPYSv3hb3axBDTijSS9nh1kXB0ZT14Esbkip3gop1qdh3zmEh
         9tEw==
X-Gm-Message-State: AOAM532kB08+GhaTTfNxC8tYsa+mEdhruAvfWx+kck5bLesbwgR5Wabx
        pgdx8SzFIw3lvBrKpUheraH9RWDu6TOyH9SZYnd1bxyJ5WGkFQ==
X-Google-Smtp-Source: ABdhPJyHGsL3KmpAfSaHNTMd/82i1F6+cRwRM+m0o47w93z03zyUiCl1luS9cH63JNPu8Igut5psCN9xqMWFtr9zb48=
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr27976698wmh.48.1619560421639;
 Tue, 27 Apr 2021 14:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <7a0fecab-f9e1-ad39-d55e-01e574a35484@linux.intel.com> <YIMsykToLKUVMWbZ@google.com>
 <87fszfxk89.fsf@yhuang6-desk1.ccr.corp.intel.com>
In-Reply-To: <87fszfxk89.fsf@yhuang6-desk1.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 27 Apr 2021 15:53:30 -0600
Message-ID: <CAOUHufYa79naFrai3T5Tkd+TW4Lvk3PUzeeg68mhZ_1M7Pe2jQ@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     "Huang, Ying" <ying.huang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 6:48 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
> [snip]
>
> > @@ -2966,13 +2938,20 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
> >                       /* need some check for avoid more shrink_zone() */
> >               }
> >
> > -             /* See comment about same check for global reclaim above */
> > -             if (zone->zone_pgdat == last_pgdat)
> > -                     continue;
> > -             last_pgdat = zone->zone_pgdat;
> >               shrink_node(zone->zone_pgdat, sc);
> >       }
> >
> > +     if (last_pgdat)
> > +             atomic_dec(&last_pgdat->nr_reclaimers);
> > +     else if (should_retry) {
> > +             /* wait a bit for the reclaimer. */
> > +             if (!schedule_timeout_killable(HZ / 10))
>
> Once we reached here, even accidentally, the caller needs to sleep at
> least 100ms.  How about use a semaphore for pgdat->nr_reclaimers?  Then
> the sleeper can be waken up when the resource is considered enough.

Yeah, that sounds good to me. I guess we will have to wait and see the
test result from Zhengjun.

Thanks.
