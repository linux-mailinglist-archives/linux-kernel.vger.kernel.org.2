Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9D630FFFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhBDWR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhBDWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:17:56 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CD7C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:17:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so2491749plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QZfrdqQKGKjK2+MdXTOGKpW5B2/eIiZIz60rCw4vSqo=;
        b=LaB+LWdwUbb1d3NoeC2iQFpDGqfBnaGiXMOzDYYl7jsF/qNKJCGY5LvBcVnDTKFpp0
         KHJl0CR1K4mdffH519Jqm4UEZXGjxOcdDj/+uAd3E+f6ZZg2etzjUc7ZBaEcdajbgkrY
         Ch94ei1RO8GnJ02+/3UfhphGnGgnk8/BNg4D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZfrdqQKGKjK2+MdXTOGKpW5B2/eIiZIz60rCw4vSqo=;
        b=ELgYu9utQYQSEl4g0R/0o5jIn+MIq8cEXm4zmTLlWfXCwqendMIURFJwU7W3vbyT0G
         pSs2Ubprr9GVexzTwVTn8V0Vu7m64TiODSm/PoGmmqwRTxGEWNUeF2NcIGj8SCGQAIky
         IgK6aaSnuJZybgB8TKdNC/icHa4pym9C3J0MOtrOov/NeWiBGvj/fG0DaxOL89XvnZmE
         LyUNwi5WAsjQdw/htU7rWICfz6B5EddKSAe8Lt6FTRgZO4FByt/AypGe4j1d5UZtHOMI
         Hi4NT4mJkqQXv3dc9+tH/tyQBQJT6FfhdzUwwrO4X15MnPO333Wo4AkD/2woReFiHDGi
         XwLQ==
X-Gm-Message-State: AOAM532e4D7N5isCsJCAjnQ90iwkS127M59K/dcy5rBAh5RmmUX6S3PS
        e2wyELWzwdqwNXTTRrl4VmL3DQ==
X-Google-Smtp-Source: ABdhPJzu7v/M8QIg5pcJy2r31qzxz/af773c9ZdS3Ehel04m8u/mNPSrmIPf9ZFrrwRK8681gTmnkQ==
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr1087246pjo.136.1612477035488;
        Thu, 04 Feb 2021 14:17:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gb12sm6280279pjb.51.2021.02.04.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:17:14 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:17:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Timur Tabi <timur@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de, akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <202102041415.D9093ED6@keescook>
References: <20210202201846.716915-1-timur@kernel.org>
 <20210204204835.GA7529@amd>
 <20210204155423.2864bf4f@gandalf.local.home>
 <20210204214944.GA13103@amd>
 <873d7e08-7a70-a1a3-f486-882d1d515965@kernel.org>
 <20210204221143.GB13103@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204221143.GB13103@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:11:43PM +0100, Pavel Machek wrote:
> On Thu 2021-02-04 15:59:21, Timur Tabi wrote:
> > On 2/4/21 3:49 PM, Pavel Machek wrote:
> > >This machine is insecure. Yet I don't see ascii-art *** all around..
> > >
> > >"Kernel memory addresses are exposed, which is bad for security."
> > 
> > I'll use whatever wording everyone can agree on, but I really don't see much
> > difference between "which may compromise security on your system" and "which
> > is bad for security".  "may compromise" doesn't see any more alarmist than
> > "bad".  Frankly, "bad" is a very generic term.
> 
> Well, I agree that "bad" is vague.... but original wording is simply
> untrue, as printing addresses decreases robustness but can't introduce
> security problem on its own.
> 
> Being alarmist is not my complaint; being untrue is.

It's just semantics. Printing addresses DOES weaken the security of a
system, especially when we know attackers have and do use stuff from dmesg
to tune their attacks. How about "reduces the security of your system"?

-- 
Kees Cook
