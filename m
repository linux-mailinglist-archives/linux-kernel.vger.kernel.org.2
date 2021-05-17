Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD6383C93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbhEQSpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhEQSpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:45:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD87BC061573;
        Mon, 17 May 2021 11:43:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 869C94A8;
        Mon, 17 May 2021 18:43:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 869C94A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621277025; bh=Be5dZWDNe5pxLA96ma0jwm393dbW0fQdTWEC+V7Y4rE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GHEH9VvGYLrqHN02joBBzzpDvlkHcR5jlIuXNvNTjUfv69ojMIwpXnZAtvIEcG1KD
         fPZUTQAEbjfKuZiOlWmtzpeo/uD/JGEgZNQpgjFy82yspQ2ptVkCAEbqxFFLuHUaCX
         9gSzvFKNM/GqazLt/ht28eTbXL0qrzeVbtnAWOwbEs7VX8Ns/7NQG7WMt5pLjALx8l
         LjBp/XONGrJYpjTpAJ2GKquGkLT2RHYlv906FNVi1Il8r8Um50UEvGF8/ISI2UPpts
         9hc+Tw7ysVy/BLUqFIaNLnKCO4Tfaww9/etTzMcz8Y/QMxH+sbG5MuD6NVtTn1QzvN
         mzAyAtKu8zEFA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chun-Hung Tseng <henrybear327@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chun-Hung Tseng <henrybear327@gmail.com>
Subject: Re: [PATCH v4] Documentation: scheduler: fixed 2 typos in
 sched-nice-design.rst
In-Reply-To: <20210516105955.120651-1-henrybear327@gmail.com>
References: <20210516105955.120651-1-henrybear327@gmail.com>
Date:   Mon, 17 May 2021 12:43:45 -0600
Message-ID: <87pmxp19r2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Hung Tseng <henrybear327@gmail.com> writes:

> This patch fixed 2 spelling errors in the documentation.

Next time, word this in the imperative form ("Fix two spelling
errors...") and leave out "this patch".  Meanwhile...

> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> ---
>  Documentation/scheduler/sched-nice-design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/scheduler/sched-nice-design.rst b/Documentation/scheduler/sched-nice-design.rst
> index 0571f1b47e64..889bf2b737dc 100644
> --- a/Documentation/scheduler/sched-nice-design.rst
> +++ b/Documentation/scheduler/sched-nice-design.rst
> @@ -60,7 +60,7 @@ within the constraints of HZ and jiffies and their nasty design level
>  coupling to timeslices and granularity it was not really viable.
>  
>  The second (less frequent but still periodically occurring) complaint
> -about Linux's nice level support was its assymetry around the origo
> +about Linux's nice level support was its asymmetry around the origin
>  (which you can see demonstrated in the picture above), or more

Applied, thanks.

jon
