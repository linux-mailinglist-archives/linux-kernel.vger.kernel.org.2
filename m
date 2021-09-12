Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D100408199
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhILUpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236172AbhILUpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Puu8xsr4TXMGSJ8xUTdr7j+2vdNDkflNeu5gWeczPAc=;
        b=dUCja9hHlHRdlMCS2SkRZQ55BHvK8Mxqu6Cuo2+OXphwYinSk7LkpZO/WvQ1RjrtpxCKAL
        tQPi/C2hqRNGOELo2vurdOmbroEgit7PBO2nDjbNI3Gxdqz5c6+3gsZMF5okHrxpvqrhBT
        4CESODZSMEhgwnIU4eBMGGmhA2Fzh9k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-u-Ur3lt8PJCbWBtaOsBDuw-1; Sun, 12 Sep 2021 16:44:15 -0400
X-MC-Unique: u-Ur3lt8PJCbWBtaOsBDuw-1
Received: by mail-ed1-f72.google.com with SMTP id w18-20020aa7cb52000000b003c95870200fso3845805edt.16
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Puu8xsr4TXMGSJ8xUTdr7j+2vdNDkflNeu5gWeczPAc=;
        b=NOgyc0w6jhUo254SUjKzNecvmj+DtGx3D5ETPrw3NnoUYvLH94/ABk5brSgaHQiYoy
         cGOGZQIEKifz0g27hchQ6QfjDf9pWJpgfZQVgUIqGcl3auoMBzEpw8s34dg8fFhzSN7q
         PXdGE+tcKOUTn0YZ801Qs+pbUycb6NcwHRi9Da9p8qydEFtYDthX6rfVQFzsWdAx8lRZ
         l2usCceNt63WjbeN05+RDMGW83YjZsCSiYTvyp9KEo+b4FIgTu80BoB+acq+5TZ6aZEm
         0W968LoqFTwEGy42R/F79JG/afUbGYYviGIUx4bigRvswd5PkseKnTgVpxUgq0iHTsuz
         EyNA==
X-Gm-Message-State: AOAM533wLtfPuZfzaIqyS0HODDWZBytAGWqBpZ2LvAntU+rKRJ0/2eLP
        g3YK4GrHtsNrL36L/AbUAwvQfE14T29BeQTkL9U0eK3/gmDUSc+asVw6YNzbiZcTM6BkNDFWOmm
        zK/UY+ZdCi5+V6/XYXV1vUgsz
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr9638987edd.214.1631479454747;
        Sun, 12 Sep 2021 13:44:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJkBjzmqIS4dVLu7mh48t4h9naVVffW0yNn5iIcdMmHGGybVTLYvHctHJjd1tFQg5rgvKy5Q==
X-Received: by 2002:a05:6402:274d:: with SMTP id z13mr9638974edd.214.1631479454609;
        Sun, 12 Sep 2021 13:44:14 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id ay3sm2475616ejb.0.2021.09.12.13.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:44:14 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:44:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v11 00/24] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <YT5mnDjsuU0tcNy8@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:03AM +0300, Alexey Bayduraev wrote:

SNIP

> 
> Alexey Bayduraev (24):
>   perf record: Introduce thread affinity and mmap masks
>   tools lib: Introduce fdarray duplicate function
>   perf record: Introduce thread specific data array
>   perf record: Introduce function to propagate control commands
>   perf record: Introduce thread local variable
>   perf record: Stop threads in the end of trace streaming
>   perf record: Start threads in the beginning of trace streaming
>   perf record: Introduce data file at mmap buffer object
>   perf record: Introduce bytes written stats to support --max-size
>     option
>   perf record: Introduce data transferred and compressed stats
>   perf record: Init data file at mmap buffer object
>   perf record: Introduce --threads command line option
>   perf record: Extend --threads command line option
>   perf record: Implement compatibility checks
>   perf report: Output non-zero offset for decompressed records
>   perf report: Output data file name in raw trace dump

following patches:

>   perf session: Move reader structure to the top
>   perf session: Introduce reader_state in reader object
>   perf session: Introduce reader objects in session object
>   perf session: Introduce decompressor into trace reader object
>   perf session: Move init into reader__init function
>   perf session: Move map/unmap into reader__mmap function
>   perf session: Load single file for analysis

up to here 

are changing the core of processing perf.data files,
I think they should be submitted in separate patchset
first and some tests for that would be great

jirka

