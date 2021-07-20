Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128203D0497
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 00:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhGTVpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhGTVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:45:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768DDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:25:45 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e14so406082ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R2F29apSURu+IG0KtraJ0+rZnz2VLfT3gZPbk7j55ag=;
        b=kbtASbOPWbpzOdYKIDhZY5bN0lT2tbl28NLr943++MghdVByMURwBagN0VTQxwmCfw
         7bUEDMCGnX3xw+69j9KigDRrbbopKWd01Mb4Nb6n0Ou5oU77FeiiucaOxdTYF8+9AcQ+
         XGaj3X2ZYwOlbR/h1g6H1fzYr6S2FjKrRxje7DHHztIQtstLxZhDC3J2BGp9yERHIml3
         OIsQ7b6MFKtoNeR+JOG3iLGLB5R4ahXAtHJdUET/Aai462EE9fTZ8GdnUiwo3afzXUxM
         GY48Ve1QVcandqBj6CGb02Jxtrmm/XPGUahIU7n0Q3VFRKW5//QlcgFi5g2w+JdIrbH6
         ug+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R2F29apSURu+IG0KtraJ0+rZnz2VLfT3gZPbk7j55ag=;
        b=BzV7O4TDVDSPbBEbBgCSe/MHJ7aAlSp8L0ARwP8F5AKIgW4yNjxWnDm+tm0JADSrYY
         epgeLF4BYBpBnUWSzFH/oNsJyj2+E85twvwhlJNvmtbVjoRXXkUs5j66qcz3FcWAsuDb
         w5t/pcolF6dUfeJ2qM7PH7Qs5dYy9BQGfJZXhMSOGmKSWnCXRNTLPFP0E9UM/xSnfeuL
         pNp2pBeJQiMnVM1POTkAoHzdRgUyz4rGweb2EEE/iKtOl7/XUcz9GM+UAPjnph61UCp5
         5hsFJICiKEyA0viyay/2WBTpRBV5v1KTlJRqEzg1f0UfNAbPjb1O92Ga943T/cX13cA9
         ejHQ==
X-Gm-Message-State: AOAM531Vb3ydQCd0s3BaO+8f2Eoi0+VD8HeB0JB9E9vuCoPyYlz+y2Uz
        dD2sh2EVeKJImAGXZfKWd54=
X-Google-Smtp-Source: ABdhPJzw/PCsP/6x/vBBSoNUuV0VbOP2Wjy5oJ6JPC1437Vh4vCVNbv548oEVT0r5Of+ZKUIj2161g==
X-Received: by 2002:a05:651c:1141:: with SMTP id h1mr23398496ljo.224.1626819943852;
        Tue, 20 Jul 2021 15:25:43 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id v12sm2488496ljv.65.2021.07.20.15.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:25:42 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
        id B439C5A001E; Wed, 21 Jul 2021 01:25:41 +0300 (MSK)
Date:   Wed, 21 Jul 2021 01:25:41 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] prctl: allow to setup brk for et_dyn executables
Message-ID: <YPdNZfoYtIhkmbkf@grain>
References: <20210121221207.GB2174@grain>
 <20210720145148.cdcfa3210e39e88a591af12b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720145148.cdcfa3210e39e88a591af12b@linux-foundation.org>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 02:51:48PM -0700, Andrew Morton wrote:
> > 
> > This of course prevent criu from restoring such programs.
> > Looking into how kernel operates with brk/start_brk inside
> > brk() syscall I don't see any problem if we allow to setup
> > brk/start_brk without checking for end_data. Even if someone
> > pass some weird address here on a purpose then the worst
> > possible result will be an unexpected unmapping of existing
> > vma (own vma, since prctl works with the callers memory) but
> > test for RLIMIT_DATA is still valid and a user won't be able
> > to gain more memory in case of expanding VMAs via new values
> > shipped with prctl call.
> 
> So...  do you recall why you added that test originally?

To be honest, when I added this test in first place I simply forgot
about et_dyn executables because we usually run executables via
traditional exec call (where brk map sits before end_data VMA),
not via loader and that's the reason why I didn't hit this problem
before and why this get revealed only after a couple of years.
This is simply rarely used.

> 
> This is under prctl(CAP_SET_MM), yes?  What capabilities does this
> require?

Yes, it is for prctl(PR_SET_MM_MAP) and requires no additional
caps. The most important thing here is check_data_rlimit() function
which called at the end of memory map verification -- we make sure
the user won't get more memory than been granted by RLIMIT_DATA limit
even if he passes some bad brk value here on a purpose.

	/*
	 * Neither we should allow to override limits if they set.
	 */
	if (check_data_rlimit(rlimit(RLIMIT_DATA), prctl_map->brk,
			      prctl_map->start_brk, prctl_map->end_data,
			      prctl_map->start_data))
			goto out;

which expands to (I wrapped code to make it a bit more readable)

static inline int check_data_rlimit(unsigned long rlim,
				    unsigned long new,
				    unsigned long start,
				    unsigned long end_data,
				    unsigned long start_data)
{
	if (rlimit(RLIMIT_DATA) < RLIM_INFINITY) {
		if (((prctl_map->brk - prctl_map->start_brk) +
		     (prctl_map->end_data - prctl_map->start_data)) > rlimit(RLIMIT_DATA))
			return -ENOSPC;
	}

	return 0;
}
