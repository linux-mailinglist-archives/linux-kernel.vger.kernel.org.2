Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE1C3B569D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhF1BaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhF1BaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:30:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1C2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 18:27:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y17so1716298pgf.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X6bVyS44WwFXAw7wP5PVaLANCpMLdUNhY7gEBvcwzvg=;
        b=TzfGmSMQYMmghKX5SsZsYk5xOa1gpjS5jXjsWD6ZEaZ2JuIwmT/PgNgxhyj4NECKsW
         QhzmZMF29kB5LJJy2mBUcXb1DSW72oI4N0hVsZ1A/gI8G5uZk+n7r2yqiNz0/EIdgmAO
         PwL7WyHFTpcnEZ6YljHB5e0s6IdXNbW0Be9vYSg00J6rVzyd6U2NHYY25caQ5/Qt1tAQ
         edwIODMcSyR1687ZabT0paF3/ZD8/6XlRuHdGwJaodEZ86DXd4MvS21DC440m5jkep7x
         qhTTDG+eurWbsvLkGK6gn0tN/YF/uzh0dhIbFOAkdPojUdeMfYVZ+zegCneBjUMsmRM6
         rRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X6bVyS44WwFXAw7wP5PVaLANCpMLdUNhY7gEBvcwzvg=;
        b=Mg5NQjXfE7YCs0KRcH4sUOqWWRmp0pxMUa7zmwyaCdJSVDbjGE3ioiERIDdjsq3IjS
         6rTV5+ffMgiKR6rRgSyHj8uIopjI4DJKDjtXubpKe/keXvWed8hJ2Y0CDZPMUp145Hov
         sSXRKpncYctKnqiW0Hu6qdzMKcvZedTUhmlgxR5rmcekg3GkIlc+bn2QmZ+ZU9STf6m4
         Fd6lzirS1p66AGVadatcG5+8w4Ag4qCPSCnZOanU0387W/drVfilY+m7AL8HsUI9dFSc
         4QMfpK/MAb3pcYdGHQ0m01dT3rUxrFwBfijOjbbVS8uus8PjJ2eCHe1l6tYtmPNYeap1
         ALMg==
X-Gm-Message-State: AOAM533cDmpLbAliH2kHMcW7RJM3y2Tb9oGIA4ixGI5QtwrBsw05IAg0
        3yXJFm86r7uYsfoTWJrdcwVEAQ==
X-Google-Smtp-Source: ABdhPJw51HZwY4OqeK3vsXR6mLJFeM3m0otkwCk3XIocioSF67NTURfk6ArIXBRVxSoxGHkl+/a2zw==
X-Received: by 2002:a63:e04e:: with SMTP id n14mr20399612pgj.324.1624843673098;
        Sun, 27 Jun 2021 18:27:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id t189sm5689388pfb.59.2021.06.27.18.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 18:27:52 -0700 (PDT)
Date:   Mon, 28 Jun 2021 09:27:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Message-ID: <20210628012744.GA158794@leoy-ThinkPad-X240s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624164303.28632-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Jun 24, 2021 at 05:43:03PM +0100, James Clark wrote:
> Currently --dump-raw-trace skips queueing and splitting buffers because
> of an early exit condition in cs_etm__process_auxtrace_info(). Once
> that is removed we can print the split data by using the queues
> and searching for split buffers with the same reference as the
> one that is currently being processed.
> 
> This keeps the same behaviour of dumping in file order when an AUXTRACE
> event appears, rather than moving trace dump to where AUX records are in
> the file.
> 
> There will be a newline and size printout for each fragment. For example
> this buffer is comprised of two AUX records, but was printed as one:
> 
>   0 0 0x8098 [0x30]: PERF_RECORD_AUXTRACE size: 0xa0  offset: 0  ref: 0x491a4dfc52fc0e6e  idx: 0  t
> 
>   . ... CoreSight ETM Trace data: size 160 bytes
>           Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
>           Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
>           Idx:80; ID:10;  I_ASYNC : Alignment Synchronisation.
>           Idx:92; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:97; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0xFFFFDE2AD3FD76D4;
> 
> But is now printed as two fragments:
> 
>   0 0 0x8098 [0x30]: PERF_RECORD_AUXTRACE size: 0xa0  offset: 0  ref: 0x491a4dfc52fc0e6e  idx: 0  t
> 
>   . ... CoreSight ETM Trace data: size 80 bytes
>           Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
>           Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> 
>   . ... CoreSight ETM Trace data: size 80 bytes
>           Idx:80; ID:10;  I_ASYNC : Alignment Synchronisation.
>           Idx:92; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
>           Idx:97; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0xFFFFDE2AD3FD76D4;
> 
> Decoding errors that appeared in problematic files are now not present,
> for example:
> 
>         Idx:808; ID:1c; I_BAD_SEQUENCE : Invalid Sequence in packet.[I_ASYNC]
>         ...
>         PKTP_ETMV4I_0016 : 0x0014 (OCSD_ERR_INVALID_PCKT_HDR) [Invalid packet header]; TrcIdx=822
> 
> Signed-off-by: James Clark <james.clark@arm.com>

I tested this patch and the result looks good for me.

I found a side effect introduced by this change is the perf raw dump
also synthesizes events PERF_RECORD_ATTR.  This is because function
cs_etm__synth_events() will execute after applying this patch and it
synthesizes PERF_RECORD_ATTR events.  I don't see any harm for this,
so:

Tested-by: Leo Yan <leo.yan@linaro.org>

Please see an extra comment in below.

> ---
>  tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 88e8122f73c9..ad777c2a342f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2430,6 +2430,22 @@ static int cs_etm__process_event(struct perf_session *session,
>  	return 0;
>  }
>  
> +static void dump_queued_data(struct cs_etm_auxtrace *etm,
> +			     struct perf_record_auxtrace *event)
> +{
> +	struct auxtrace_buffer *buf;
> +	unsigned int i;
> +	/*
> +	 * Find all buffers with same reference in the queues and dump them.
> +	 * This is because the queues can contain multiple entries of the same
> +	 * buffer that were split on aux records.
> +	 */
> +	for (i = 0; i < etm->queues.nr_queues; ++i)
> +		list_for_each_entry(buf, &etm->queues.queue_array[i].head, list)
> +			if (buf->reference == event->reference)
> +				cs_etm__dump_event(etm, buf);
> +}
> +
>  static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  					  union perf_event *event,
>  					  struct perf_tool *tool __maybe_unused)
> @@ -2462,7 +2478,8 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  				cs_etm__dump_event(etm, buffer);
>  				auxtrace_buffer__put_data(buffer);
>  			}
> -	}
> +	} else if (dump_trace)
> +		dump_queued_data(etm, &event->auxtrace);

IIUC, in the function cs_etm__process_auxtrace_event(), since
"etm->data_queued" is always true, below flow will never run:

    if (!etm->data_queued) {
        ......

        if (dump_trace)
            if (auxtrace_buffer__get_data(buffer, fd)) {
                    cs_etm__dump_event(etm, buffer);
                    auxtrace_buffer__put_data(buffer);
            }
    }

If so, it's better to use a new patch to polish the code.

Thanks,
Leo

>  
>  	return 0;
>  }
> @@ -3038,7 +3055,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  	if (dump_trace) {
>  		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
> -		return 0;
>  	}
>  
>  	err = cs_etm__synth_events(etm, session);
> -- 
> 2.28.0
> 
