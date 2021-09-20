Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468D0411285
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhITKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhITKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:05:01 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E32C061764
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 03:03:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p29so64603527lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 03:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JsflVfkQxQB4N10JR68gBY89s+ETKAkmb+oupF+vnMo=;
        b=27IEOpveeqqFcAi832Br+8AG9JKChmAv7tTrVV950tvPtiqpC6Psrah4+xSVxUaJxd
         OOKtThwEUavPn3JhVr2Nbj+N8aBC33lIuEyu7BINU8GGBzDYDijug74t6wde0vhp211R
         nh8mUkfErVn8ZmBK+CwKhwa32vtsfl1O66XS3KXTuYhc7Z/bO5ah2+kW6ZGIZmrjVcuB
         ZbTp8f7Qn6ilulvkGgc6YeIJPW/u69ubD25NrfyFd4Ob2zZuG823H6yGMXImEd+b/4dx
         dK4EFgA73SkzK2t9nDI6500OlEpBG2oIGrQj15vChjV8Balbp1ESoqCBKzHTxKteSZ3g
         ERTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JsflVfkQxQB4N10JR68gBY89s+ETKAkmb+oupF+vnMo=;
        b=pyb493TYOpKq9l5U+CSDjwOL2itpPx+QecTcSv2EpS9eAjDBqbvUidDG1dsknIrSCC
         YisGa8fHMaMFpbrD6o17ulRviJvEc6fkqDrEgUV49Xk8jAzHgNG3ZMDayZFJcLOqW/KZ
         H/HzXGaFnai0O09thjcust3cdQ3o6iMF/GJ9SCQCP2sDwYXa+oLNYII7G2bxsDh+Cj68
         EGx0+shAjmN6npPC9721ztV9a9ctdrus+JHLfXCfpO51FbvEO6FYzLOnbUhwkd77V9Pi
         s1AqJQi8E9x75IsskVibF0JhMojqLWQs8+IW7Krjfl0/3+YhwMmRGCi//btuCZo89JEW
         ti/Q==
X-Gm-Message-State: AOAM5323dXkgwhJxLLyGJWgReNWYbp9eXNCAUn5LMr19wYBz5JboekAd
        RBLLpSMX1Fg9ri1g/7+jhMQUpg==
X-Google-Smtp-Source: ABdhPJwWeA3bEQ95y2LO86pVxC5P5j6PanypuMtnhgm81tBPbpzuBTk2e2kpj/5MX7P31r1CnCOLUQ==
X-Received: by 2002:ac2:5d63:: with SMTP id h3mr18425134lft.278.1632132213126;
        Mon, 20 Sep 2021 03:03:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i4sm1227194lfo.13.2021.09.20.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 03:03:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7D479103053; Mon, 20 Sep 2021 13:03:32 +0300 (+03)
Date:   Mon, 20 Sep 2021 13:03:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <20210920100332.gd4a2c3aza3rufk5@box.shutemov.name>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <20210917205735.tistsacwwzkcdklx@box.shutemov.name>
 <YUUhnHrWUeYebhPa@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUUhnHrWUeYebhPa@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 07:15:40PM -0400, Johannes Weiner wrote:
> The code I'm specifically referring to here is the conversion of some
> code that encounters both anon and file pages - swap.c, memcontrol.c,
> workingset.c, and a few other places. It's a small part of the folio
> patches, but it's a big deal for the MM code conceptually.

Hard to say without actually trying, but my worry here that this may lead
to code duplication to separate file and anon code path. I donno.

-- 
 Kirill A. Shutemov
