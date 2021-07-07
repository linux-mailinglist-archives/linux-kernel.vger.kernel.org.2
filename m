Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE83BF1E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhGGWRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:17:16 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:37378 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhGGWRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:17:15 -0400
Received: by mail-lf1-f43.google.com with SMTP id v14so8391864lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9K0BkBCBw+RmkbL9QYCPWa28Ido9s+Dk7ukJ8FV0eU=;
        b=P8STMe3Uhp8wh1OurinvjUQ+i1fArST8S/GAjXGgDcoHvVwRYqRuFp7VzLWFHHMQus
         wuIAh4iN/uqDgSIhRzgA0EOnlCS6LN9c8QsQZ0VKsC3aKtes7MZyhVwleZ2Y0PbjLOyj
         IdUOSTaLa+5zCjGfm+JhepVk2A/warNUVVZA7FjiOck2AaiFuGV2xmvOVSnngBtS4pg0
         otykZVuyplPMrOJyHLJCMTN/Pr6iUI2KptUuqIpH64IThvgM18h4eoyiIMs79lNvHfDN
         I8HNTZi3ceMQRwxdklp1y5topq764HcGs7ZkyGmQ8AQr8+gCUdDAkXBw0Q38q7qTt50C
         MpkQ==
X-Gm-Message-State: AOAM530Nvn973N2xAT1Y4D3++kCGi+isvKNoxHOWy/12Gsp5KsHpVR0H
        9bB25jYnlULXUDyEenhFBNUpZBd3nlBhLaFJQMUHar22
X-Google-Smtp-Source: ABdhPJye+wkZw3Hzb60m9wwjVYL8EOC9OIgOSO/vVMqGgmglOyn7zoffdBCoAimwoAkWDNAO6oluJbmrFKVohTuFCcU=
X-Received: by 2002:a19:8c0f:: with SMTP id o15mr21030071lfd.509.1625696072757;
 Wed, 07 Jul 2021 15:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210707213623.250212325@goodmis.org>
In-Reply-To: <20210707213623.250212325@goodmis.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Jul 2021 15:14:21 -0700
Message-ID: <CAM9d7cjQ+9tSXZYfYaUMumH=b2yLYm0Jp+MpbA15J8YUOqpkjw@mail.gmail.com>
Subject: Re: [PATCH 0/2 v3] tracing/histogram: Add buckets to group data in
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 2:39 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Add a .buckets modifier to group the data instead of having every key saved
> in its own entry, and in a linear fashion instead of like the log2 modifier.
>
> Changes since v2:
>
>  - Rename "grouping" field in hist_field to "buckets"
>  - Updated documentation to describe the new modifier
>
>
> Steven Rostedt (VMware) (2):
>       tracing: Add linear buckets to histogram logic
>       tracing/histogram: Update the documentation for the buckets modifier

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
> ----
>  Documentation/trace/histogram.rst | 92 ++++++++++++++++++++++++++++++++++++---
>  kernel/trace/trace.c              |  1 +
>  kernel/trace/trace_events_hist.c  | 65 ++++++++++++++++++++++++---
>  3 files changed, 145 insertions(+), 13 deletions(-)
