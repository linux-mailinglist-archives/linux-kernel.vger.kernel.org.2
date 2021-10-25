Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E343A84D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhJYXls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhJYXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:41:44 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E3BC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:39:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so14678821ote.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+x1+mpL5p2fvvx0kOxI6O1ZDpS1ftyIoRUZRoClEdJ4=;
        b=GhNmBU5MJmUgXqpEcP355XeBo53QAlB7tSh6NrbCYZVKOxyQA1Y0AHLcVjKvehfb4E
         scadGDf5YIhI0dkQhCYzZKqqMGmfUHk595eBxUvSHk1iFfgL/aE5jD98DDLApkchxKUh
         5VzxioDiCEzm+/bNU3tzkToCALzIAPMzafmJHIMGLQwwvcHOtJRaAuaWcK20EFbK5v+l
         99EEYZ6XrhbGEWk6TUcElZQ8bsNFxJqbPDYf3/qXmEZp1LYO0euFbnIWmKdil9JTTaqf
         tn1jA/w78S1DtSEO+ezUb7S0TgiNv/lp0lIsTNIPchrtE3cXQkRhTNzx4gPZOJBy4cxp
         WI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+x1+mpL5p2fvvx0kOxI6O1ZDpS1ftyIoRUZRoClEdJ4=;
        b=E/Pbc+Z5KFjFDe8HjWlJK8vX3hIcrkmWEm/TvCO0JONXBYNLvoD6PT0crEZ9IvZDs5
         nSxC1GL3fKKHbb3Nik6x7Ik8IEj70vLrY6GqOQwNGVYifmVgdk52gGntU3tQe+ZfgOpR
         x5nySTWhif+QTRrQuI9fohg/79niE78rl36zahAfkJx5C70w0kDLzxn4gYKk7unMoVuM
         KMbFXC7TA1GXwq0zkUtxZ3HHG9rpPaOCFhh4HZoP99mRcHz4Zr6wY5JooQq4v6jv3Ixs
         iMBRCru3bmqrpos3tO2uvvVmngOPqtNOsdebKjK7L0tlN5ukV6TybRz4vcq5uxRJCObS
         SW7g==
X-Gm-Message-State: AOAM530UEdmBU8C3ogZsYA9Gi3H/BulbZhnJb10CLKGR2cxNIK/sU3bs
        Smu/KUxrYshL2ZhOQ/iPBUbLXCcEkY8=
X-Google-Smtp-Source: ABdhPJzDbFvihlZf3r5TwBQDEDlQEo+sZhrFu19dLpjJ21bUXrxQPSAk5Kb1ySWzoG8y22oe6f+8tA==
X-Received: by 2002:a9d:2f61:: with SMTP id h88mr3899639otb.36.1635205161094;
        Mon, 25 Oct 2021 16:39:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x62sm4119645oig.24.2021.10.25.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:39:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Oct 2021 16:39:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc7
Message-ID: <20211025233919.GA2394574@roeck-us.net>
References: <CAHk-=wi1+boAQyckdiYXuBkybN4H_7OT569MwgyetWAfTExeEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1+boAQyckdiYXuBkybN4H_7OT569MwgyetWAfTExeEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:51:43AM -0700, Linus Torvalds wrote:
> So the normal Sunday release was spoiled by me spending more time in
> airplanes without wifi, and I didn't feel like doing an evening
> release while tired, so here we are, midday Monday, and with tc7 a day
> later than usual.
> 
> But the delay isn't because of any kernel trouble. In fact, the worry
> I had last week about a big rc6 turned out to be just a false alarm
> due to timing of pulls, and rc7 looks nice and small, right in the
> range of normal. Both the number of commits and the diffstat looks
> fine. It's all pretty small and flat (meaning mostly small trivial
> changes) with just a couple of  peaks for some x86 kvm code, and some
> ksmbd changes.
> 
> Nothing particularly interesting or scary stands out, and it's a
> fairly eclectic mix with networking, kvm, selftests, and some core mm
> stuff. With all the usual random small fixes. The appended shortlog
> isn't too long to scan to get a feel for the details, but I think the
> take-way here is that it all looks pretty normal, and if nothing
> special happens this week, this is likely the last rc before final
> 5.15.
> 
> But please do give it a good testing to make sure we've shaken out any
> issues. I have yet more travel coming up next week, so it would be
> very convenient for me to delay the merge window if I get the excuse
> to do so, but right now that looks unlikely.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 480 pass: 480 fail: 0

Guenter
