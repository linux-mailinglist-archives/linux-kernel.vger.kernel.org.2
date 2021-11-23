Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33E2459B86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhKWFWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhKWFWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:22:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B929C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:19:33 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u11so16063460plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oKRvahD1aNDjuEHJSgJSG9ADD96hf2NAU7kTYJqw3QQ=;
        b=rup/zwcv/KBBx/v24ugK8qieK9g09vNspjb/6RmjYKYgED2XNJe7YStgJb/1FMpUtv
         3mpO87v3R+HPPv+J/Euz7qRdT2WXedbsON7jo2q7Vk7uCBvQJkP3EN/k15zqsRxNnVAJ
         orTgZVGIObluJ4Qz4H+wjZEzxPz1qIvcrH3yUl2TV9oNSdQXM2FE75awNkhSychijvzx
         NNhRO9H+ar4gG4WhBMcB9zESZWyErvR2cEwbbD6kgSpiDqqfJte9XTgRsOOUCffUCKl8
         8eydcTwgXxhDJVNibcSsqzLl4YV+pvRZMegt3D/CXUZl8ZhgGUKu9IPKB/rbZLveBJIj
         weOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oKRvahD1aNDjuEHJSgJSG9ADD96hf2NAU7kTYJqw3QQ=;
        b=oxYh48+34jxAUzy9i3HMreFsrYJ57Fhdh9BvfGVfRHQ+YqqthL1wU6GLuaaIW6Z6MI
         SO9ZEZFPpBZ2TXa+PYtc8rfFFLpa0iQYJlz2Q+j+Usunw7Gnz3w4SacY2Vz7af+MhgEr
         9enUKqluapwefnJoXmOkMYNtEQo6F3CecMT8usG1Tm3sobVCFzCGxY0hpoiRrWV1SyZw
         zR4PuVsP+/tEnxlqRhCZqZb2GTAk3WlundHzo7cl7U7t8h78MWsswIysiMD/CykIib5Z
         +igdUloQptWNeUZ9VXUIktEqHzvV4Y3EN4+bRCJz2G6irkjjYwLv7ZVU5k/dyzrv/R8k
         CFsA==
X-Gm-Message-State: AOAM532sTpEqFi5yIYUDvBzj6AcX3Wk1zz6KwcUTls5lC087A0V/d+Nl
        mLExY5AjkzVoOQnnOjeSjD305Q==
X-Google-Smtp-Source: ABdhPJx0GD535cYgqf/c1IQpzT5ffDPMxmQEhvLQFxYY3waLjhGOjEMnREIIFAqhswcemuChtJB7Fg==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr3342297pjb.62.1637644772585;
        Mon, 22 Nov 2021 21:19:32 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.248])
        by smtp.gmail.com with ESMTPSA id s3sm9612468pjk.41.2021.11.22.21.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 21:19:32 -0800 (PST)
Date:   Tue, 23 Nov 2021 13:19:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1] perf arm-spe: extend Arm SPE test script with
 regression testing
Message-ID: <20211123051924.GE124250@leoy-ThinkPad-X240s>
References: <20211112162005.11876-1-german.gomez@arm.com>
 <20211112162005.11876-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112162005.11876-2-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Fri, Nov 12, 2021 at 04:20:03PM +0000, German Gomez wrote:
> Extend the test_arm_spe.sh script to test for regressions in the
> decoding flow of Arm SPE samples. In order to support the tests, a set
> of perf.data files has been generated offline and is being hosted under
> tools/perf/tests/shell/test_arm_spe.tgz:

Seems to me it's not a good idea to upstream perf data binaries into the
mainline kernel.  I understood you want to test the perf data with
different context tracing modes (using contextidr vs switch events),
since these two different modes we cannot capture them with the same
kernel Image, I think this is the main reason you upstreamed the perf
data binaries in this patch.

On the other hand, like CoreSight smoke testing, by default we can give
priority for testing root PID namespace, so you could do the test with
below commands, which is assumed that tracing PID in contextidr:

  perf record -e arm_spe_0// -- test_program
  perf report
  perf script

Then, for testing non-root PID namespace, can we use the command
"unshare" to create a namespace and run perf tool in a non-root
PID namespace?  In this way, you could record Arm SPE trace data and
decode it on the fly.  Finally we can avoid to upstream perf data
binaries.

Thanks,
Leo
