Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E08340F52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhCRUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhCRUmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:42:11 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D29FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:42:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f12so5172818qtq.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOAtzI6XfjgzBwIu+EtPFo8QNNgd7hESHH8Nk+Ja34k=;
        b=YiuPthPTj9K4DZzonYzJpHPIHwQFHfF2KQ1rQlIwX6jagxxhiwkVQ7qtZWE6Sh//gx
         kVneIcG1TrbLMGNO4Qv0mCX5ZXOmsuWbmsfv5A6djSOfChuDMzqK3uIEADvP9IDBF5zv
         8mj2R9ABhCWW9j9570+xb0MtoF6XCFuohQqyVDDs701NHJjZE5jOVk76/vjLM7iutOnd
         MiOTzt/LpoK+PxTYfrebP1jIj7az8gvF/Uq5jJuT4hJkyVos7Njz9nzh/iHJYP9PuDDY
         zLTcNSZWa07fgNa8VnsVKJmMvf4mcT2bWjtYXEybPS/DORjvuvb0dvf9KAAPpeqT9f1M
         dKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOAtzI6XfjgzBwIu+EtPFo8QNNgd7hESHH8Nk+Ja34k=;
        b=nqo/pOOgBAsEUgi10htXNHsch4XFPTII9SAFNQG/lLjQ0ZLfD4jBd3H5a/+VDWzrir
         juYMyoFPADWLIljSqfjKuaAHQK+f3+9dnPHoSxRrCwkt9cvBD6C49f3Dtsd7mIPaIG8X
         El/q/Z2wJEAvi8SPSIUb53J5RA1Wfq5bfXdU6xkIJsOkHk/aH5m/75RohPAuSbb+0F2J
         C/p2gntNP8w3+aKEFkGW9M2d5fXI4Gn9gMTqto9NfEK5SlzXf/rW9m6I/vtINKDaB1+3
         o+ZPHDVaa5B0JQ856shYLb0zQFfUu+3dlnY02TNfyAuwdI+BRhcvLtF+eOOFz+3AdzwT
         60hw==
X-Gm-Message-State: AOAM530xJbhxFEXrn92UjfvLc17V7Kx5zUgw6PaCIy3uHEnOljaTXqId
        5R0mzLhO2f/0P1JbSD2e2GItP6Q1cD+5LjNoP9kmsA==
X-Google-Smtp-Source: ABdhPJwbbwbQtsKdXGidS0XzrLmAq2xIk32hRRm0JCeqaQMKwgMzpgTOHvND+KsVFVSUU6lW++UO6E5dgGWp55eEBMQ=
X-Received: by 2002:aed:2b06:: with SMTP id p6mr5496809qtd.101.1616100130193;
 Thu, 18 Mar 2021 13:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210317045949.1584952-1-joshdon@google.com> <20210318143158.GB17012@xsang-OptiPlex-9020>
In-Reply-To: <20210318143158.GB17012@xsang-OptiPlex-9020>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 18 Mar 2021 13:41:59 -0700
Message-ID: <CABk29Nu0+k3dLa5T-Z99EE7FdVSa1wb_OT3zTbXKUaf5Tb-iWA@mail.gmail.com>
Subject: Re: [sched] 663017c554: WARNING:at_kernel/sched/core.c:#scheduler_tick
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Paul Turner <pjt@google.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning is WAI (holding spinlock for 100ms). However, since this
is expected for locktorture, it makes sense to not have the warning
enabled while the test is running. I can add that to the patch.
