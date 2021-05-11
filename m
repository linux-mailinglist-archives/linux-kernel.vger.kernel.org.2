Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C532C37AACB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhEKPip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhEKPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:38:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651EEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:37:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so11018121plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NKp71YaU0JXBYBsb0mkN6lX6rK/S4/DoKGSWP1tuOHg=;
        b=gtgwzsn6DcTHb/gNDvXWSsL0FXdGuu0cQDL47A1OypEUl0C3QuLrB2+9YCZZ3bo05q
         NkPu4gwD87l84cAAE5DfOOqz+kDfRml4YSP6yNEOEbnnJi8OkTGjvXsD74ZqtyRafVCN
         bibn7lZc3yc5SfEG++Ts7VfWEE/es5Jlgcnu2MSwisAtnFi38C2A6obU3pmLJHcqwECE
         UL03ZelFQYqzvL5etX4ZXHOkjFrlM5060sEEO0g9Y1O3RHTJyyKQQLYnbqHEiuepE9vn
         CN3mpzv+ucSTcqHpGLmXYr/VicKTp5s2c8udNkHR/IFqUGx+JHP8FakLDlQ2ddECWo9s
         Cq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NKp71YaU0JXBYBsb0mkN6lX6rK/S4/DoKGSWP1tuOHg=;
        b=rFHVz/KXeGls3+SFJrRDvDs3NIeQX1QiqGpd8VD0aPtNh7j2wICJrCTgQ8OOi4mvEw
         Iy+I1Siz5CPWt6Srph9f+Qgd+IzqoqmMayHmQ7QTwopaosWYPF5NoJxEDPUWKuax6PAs
         5TDBkEt8B5yIQBMfAf2eSQJMdtKh4DfoS8NmMst0nRqersDhX7nSF5gcM/X5u0y2IvyP
         Kb31uQFyyOrP9eK7G+NwbcaPIP2vrGQvLGOis6c3a2X30BP0MShPUa4mXp5Lx7dbe9a1
         U+m5SECTd7Gsv1NRGjuIZrcQYwMdwM7nPCEb6C9bl9ri7MSV/eMDa+Qxeatl/Lk5JRxy
         AJJA==
X-Gm-Message-State: AOAM530KSld+JHO7FyTtIuUZOYvIvhwBSL5ZEgDNX/Sas/KbUPH/hcap
        4rC55rqV3vg8mqAGoEzesJgbJg==
X-Google-Smtp-Source: ABdhPJyoMSJad0vMIKhXC9GddSk1MpU/4y5VA5Qonxo6xr60ccVI4hkupkUgJlYs0pbbKdta9XcaPw==
X-Received: by 2002:a17:902:7d87:b029:ef:176:843b with SMTP id a7-20020a1709027d87b02900ef0176843bmr25924176plm.61.1620747454998;
        Tue, 11 May 2021 08:37:34 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t9sm14245033pgg.6.2021.05.11.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:37:33 -0700 (PDT)
Date:   Tue, 11 May 2021 09:37:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, acme@kernel.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210511153731.GB124805@xps15>
References: <20210510143248.27423-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510143248.27423-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:32:46PM +0300, James Clark wrote:
> Changes since v2:
>   * Collect acked and reviewed-by tags from v1 that were
>     missed in v2
>   * Add comment and commit message suggestions from Suzuki
>   * Rebase onto next-20210510 (also applies to perf/core)
> 
> Thanks
> James
>

Arnaldo,

Please condiser for inclusion in your tree.

Thanks,
Mathieu
 
> 
> James Clark (2):
>   perf cs-etm: Refactor timestamp variable names
>   perf cs-etm: Set time on synthesised samples to preserve ordering
> 
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++---
>  tools/perf/util/cs-etm.c                      | 57 +++++++++++--------
>  tools/perf/util/cs-etm.h                      |  4 +-
>  3 files changed, 44 insertions(+), 35 deletions(-)
> 
> -- 
> 2.28.0
> 
