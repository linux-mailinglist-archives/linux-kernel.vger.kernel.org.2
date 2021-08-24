Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6213F59E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhHXIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhHXIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:37:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80028C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:36:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so610584pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1XMyMZTrlMsAyxJHJ7+jgxpDBQIUvOlx6q4619hvdU=;
        b=NUoRDRdLXEWTEekCDmBtZ/exdtGXze3rrbYg+ex/+uIqp7rJsa6G1CjW9ZlBEbGJPa
         0E9ZTiBZqMWIHwk7RZqP77HaITamZxBNT5RVqPYk0GC4AG8bcGOqwG6McNx/1WRjBYBZ
         aDAXLl9Mjfl68opbSN2x68GaPNFYOVo6orj7fRjUDwa/kZLN3+OZTwxFE03UekCI6qhR
         3I2uNbJQVkKOsWInW3GrI+etyfetVKbN6j/7w0fuZB2RqYweNmNrkge8BnBLNF6xVwdy
         wqF6TjBxK2KjbLdlWUR2uSSpM53Yf9dG5mFMUrtxcOzUV2tjRiP2zld8yCb1tnES86TI
         KmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1XMyMZTrlMsAyxJHJ7+jgxpDBQIUvOlx6q4619hvdU=;
        b=un40kFX6te21Ta0GV3kVMKf29UfqJNSdGMkH7klS3afg8ZPrkNsz5jG1GCSaCw90XI
         kYy++3XQDNAaTdGjBwwDhIcf98CF3KdudLkzvX0898GaBaj7kVuZQ1wJDadYjuXZzsAt
         4+DLdYSUGu6mxL+i6oYRRxtyWvRgAp1Hi6oLoetHwE78OlHzTAgkr35o6dPqRWSg5mgA
         +QXNLknkkgzfdPQcWS2Pf1rJJwxNkTxosAfVRHpV86YM0HsEaE+pvXYk89epuLCexqu2
         +keSWI2QPubNGpC0XxMDo3bNCH19ZTkVavmAfAIRdwKm5m2W1CAbD5fCr1uw0vlYC0YQ
         RYqA==
X-Gm-Message-State: AOAM530a96Hqn6unxzG6zljC89TwsfF29tuisgXhoTSxEDKkmLU//dg7
        XQH+vdrgRy2hUEbndwLRC3MWUA==
X-Google-Smtp-Source: ABdhPJyUW69QXyRkb+6UuNtr5+pZZHByZSuSk3OEROQ/prtfEBYN0rOUFRkvTRN1VPFRsmRgERbpVw==
X-Received: by 2002:aa7:86c3:0:b0:3eb:1857:8ae9 with SMTP id h3-20020aa786c3000000b003eb18578ae9mr14612757pfo.52.1629794182897;
        Tue, 24 Aug 2021 01:36:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id z3sm18612008pff.47.2021.08.24.01.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 01:36:22 -0700 (PDT)
Date:   Tue, 24 Aug 2021 16:36:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        acme@kernel.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] perf cs-etm: Show a warning for an unknown magic
 number
Message-ID: <20210824083615.GF204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-10-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-10-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 02:41:09PM +0100, James Clark wrote:
> Currently perf reports "Cannot allocate memory" which isn't very helpful
> for a potentially user facing issue. If we add a new magic number in
> the future, perf will be able to report unrecognised magic numbers.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/cs-etm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 788ad5a099f6..5b276bdb96a6 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2973,6 +2973,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  			/* ETE shares first part of metadata with ETMv4 */
>  			trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> +		} else {
> +			ui__error("CS ETM Trace: Unrecognised magic number %#"PRIx64". File could be from a newer version of perf.\n",
> +				  ptr[i]);
> +			err = -EINVAL;
> +			goto err_free_metadata;
>  		}
>  
>  		if (!metadata[j]) {
> -- 
> 2.28.0
> 
