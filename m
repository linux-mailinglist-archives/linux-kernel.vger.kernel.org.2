Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B738E41472E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhIVLBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhIVLBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:01:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD7C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:00:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w6so1512930pll.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hwl3MVKuLK+CwZQofEVoUFGs27PPnfkfJHGmENBFAts=;
        b=hjLHBpmuAPymArjlyDDR/L6wa5rSjTRJswtwPE1xPI6UPAl8bAIeYySoyLmCJXlrGq
         6DyG9PKxc/HH/KRFqwnbLjTXdXSo/u23wFNK1l425tkZjDBipaGE2f5TYRfs6HUdo4In
         xg9TjAHhTybSVQyE4zwUBgLHJAsivfkWQCqNQbrITK7u5Gk4lSC0Bk4LY5X29gZMRFFQ
         SsiJL0skX75tSXdvquluepwkNt0kl7Eqh7e/k0ljYsx2zoS8BNckVNi20dkqosN5QqYj
         0g/xgmXAPus3mkTbzuIgxCuK0Xzwb6u4L+wWAiwuTZ/nV8hqcNwc5V+5XtUF0p958QiK
         90TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hwl3MVKuLK+CwZQofEVoUFGs27PPnfkfJHGmENBFAts=;
        b=mhdUgLRD6hwQH1h6Q6djCYe29UW/T+Im7Xgjq0zfKK412bzZQRo56xJCOJIWBfnGJK
         PWZvRfFY+e7Uca0exmdBhHa/PWo4TfkuFZkp2ns9cZviJ5lbcgiP2PIxnDMactIbs33n
         osmlzHygjJxn9weurTuNuo8Hv/tfmv/UPfCpbN2eVeNLFHiPXtbE1yXTpIQFaPLrsSUO
         VYjbM/l/xAEjiLr7IebdjY9zh5IKeDD87II6hLXp/LmOKH0WKv5xeVbn5Tbf+/VN6ISc
         22vDIURPLVZQw6PDnMLrG7HPa7fNcqSRDX4oFF0Tfbfer/cz0O0h1uaUOfoWW8690Z14
         Jq0g==
X-Gm-Message-State: AOAM533/Li3ovI9Jt1ocuOAazWJg3YUAQFBgtAcLVXwvNbRIngBs8iXQ
        caHOsPnMw0CRwX4Yw6JyycpZcg==
X-Google-Smtp-Source: ABdhPJyox/oP8xe915hBd8nZV6x52NPUVmKObsHum2sThZRTtinoTUoYJOv9eBNvHs09nCniPZ/RLg==
X-Received: by 2002:a17:90b:1a90:: with SMTP id ng16mr10659892pjb.130.1632308416907;
        Wed, 22 Sep 2021 04:00:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id u12sm3518046pjr.2.2021.09.22.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 04:00:16 -0700 (PDT)
Date:   Wed, 22 Sep 2021 19:00:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, leo.yan@linaro.com,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf tests: Improve temp file cleanup in
 test_arm_coresight.sh
Message-ID: <20210922110012.GA400258@leoy-ThinkPad-X240s>
References: <20210921131009.390810-1-james.clark@arm.com>
 <20210921131009.390810-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921131009.390810-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:10:09PM +0100, James Clark wrote:
> Cleanup perf.data.old files which are also dropped by perf, handle
> sigint and propagate it to the parent in case the test is run in a bash
> while loop and don't create the temp files if the test will be skipped.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> index c9eef0bba6f1..6de53b7ef5ff 100755
> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -9,8 +9,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Leo Yan <leo.yan@linaro.org>, 2020
>  
> -perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> -file=$(mktemp /tmp/temporary_file.XXXXX)
>  glb_err=0
>  
>  skip_if_no_cs_etm_event() {
> @@ -22,13 +20,20 @@ skip_if_no_cs_etm_event() {
>  
>  skip_if_no_cs_etm_event || exit 2
>  
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +file=$(mktemp /tmp/temporary_file.XXXXX)
> +
>  cleanup_files()
>  {
>  	rm -f ${perfdata}
>  	rm -f ${file}
> +	rm -f "${perfdata}.old"
> +	trap - exit term int
> +	kill -2 $$

Here it always sends signal SIGINT to current PID with $$, another
choice is to send signal based on the incoming signal type, like below:

  [[ "$1" = "int" ]] || kill -SIGINT $$
  [[ "$1" = "term" ]] || kill -SIGTERM $$

If you think the current change is sufficient to meet the testing
requirement, then this patch would be fine for me either:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> +	exit $glb_err
>  }
>  
> -trap cleanup_files exit
> +trap cleanup_files exit term int
>  
>  record_touch_file() {
>  	echo "Recording trace (only user mode) with path: CPU$2 => $1"
> -- 
> 2.28.0
> 
