Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F843930D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhE0O0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbhE0O0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:26:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27FAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:25:04 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id v4so330960qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5ioh6/kmyR43pZvyyWx3jgh3NQ4aOfCzd/5djtqWu8=;
        b=uk1Clutn08ap0T0eYiCfBLwIre/sRgapht3WRTSb/OUz86VJK5yz1vBTHMxu/U6zTM
         YqtL/akei9DOsGUBMzxBwyWrksY5LQriwy+lYebt/K15XJVyvstz+BQ4izwCBbA6v85u
         o4N5jnOcO+4jk7cB4+k84aVnCN6+qkks38BBc6HPuA4f+UriPgZNqQ6oGHQjjiZ//4MT
         ypgXJjp0y+y2zzRQ1awvIiR+TVc3zxChipuUFY5u4wShlpQGC3K14lDxFs6rxWxxPufK
         h3L2wVOWANe9dPni62OaXYZV95+oNGkyNDclB4aLoBToQnycLzpEg9WfiXSx3Tlz4MtX
         jHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5ioh6/kmyR43pZvyyWx3jgh3NQ4aOfCzd/5djtqWu8=;
        b=Jmx90Cneo2Gk2XZq9kV/bDB4rJ/Z1BTc6q8pW/+9Zx4sWL0qCyaCv5jGMuS/GBPSXs
         Hnk5utXjMyH5XxptHqTfvKDlcl6bWpqnw2BEYYhkNtYarE3NW4t0+TujctaMndekpL7L
         IqHMQpleQe88VOo+pIimV+vyoc0+kBq5lFDaqpNUQ7WxQvR/HosALx9BEkQBXvwLd3dv
         vqYI5QE3vxWElwcQgbVV84qxQMJP6Xz7TTAnSgrrcaWXR++wAg3SHLYlqS+ZTSK31KFE
         MQ2pbg4Hi6XzZP8vM/dvSeV4YxlBEFGSaCtY01m414k4PuXSDdGywbW84BPS0JvvULr6
         lQmw==
X-Gm-Message-State: AOAM533L5V6NfxyLEbGd/C+PyQfjbiVk8IyyvLHDmGPJAwsyBEwLQWhC
        mQyag61ZrkuOMCsix0k17h+wX/NHzgHQ1LhRfQlw6g==
X-Google-Smtp-Source: ABdhPJwhdt5wcjjTW0iOJsm+wu8Rclsir1cSLjlKUZxzBn3wYrKchPfxZu0GBf9UQHH89vz8RX0cSJxrC/rC3ukFH2o=
X-Received: by 2002:ac8:699a:: with SMTP id o26mr3318904qtq.209.1622125503830;
 Thu, 27 May 2021 07:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210527122916.27683-1-vincent.guittot@linaro.org> <CAKfTPtAK2fkzhzKA8iFT8cEcCG6Q=8WfLskPYADvTrQ=nF7kDA@mail.gmail.com>
In-Reply-To: <CAKfTPtAK2fkzhzKA8iFT8cEcCG6Q=8WfLskPYADvTrQ=nF7kDA@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 27 May 2021 16:24:24 +0200
Message-ID: <CAFpoUr0FrSV5VO40q7pbnqiiqCYbgS_YUp1Kktfn6YgOgh8whw@mail.gmail.com>
Subject: Re: [PATCH 0/2] schd/fair: fix stalled cfs_rq->tg_load_avg_contrib
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yes, this does the trick!

I have tested this locally and it works as expected, as discussed in
the previous thread (more info there). Together with the patch "[PATCH
2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle", I
am unable to reproduce the issue locally; so this is good to go.

Feel free to add this to both patches when the warnings on the first
patch are fixed;

Reviewed-by: Odin Ugedal <odin@uged.al>

Thanks
Odin
