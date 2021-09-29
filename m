Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B901341C9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbhI2QMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345723AbhI2QMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:12:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB33C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:09:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q205so3799763iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACUKWINJ+b06A5Dd/rYTKUJ9Y6q0KbWlxJSrgmw5wHA=;
        b=MOc/3VdQCP9UfKju2Uqc1gSeyJTWl8zXipu0hevSto3yALhXsOmo+pY1Hb2lYDPKDp
         qc832qgrr8pNocPHOPEDOQAG+MSlbU/YHGvL7N0/vq6KM8nbs+lcJyP8vvDCg8vG/5YP
         lA8Gd2GAa3dgO1+Ved/3ni8ZSXdSYQWkfx7I+QkBF1s1SoOJFxgT1fGkb6RIZJEi47uJ
         C3gGTMH/fZAqgE+P8iJ72fjZIDvozOXpAuH/bXEJdK9jKQNXjKSfPa3tUgNQ4EBTC6BS
         jWj+ogFJoD2S2uN/1D6BiAqR4Dpit1IPt48nBqrGUC3XEivutYWFWaMSRhemhz54VRle
         5Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACUKWINJ+b06A5Dd/rYTKUJ9Y6q0KbWlxJSrgmw5wHA=;
        b=aI+TFljL3pWIfl0JMbCJdxkF/M1YvVtKpmdWxgF46A0hgFd11IOMeTt4V0VzJmBZlC
         DbDOLqJ/7V8m/D65Ygi8yt+SQn8vCPbQyl54L67glyKa+4NpuzJoO31zH8Wk8AVryDH+
         0j0XAGCacLeFO1G4vkk808Qm6DnnRjGSDnmrCyYpbdoXOsvUCv/gIpgV5nWGCLrAFIWu
         SOULJJ/ztIKyZrsDKwMSZcjbUfwkAJ06daMFQnUUxO2yN4AK35POAw3IAY12tcasjTie
         E7ohnvJmpF5UmrkmNBswmhcQt1j2afbPV7kIFCE9O28ua+jm2kNnaKtyvSJ17/7moM2x
         579A==
X-Gm-Message-State: AOAM533rQen+6+JILru/o3hjPrnsqldLztzRIhrC/wFrx9HeZ+8QKok1
        Z59IrgxZ4dIuxc0KPfeE8V76B46PEMcIhu9e3zQM1Q==
X-Google-Smtp-Source: ABdhPJy0gIx1+yVcS/UAQTXH0ffONVAs642RbjnsR2662Krs+4wo4y+Wj9uF+tsNYNB3wKON/rz76H4EUrkWJNPKguw=
X-Received: by 2002:a5d:9d8e:: with SMTP id ay14mr439562iob.32.1632931778709;
 Wed, 29 Sep 2021 09:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210923074616.674826-1-irogers@google.com> <00eb6280-fad0-66c4-b957-a4d27dffd0da@huawei.com>
In-Reply-To: <00eb6280-fad0-66c4-b957-a4d27dffd0da@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Sep 2021 09:09:24 -0700
Message-ID: <CAP-5=fXcq6Npio0n9y8znknNUGJ4ovtbi=hHr4jWG6H38=BzSA@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] Don't compute events that won't be used in a metric.
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Paul Clarke <pc@us.ibm.com>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 8:16 AM John Garry <john.garry@huawei.com> wrote:
>
> On 23/09/2021 08:46, Ian Rogers wrote:
> > For a metric like:
> >    EVENT1 if #smt_on else EVENT2
> >
> > currently EVENT1 and EVENT2 will be measured and then when the metric
> > is reported EVENT1 or EVENT2 will be printed depending on the value
> > from smt_on() during the expr parsing. Computing both events is
> > unnecessary and can lead to multiplexing as discussed in this thread:
> > https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
> >
> > This change modifies expression parsing so that constants are
> > considered when building the set of ids (events) and only events not
> > contributing to a constant value are measured.
>
> Based on some testing on my arm64 platform, no regression seen, so:
>
> Tested-by: John Garry <john.garry@huawei.com>

Awesome, much thanks Jiri, John, Andi for the reviews and testing!

Ian
