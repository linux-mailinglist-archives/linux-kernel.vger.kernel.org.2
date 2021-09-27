Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DA419D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhI0Rrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbhI0Rrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:47:43 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC21BC04395E;
        Mon, 27 Sep 2021 10:31:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8AAB3867;
        Mon, 27 Sep 2021 17:31:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8AAB3867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1632763892; bh=Cq1GlbNCWDIYUa8VMpjmo1bTwWlufr1ZW75WB5tCwWg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QSRtAKz7b9DjnCy7EFMe6cvZPoE7N9wHE/ApKmW/D0AM4NwllrmV5GCq5d56hha/j
         oDadCHOtDyHlxw6BVPTqp5ZhibPcEEUvxoj+dCVNVv7DWnzTV2SbGv0JoshDuAj1tM
         Q2N/8oLVq/BCZruq6e23Yw0FjaCthRD+Q/Nv5wi9Il4irC7AACrP+xjdoUlCJH+Jkp
         /HUd/7KaminWXjVxPnBuT62ukM0XLKD2eWBhsqh2PvbHPLh6BRai9GrcsIZiNSBcwP
         1QH3xxHMMQrOfviM/oAzLB7SGsPRrkV3NwGjvJM6B80Wv3BBwBj3UhmuXODBXisQMd
         Wz99rvcxxFNFw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/no_hz: Introduce "dyntick-idle mode"
 before using it
In-Reply-To: <20210914203355.21360-1-bp@alien8.de>
References: <20210914203355.21360-1-bp@alien8.de>
Date:   Mon, 27 Sep 2021 11:31:32 -0600
Message-ID: <87bl4ehqmj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> From: Borislav Petkov <bp@suse.de>
>
> The CONFIG_NO_HZ_IDLE paragraph is using "dyntick-idle mode" before
> having defined it while the definition comes a couple of paragraphs
> later.
>
> That is leaving the reader with scratching head what that dyntick-idle
> mode might be. Pull its definition up so that it is clear.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  Documentation/timers/no_hz.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
