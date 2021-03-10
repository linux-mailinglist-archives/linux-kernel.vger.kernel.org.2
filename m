Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6CE333B95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCJLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhCJLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615376289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1khCg40LUG3hga5USvqwXFKaGBm9b7PAKjcDF2JJERk=;
        b=cuqeLRx4VIK7q0K7yGLJZmNx+8RJnCn9kryQU4JM1+qFr2NWi/WW5jZ6JzgI0Mmv3jTeB5
        zPWhbhNUQxgaZtVoBOxUoht2caJfu5OJHk9MJb6wCFHojMFD/MsCxTBrytMQpf4st0R8+o
        uIuIKWmK0PVQVbAnLs6mB5ymJR0E+l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-R8fEy-I0PiqSqblJHXk3MA-1; Wed, 10 Mar 2021 06:38:07 -0500
X-MC-Unique: R8fEy-I0PiqSqblJHXk3MA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 660081018F70;
        Wed, 10 Mar 2021 11:38:05 +0000 (UTC)
Received: from krava (unknown [10.40.195.168])
        by smtp.corp.redhat.com (Postfix) with SMTP id 43A8C6E515;
        Wed, 10 Mar 2021 11:38:03 +0000 (UTC)
Date:   Wed, 10 Mar 2021 12:38:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4] perf pmu: Validate raw event with sysfs exported
 format bits
Message-ID: <YEivmv6WCWW9ae59@krava>
References: <20210310051138.12154-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310051138.12154-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 01:11:38PM +0800, Jin Yao wrote:
> A raw PMU event (eventsel+umask) in the form of rNNN is supported
> by perf but lacks of checking for the validity of raw encoding.
> 
> For example, bit 16 and bit 17 are not valid on KBL but perf doesn't
> report warning when encoding with these bits.
> 
> Before:
> 
>   # ./perf stat -e cpu/r031234/ -a -- sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>                    0      cpu/r031234/
> 
>          1.003798924 seconds time elapsed
> 
> It may silently measure the wrong event!
> 
> The kernel supported bits have been exported through
> /sys/devices/<pmu>/format/. Perf collects the information to
> 'struct perf_pmu_format' and links it to 'pmu->format' list.
> 
> The 'struct perf_pmu_format' has a bitmap which records the
> valid bits for this format. For example,
> 
>   root@kbl-ppc:/sys/devices/cpu/format# cat umask
>   config:8-15
> 
> The valid bits (bit8-bit15) are recorded in bitmap of format 'umask'.
> 
> We collect total valid bits of all formats, save to a local variable
> 'masks' and reverse it. Now '~masks' represents total invalid bits.
> 
> bits = config & ~masks;
> 
> The set bits in 'bits' indicate the invalid bits used in config.
> Finally we use bitmap_scnprintf to report the invalid bits.
> 
> Some architectures may not export supported bits through sysfs,
> so if masks is 0, perf_pmu__warn_invalid_config directly returns.
> 
> After:
> 
> Single event without name:
> 
>   # ./perf stat -e cpu/r031234/ -a -- sleep 1
>   WARNING: event 'N/A' not valid (bits 16-17 of config '31234' not supported by kernel)!
> 
>    Performance counter stats for 'system wide':
> 
>                    0      cpu/r031234/
> 
>          1.001597373 seconds time elapsed
> 
> Multiple events with names:
> 
>   # ./perf stat -e cpu/rf01234,name=aaa/,cpu/r031234,name=bbb/ -a -- sleep 1
>   WARNING: event 'aaa' not valid (bits 20,22 of config 'f01234' not supported by kernel)!
>   WARNING: event 'bbb' not valid (bits 16-17 of config '31234' not supported by kernel)!
> 
>    Performance counter stats for 'system wide':
> 
>                    0      aaa
>                    0      bbb
> 
>          1.001573787 seconds time elapsed
> 
> Warnings are reported for invalid bits.
> 
> Co-developed-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

