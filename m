Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B203472E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhCXHnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:43:33 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39429 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCXHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:43:26 -0400
Received: by mail-lj1-f181.google.com with SMTP id u4so28956514ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cdqTVg+Ahm97YQBNHuCQzwsa15Gkq0Cek2B8TrxC8x8=;
        b=Hw5Taoui0VLOIhl7qzwEhcb628VapwS8PyNZvsqAA8zGcV7iQHgweVL337QEx6swYu
         tG6D115nDkzyrtc1jdWcNN7KXCphF1aFOldj5jWjEfo6B40PWJJAtOWMo73VXkIMJ1QI
         yjzFckJoaOPsfIhWUoYaeDU9wuPaMuu45cqKpQp8yz6p76LfRKT+Dxm9hwmrdMxgvdHE
         dur4myr8Ew2ifsOIlAaFGtEpD+SVEKsOefZ5m8/xVKnyO3DbTPqSwHE3KVKPx0y8GAQ0
         OPquAG0CAmGROPwOq9HRCnQJNcEPQ+LLw7XXt3HD8ZJokDm6nWjyFRWkvICLMdHo4914
         cocw==
X-Gm-Message-State: AOAM530mXhXhTJGQTo3Ir7Cn4eFKKQ2IPTDE6y7I3JJG1E39XqV6OOj/
        OXtmQ0jrQh9xxwBHg0C+gecEqP3CYz4akg==
X-Google-Smtp-Source: ABdhPJzhqw7O1cTznOlG1TOhRnhqie4oQq7rnNiEpqFhQKU/KVbqDj709VUrCW/MuInHMQuRBWZr0Q==
X-Received: by 2002:a2e:7007:: with SMTP id l7mr1271212ljc.436.1616571797449;
        Wed, 24 Mar 2021 00:43:17 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id f4sm195108lja.69.2021.03.24.00.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 00:43:17 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: misc: update uninitialized_var.cocci
 documentation
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20210308073018.108487-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <a32bb28c-878b-44b6-440e-274a6002dac6@linux.com>
Date:   Wed, 24 Mar 2021 10:43:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210308073018.108487-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 3/8/21 10:30 AM, Denis Efremov wrote:
> Remove the documentation link from the warning message because commit
> 3942ea7a10c9 ("deprecated.rst: Remove now removed uninitialized_var")
> removed the section from documentation. Update the rule documentation
> accordingly.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/uninitialized_var.cocci | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
> index 8fa845cefe11..69bbaae47e73 100644
> --- a/scripts/coccinelle/misc/uninitialized_var.cocci
> +++ b/scripts/coccinelle/misc/uninitialized_var.cocci
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
>  /// Please, don't reintroduce uninitialized_var().
> -/// From Documentation/process/deprecated.rst:
> +///
> +/// From Documentation/process/deprecated.rst,
> +/// commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()"):
>  ///  For any compiler warnings about uninitialized variables, just add
>  ///  an initializer. Using warning-silencing tricks is dangerous as it
>  ///  papers over real bugs (or can in the future), and suppresses unrelated
> @@ -11,6 +13,11 @@
>  ///  obviously redundant, the compiler's dead-store elimination pass will make
>  ///  sure there are no needless variable writes.
>  ///
> +/// Later, commit 3942ea7a10c9 ("deprecated.rst: Remove now removed
> +/// uninitialized_var") removed this section because all initializations of
> +/// this kind were cleaned-up from the kernel. This cocci rule checks that
> +/// the macro is not explicitly or implicitly reintroduced.
> +///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
> @@ -40,12 +47,10 @@ position p;
>  p << r.p;
>  @@
>  
> -coccilib.report.print_report(p[0],
> -  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +coccilib.report.print_report(p[0], "WARNING this kind of initialization is deprecated")
>  
>  @script:python depends on org@
>  p << r.p;
>  @@
>  
> -coccilib.org.print_todo(p[0],
> -  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +coccilib.org.print_todo(p[0], "WARNING this kind of initialization is deprecated")
> 
