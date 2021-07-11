Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4A53C3DB3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhGKPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234738AbhGKPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626018250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5om9K/umaEadA+Zd5EA9MMa7NUG0fG4OJe5sb2/6xg=;
        b=L053drnO63jkkaRJANTrlM1ICiMS+9nLlpgbmPEvDHfU4W3B1B7L0OwsgS/s2Vtg1zcL8Y
        qJAWnw5Q/bqDQe4BtlSV3IqpCYK3EpKjcTw/2HzpOuXuUdGWuvOxDoLLAS+x7K0HdIFY2E
        QMhBfn0rGit7Mf3nvY0D4rsKS0ovKvA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-BMwPbgIUMi6r7hSmn54-Qw-1; Sun, 11 Jul 2021 11:44:09 -0400
X-MC-Unique: BMwPbgIUMi6r7hSmn54-Qw-1
Received: by mail-ed1-f71.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so8408569edu.17
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 08:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c5om9K/umaEadA+Zd5EA9MMa7NUG0fG4OJe5sb2/6xg=;
        b=AMvbQghfemYiR+QyeJKWfPz6PxaOaFY1q5+J8kVtB37kQqTm0xG1AScUxHf7nEDHWx
         F57TTjYd4bVbpjNmAzbeJXTKk3yLr16uthZGhJv0D6t5JL0B9DH3XQH0L4sGaDIm3JDg
         ooZqPupjHwexCionhWz64JnFGI8axVj9fEZeVBHQNruP7+0YBbRKu7WVeyMwWaMEvsTB
         PTKCJf6BcJ2+QpBYeHWh8dEV+rBZV85ArZssYbmDSD/7MJ9NNamE9S4VFiLocIODpwA2
         B4JZPNQifwgH7NAgqGhxYR9eRTp4N3Hn9kSy2cK6x+/dAhVLdK7WW9d45fM+olzNl3h7
         o/KA==
X-Gm-Message-State: AOAM5308moxMYm7XsqvgKVWDNcS2OZ2UGGy51fmnl+L8H3uG/6/Zde72
        9gWdAyESeRwCpPccmoNO8cIECYN4KV86snr3SsUteiNoCUxIHBNkTr9GLLzYfccSIZF9NwLlvD0
        C7Au8K3t/K3U9XJNo3wjtKtME
X-Received: by 2002:a17:906:5650:: with SMTP id v16mr19270228ejr.533.1626018248000;
        Sun, 11 Jul 2021 08:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJjxxdC3v9agp6Ldfpv99b4l4Rn5DAtiOo30Ovgu7542+Da6/zHbEkeczRKVUV62eZ2OFBoQ==
X-Received: by 2002:a17:906:5650:: with SMTP id v16mr19270216ejr.533.1626018247844;
        Sun, 11 Jul 2021 08:44:07 -0700 (PDT)
Received: from krava ([5.171.249.81])
        by smtp.gmail.com with ESMTPSA id j24sm6318012edv.48.2021.07.11.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 08:44:07 -0700 (PDT)
Date:   Sun, 11 Jul 2021 17:44:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 4/4] perf inject: Fix output from a file to a pipe
Message-ID: <YOsRxDnAgE7zNOVP@krava>
References: <20210707180536.72175-1-namhyung@kernel.org>
 <20210707180536.72175-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707180536.72175-5-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 11:05:36AM -0700, Namhyung Kim wrote:

SNIP

> +	if (!data.is_pipe && inject.output.is_pipe) {
> +		ret = perf_header__write_pipe(perf_data__fd(&inject.output));
> +		if (ret < 0) {
> +			pr_err("Couldn't write a new pipe header.\n");
> +			goto out_delete;
> +		}
> +
> +		ret = perf_event__synthesize_attrs(&inject.tool,
> +						   inject.session->evlist,
> +						   perf_event__repipe);
> +		if (ret < 0) {
> +			pr_err("Couldn't inject synthesized attrs.\n");
> +			goto out_delete;
> +		}
> +
> +		ret = perf_event__synthesize_features(&inject.tool,
> +						      inject.session,
> +						      inject.session->evlist,
> +						      perf_event__repipe);
> +		if (ret < 0) {
> +			pr_err("Couldn't inject synthesized features.\n");
> +			goto out_delete;
> +		}
> +
> +		if (have_tracepoints(&inject.session->evlist->core.entries)) {
> +			/*
> +			 * FIXME err <= 0 here actually means that
> +			 * there were no tracepoints so its not really
> +			 * an error, just that we don't need to
> +			 * synthesize anything.  We really have to
> +			 * return this more properly and also
> +			 * propagate errors that now are calling die()
> +			 */
> +			ret = perf_event__synthesize_tracing_data(&inject.tool,
> +						perf_data__fd(&inject.output),
> +						inject.session->evlist,
> +						perf_event__repipe);
> +			if (ret <= 0) {
> +				pr_err("Couldn't inject tracing data.\n");
> +				goto out_delete;
> +			}
> +		}
> +	}

hum.. how bad (too many args?) would be to put this to some function
in util/record.c, because it's copied directly from builtin-record.c

jirka

> +
>  	if (inject.build_ids && !inject.build_id_all) {
>  		/*
>  		 * to make sure the mmap records are ordered correctly
> -- 
> 2.32.0.93.g670b81a890-goog
> 

