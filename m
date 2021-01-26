Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5C3057DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314416AbhAZXHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbhAZEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:36:41 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE90EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:36:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u11so18000818ljo.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1LlWkeSbCU+8eK5VQp4zW4V35HHf5JK2AOgO/JAOhA=;
        b=QutNPMwrz22QyIksGybIjqyNkdkn2TTRfMqUHm4tAuSawCDjtKLuKp4GVCZkL6zH4e
         elxntLvscHEp4P+du0Uqtu+bmKi+lgSMkswGkgihGYwKxy5PmboIUKEeU3ZXiaXHw7n9
         wkM1rjruATUjkpUiM+L1YqkDyOBjyG1opk5HbEtKGj0wZZJyLbpmtoPOzHtDYkh2m5g+
         9JmQ9OcKwKDe26AC3rYPpumbEAOBDnJxWEDfSzJp38P4Dq+bfqSBX6ha8TiMfDi4LmPX
         dG5n2lMHim3vQK6ecHIt3UYOdhA6Xtqe4FYY2eYGZsqb/Vg1lhJPi0HUzvTeefgGc5ZX
         aErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1LlWkeSbCU+8eK5VQp4zW4V35HHf5JK2AOgO/JAOhA=;
        b=etjlUK+xSDwF1E93wB+TCOuGd9eCVmzDHB6+mQI9hgc3AhbHWLBy+Z0E4ZamV/8Phy
         gumV8TF2u6wS4TN9IsPbg8ByenMMZ00r7BKrzAd+yhLbMFsDf3x2FKfEAETg5lp2oRTB
         c7bJfzLeXeoMUS8OKpe54A0/xHsNP+j89o0XijbqJET8Ba5dAbLcktC8ptf1bydlPsO6
         TsG9n6Qat0yyGXXqTYAlZOAHjHmhvXy1L/ZifVH5bq2yB1UF1ZyEBhQkqsXdaKN8djju
         j1m3fl1iykvfi/zCdCWkAhbPjUj4XW2mA4N/N5C4J7GwthuFTPF+pRcWVA/IuTDoCqbr
         W4bQ==
X-Gm-Message-State: AOAM530cGecKmZ2ucffwqm2thG7xlVfdtXWi2uuTrxugC27BOKFm8kYD
        D7GF3T26bvUHa7tIExJEX3VqUclcQxpARzjkZ/QQxw==
X-Google-Smtp-Source: ABdhPJz7W2qEeDhfgl7DWVpV4Q1pHs0TZ4dBO2vCmGJYGtt3GJlr5VdX3syh5mqDvOxcxh6knTskyWzZbiIECxrz8lM=
X-Received: by 2002:a2e:3309:: with SMTP id d9mr1900557ljc.245.1611635758956;
 Mon, 25 Jan 2021 20:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20210113160557.1801480-1-elver@google.com> <20210113160557.1801480-2-elver@google.com>
In-Reply-To: <20210113160557.1801480-2-elver@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 26 Jan 2021 12:35:47 +0800
Message-ID: <CABVgOS=sOZ29Q0Ut8YSKD+BrXDQwGftPeYEoON_iOxajK_wL9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcsan: Switch to KUNIT_CASE_PARAM for parameterized tests
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, boqun.feng@gmail.com,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:06 AM Marco Elver <elver@google.com> wrote:
>
> Since KUnit now support parameterized tests via KUNIT_CASE_PARAM, update
> KCSAN's test to switch to it for parameterized tests. This simplifies
> parameterized tests and gets rid of the "parameters in case name"
> workaround (hack).
>
> At the same time, we can increase the maximum number of threads used,
> because on systems with too few CPUs, KUnit allows us to now stop at the
> maximum useful threads and not unnecessarily execute redundant test
> cases with (the same) limited threads as had been the case before.
>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---

Thanks! This looks great from the KUnit point of view: I'm
particularly excited to see a use of the parameterised test generator
that's not just reading from an array.

I tested this as well, and it all seemed to work fine for me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
