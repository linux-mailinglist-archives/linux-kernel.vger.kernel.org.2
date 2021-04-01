Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D34352388
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhDAX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhDAX1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:27:14 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6CAC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:27:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id j26so3795687iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/Cy9GFSSG292kbWWXXjaNyNH/4apg+3HJDMSJ6lS/0=;
        b=cnGPeiI0reWFraLFVR4ze+oO/uopDQHdjCCjQGr7HYMB3+g/7D7+MyXjBwAxVqqAcg
         Z8gbSe19fHzXp+1tRlQB/wNt++TDIlccEIj7DzgssBOoHWqg75WcMQgHetZEA9vQ0dHS
         puqYQ22lO5Y3r6baZBtXdEkpznip1fHW1wVA4YeOAe7hqwQG7NsMkRxDy5ISkk6VicP3
         1YUxLe90IYzaODAl/7qi/l5c8aJZVpFzu4nvs4zzw8zcadsqPrjCtailwDOurWHsK7Pq
         TAQ9MNeZ8X4tgyvF9z7uXQ7rQgaoAf/R/qSlyHDc41d9/ou94mxwOVG4pGPJVC2W7w1b
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/Cy9GFSSG292kbWWXXjaNyNH/4apg+3HJDMSJ6lS/0=;
        b=Vf/V9r5XF8s/DEu8XIlL0MNuWZ8EGH2N06ZI3Kt9l4qn4bEpQR8tqQiVRzH/Fx+D6D
         GnZXeFDKfOQMXHFSmNhQiWcOAn/T5QZL3/HKthjAtqLYMixZNkupb1sXVybworgZKtHc
         AJe+QBF9gsVWvXSgcYDSReFHSe7twH80vKd/XvskbqxNTR2CB+ZeO+vzGGtiznp6ys3y
         0wGJ2CuWDxx9Mgaqfz0Ttn9S7HAnq+T0olDpmD6O5+KlFj8MORTQOb+90uSThRTh5+95
         ljivRFt8rBW9qetetkwj5PPnVYP+HzFueTK5mS6lMvejMuP9y0r/8Q9dk1udbgUlPIUg
         x0HQ==
X-Gm-Message-State: AOAM530i4W5AW3wq4NGy6EJlqqKlxqg0lDAneLO+2yTpRnjsNaxy7RqH
        IrC3/uZ9xTcAuk8xdXp0Tuo45FHm2l9xPT+w/9v50x41y9qZ5D0c
X-Google-Smtp-Source: ABdhPJy5WrUR32ElfKa80MigZbS1m8oMj+ZQkP4ozZ9oygO7G1Z+PTnvQcBiDCoRD/ZUi/2BaLZkWoRmbEi3OD8LhqQ=
X-Received: by 2002:a5d:8453:: with SMTP id w19mr8595652ior.25.1617319633765;
 Thu, 01 Apr 2021 16:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210401114504.13466-1-psampat@linux.ibm.com> <20210401114504.13466-3-psampat@linux.ibm.com>
In-Reply-To: <20210401114504.13466-3-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 1 Apr 2021 16:27:04 -0700
Message-ID: <CAAYoRsWKw2eXXoXGhdaM2pqhvDGXz8o=hV5K5HmYaZvetxv96w@mail.gmail.com>
Subject: Re: [RFC v2 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratik,

On Thu, Apr 1, 2021 at 4:45 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
...

> To run this test specifically:
> $ make -C tools/testing/selftests TARGETS="cpuidle" run_tests

I have not become any smarter than I was with version 1,
and still assumed that the "$" meant regular user.
Please put it as "#" or separate the two steps, compile and run.

>
> There are a few optinal arguments too that the script can take

optional

Suggest to also specifically mention how to run without re-compile,

# ./cpuidle.sh -v

Note also that the test still leaves all idle states disabled when done.

>         [-h <help>]
>         [-i <run timer tests>]
>         [-m <location of the module>]
>         [-o <location of the output>]
>         [-v <verbose> (run on all cpus)]
> Default Output location in: tools/testing/selftest/cpuidle/cpuidle.log

...

> +cpu_is_online()
> +{
> +       cpu=$1
> +       if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
> +               echo 0

incorrect. should be:

> +               echo 1

... Doug
