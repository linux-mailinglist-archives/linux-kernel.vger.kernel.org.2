Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A671130A08E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 04:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhBADdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 22:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhBADdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:33:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A10C061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 19:32:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m12so301878pjs.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 19:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fBoO4RYEH6byZoO1WlacVJT4VjUFT90WWDlxk4juvyk=;
        b=xEvn8GXDCUMeIsvBdDna7NRSuc5e8RWokoUNNOtIYCW6OeJJCghEXIsiGsKoz9e4xR
         6uMpYoEp/BA+sw9AYzRBpLwjE1iNSQZuL3IhAVTddfGiKid60yhHGJ3FR25RKuA+s+ui
         q8FrPimYsAPCc0fADjucbeeXUKbpSQYW6X2DWpjvl/i7XBuwxVzcEB36XudW0WWrEHfi
         MHTPb2oiDtlVImO/+uSt8ijd8gXUDXIU2iVkvil5T0czjoBYaGWlUykmj0xq7ot+tdzH
         AzsJZgpsxYp87VX51dklFpwqlPAnsZTwNihY11TWhJ0M0viKcYmPIYqE12+4c+AgcT66
         11MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBoO4RYEH6byZoO1WlacVJT4VjUFT90WWDlxk4juvyk=;
        b=BkkrZDiVmRddc8n5U6ZtTfCx0O1XizS+D1hXRtH4BNP0xUpwloAMCQ6d7NiqCnRT1M
         ReEmasHNYMnF+6qyBrqzoABOx1F1qB3XAa88YIplLklzv/LdsVkI9x/trGhK9hw78uLL
         HUdVJCj8qJMFq9QGfWnG+qNS2ivclhdF7xILqTSsrDTgy9I21YFBqKnaiVj0iRo+0uhy
         xbnvGv1zrvhcWWqwPgGiEzsMLzVzB+bRJI/f+wGEy8D242OA/vLzvHBKuSFcIgtNEP1e
         UPlfjrLyIR6N40hr97463/wSXfcjxlqn6ViA4Iks0k80TcIeiPAglhgchtvgUgzv6SRD
         qSog==
X-Gm-Message-State: AOAM530WiNgZ4vhmu1h9LfCTdGBzPmgMNXFHWbu1FJD8nst9KQlwMg0x
        JnMaH/eG0cf7C4sHTc92r3pcIg==
X-Google-Smtp-Source: ABdhPJyyF+HHexoS1dd8kPDCEzHezLwX4Nc9PqM3CZNwbO9c+x3NSq5bWABH5gLykhXMaDM/T6M2HA==
X-Received: by 2002:a17:90a:9602:: with SMTP id v2mr15181860pjo.28.1612150355069;
        Sun, 31 Jan 2021 19:32:35 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 17sm16247628pgy.53.2021.01.31.19.32.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 19:32:34 -0800 (PST)
Date:   Mon, 1 Feb 2021 09:02:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: thermal: fix spelling mistakes
Message-ID: <20210201033231.vhhmaf6lvqpiegmk@vireshk-i7>
References: <20210129132035.16967-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129132035.16967-1-f.suligoi@asem.it>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-21, 14:20, Flavio Suligoi wrote:
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

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
