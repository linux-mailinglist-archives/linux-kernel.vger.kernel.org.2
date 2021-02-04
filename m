Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49D030FFBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBDVwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:52:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:52624 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhBDVwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:52:05 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 946201E77;
        Thu,  4 Feb 2021 21:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 946201E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1612475479; bh=JKWAHZUEZSPNRnRWcyM2ssLUmsuuTmFbsEXwJlB7SiU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rV3YIRtHR4MuWjipzYKONy79QxyimSKBIdJOHsg4O7oiGeAQ8zGqOiHAQmA9IN2/P
         G267bkkU7Q7qrvDCEsPZS7P83iy8nPAWfZrpf7U0hmo3+n7c3KRNFXTcAKMv9ZPD+y
         qiVkyMVTZNY1qqECVhuiFbuZy4Dj5GOuqAuD0cg+mfL8tcE1TVCbfDM6odMi43pKxV
         ojYcC+qlT12yyo5pPeVQLyVVMCORbhSX4pgn45DIVgLF1Q8U9YOzFhWAqu/FnrqM61
         ynnQyQos53VN8HZXc2hPC6+PvpBASzI1v7CkIy4LMSpF3zKokZpjNiZXn4uH2NuntU
         j5zhYAzx4kRSg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: Re: [PATCH] docs: thermal: fix spelling mistakes
In-Reply-To: <20210129132035.16967-1-f.suligoi@asem.it>
References: <20210129132035.16967-1-f.suligoi@asem.it>
Date:   Thu, 04 Feb 2021 14:51:19 -0700
Message-ID: <87wnvnec2w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Suligoi <f.suligoi@asem.it> writes:

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/driver-api/thermal/sysfs-api.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
> index e7520cb439ac..71da7dc8c0ba 100644
> --- a/Documentation/driver-api/thermal/sysfs-api.rst
> +++ b/Documentation/driver-api/thermal/sysfs-api.rst
> @@ -54,7 +54,7 @@ temperature) and throttle appropriate devices.
>      trips:
>  	the total number of trip points this thermal zone supports.
>      mask:
> -	Bit string: If 'n'th bit is set, then trip point 'n' is writeable.
> +	Bit string: If 'n'th bit is set, then trip point 'n' is writable.
>      devdata:
>  	device private data
>      ops:
> @@ -406,7 +406,7 @@ Thermal cooling device sys I/F, created once it's registered::
>      |---stats/reset:		Writing any value resets the statistics
>      |---stats/time_in_state_ms:	Time (msec) spent in various cooling states
>      |---stats/total_trans:	Total number of times cooling state is changed
> -    |---stats/trans_table:	Cooing state transition table
> +    |---stats/trans_table:	Cooling state transition table
>  
>  
>  Then next two dynamic attributes are created/removed in pairs. They represent
> @@ -779,5 +779,5 @@ emergency poweroff kicks in after the delay has elapsed and shuts down
>  the system.
>  
>  If set to 0 emergency poweroff will not be supported. So a carefully
> -profiled non-zero positive value is a must for emergerncy poweroff to be
> +profiled non-zero positive value is a must for emergency poweroff to be
>  triggered.

Applied, thanks.

jon
