Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523D43390CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCLPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhCLPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:08:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:08:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so5006467wrz.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N8S2s5rJcGUHcU1OSYPYZlzzNPfPJNrusRzWOjftzyo=;
        b=twQbMdDX+E/m9JxLOQUn4niREFm6u3gAjlBCftyWk/7Fc/oeTFWTqT9K7jY/8bju9d
         b5YxYepSmu3bX1j7LLh+LkFptHi1EiE7m2a2Ed3dP3BLPhtplfe85beWxk2KycARy3Dx
         nUbSAwMymVzlgNUMhY3f0c6x4ss8w8ohraRgOvp4ejdCYIGyuqk9v9U29N04WJD40jOv
         +Hp6h0zyAe+K2TsDXzbs4E1khq/VwC9xMn5AXy17uNZ9vNPzTQAFlAprxlE6puHVWg0N
         iZlC1sWYwMT4Q2I9ynUaPw7gq1/5CHSx3XY5ZuAqEedMV/Vgk95QAGdrXuY18mBlkq1x
         s9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N8S2s5rJcGUHcU1OSYPYZlzzNPfPJNrusRzWOjftzyo=;
        b=Z86WNJpqfw9mpH6CUanYJXTWqyg1gxMsazMFtuEd7332CA7S8pPYU/Tz9Da86exfKr
         zYF5vG1V3Nope0aESBk+yPYx3lwY2jiS91Ob1t0yfOWM9cp0RdcS8rsFXpI8psx/Va/d
         LVrk49wDst2lCGhK7LitgjpJ/LI2qnaf9DA2pLNuExrcsJv8faJRoirNFm7bBW9epDT6
         wrTipB006JR9HreQiXVnPbP+yQTADOhaXffEgdiO7k7iiKv0jGgs3OkNd+V+yg/13d9j
         C09FU8EI2Obox4N96O8VsvLQQBkkkGhfbsB7IIzDGph2sTTJ8POArktExzkmWd7n6Gje
         S/8w==
X-Gm-Message-State: AOAM533MfjdvA7CH/8KJjlwfJbHjYZLA073LZ3dcE9eo4+P2TE/MwZmE
        Q2QcBcqWJ4J3K8sE7qC2ATi9BA==
X-Google-Smtp-Source: ABdhPJz/fg6ZuEZUeczFW5KClcE82a/e1SH/ti4JB0iIeTLRh6rAj6AKum0qDQiG+Fg3pNtedgSgCQ==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr14242807wrt.80.1615561710089;
        Fri, 12 Mar 2021 07:08:30 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id j30sm9332276wrj.62.2021.03.12.07.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:08:29 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:08:24 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/11] kasan: docs: update boot parameters section
Message-ID: <YEuD6CIhVsSo9uqA@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <01364952f15789948f0627d6733b5cdf5209f83a.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01364952f15789948f0627d6733b5cdf5209f83a.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Boot parameters" section in KASAN documentation:
> 
> - Mention panic_on_warn.
> - Mention kasan_multi_shot and its interaction with panic_on_warn.
> - Clarify kasan.fault=panic interaction with panic_on_warn.
> - A readability clean-up.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index cd12c890b888..1189be9b4cb5 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -174,10 +174,16 @@ call_rcu() and workqueue queuing.
>  Boot parameters
>  ~~~~~~~~~~~~~~~
>  
> +KASAN is affected by the generic ``panic_on_warn`` command line parameter.
> +When it is enabled, KASAN panics the kernel after printing a bug report.
> +
> +By default, KASAN prints a bug report only for the first invalid memory access.
> +With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
> +effectively disables ``panic_on_warn`` for KASAN reports.
> +
>  Hardware tag-based KASAN mode (see the section about various modes below) is
>  intended for use in production as a security mitigation. Therefore, it supports
> -boot parameters that allow to disable KASAN competely or otherwise control
> -particular KASAN features.
> +boot parameters that allow disabling KASAN or controlling its features.
>  
>  - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
>  
> @@ -185,8 +191,8 @@ particular KASAN features.
>    traces collection (default: ``on``).
>  
>  - ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
> -  report or also panic the kernel (default: ``report``). Note, that tag
> -  checking gets disabled after the first reported bug.
> +  report or also panic the kernel (default: ``report``). The panic happens even
> +  if ``kasan_multi_shot`` is enabled.
>  
>  Implementation details
>  ----------------------
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
