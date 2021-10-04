Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83586420AE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJDM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhJDM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:29:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF24C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:27:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n2so10955418plk.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=seqv46vapK3LYSUO+3R1zuCP1rybYVvrFT5pZqlDw1A=;
        b=B9th5UxPPKH4IGJzAy4GbFFVV9wEb9q8pYukvEGqowKB/vV/l4UpjJGJxuTbaoHg78
         P4NiaoBGoOFxqlL0UNnjgC5fCNf64+LIK7RDQyDYplmsBwZnz/23MGV4Va31cqrB4+Wa
         Ffgtj4gp3UnvQcsgDLmIKLmyIBzXcBqq3aI1hVE8un2jvArUCE+O+wW3fa3zRijAO539
         0VrjxTo80cRcLs12HoHBba8Z23DkdeNiNrQq2Y/KyZsVjLoLzpbNTDp7JVMuIV/Xu8xJ
         GmTuBmqDI+tjQujcjTfiUd+06nxInO6B49btOoTnfGuRFWX1t8cQ3sWU6U7mxaAOEm0O
         h+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=seqv46vapK3LYSUO+3R1zuCP1rybYVvrFT5pZqlDw1A=;
        b=Iy5azMbpi0g+3lw7EBWx09nrLGn7syHX8AI9pyImKUxwTpvLPIjDkW9b3LEq9Kz/AB
         gAt8USCFWvYt7lItLamlN1I1VLldAaARnXWMCh161MKHbBlJN6NpPc3In9rt5VihiNIk
         mddVGk8Zrg8FMlgITMejdL+uoTAX3eGg1YDkcstmJ13ynl6CFC1WGr8fWPj4l09MZ4nY
         XbemvOvPyTq04h5QvzJT/ezcXWzO4hb312Mqew0kA7Bde8yTzmaDV8O8YyoSBkVpu8nL
         pnZVZOiXXV//Egq43rRcFO0guepAjqD+n3RRX7KF//GSWLU1e555XnHI0pELAZiZHenI
         Sgkw==
X-Gm-Message-State: AOAM532XPZHX0XTfkgJXF/8xzmE0vkqOWbbC/FTF726Pd7DgRyo599NP
        V6UqiuS8Gpz3T2Cs9pASq+m8iQ==
X-Google-Smtp-Source: ABdhPJxMgsnpiosCKhuEpLJjE3CB+I+h06iBCRwJEbbQ+Z59Ytp3hnFa5B/efn+C3/yQFI4hUws3Ig==
X-Received: by 2002:a17:90a:f0c4:: with SMTP id fa4mr2614890pjb.245.1633350450588;
        Mon, 04 Oct 2021 05:27:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.210])
        by smtp.gmail.com with ESMTPSA id a10sm14423232pgd.91.2021.10.04.05.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:27:30 -0700 (PDT)
Date:   Mon, 4 Oct 2021 20:27:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211004122724.GC174271@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Thu, Sep 30, 2021 at 01:26:15PM +0100, German Gomez wrote:

[...]

> The patch is indeed based on that commit. The reason behind it is that the
> values for *head are being wrapped in the driver side (see the macro
> PERF_IDX2OFF which is used at various points in
> /drivers/perf/arm_spe_pmu.c).

Yes, I noted that Arm SPE driver doesn't use monotonical increasing
for AUX head.

> If this callback is not to be added, I believe the driver needs to be
> updated > first so that the head pointer monotonically increases like in cs-etm. Do
> you think this makes sense for SPE?

Please note, there have two cases should be handled for snapshot mode:
- Wrap-around case, somehow function __auxtrace_mmap__read() has
  handled this case, see [1];
- It's possible that there have overrun case for snapshot mode, e.g.
  the kernel space receives multiple signals and take snapshot to save
  Arm SPE trace data into AUX buffer for multiple times, but the
  userspace tool cannot catch up to save AUX data into perf.data file.
  Thus the AUX head might be wrapped around for multiple times, for
  this case, I think monotonically increasing AUX head is the right
  solution to handle overrun issue.

So simply say, I think the head pointer monotonically increasing is
the right thing to do in Arm SPE driver.

> (note that the patch will skip the wrap-around detection if this is the
> case,
> in order to handle both cases in the userspace perf tool).

Almost agree, I read multiple times but have no idea what's the
"both cases" in the last sentence.

Please let me know if anything is not clear.

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/auxtrace.c#n1804
