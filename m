Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069E4360DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhDOPFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhDOO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:57:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93429C061359
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:56:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m11so16224005pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PhTmwH8PhT9mJZ3C0aVcmTrvg6qX9lyZC429IhOM4QM=;
        b=q3BREvqEB2G3BNbpkG8kBbf7BElXASTuxr+GvNV7K1WJc89G3SaGdHjDAu4UCtVvSC
         2K/277udq3BCCJdE/9yr6aITZn/oJlz51iW7Zdkd18ZaAdvTgOWDCIghYIioeLa9qww1
         Hb1ScRJLz9eagiwvAhGAIJPscYOodOkHrj71r+Rx0ZhP2dq6eGZUlDYY+/Zimj1KV86V
         1wfO4DtWvxGrQUdx+g1Wxtc3jnNe9PM+JCPlz3dXZp6PPi8VyEU3hAAtGcszP3YU7HHB
         9C7Z2xfnAZ5k5jWOdBMenO/zr3PdZ0sl1Tk3bLOQ+GnOHC4dMd0bp8NQOzNmYlVmswmn
         LJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PhTmwH8PhT9mJZ3C0aVcmTrvg6qX9lyZC429IhOM4QM=;
        b=flPRthSpJUtj8LI4uIONeVF/EpZbwB8Ux/PjIGYGg7TObrfGiqoK10kRbk1jqAhGdL
         dPUgfevxPoPJAjHFEkHNuAbSneQ2Hifl47EVb7ngdwn9qGkpEaCKnRAsSQX5K9jqqD0y
         G6vXR/qTp6Ocz8qWsRE55j7GRI7FVexQ7yCeCtCN3DeUmWQeRx6IaEQiLq8wyEvZv2w+
         TzeCc5uTfPrUP3OwjwIh2WRk9yfv4HQaWBOe+TAwxyQjdjVRSAtCwimi+lQGwhfq/6zn
         yFAVng6ZxF/3OiMKPA/kzTo4ZAJ92cbAyhO95EDTDFu2wvFpUiMfwzSJsyYXOl2AHzaN
         n+AQ==
X-Gm-Message-State: AOAM532ez05d+JEPUeitGQjc/HaultdKU9i1b1/hieVTUHouO8dpSzbg
        2yIoBS1aRtjwR3iPE6J0MS11wQ==
X-Google-Smtp-Source: ABdhPJwbpBWFS/DrNNeCNcxK8P61L/I09eLggFGIfDMGJvBkdCoJ0HdLMHpYtG/PdQm7IT5fig4+fw==
X-Received: by 2002:a63:6b4a:: with SMTP id g71mr2225731pgc.274.1618498588061;
        Thu, 15 Apr 2021 07:56:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id s1sm2754011pgc.28.2021.04.15.07.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:56:27 -0700 (PDT)
Date:   Thu, 15 Apr 2021 22:56:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] perf arm-spe: Enable timestamp
Message-ID: <20210415145622.GE1011890@leoy-ThinkPad-X240s>
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <570051ef-eda0-ead2-96de-0e22ca226e0a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570051ef-eda0-ead2-96de-0e22ca226e0a@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 05:43:24PM +0300, James Clark wrote:
> Hi Leo,
> 
> I was looking at testing this on N1SDP and I thought I would try the round trip with perf inject and
> then perf report but saw that perf inject with SPE always results in an error (unrelated to your change)
> 
> 	 -> ./perf report -i per-thread-spe-time.inject.data
> 	0x1328 [0x8]: failed to process type: 9 [Bad address]
> 	Error:
> 	failed to process sample
> 
> 
> Do you have any test suggestions other than looking at the raw data?

Good catching!  I didn't use inject mode for Arm SPE before (it's not
not like Arm CoreSight for instruction sample, or SPE's branch sample
is statistical so we cannot generate branch samples based on accurate
interval).

For the debugging, it's good to use "git grep" to search "Bad address"
to check where the error happens, and can use gdb.  I personally think
it's possible to go back to check the sythenization flow, simply to
say, it might have problems when inject samples but not in the
decoding flow.

Thanks,
Leo
