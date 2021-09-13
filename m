Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF0D408660
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhIMIYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbhIMIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:24:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:23:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631521382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1XelB5z971jS8uF6ixZ0C4J0NZVExR0gzd3G3h6x+o=;
        b=sR5mK4OE7eZbXf9v0RASEkwuJguwMweAJZVYarDyY736fFGCf4s5U7F9bsqmOhXludC4jv
        Pl6SRrZ+zNj9wHKH0Ck//fENcWUqke3A/82OvUHMMgKPRp60xPKK0Mkd8XbYHSEE943uLs
        FDEBK3mXXr8YD+wQs/Pk3zzA+rFl4P8yzrTAI+Nc/4F54x03HPDnYYG379BVDUXq+HAazH
        zKxcIphIdJqEobFldkn5YxudGrJbFmyHbvEAqSGV3jcM7+iN28MXySXFy6rFOjDVfiyBz2
        IolYhW/VgV9X0oBMrzLQSjVC4V4Ys5IfAckKfQWHjUhkYQl6uDttZ2ehD8aToQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631521382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1XelB5z971jS8uF6ixZ0C4J0NZVExR0gzd3G3h6x+o=;
        b=qmtPqcavy+hxHSwt5jMqQLfiWN/3Z/xsg1X7GCHeWndBooklbMFcW6rknmCGVT9KbFYWIC
        J4SbWWKjttlHmFCw==
To:     OPENSOURCE Lukas Hannen 
        <lukas.hannen@opensource.tttech-industrial.com>,
        John Stultz <john.stultz@linaro.org>,
        "EMC: linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND PATCH] time: changed timespec64_to_ns to avoid underrun
In-Reply-To: <AM0PR01MB5410AD1A0E31405EF63B3DF3EED99@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
References: <AM0PR01MB54100B19D6ED5FDE764FA516EED69@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
 <87fsucc4yy.ffs@tglx>
 <AM0PR01MB5410AD1A0E31405EF63B3DF3EED99@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
Date:   Mon, 13 Sep 2021 10:23:01 +0200
Message-ID: <87sfy8g9zu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

On Mon, Sep 13 2021 at 06:49, OPENSOURCE Lukas Hannen wrote:
> (also ad 2,3 and 4: ) unfortunately our company mail system never showed me
> your replies to my original mail.

...

> You were right in assuming that the format of the patch was messed up by
> our company mail, I am as infuriated about that as you are and will try to
> change this situation asap.
>
> The other mishaps (like the wrong use of the RESEND tag, failing to check
> if the changes were already applied to your tree etc. ) were caused by me
> being a young and inexperienced contributor.

No problem. I was certainly not expecting that the resend was caused by
the lack of incoming mail on your side.

> Thank _You_ for not immediately ignoring me forever,

There's no reason to do so.

Thanks,

        tglx
