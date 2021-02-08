Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA90312928
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 04:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBHDBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 22:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBHDBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 22:01:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E36C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 19:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=YA/wwOFoj3yUFAg+fXip6+7XiG3+kGq6hXOyNVAPJAA=; b=rSHq8KFeUL00+1sbvkSbL9dD8s
        tQlceoCfygVCZKT6uVRwxv+SQbrH7PBg0agidR7dTq99rjImrG8I7I/+7P9lQeNCWrvoEl0LWYC3R
        X73/MUEU2mHuJ5/sVh3xwHGzvc2Jd0lfjkymxkDQ+JrfQKBgtS1DdDldmacO63mX5lfQG9krfDuDg
        7o4GOtjFommRqAVPmwpgqKh6yC1A6yKVJCaCVis1+tOsNlRLuYUrlaMuHZ9h4At6d48LGG0KJHDND
        +r7u6MiyLDdscAWcDGvECzREAaXs7s6gobPOSYRAXU9WafuolvZw+aMJwL34x9KmSwfcgIRjHxjC8
        ycSPAmMQ==;
Received: from [2601:1c0:6280:3f0::b879]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l8wnK-000301-Ga; Mon, 08 Feb 2021 03:00:58 +0000
Subject: Re: Linux 5.11-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgxhBkWH0D6chYcwqDvdh2rB5ZVpToxodz5Q6qaFd_qyg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f514a734-7bfc-4c1f-6ce2-79fc04b456e0@infradead.org>
Date:   Sun, 7 Feb 2021 19:00:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgxhBkWH0D6chYcwqDvdh2rB5ZVpToxodz5Q6qaFd_qyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/21 2:32 PM, Linus Torvalds wrote:
> So it's the biggest sporting day of the year here in the US, when
> everybody is getting ready to watch the yearly top TV commercials,
> occasionally interrupted by some odd handegg carrying competition that
> I still haven't figured out the rules for after twenty-odd years here.
> It's kind of a more violent and hands-on team-oriented version of the
> traditional egg-and-spoon race, and involves a lot of standing around,
> apparently waiting for the next commercial to come on.
> 
> Go forth and test. Unless you're glued to the TV, of course.

I should have watched the Puppy Bowl!

-- 
~Randy

