Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64832A02E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575462AbhCBD4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344190AbhCAWvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:51:02 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF30C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:43:32 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id h8so18427227qkk.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSW03qXRNzDDWUFd7HDVgAkqmhLV+uIrk9Nn7LdcJQA=;
        b=drUkO2+KLPEIvI8tMqJjJb9nI3O6lfZOPMqiw32jogITD6yPK2lJ6CRWJyZu2FXq6D
         eGwQ6llMSy51834BWN+9xSe51F+x0CDiVHP4JgyeIr/DPQEYs0HHYbKvFJwy5nSkT+7o
         MQmTVUeL6YlzNqkHelJVuAyZ2HtwPyNVBmQdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSW03qXRNzDDWUFd7HDVgAkqmhLV+uIrk9Nn7LdcJQA=;
        b=h92zSiVSZWE+2aAtovk+VTgHYJ1JoDWr2QWKFUHlPs0qEj8VvO9N2XbyhxYNRYw0eb
         HWJa3qhRg0vST6LlcEr0hKcj5iX/OCst95RUfI6bFvAIuOrSa13tL/P6hNdy1cV4js4S
         2ecNQhbFI0e8/DRR6LIzF6w2sD9FqKcBnfrqERsfNHe31ypjr6bZjvTw6vH+Fy/uti3K
         C+8CftMqJKKVrNob2RCn+BLXmCdXFLSFBlH4YDQwlPcTGwD75nQtH6lr8FEy+hOg5upR
         6+B25UNFPCkWaH+qwdWWqwFIU+uZMxiqIwIyMLumUKXQNg4jPPbJ6lWbTMp3T2PlNYi7
         fquQ==
X-Gm-Message-State: AOAM531OAYPnBYixsbMBdH+R7nfTMQbQf+hChLQYCtdK02fBvgCDWmaJ
        Oly/HAK7IypJyXynE7RM31l5FAJ8JyasSg==
X-Google-Smtp-Source: ABdhPJwhG4Bq5Zq4WvLFoOh/YKmbpO5bNfre+hgz6DBleEYW4nrqH/EbLJpRsfAR/4tJ1q7J/DtKfw==
X-Received: by 2002:a37:9444:: with SMTP id w65mr16813280qkd.88.1614638610856;
        Mon, 01 Mar 2021 14:43:30 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id d14sm3607814qkg.33.2021.03.01.14.43.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 14:43:30 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id p186so18679498ybg.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:43:29 -0800 (PST)
X-Received: by 2002:a5b:84f:: with SMTP id v15mr24920639ybq.79.1614638609454;
 Mon, 01 Mar 2021 14:43:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614624041.git.saiprakash.ranjan@codeaurora.org> <523a5af43615b804aa1211a3f27e06226d7159bc.1614624041.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <523a5af43615b804aa1211a3f27e06226d7159bc.1614624041.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Mar 2021 14:43:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQbVpOLz_xavCPXQ9gN-9G4J8qN3+5f0E3jYZDDx4Cjw@mail.gmail.com>
Message-ID: <CAD=FV=UQbVpOLz_xavCPXQ9gN-9G4J8qN3+5f0E3jYZDDx4Cjw@mail.gmail.com>
Subject: Re: [PATCHv2 2/4] perf evsel: Print warning for excluding kernel mode
 instruction tracing
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Al Grant <al.grant@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 1, 2021 at 11:05 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Add a warning message to check CONFIG_EXCLUDE_KERNEL_HW_ITRACE kernel
> config which excludes kernel mode instruction tracing to help perf tool
> users identify the perf event open failure when they attempt kernel mode
> tracing with this config enabled.
>
> Tested-by: Denis Nikitin <denik@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  tools/perf/util/evsel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I'm not really knowledgeable at all about the perf subsystem so my
review doesn't hold a lot of weight.  However, Sai's patch seems sane
to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
