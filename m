Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A13CBAE5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhGPRGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:06:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4CEC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:03:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a132so808325oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5+sbnoetmWZo2JNdEqLWaey1bVFrcYQ13fx9gWuL+4=;
        b=hzZyj0MCkTQEI714kBick4I22s4vTbHAm0FVKUrPd9kWwJaGfZjIiELv12bqvZq1f/
         JyD9ZsuD7RVFB15M5VPOX4S3TrL4oO+aIXXEnpNxp7p2HOaZ9krO50+PN8n+t6IZY6XY
         TkDXHGsWIE2/DpP41ZryBix+V+K11vBkpE+OVxl1VOcmbWVttNQgy5rMZtDlaQkb2fQ+
         3XltIf1JG3/2aOstZtJRm2aGtcGkp4yDkF3HvSIneFTzHKj6VLtkjftx4clrYx+5JSeU
         Q7vE3+v+uyjJl3hGoa3jOEL+uOEfyike6aJrHLRCaD7pbm5Qd4u7MVIEWmonDyZa2Wg4
         qeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5+sbnoetmWZo2JNdEqLWaey1bVFrcYQ13fx9gWuL+4=;
        b=iBDt20D59QXrqCRFCj1XOYxoINSiqFSrc99XWvE5zF3NOJmxcunVZKRr6N8S5QlEdw
         aspD2FVj8xQhAMRjrKDqS0Nj8fAZQwrMuw82wlUBWh2XuOykpMDca4ECuL7HFFTo7Guu
         z8cxMExPeksPHdEslGzUiU5RQt2ZB1gcZjYPpAdwo/LJ47ctQTGIRCUpHFtvpnVJ2bhQ
         8YC5KvI4mxPj37LHdu/0fw02KMi8m9XbqAQdmRXeSxMu9YqC7ImJZf+Iu0RfroFDX/4Z
         xK1ndLFBkedNTTIZMSq26WfphiO9FFfXsDGCDkeYSB7sFYFPE9y8LXMP01hdkJBohqTO
         RpEA==
X-Gm-Message-State: AOAM531A+FKQxg84rIjxIuRs+sj0VUOp1ULC3JGGyVz7LeKKNXlhs/kz
        hO54MsoJMdrRSKuMgsfZ43FFcbYbYV6j7Wf8yBSqiA==
X-Google-Smtp-Source: ABdhPJz2dddfX2tS4rHdQ9DqMKSJlrede30CF/SfUWxVe6cF+VvFPNN4iqgNsuQfgJ/t5rL3oSzeJcyqJk9P/RFjuOs=
X-Received: by 2002:aca:1e07:: with SMTP id m7mr8420800oic.28.1626454989592;
 Fri, 16 Jul 2021 10:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210716085325.10300-1-lingshan.zhu@intel.com>
In-Reply-To: <20210716085325.10300-1-lingshan.zhu@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 16 Jul 2021 10:02:58 -0700
Message-ID: <CALMp9eSz6RPN=spjN6zdD5iQY2ZZDwM2bHJ2R4qWijOt1A_6aw@mail.gmail.com>
Subject: Re: [PATCH V8 00/18] KVM: x86/pmu: Add *basic* support to enable
 guest PEBS via DS
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     peterz@infradead.org, pbonzini@redhat.com, bp@alien8.de,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        joro@8bytes.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        wei.w.wang@intel.com, eranian@google.com, liuxiangdong5@huawei.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        like.xu.linux@gmail.com, boris.ostrvsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 1:54 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> The guest Precise Event Based Sampling (PEBS) feature can provide an
> architectural state of the instruction executed after the guest instruction
> that exactly caused the event. It needs new hardware facility only available
> on Intel Ice Lake Server platforms. This patch set enables the basic PEBS
> feature for KVM guests on ICX.
>
> We can use PEBS feature on the Linux guest like native:
>
>    # echo 0 > /proc/sys/kernel/watchdog (on the host)
>    # perf record -e instructions:ppp ./br_instr a
>    # perf record -c 100000 -e instructions:pp ./br_instr a
>
> To emulate guest PEBS facility for the above perf usages,
> we need to implement 2 code paths:
>
> 1) Fast path
>
> This is when the host assigned physical PMC has an identical index as the
> virtual PMC (e.g. using physical PMC0 to emulate virtual PMC0).
> This path is used in most common use cases.
>
> 2) Slow path
>
> This is when the host assigned physical PMC has a different index from the
> virtual PMC (e.g. using physical PMC1 to emulate virtual PMC0) In this case,
> KVM needs to rewrite the PEBS records to change the applicable counter indexes
> to the virtual PMC indexes, which would otherwise contain the physical counter
> index written by PEBS facility, and switch the counter reset values to the
> offset corresponding to the physical counter indexes in the DS data structure.
>
> The previous version [0] enables both fast path and slow path, which seems
> a bit more complex as the first step. In this patchset, we want to start with
> the fast path to get the basic guest PEBS enabled while keeping the slow path
> disabled. More focused discussion on the slow path [1] is planned to be put to
> another patchset in the next step.
>
> Compared to later versions in subsequent steps, the functionality to support
> host-guest PEBS both enabled and the functionality to emulate guest PEBS when
> the counter is cross-mapped are missing in this patch set
> (neither of these are typical scenarios).

I'm not sure exactly what scenarios you're ruling out here. In our
environment, we always have to be able to support host-level
profiling, whether or not the guest is using the PMU (for PEBS or
anything else). Hence, for our *basic* vPMU offering, we only expose
two general purpose counters to the guest, so that we can keep two
general purpose counters for the host. In this scenario, I would
expect cross-mapped counters to be common. Are we going to be able to
use this implementation?
