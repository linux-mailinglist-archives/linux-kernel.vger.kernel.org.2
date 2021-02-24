Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745E2323C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhBXMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231810AbhBXMqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614170725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mFqH8af2fRiF4kDj3/GhcCj+VPHyIs/HsKUBnUbZYPM=;
        b=BtdYVVJFFdnBHF+R2s0sWxlaBxWnHENhBDLLgvwr8JZ23mHiCrot36aP81VhSxZMgWBAUp
        gZQaH8oiqsmtApg6MkXBQ1itDn/xYDvKKfzS/01a8acm8cOQN2nFsx9B3NWPTqLQKtOlU8
        TiyLYTNoDS6ODWJIitnttGRg7QIXVOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-jqm7fzjfNUyfP12JuTeCBw-1; Wed, 24 Feb 2021 07:45:23 -0500
X-MC-Unique: jqm7fzjfNUyfP12JuTeCBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ACE18030B7;
        Wed, 24 Feb 2021 12:45:21 +0000 (UTC)
Received: from krava (unknown [10.40.193.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3BDE85C1CF;
        Wed, 24 Feb 2021 12:45:17 +0000 (UTC)
Date:   Wed, 24 Feb 2021 13:45:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, hagen@jauu.net,
        john.wanghui@huawei.com, abudankov@huawei.com, yz.yuzhou@huawei.com
Subject: Re: [PATCH v4 0/2] perf tools: add 'perf irq' to measure the
 hardware interrupts
Message-ID: <YDZKXKBJx0/yygDB@krava>
References: <20210218104312.50171-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218104312.50171-1-cuibixuan@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 06:43:10PM +0800, Bixuan Cui wrote:
> When the hardware interrupt processing function is executed, the interrupt and 
> preemption of current cpu are disabled. As a result, the task is suspended.
> The execution of the hardware processing function takes a long time
> (for example 5 ms), will affect the task scheduling performance.
> 
> This patches provides the 'perf irq' command to trace and calculate the time
> consumed of the hardware irq function.
> 
> [verse]
> 'perf irq' [<options>] {record|report}
> 
> DESCRIPTION
> -----------
> There are several variants of 'perf irq':
> 
>   'perf irq record <command>' to record the irq handler events
>   of an arbitrary workload.
> 
>   'perf irq report' to calculate the time consumed by each
>    hardware interrupt processing function.
> 
>     Example usage:
>         perf irq record -- sleep 1
>         perf irq report
> 
>    By default it shows the individual irq events, including the irq name,
>    cpu(execute the hardware interrupt processing function), time consumed,
>    entry time and exit time for the each hardware irq:
> 
>    -------------------------------------------------------------------------------------------------------------------------------------------
>      Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
>    -------------------------------------------------------------------------------------------------------------------------------------------
>      enp2s0f2-tx-0    | [0006] |      0.000001 s |   6631263.313329 s |   6631263.313330 s
>      megasas          | [0013] |      0.000003 s |   6631263.209564 s |   6631263.209567 s
>      acpi             | [0016] |      0.000018 s |   6631263.085787 s |   6631263.085805 s
> 
>     And:
> 	perf irq --cpu 78 record -- sleep 1
> 	perf irq --cpu 78 report
>    -------------------------------------------------------------------------------------------------------------------------------------------
>      Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
>    -------------------------------------------------------------------------------------------------------------------------------------------
>     enp134s0f0-TxRx-2 | [0078] |      0.000005 s |    693757.533189 s |    693757.533194 s
> 
> 
> Changes from v4:
> * Keep pairs of irq entry/exit per cpu;
> * Add NUL-termination to the end of irq->irq_name when strncpy is used;
> * Delete some unused declarations and parameters;

hi,
I can't apply this on later Arnaldo's perf/core,
what commit/branch is this based one?

thanks,
jirka

> 
> Changes from v3:
> * Delete 'perf irq script' because its function can be implemented using
>   'perf script';
> * Add --cpu option for 'perf irq';
> 
> Changes from v2:
> * Delete "-m", "1024" in __cmd_record();
> * Change 'perf irq timeconsume <options>' to 'perf irq report <options>';
> * Fix a error for tools/perf/Documentation/perf-irq.txt;
> 
> Bixuan Cui (2):
>   perf tools: add 'perf irq' to measure the hardware interrupts
>   perf tools: Add documentation for 'perf irq' command
> 
>  tools/perf/Build                      |   1 +
>  tools/perf/Documentation/perf-irq.txt |  47 +++++
>  tools/perf/builtin-irq.c              | 259 ++++++++++++++++++++++++++
>  tools/perf/builtin.h                  |   1 +
>  tools/perf/command-list.txt           |   1 +
>  tools/perf/perf.c                     |   1 +
>  6 files changed, 310 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-irq.txt
>  create mode 100644 tools/perf/builtin-irq.c
> 
> -- 
> 2.17.1
> 

