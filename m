Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E2131899B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBKLf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhBKLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:05:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CFCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 03:04:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c6so6525869ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 03:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YL/aAQI10ffY0mwAteqz/UkF3AdWj64F0xz85Qyk4GI=;
        b=H6MPuqEflInoZphbiEmEeHWj472ShEEne7aF/1B0poZ5Z3KIApIqSZJUIr1C+Jpm7F
         SP4Fvj/Izw9uSF2QzVWszFkYRSkyqZ1GhEZSGOW6X8i4reuzJneRXsTUT6lYvPiy+Bod
         wEyd+1agqUeckZFWPhhtM5UqXjlJPEeY7gD38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YL/aAQI10ffY0mwAteqz/UkF3AdWj64F0xz85Qyk4GI=;
        b=UkI+Ejf9hqV4nrg2Avgmfe9YliXB/cua98X874mXJ3DQ4rQiKCuR4uQqbIQ1HuSvOT
         edNaxWwAhIOZO7UUiD2YmJZzZruijLmWOzSX3zQPplUGQTXFzNj0ckOMkGO0j8eG+KUk
         kuHC9Eo22KmiUI9J3GEZzaPOV2k2alVECn+cYqX9LfEaUj90y4bav1NVxGUiVqXtQmit
         g0I5GWxBZFfJIuZyFOGWxTUnSMS8zhcK6ooeFg3kYGGno1l37PEVDyrm5X2jyMKkykhf
         j09LlQ5QtoFjrA72MP/izs2cyfhiRNr5J17hya8X9T0NMyOGoEE3Gz0Xo0F3G3/fq10L
         3gHQ==
X-Gm-Message-State: AOAM5338FwMXRjIgrZW/kS02E3VWDCZk2913Zo/SDKM8CgYrVp+SDGRH
        N09KYmyGxtiVUgBflDbkLjB26g==
X-Google-Smtp-Source: ABdhPJy5CWNJgl3XKpI+l8HOH18UnQgIcs8m3SOc527uHBIl3G8CBTjfNIqMWCoUQV44Mdu+/2SslA==
X-Received: by 2002:a05:6402:22b0:: with SMTP id cx16mr7713623edb.255.1613041493490;
        Thu, 11 Feb 2021 03:04:53 -0800 (PST)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id hb24sm4089174ejb.16.2021.02.11.03.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 03:04:52 -0800 (PST)
Subject: Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
To:     paulmck@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <YCQJToq1d63BU55S@smile.fi.intel.com>
 <20210210175751.GH2743@paulmck-ThinkPad-P72>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <da9ca86e-4113-f0ad-6120-3b3cbea5c836@rasmusvillemoes.dk>
Date:   Thu, 11 Feb 2021 12:04:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210175751.GH2743@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 18.57, Paul E. McKenney wrote:
> On Wed, Feb 10, 2021 at 06:26:54PM +0200, Andy Shevchenko wrote:
>> On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
>>> The basic objective here was to add support for "nohz_full=8-N" and/or
>>> "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
>>> to the last core, evaluated at boot for anything using a CPU list.
>>
>> I thought we kinda agreed that N is confusing and L is better.
>> N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
>> sounds better as *last available CPU number*.
> 
> The advantage of "N" is that people will automatically recognize it as
> "last thing" or number of things" because "N" has long been used in
> both senses.  In contrast, someone seeing "0-L" for the first time is
> likely to go "What???".

Completely agree. The patch that introduces this even updates
Documentation/ at the same time, and if people are confused just because
they don't RTFM, xkcd#293 applies. So let's please just paint the
bikeshed N. (As for case insensitivity, I don't see the point, it just
makes documentation and implementation more cumbersome and confusing.
Just document and implement _one_ way of doing this.)

As for a future syntax for "last 4 cpus", it's common to accept a
negative index to mean count from the end, so unless we already accept
-4 as a shorthand for 0-4 (haven't checked), that could be -4-N. But
regardless, I also agree with Paul on this point, that's for a future
time when the need arises.

Rasmus
