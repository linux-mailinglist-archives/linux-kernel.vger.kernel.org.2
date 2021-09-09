Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348C6404887
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhIIKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhIIKgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:36:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78CCC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 03:34:53 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 93so805057qva.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGMqJnOir1+cYUQY5iIAYPXDmHOFVbSMzDJHUxueGwM=;
        b=hqfKwhuHkAWwH9oxhi0FYe+K6nDsG4IXbVo+4X85g4XEiHHBugH2qjKt4D8NH3UvGC
         v3f711yie0mGm9guPptXEFy8Oh1vpiH0SfWA+Zr6ZKE6q0nhtbTFLEazsUeV0inqSDif
         ag63Ho4LtG2Zzfk0Stz9yDUcjOm7Ffo4a6VnMSCAl6AQntRl13oXX24mzDofUPOOpTt6
         E0DxoKdkrFi00/HNXZZDYW4vE+eaTyNRtI57p/zIbJxQp0BHyO014LD7bJJXBJiyKmD4
         N+IBhSegd7nH6mWWAKumrx8rVkhh5s7Q9pPfqVgB6CPE1bdMsdUQY6VeIouzlJpvSJF9
         37vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGMqJnOir1+cYUQY5iIAYPXDmHOFVbSMzDJHUxueGwM=;
        b=7YS6gswA3B3FTE4L9ml4KQ+M0TLYzLVlhViACY6snELpvmHzelJs9tWmTnVhwGfL4P
         cIa7b20vOlB1tg3V5wxQsIpmYfmBxneS2Jqvqml8Yz/BkFSJEvSMYetvWv+3ejI2W19+
         ad1+YSBCgHufcfcN+zJ5CgzTJEaMkKlME9/f6iMS3aZohQlid7thT5dY7XigtjK35dUC
         tCpGBCrSJ+dSqrx8+5ZiO3BrhTnr4VeGTFrzWqzOKgS+lLygGzhTg9RLiUGgps27JwZ1
         FeCIfs94fyZtBerUK1NCMUeZRP7x8n90tLtGfhKGKdMAvfuu8Wrppc0dODEz9C/ac+z1
         Kq9A==
X-Gm-Message-State: AOAM530ENFgiPZkPp/oVfIQhjy0ellnYICO5WTqfJSDoNxWgxdzz2/Sc
        zBtnKpglLsEDASRdUIM8aUlxjv0dX/3xWlEIGft5QiF1
X-Google-Smtp-Source: ABdhPJymjxFd2a+n5NsJma4qk5NVz1PCiu+Fy3tKRxgB069yWNsNec/+2HNh3LyKp9hRKhSmMQDxfTSfZFdEhpkjEv8=
X-Received: by 2002:a0c:9103:: with SMTP id q3mr2137963qvq.36.1631183693146;
 Thu, 09 Sep 2021 03:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com> <YTnWXIB42sCLbM2k@zn.tnic>
In-Reply-To: <YTnWXIB42sCLbM2k@zn.tnic>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Thu, 9 Sep 2021 18:34:40 +0800
Message-ID: <CAJRGBZyQuQohbf8v3H19zo1mpbvDXrbNVXCJAUpCEmHgmqTYpg@mail.gmail.com>
Subject: Re: [PATCH] perf: optimize clear page in Intel specified model with
 movq instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jinhua Wu <wujinhua@linux.alibaba.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        zelin.deng@linux.alibaba.com, jiayu.ni@linux.alibaba.com,
        Andi Kleen <ak@linux.intel.com>,
        Luming Yu <luming.yu@intel.com>, fan.du@intel.com,
        artie.ding@linux.alibaba.com, "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        pawan.kumar.gupta@linux.intel.com,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        ricardo.neri-calderon@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 5:41 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Sep 09, 2021 at 04:45:51PM +0800, Jinhua Wu wrote:
> > Clear page is the most time-consuming procedure in page fault handling.
> > Kernel use fast-string instruction to clear page. We found that in specified
> > Intel model such as CPX and ICX, the movq instruction perform much better
> > than fast-string instruction when corresponding page is not in cache.
> > But when the page is in cache, fast string perform better. We show the test
> > result in the following:
>
> What you should do is show the extensive tests you've run with
> real-world benchmarks where you really can show 40% performance
> improvement.
>
> Also, the static branch "approach" you're using ain't gonna happen. If
> anything, another X86_FEATURE_* bit.

do you mean jump label would not be replaced to nop when its key is enabled?
so we could not use it in certain functions?
I don't understand exactly what "ain't  gonna happen"
>
> Good luck.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
