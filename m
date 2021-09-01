Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFDE3FE45C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhIAVA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhIAVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:00:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4039FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:00:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m2so735952wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FjeZ4dlBjB70RlRBxV6Srwhf3xdbtXfhDi5m412yaQw=;
        b=q1biW8AeA7Ooox76RYpSXEBDIRelue7d6rT0ovjCORVu+WZvbmUGIyhKYb/bf61Mwv
         naCX4uIrZIGWUsb9GjoedI3QYLGIhYEtKRhmrC4Pr0BnhTxcf+zTYceOwcic6a/cmgie
         67/dwh0OECt4TT+cH8obFPFSlylryxK24wGSuhKAnxHJsg7CIeVWXVNxFwRoy8HI9OUb
         w/C/IECjihHd7kZJKNeQQxc+sJna7CS0shfw+DE8Ch5Ob7wB5XVHwMn3Lb3mC4z3QXUa
         7/TNHMhBH6U/DrlkSBF+SnACE+BiXWJX16pQklG0sHLLtu0OcDuPFYze/r1vXQB+Ud1h
         DsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjeZ4dlBjB70RlRBxV6Srwhf3xdbtXfhDi5m412yaQw=;
        b=dyAPpSc5YVBqURB5kL42ItrFt+nD/iDGb31dFbuC3AJMpazdZlBK7RSI42IxhWcaDx
         fSphJ/1gleK9MUKcuuuyxU9GKD1fVEhIrfrHGqZD7obBruQ0xNmi9nrQfqhbKVENgbtW
         ieZ54rbzsWS3pZoZzueobO5BZupDo+Vv5imMqCVA23M/mo+zCnbBfz4xhfJ/Mg9nD1D1
         YiMzX6xEfRdsey4eYcp3AnUo/uSXQoQtKJ4nd15owOVzJZImVgeecBcQJySfPowH56KH
         mmNHMQYjdbaQ53uAJT3uOiT74jzbbnelHRMeVk/o2bQw/CFireyFsxkL6iNqWvkoyXJj
         4MUw==
X-Gm-Message-State: AOAM530/NHlKfHU0TmraUs8ZehhFEUvTJaqHyw5x537ou+NwLZ1NfXDm
        sX+vGc7OdCtMRv8fBYp0pBm0rek0hHaPTg==
X-Google-Smtp-Source: ABdhPJysn9IAfw6kPJJTaw1OmEQXr3M0uQxEHOUHBYTGapBJAsFQVmPx3QfXXoQPLTf3DZhKmasFpw==
X-Received: by 2002:a05:600c:210a:: with SMTP id u10mr1267894wml.127.1630529998821;
        Wed, 01 Sep 2021 13:59:58 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id o26sm553804wmc.17.2021.09.01.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:59:58 -0700 (PDT)
Date:   Wed, 1 Sep 2021 21:59:56 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        Larry.Finger@lwfinger.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [GIT PULL] Staging / IIO driver changes for 5.15-rc1
Message-ID: <YS/pzJCV8MiwOPRB@equinox>
References: <YS+LXqoDGk0CqU1Q@kroah.com>
 <CAHk-=whqN1gAZk0ZD_4JxGemdbpnQkDaNFY9MjW==v-kb1J-fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqN1gAZk0ZD_4JxGemdbpnQkDaNFY9MjW==v-kb1J-fw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:49:47AM -0700, Linus Torvalds wrote:
> On Wed, Sep 1, 2021 at 7:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Lots of churn in some staging drivers, we dropped the "old" rtl8188eu
> > driver and replaced it with a newer version of the driver that had been
> > maintained out-of-tree by Larry with the end goal of actually being able
> > to get this driver out of staging eventually.  Despite that driver being
> > "newer" the line count of this pull request is going up.
> 
> Ugh.
> 
> So this had a conflict with the networking tree, and commit
> 89939e890605 ("staging: rtlwifi: use siocdevprivate") in particular.
> 
> Ok, so that conflict looked annoying but harmless - git saw the new
> driver as a rename of the old one, and tried to actually apply the
> changes from that commit to the new one.
> 
> And git actually did a reasonable job, everything considered. There
> were enough similarities that it wasn't entirely crazy, and enough
> differences that it caused conflicts.
> 
> HOWEVER.
> 
> Actually then looking at the root causes of the conflicts, as part of
> just trying to finish what git had started, I notice that a lot of the
> code in the new driver was just completely dead.
> 
> As of commit ae7471cae00a ("staging: r8188eu: remove rtw_ioctl
> function") the only caller of rtw_android_priv_cmd() is entirely gone.
> 
> But rtw_android_priv_cmd() was kept around, and was in fact the only
> reason that the files
> 
>     drivers/staging/r8188eu/include/rtw_android.h
>     drivers/staging/r8188eu/os_dep/rtw_android.c
> 
> existed at all.
> 
> End result: instead of trying to fix up the conflict in dead code, I
> just ripped out the code completely.
> 
> So my merge actually looks simple and clean: when you look at the
> conflict diff of my merge, all you see is that I removed
> 'os_dep/rtw_android.o' from drivers/staging/r8188eu/Makefile.
> 
> What you don't actually see as a conflict, is that I removed those
> files entirely. That removal doesn't show up as "conflicts", because
> that filename didn't exist in my HEAD commit before the merge at all
> (because my tree had that old "rtl8188eu" driver).
> 
> So this email is just a long explanation for what I did, to make
> people aware that maybe I screwed up. It builds for me, and honestly,
> it makes sense to me in ways that your git tree did not, but I can't
> test any of it.
> 
> Added Arnd (for the siocdevprivate conversion) and Phillip/Larry (for
> the r8188eu driver side) - can you please double-check what I did.
> 
>                    Linus

Dear Linus,

Thank you for merging the code and resolving the merge conflict firstly,
much appreciated.

You have not screwed up - the driver still works, I've just built it
from your tree and tested this kernel with my USB-N10 Nano, and it works as
expected. Indeed, other than the removal of the unused Android code, the
driver is identical to the one in staging according to my checks with diff
etc.

I left this code in when I wrote ae7471cae00a ("staging: r8188eu: remove
rtw_ioctl function") with the intention of modifying and reconnecting,
once the changes to struct net_device_ops made their way into the
staging tree. Removal of it is not an issue though, it can always be
reintroduced as and when myself or someone else gets a chance to do it,
assuming this is worthwhile - others may have an opinion on that also
:-)

Regards,
Phil
