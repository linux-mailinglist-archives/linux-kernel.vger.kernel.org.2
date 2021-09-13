Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15216409990
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbhIMQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhIMQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:42:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55202C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:41:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r3so18436050ljc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEgn/zBUCAYLpfQi4V6xIhWmiywfHNfRtMEnwO6kR+c=;
        b=syDyX7vgd0a0s0H8E39DhdZAxxIacRGmImxZXPDkqrsFtuRdtZ01nc7oe6QkiK7+kF
         9AO+KH8UbGbL3V7FT3Ua1GNtC+Oqfy81iaYdeZQda2WHE9WE91MM+TrlUUljGjPFP/iy
         OfKPLyTPMSMJLH7KkBvSf4QmVWSfWCE7LkZjGqHuzLJpD99IzLkzz1tC7wNRkkBNr1fs
         iVZm2d807al1PKNfLkShegkP7FCmW34W1Cor9RwrItg3Udt3yPx7WptLAaU4a9qjRcgy
         I3ZMgZzVBY5nwcfJPFVB+fDMteiMcdiKm4g32qySvuthLfEensi7DTOmc+1ReI8Tuc+2
         CbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEgn/zBUCAYLpfQi4V6xIhWmiywfHNfRtMEnwO6kR+c=;
        b=syW/fvLCxEmcjAq7jU2LQ8hj6QeiC6u73qO2vxGQvZ2b9QJ4fVPG9WXfP9NUmwDywn
         mg3yEbvYx79JtzkiFmB9FM4Fu27sHGY1c/FcXWB8oUmRd++CR4upxw+yycy+ahLtu5rC
         SoepbNKn9UAabyjVz6sBRrFTV7tnz1Lwl3WOfSqf9W3Z/5YrdQsnh4I7bHBQrb7jTavH
         lz1mfIp8gQ2sJ0rVgIA7+hNzg0ls6donNoNxC7d6WT8nsc3EHWTldRKpRmOL405pZI2g
         4rJ+ppFxVe21QZSakarXwln0Q8+vfvuOTR9dUjuGzGaSqxX1pqFfXgGUCno5IyUOFxgV
         jwFw==
X-Gm-Message-State: AOAM531rtydX5DxYZ/2YlgByqdvRoER41avOAHErV0N+3WlNMwxSpa1Y
        h5rbx3ee7Y3uqNelop0z8jxnBnPmD7zayAIGiYsrbQ==
X-Google-Smtp-Source: ABdhPJw1F3Ec/Nrf+cKOsxps+U6oWgomqVmy/xP75QvywM17PB0ypAtnETT5CAR4/ekwkaBNqOPOHa0pLsjdau9tK+E=
X-Received: by 2002:a2e:9ed9:: with SMTP id h25mr11034279ljk.40.1631551278401;
 Mon, 13 Sep 2021 09:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020> <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com> <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com> <20210912132914.GA56674@shbuild999.sh.intel.com>
In-Reply-To: <20210912132914.GA56674@shbuild999.sh.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Sep 2021 09:41:06 -0700
Message-ID: <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 6:29 AM Feng Tang <feng.tang@intel.com> wrote:
>
> On Sun, Sep 12, 2021 at 07:17:56PM +0800, Hillf Danton wrote:
> [...]
> > > +// if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
> > > +   if (!(__this_cpu_inc_return(stats_flush_threshold) % 128))
> > >             queue_work(system_unbound_wq, &stats_flush_work);
> > >  }
> >
> > Hi Feng,
> >
> > Would you please check if it helps fix the regression to avoid queuing a
> > queued work by adding and checking an atomic counter.
>
> Hi Hillf,
>
> I just tested your patch, and it didn't recover the regression, but
> just reduced it from -14% to around -13%, similar to the patch
> increasing the batch charge number.
>

Thanks Hillf for taking a look and Feng for running the test.

This shows that parallel calls to queue_work() is not the issue (there
is already a test and set at the start of queue_work()) but the actual
work done by queue_work() is costly for this code path.

I wrote a simple anon page fault nohuge c program, profiled it and it
seems like queue_work() is significant enough.

   - 51.00% do_anonymous_page
      + 16.68% alloc_pages_vma
        11.61% _raw_spin_lock
      + 10.26% mem_cgroup_charge
      - 5.25% lru_cache_add_inactive_or_unevictable
         - 4.48% __pagevec_lru_add
            - 3.71% __pagevec_lru_add_fn
               - 1.74% __mod_lruvec_state
                  - 1.60% __mod_memcg_lruvec_state
                     - 1.35% queue_work_on
                        - __queue_work
                           - 0.93% wake_up_process
                              - try_to_wake_up
                                 - 0.82% ttwu_queue
                                      0.61% ttwu_do_activate
      - 2.97% page_add_new_anon_rmap
         - 2.68% __mod_lruvec_page_state
            - 2.48% __mod_memcg_lruvec_state
               - 1.67% queue_work_on
                  - 1.53% __queue_work
                     - 1.25% wake_up_process
                        - try_to_wake_up
                           - 0.94% ttwu_queue
                              + 0.70% ttwu_do_activate
                 0.61% cgroup_rstat_updated
        2.10% rcu_read_unlock_strict
        1.40% cgroup_throttle_swaprate

However when I switch the batch size to 128, it goes away.

Feng, do you see any change with 128 batch size for aim7 benchmark?
