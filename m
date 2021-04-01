Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35B0350FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhDAHT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:19:56 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:44845 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhDAHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:19:50 -0400
Received: by mail-lf1-f46.google.com with SMTP id d12so1316038lfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 00:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RG0cIOeeDttNPxGbdwFSZXm9dJ/yfyeiln/lD1h5lxE=;
        b=r0OmChyRFo4jxEv+PNyZ49FZLxDeLvcffOLcE5d/GeVOloUVkHdsGJuy7qjuyPccY5
         hXfOBOyPzTdSXpS9LwUwin9TXFddGBo7AEhfPzH7Lu+8+DSv2qwFdF7MYQ1cexYMTTLw
         XIakzQGhfdIJl8I8IA968hUyiyxkX7+Hv0VXFdHkFIXOFnvBPAa9mKyMvZ6qahLto/sp
         8hhwr3bE+kxu0JqOYGX9pTACfKqfOdc82q6tfwK7o3T7sEeY9mVglorc06nW5OK0DZ9Y
         7UnCZ9SxHmG2TrWIFj1qXxzKSZxuvQlNminbNd4bMT0RTvDlhBbfpUKmLmSZrBU/wrl8
         XXEw==
X-Gm-Message-State: AOAM532DIsNOKfU50UdkcRZOSg1EZG3OjJHuuUrZlLkVQ8vexsu0XhOP
        /YAMR9VznTzGHARGIm8CwiPfnk++o/Tf58CHKww=
X-Google-Smtp-Source: ABdhPJzDQU/44oYFaEW5siH24IF25dcyvFdkQ9WagnO6Ug5vEFkcY5dAAtzYj2CMsvCgJQsg3JBhVbIxQsw+uPHADLk=
X-Received: by 2002:a05:6512:b26:: with SMTP id w38mr4529142lfu.152.1617261589487;
 Thu, 01 Apr 2021 00:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210401062424.991737-1-wanjiabing@vivo.com>
In-Reply-To: <20210401062424.991737-1-wanjiabing@vivo.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Apr 2021 16:19:38 +0900
Message-ID: <CAM9d7ciHzUDJc0KutAKoBqB2RA7pheB44=xv7dZ97=UqdNtv_g@mail.gmail.com>
Subject: Re: [PATCH] tools: perf: util: Remove duplicate struct declaration
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Apr 1, 2021 at 3:25 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> struct target is declared twice. One has been declared
> at 21st line. Remove the duplicate.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

I think we can move all the forward declarations to the top
(and sort them) as well.

Thanks,
Namhyung


> ---
>  tools/perf/util/evsel.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 6026487353dd..998e5b806696 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -157,7 +157,6 @@ struct perf_missing_features {
>  extern struct perf_missing_features perf_missing_features;
>
>  struct perf_cpu_map;
> -struct target;
>  struct thread_map;
>  struct record_opts;
>
> --
> 2.25.1
>
