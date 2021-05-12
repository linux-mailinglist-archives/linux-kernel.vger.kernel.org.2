Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FD37B416
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELCJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhELCJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:09:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C4FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 19:08:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k19so17453187pfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 19:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/T6CLLyn9SUFrGpwAzK8HB5UoGMRR2NGLIIVBl6EDiw=;
        b=MttoakW10LwmyrCqFMLJZWsQP8cclDji6VSQL3Od36ifhNPSovwRZyrSGktdZZJlUb
         uwnT7S+tPvumMcQWotXSa69zmQj1FprOxfe9i6IIJZdogjPnuUSKLWznwP4H7qc2aFOG
         JE6HsHePS/tBxc6rDqDQ85etKvcUtV1yqHgnxAX+NtgCoJ7rHY4YHbboOTmTbO/LQulr
         O8088SJyxJfTb9RvxTzNOm4ADDjpSs2/8EGhNNpN0qkf10KDLO0oSejZgk4I5wOovgdf
         cAkRzRpIW3P31s0cEEs9MYb75oyDazw7KsqIoGkhbYRyw9xVUvqUF1qovqK/lf+pXilv
         WZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/T6CLLyn9SUFrGpwAzK8HB5UoGMRR2NGLIIVBl6EDiw=;
        b=dWwc8pY25/G5L6iO+meauGaEMGqWQZmdzUyFArOx/TW2gsjm5Bv5cJEWkD87RIB1xT
         yNdA29/7S2pORzucMVK1y2o2kmqJ+6YV7Vjbo8S1f6VD3urgcel7wOuc3x5cxfyBlVNE
         M0hganlerHzApLMGHhyftCDFW0YOlERD63FdoPuCU2Bhf5LHeqiTZLFBVnbrI0IsOps4
         /oZFcSGkfz7nzlcDyuAi9oXiZb+IieNwsAwvxW+soeT9tKkDIMlA528ySGVYi+SS6yLR
         kZsqSvq1mUwIOjFQsbKiyyP5mctzL9vqKbntCV201Pmr+YmqLa+Q+x6juQ/6c3OBUMFi
         Tu2g==
X-Gm-Message-State: AOAM533ccm72kMWGJarbSDLcoqVm9JQYErjZzMzfn7aKdSggaF/EIjsX
        5ly0AW8Q50SOE5Jv1q6b7qdHWQ==
X-Google-Smtp-Source: ABdhPJzdqatxcPiT/fgPaaeAL5+G1lmEA1aN8dDa+w6hX7I1Nfs1ItemlTS+gzSxs4a/GFx8/1ExFw==
X-Received: by 2002:a63:e706:: with SMTP id b6mr33747773pgi.302.1620785314697;
        Tue, 11 May 2021 19:08:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id 202sm8890052pgg.59.2021.05.11.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 19:08:34 -0700 (PDT)
Date:   Wed, 12 May 2021 10:08:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
Message-ID: <20210512020826.GC249068@leoy-ThinkPad-X240s>
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
 <da07f930-ccd7-2b46-7b0f-0e9da3bf9482@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da07f930-ccd7-2b46-7b0f-0e9da3bf9482@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:53:35PM +0300, James Clark wrote:

[...]

>         /* First get the packet queue for this traceID */
>         packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
> @@ -320,7 +323,20 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>          * which instructions started by subtracting the number of instructions
>          * executed to the timestamp.
>          */
> -       packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
> +       if (!elem->timestamp) {
> +               packet_queue->timestamp = 0;
> +               if (!warned_timestamp_zero) {
> +                       pr_err("Zero Coresight timestamp found at Idx:%" OCSD_TRC_IDX_STR
> +                               ". Decoding may be improved with --itrace=Z...\n", indx);
> +                       warned_timestamp_zero = true;
> +               }
> +       }
> +       else if (packet_queue->instr_count >= elem->timestamp) {

Nitpick: I personally think should use the condition ">" rather than ">=".

> +               packet_queue->timestamp = 0;
> +               pr_err("Timestamp calculation underflow at Idx:%" OCSD_TRC_IDX_STR "\n", indx);
> +       }
> +       else
> +               packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;

Nitpick for coding style, as described in
Documentation/process/coding-style.rst, section "3) Placing Braces and
Spaces", so here should use braces with the format:

  if (!elem->timestamp) {
    /* print warning */
  } else if {packet_queue->instr_count >= elem->timestamp) {
    /* print warning */
  } else {
    packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
  }

Thanks,
Leo

>         packet_queue->next_timestamp = elem->timestamp;
>         packet_queue->instr_count = 0;
>  
> @@ -542,7 +558,7 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>  
>  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>                                 const void *context,
> -                               const ocsd_trc_index_t indx __maybe_unused,
> +                               const ocsd_trc_index_t indx,
>                                 const u8 trace_chan_id __maybe_unused,
>                                 const ocsd_generic_trace_elem *elem)
>  {
> @@ -579,7 +595,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>                 break;
>         case OCSD_GEN_TRC_ELEM_TIMESTAMP:
>                 resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
> -                                                        trace_chan_id);
> +                                                        trace_chan_id,
> +                                                         indx);
>                 break;
>         case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
>                 resp = cs_etm_decoder__set_tid(etmq, packet_queue,
> 
> 
> James
> 
> > 
> > Thanks,
> > Leo
> > 
