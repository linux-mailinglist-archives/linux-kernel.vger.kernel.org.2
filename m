Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8FA356D08
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbhDGNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbhDGNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:15:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B7C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:15:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so1296558pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e020mPPNiEurZGNJnvheGOQIDOekvN6B/W7sf2sZ/0E=;
        b=XZRfqDsJE0OpHvkud1uydE53Yqojtj8k0FOmOZg8fUqX33doNvBiNH6Rc7eqQt53/A
         LHAam25Xn5ybOcRFslmHomQxeuP6BiPOk9QFGCCqTF+CRNgM1VME87HoOxR8/qweAx6a
         93zK2aSa5X6Ao+6USX2g70BaGEliLoRhsxAzLihEX3+T+Xk1WYbDjh3t9aDMhIWDgBMm
         5MO4Epvy+HcKEIjlnrGTr/SoKNvdijNkxFc6Fc+Z5TDbvP/zHAKawxql0jq0QpVHr67E
         WqTHf8aVobbMTkjfFxtx5VbcMw8Pa0kAY5ERNTT+pGJl4R05z9OG0qqPvrH8j8Oe7UWX
         Wkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e020mPPNiEurZGNJnvheGOQIDOekvN6B/W7sf2sZ/0E=;
        b=aFda4D3ijV2AnduBt1jprpJnr3MwvUHZbM1vojrQK07/arqYLzC5eAwLO4llAKDITZ
         1vc1IGs+g5QjshO4iBkkAvB9w8OtvtGG3i9oxue87g1VzpU5JVY1cwsnAuT3jHRDAFkR
         LM6OeAwdjeTbSNVKqtXfxBO2BMh9iLxKCqSHaMe5TsLnEgLxXUTX15ctvjznyLHSoxVV
         WppUh0JM6TrjFfJHronS0DOTm4D3UAEljksv+UJ1aS/cCgIoXFtQUk4TIbnjGXNLyu25
         wbCe4HnJAGwSSnrTE114lfXzPgy3hSXZ2CtVrDDrZHD/FCW/HXF1wd7xkJlASvkFazeu
         Om+g==
X-Gm-Message-State: AOAM5304WljXuvfjdix33eaSSAw4tXepQCo39RZwgJdOS0ngU1U9ZRvY
        OSWET1dtrtLE+/rQALA0lZUOeg==
X-Google-Smtp-Source: ABdhPJx59BDW1N03Vp+Ek/kQ+Ja9lC0HD2LfQ7FaBy2na5hBNmXQ2VXRoSwv/goEFWk/E/DDptcoJg==
X-Received: by 2002:a17:90b:295:: with SMTP id az21mr3227624pjb.11.1617801335124;
        Wed, 07 Apr 2021 06:15:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.229])
        by smtp.gmail.com with ESMTPSA id u12sm21439759pfn.123.2021.04.07.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:15:34 -0700 (PDT)
Date:   Wed, 7 Apr 2021 21:15:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Al Grant <Al.Grant@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] perf arm-spe: Enable timestamp
Message-ID: <20210407131529.GA585163@leoy-ThinkPad-X240s>
References: <20210403072346.30430-1-leo.yan@linaro.org>
 <AM6PR08MB335124DC0080EA95A817D71786769@AM6PR08MB3351.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR08MB335124DC0080EA95A817D71786769@AM6PR08MB3351.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Tue, Apr 06, 2021 at 09:38:32AM +0000, Al Grant wrote:

[...]

> > This patch set is to enable timestamp for Arm SPE trace.  It reads out TSC
> > parameters from mmap page and stores into auxtrace info structure;
> 
> Why not synthesize a PERF_RECORD_TIME_CONV - isn't that specifically to
> capture the TSC parameters from the mmap page? If a generic mechanism
> exists it would be better to use it, otherwise we'll have to do this again for
> future trace formats.

Good point!  Actually "perf record" tool has synthesized event
PERF_RECORD_TIME_CONV.  This patch series is studying the
implementation from Intel-PT, so the question is why the existed
implementations (like Intel-PT, Intel-BTS) don't directly use
PERF_RECORD_TIME_CONV for retriving TSC parameters.

I agree using PERF_RECORD_TIME_CONV for TSC parameter is better than
extending auxtrace info.  Will experiment for this.

> perf_read_tsc_conversion and perf_event__synth_time_conv are currently
> in arch/x86/util/tsc.c, but nothing in them is x86-specific and they could be
> moved somewhere more generic.

This is not true on the mainline kernel; these functions have been
moved into the file util/tsc.c.

Thanks for suggestions,
Leo
