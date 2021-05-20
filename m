Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91238B4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhETREK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhETREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:04:06 -0400
X-Greylist: delayed 110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 May 2021 10:02:45 PDT
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BEAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:02:44 -0700 (PDT)
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E6CD82E17ED;
        Thu, 20 May 2021 20:00:51 +0300 (MSK)
Received: from mail.yandex-team.ru (mail.yandex-team.ru [2a02:6b8:b080:9020::1:f])
        by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with HTTP id n0ZueB01WW21-0p1mcVGp;
        Thu, 20 May 2021 20:00:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1621530051; bh=d+H8GCIV5S3WIPcPht8m0TNgn2GZfcRkAgWxaYkRe4g=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=b5yv92FmXO4Rqwq0hL8Dlc6drL0WcStLx3ms5SHFz3n+sRhs+WNL43jD0FRuh6F2J
         g66l1F7SnN/vvu2/E2HDIJKSglqvd3mpygeMJXJJj9cGz+ZZ8OQu5F+p1wJYgvmmZP
         EhIOB0d9VWvYYcy532GALTiaYKHLt7NS6fwfyAbk=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000084479
Received: by iva4-92c901fae84c.qloud-c.yandex.net with HTTP;
        Thu, 20 May 2021 20:00:51 +0300
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk
In-Reply-To: <YKZ5i5P8fL8bgq7G@slm.duckdns.org>
References: <20210513082827.1818-1-dmtrmonakhov@yandex-team.ru> <YKZ5i5P8fL8bgq7G@slm.duckdns.org>
Subject: Re: [PATCH] blk-throttle: fix race between submitter and throttler thread
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 20 May 2021 20:00:51 +0300
Message-Id: <1394051621530051@iva4-92c901fae84c.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Hello, Dmitry.
> 
> This generally looks good to me. A couple nits below.
> 
>> @@ -277,6 +277,8 @@ static struct bio *__bio_chain_endio(struct bio *bio)
>> {
>> struct bio *parent = bio->bi_private;
>>
>> + BUG_ON(!bio_flagged(parent, BIO_CHAIN));
> 
> Let's do WARN_ON_ONCE().
If we hit this point when this mean that  ->bio_end_io  will be called for parent bio.
Which likely result in use-after-free for that bio and silent data corruption for bio's pages
So IMHO BUG_ON is more appropriate here. What do you think?
> 
>> @@ -2270,6 +2285,8 @@ bool blk_throtl_bio(struct bio *bio)
>>
>> td->nr_queued[rw]++;
>> throtl_add_bio_tg(bio, qn, tg);
> 
> Can you add some comment here explaining how now that the bio is added for
> throttling, there are two accessors of it and the bio must not be modified
> without holding the lock?
Sound reasonable, will be back with updated comments.
> 
> Thank you.
> 
> --
> tejun
