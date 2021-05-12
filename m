Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9737D036
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348058AbhELRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbhELQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:07:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597A0C03542A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:37:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j12so12393299pgh.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LkdhH7+c0e5NenvwnpF1EhNTDLZfHKCyQtBoZSCgUv8=;
        b=xnvFRFE5P1SW4ArsaTq+9WNn2bn2wGD9xTssrTIMjyiBm+C2ERsRYlf2SnIFZG+k8K
         Tj1ckCqdvlHIpsfu+BVfIMg02Iy+0ZnfOCfxdi/OwXiR6d4d50UB1022V1tT/hRO3Cr6
         /LMiSeisBQ4e1rjGTr+7nQwuifQFPSi1ttJ8wyzlj3Ccwc6GD6q1CpgWo8Cqt9dTsKPb
         YGXkd3FXSp6uSc1HqkQLZPCJDJjDajT1zYbxISEAW+InbE2gJLw8ehZMfSJCHziE91iW
         7DeqcYp+A9DJG0vs0Zw/8ELzTDnaxJAIv9M2ucyBMvJxwUOBtsy1p/rWffBRuVMzdP2O
         PGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkdhH7+c0e5NenvwnpF1EhNTDLZfHKCyQtBoZSCgUv8=;
        b=JvHJwpSnUyDWROuw1eCcwN8DtvGWS1JcgnOKJUZOrCUy0T7M94KS7Lw7Jq8N/B/Cy2
         6EA5/BRkDNZgiAagjGSN0CTVc+2IiAaKzd9crJlgpmzAeN1qyMHXlquhoR+dkj9dwSCp
         W8ClIcYpaCT12nwUP7SykupUtWdNGmfKEDnhC/5y6SKvwkyWGSXZJ2qmkpRba+eVaxl5
         YOysnGM4L07l2fzJbO/CThH/qM3WZsZIx5StzRE94U6r5iuvA/rlH8J6hzbsImSFJsDT
         1qSVFOgdBYZtr53qLM9Py0M47zxxaJP/BYIYgpQyGoFlloKx9yKFy4n+Vidv+ttNSDWu
         lBow==
X-Gm-Message-State: AOAM530t/vHL92IcwL0wdlrD8YNQmkwGpBv1e+Ea/YYlbVtKFEck5o+i
        J7py6y1dG5wa3Vg3lhDnzZ9BiA==
X-Google-Smtp-Source: ABdhPJzvw/VDOYAkw+NRfNrYJKyNkre0LOhS6gsLFbEQ+4M57hSp6rr3i/18rPTDUXzrIxloxKgJOg==
X-Received: by 2002:a65:6a07:: with SMTP id m7mr36630365pgu.136.1620833841785;
        Wed, 12 May 2021 08:37:21 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1207-178.members.linode.com. [45.79.108.178])
        by smtp.gmail.com with ESMTPSA id r22sm258836pgr.1.2021.05.12.08.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:37:21 -0700 (PDT)
Date:   Wed, 12 May 2021 23:37:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Message-ID: <20210512153714.GC121227@leoy-ThinkPad-X240s>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
 <95d93dcb-e930-a1c7-08e1-be8885d19f64@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d93dcb-e930-a1c7-08e1-be8885d19f64@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, May 12, 2021 at 06:17:03PM +0300, James Clark wrote:

[...]

> Apart from this issue above, I've tested the full patchset with various combinations
> of --per-thread, -a and --timestamp and don't see any issues like missing command names
> or decode issues. (Apart from -a where Command is reported as '-1', but this issue is
> present before and after this patchset so is unrelated.)

Good finding!  Will take a look for the failure issue with option '-a'.

> I think it makes sense to unify the behaviour to make it more like Coresight and others
> so this is a good change.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Tested-by: James Clark <james.clark@arm.com>

Thanks a lot for the testing,

Leo
