Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90B431F65B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhBSJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:13:48 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:45757 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBSJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:08:16 -0500
Received: by mail-lj1-f180.google.com with SMTP id c8so16384211ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xyq5nG2yr38aemsnJfNSmiVO/9QJ0+e2d+IFGadQ8SI=;
        b=V45WOSS/UYELHUUlWuixpQpmyv8gOPzCAfRXqffKLfIDKZYmNSC+Eo5lWAmNmzVHEs
         9MY280ME01/Ek3nwU/7x9gJMI4eqeMm8h/Sl8fIhvxlZB23dT1VWIL1kFQM19MWtRvF3
         VZkfXIlYIVzoo/aj7VT6ldJT+HRcgi3eQ59LoGzqAVl6S1lK+6ewVgexDTaZhfUG3Boz
         GKha6OkGNuJxHtJXXxeD0xBVx6XxcUthjlWo8PdIoHgJ3xb/+dMlaF4Esa/pno2BH9oc
         egxfj+po+XQW1elDUDfYo9mIUmqK3WA4+R6F/khpoye0koITIopMCggjSCffZOCR5OWx
         93+g==
X-Gm-Message-State: AOAM5320qF+Gc/zeo7ihGNcRTDWt4+dqMdWsotNiTqTlMnuaaaOnqi+7
        kSXjBfMaMQw5RYWGEXsHR1lUaXBKv3kCVg==
X-Google-Smtp-Source: ABdhPJyh5xjPIJcNbDRYZFGZdha1/lEiSWn8YXBXcjs4x5PCv6Jf96UBIOZJyxu9rGD+IAsWBb48xw==
X-Received: by 2002:a2e:9c94:: with SMTP id x20mr5246491lji.366.1613725652675;
        Fri, 19 Feb 2021 01:07:32 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id l23sm911213ljg.72.2021.02.19.01.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 01:07:32 -0800 (PST)
Subject: Re: [PATCH v2] coccinelle: misc: add minmax script
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210216080133.455456-1-efremov@linux.com>
 <20210219090520.8812-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <d12393d9-982c-53f5-9db6-0397aef95179@linux.com>
Date:   Fri, 19 Feb 2021 12:07:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210219090520.8812-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for wrong thread, I'll resend v2 to the right one.

Denis

On 2/19/21 12:05 PM, Denis Efremov wrote:
> Check for opencoded min(), max() implementations.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> 
> Changes in v2:
>  - <... ...> instead of ... when any
>  - org mode reports fixed
>  - patch rule to drop excessive ()
> 
>  scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/minmax.cocci
> 
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> new file mode 100644
> index 000000000000..61d6b61fd82c
> --- /dev/null
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for opencoded min(), max() implementations.
> +/// Generated patches sometimes require adding a cast to fix compile warning.
> +/// Warnings/patches scope intentionally limited to a function body.
> +///
> +// Confidence: Medium
> +// Copyright: (C) 2021 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: min, max
> +//
> +
> +
> +virtual report
> +virtual org
> +virtual context
> +virtual patch
> +
> +@rmax depends on !patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {>, >=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	x cmp@p y ? x : y
> +	...>
> +}
> +
> +@rmaxif depends on !patch@
> +identifier func;
> +expression x, y;
> +expression max_val;
> +binary operator cmp = {>, >=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	if (x cmp@p y) {
> +*		max_val = x;
> +*	} else {
> +*		max_val = y;
> +*	}
> +	...>
> +}
> +
> +@rmin depends on !patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {<, <=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	x cmp@p y ? x : y
> +	...>
> +}
> +
> +@rminif depends on !patch@
> +identifier func;
> +expression x, y;
> +expression min_val;
> +binary operator cmp = {<, <=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	if (x cmp@p y) {
> +*		min_val = x;
> +*	} else {
> +*		min_val = y;
> +*	}
> +	...>
> +}
> +
> +@pmax depends on patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {>=, >};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	x cmp y ? x : y
> ++	max(x, y)
> +	...>
> +}
> +
> +@pmaxif depends on patch@
> +identifier func;
> +expression x, y;
> +expression max_val;
> +binary operator cmp = {>=, >};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	if (x cmp y) {
> +-		max_val = x;
> +-	} else {
> +-		max_val = y;
> +-	}
> ++	max_val = max(x, y);
> +	...>
> +}
> +
> +@pmin depends on patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {<=, <};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	x cmp y ? x : y
> ++	min(x, y)
> +	...>
> +}
> +
> +@pminif depends on patch@
> +identifier func;
> +expression x, y;
> +expression min_val;
> +binary operator cmp = {<=, <};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	if (x cmp y) {
> +-		min_val = x;
> +-	} else {
> +-		min_val = y;
> +-	}
> ++	min_val = min(x, y);
> +	...>
> +}
> +
> +@depends on (pmax || pmaxif || pmin || pminif)@
> +identifier func;
> +expression x, y;
> +position p;
> +// FIXME: Coccinelle consumes all available ram and
> +// and timeouts on every file.
> +// position p = { pmin.p, pminif.p, pmax.p, pmaxif.p };
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +(
> +-	(min((x), (y)))
> ++	min(x, y)
> +|
> +-	(max((x), (y)))
> ++	max(x, y)
> +)
> +	...>
> +}
> +
> +@script:python depends on report@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmax.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on report@
> +p << rmaxif.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmaxif.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on report@
> +p << rmin.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for min()")
> +
> +@script:python depends on org@
> +p << rmin.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
> +
> +@script:python depends on report@
> +p << rminif.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for min()")
> +
> +@script:python depends on org@
> +p << rminif.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
> 
