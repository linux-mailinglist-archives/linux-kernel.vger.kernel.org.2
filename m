Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FAA4029AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344417AbhIGNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbhIGNZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:25:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE2C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 06:24:30 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a66so10048743qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=snKy/WADFwokRT+osDI9do+M8g2hziIwUcmQdPSAFyc=;
        b=XVv+i9saQ7NVKMuYyZaNVEK0Ukra4Ijtg+Rq16/2Nf2hK+/GvERQEMSlkMsxuhWYxn
         z2Gk06jl5PM8QlSxfPBwRwgdVHD6eWzZXZvkdkEvbK0gohnUs1MBcwGzoEMgapDK6mfa
         aZUKvI7nwU5GOkpQVyoaeNiWrtqw98qQUsNqA5uBx2JtJnxcj/OemDNrHKxIHgael230
         p07XbUPC8IMw6lmmdmmFaHHVdYnDjUYaNnSC7Rzla5hfYdJBi+2v23Hud66U/TsdR7pE
         AJkh6gspQ9Uk6+lbY/Cjh4VhHrydNNGmTYyu1TpmUeid3noetauKF18nvM4y2jHrJvmB
         +4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=snKy/WADFwokRT+osDI9do+M8g2hziIwUcmQdPSAFyc=;
        b=BCi3023hT3mwJr9nhi0scwllbdaZ9u8WO5msnLqda/W2AYwUdAWsOhCKUhsk5DyK4j
         B8HNqNXFsg9bs1z8ZuKHFnaBVl6tyJZL7feavP42R+eaLsdFQE+vYeWt5cCMWzOrtC2P
         aDNdlch/D/eHPabUfHHHvpANlTVGv77CYEAJCvsQYL/d1jC5kwYlcLLTzsDRWINtPfJI
         Zk+jqIAp6jjYZBsk/uOGhhZuD3c9lR/8UMCMiERssMx7LhjG2rYUYJkEo6xR1vclIHMa
         QHbMcwvcbfnLbKQOyoRA6ZnGv40TcQqvE4LKZX2szYDcdYotDWrBEAyJ2oY2x/OM3+d/
         5bDw==
X-Gm-Message-State: AOAM533deEXvmwcqKXxPdZTNjeiQ0sDsCZ2ClWWFcLvf5LpxDiMNg9ob
        eOT2PwgyV1eWVR/HwJ6NHoKJZQ==
X-Google-Smtp-Source: ABdhPJwl+xY/vbUI8SwIRZRn7WY9w2nTQTOJynm9CWgFNldLL4FjH0eNw8V7Ge1ULuU8Jb6JQX7MJw==
X-Received: by 2002:a05:620a:444b:: with SMTP id w11mr15732760qkp.479.1631021070123;
        Tue, 07 Sep 2021 06:24:30 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b15sm8581895qka.107.2021.09.07.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:24:28 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:26:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm : bail out from psi memstall after submit_bio in
 swap_readpage
Message-ID: <YTdoesOHCNoe+rGH@cmpxchg.org>
References: <1631015968-9779-1-git-send-email-huangzhaoyang@gmail.com>
 <79c08d1d-eef5-bc15-8186-7e3367b4ebe7@suse.cz>
 <CAGWkznHY-iZ0ERbJdX-j4S5qOsUAzV0+x67maprz3W+xbq4hTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHY-iZ0ERbJdX-j4S5qOsUAzV0+x67maprz3W+xbq4hTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 08:15:30PM +0800, Zhaoyang Huang wrote:
> On Tue, Sep 7, 2021 at 8:03 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 9/7/21 13:59, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > It doesn't make sense to count IO time into psi memstall. Bail out after
> > > bio submitted.
> >
> > Isn't that the point if psi, to observe real stalls, which include IO?

Yes, correct.

> IO stalls could be observed within blk_io_schedule. The time cost of
> the data from block device to RAM is counted here.

Yes, that is on purpose. The time a thread waits for swap read IO is
time in which the thread is not productive due to a lack of memory.

For async-submitted IO, this happens in lock_page() called from
do_swap_page(). If the submitting thread directly waits after the
submit_bio(), then that should be accounted too.

This patch doesn't make sense to me.
