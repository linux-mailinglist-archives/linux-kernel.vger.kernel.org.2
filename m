Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07D36394D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhDSCHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhDSCHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:07:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E6C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:06:40 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso29276676otb.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 19:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JdcLr2SXndozP9ALF1nEmVeBdD9xinkessdTeHKabVc=;
        b=ClqImXLhV19R1QSBGiQFv4t7pODZ834Y7nhzA+qgaPI9c+6vx3yeoFV4D+X+0KO/gh
         yboAA5Kn1ukbDmi9LG7gBQAFQlyx7Dgbrhpb1iA5ivsKuyTHrOh+OLt1LAX4Fmf1iszN
         /IyWDD30cDt0fvjNZH8RJjIoEgPjdMtYZ8ZEA7TIJczxbp7p0FoEQHFN9Dmvs76KUxOP
         CJhd85URYUiyQZFenG2Eg665O+hDtIcOlqVbwGBmutldyxbi1U/xRYEzdS4Orva06cij
         +/W8KlFWxAVO39IEsOzqK1Fh2UA3ohXIyl5Q+ReZ+/I1cZwdQsZ7ZY+4gNjQKe1HPkAd
         vI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JdcLr2SXndozP9ALF1nEmVeBdD9xinkessdTeHKabVc=;
        b=AEo4uYwKMHQQI8eDFU1fXXx1yarBeKFy4qLI/YIZ98RwrkHmzfUwGjR8mRDVBcH64A
         faFhPFER07WTXL4cvwIFZmJzgOK+8gPVVJBouPsbCLQIIVtJEgnlD4QPEsUUuqEcA8kM
         Rm2h1mGp2blmOm/mc4u0nVC6sjJBET+lSz0vnZQHgqEFIrjKZSDiO0oYGu1Tar6HEG5L
         0NxRZtldeLrRmgAVbgwqqKhzSxK/X+D7ZDOwq2Q1r0dOyWL7X8yEPny1sf136COPV/KQ
         RSRSihHsREe1ktspZIuVWftw7ek69MOvOUkJi69/PMtd2vly/3hvs22s2sjmHd0GMLN0
         aFCg==
X-Gm-Message-State: AOAM531DP1JQ/klsA/pK5sSwdGU5WQ+DtniMfqVDnqi0W7qZkHU+1BAS
        +QxZ5KM2PgCcuCSs9urlMDaI1sy7Yr4=
X-Google-Smtp-Source: ABdhPJzAXolMOIqIa+BB5SgJfYMxHg63fst1xX0FXgu2QGLvCb3/909SvcjikmSpmGgVOgb1fK0xkQ==
X-Received: by 2002:a9d:1d6a:: with SMTP id m97mr12517127otm.322.1618797999748;
        Sun, 18 Apr 2021 19:06:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a134sm125821oii.29.2021.04.18.19.06.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Apr 2021 19:06:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 18 Apr 2021 19:06:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc8
Message-ID: <20210419020637.GA145376@roeck-us.net>
References: <CAHk-=wjgVFDhX60fxwDobHoqJvVkuxf=JgSTtGnGMa5r-1u4Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgVFDhX60fxwDobHoqJvVkuxf=JgSTtGnGMa5r-1u4Yw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 03:02:49PM -0700, Linus Torvalds wrote:
> Ok, so it's been _fairly_ calm this past week, but it hasn't been the
> kind of dead calm I would have taken to mean "no rc8 necessary".
> 
> So here we are, with an extra rc to make sure things are all settled
> down. It's not _that_ rare: this is the fifth time in the 5.x series
> we've ended up with an rc8, but I have to admit that I prefer it when
> a release doesn't end up needing that extra week.
> 
> Because let's keep it to just one extra week, ok? We have occasionally
> done rc9's too, but I really don't expect that this time around.
> 
> About half of this is once more networking, with driver and bpf
> verifier fixes standing out. Other than that it's mostly other driver
> updates (gpu, dmaengine, HID, input, nvdimm) and arch updates (mainly
> arm and arm64).
> 
> And a number of one-liner build fixes for unusual configurations.
> 
> So it's not tiny, but it's all small enough that you can easily scan
> through the shortlog below and get a fair sense of what's going on.
> 
> Let's plan on a final 5.12 release next weekend - but please do give
> it one last test to check that it is all solid. Ok?
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 461 pass: 461 fail: 0

Guenter
