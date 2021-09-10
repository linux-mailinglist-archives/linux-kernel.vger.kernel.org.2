Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9A406E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhIJPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhIJPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:35:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC638C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oaN7qY6S4Isxzy4JLgqhBnxwl4cPBYd1rT3odrvAhkE=; b=EYYEyWNgiYgbFcjd+HEoEf0qsI
        E/NiSQdKohkj9lefBwKagRRodVIVjbSMhH/Nd6zTtsjGQZOkMHWdXIcF9ck8V8jjRO+Yyt7jATzA4
        ygVPaWwXVkeJVAI6gnxHJlG47N4f2BE0H1H4RKMi198dkX99cj13uX4fsSQR75HonFXRXkIlDQZWZ
        xyAurHH5zFa9SsRrojeSBHz7uYQmuxjGaq6eRvvLrDZR1fL+9MG0NIDetC2wEtm5rw2y8Sqs9Z29a
        6swk9LV78PuI9uDVmMgdavDAkkl7I2plJ1TKhMtyplS0gD0Bpfl/Hcg3KuNpNhboVYMs5ClmmZCIG
        dSfwqlXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOiWi-00B7IE-HX; Fri, 10 Sep 2021 15:33:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B735198627A; Fri, 10 Sep 2021 17:33:15 +0200 (CEST)
Date:   Fri, 10 Sep 2021 17:33:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Singh <ravi.singh1@samsung.com>
Cc:     hannes@cmpxchg.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com,
        vishal.goel@samsung.com
Subject: Re: [PATCH] psi: fix integer overflow on unsigned int multiply on 32
 bit systems
Message-ID: <20210910153315.GG4323@worktop.programming.kicks-ass.net>
References: <CGME20210906122653epcas5p19c46576f0be4d4a101f851a751addde8@epcas5p1.samsung.com>
 <1630931124-27197-1-git-send-email-ravi.singh1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630931124-27197-1-git-send-email-ravi.singh1@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 05:55:24PM +0530, Ravi Singh wrote:
> psi accepts window sizes upto WINDOW_MAX_US(10000000). In the case
> where window_us is larger than 4294967, the result of an
> multiplication overflows an unsigned int/long(4 bytes on 32 bit
> system).
> 
> For example, this can happen when the window_us is 5000000 so 5000000
> * 1000 (NSEC_PER_USEC) will result in 5000000000 which is greater than
> UINT_MAX(4294967295). Due to this overflow, 705032704 is stored in
> t->win.size instead of 5000000000. Now psi will be monitoring the
> window size of 705 msecs instead of 5 secs as expected by user.
> 
> Fix this by type casting the first term of the mutiply to a u64.
> 
> Issue doesnot occur on 64 bit systems because NSEC_PER_USEC is of type
> long which is 8 bytes on 64 bit systems.
> 
> Signed-off-by: Ravi Singh <ravi.singh1@samsung.com>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>

That's not a valid SoB chain.
