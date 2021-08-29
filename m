Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6633FAAF4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhH2Kwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhH2Kwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:52:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66213C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:51:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so7999612pjs.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lFzFG2XeopOOy6Mnz/fganlfwA/D8OqBSKpVQIaiZig=;
        b=z8B6S7DTFgi69OBaCjTUZIAvdGWjOqopBYd0e5b9wfD2TYtv2Yz7XF/0ZRYVqqNYTA
         aWoYGt03eFil1j1RR4ERTcZZ4ASU0Si4zjY5c7tC26ybatnYAC/mwwyYYif1XIpTpeKW
         JdoULIRhDxxRQcum/i3YpDF2O0uVsT87MeHqFMF4ilYgqX5g995JNn3uSkMNVEChUdBo
         012nXR3PXMSqYj0q3rIPSC3rTvoKbxZPI9hcwAeVI53GvfrBV6JZS2QRb508mW3YiNHT
         so9SNsPLO9MSMM+LCVhZ8o3odbtaprHf/TkbuRcA6e+b3I6MMoKanzWdbgFceCXVd55T
         WFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lFzFG2XeopOOy6Mnz/fganlfwA/D8OqBSKpVQIaiZig=;
        b=eA/29JQzLgyPWIZXqcdLFDG6ARffZNJ4C5FfGEQHL2Nh4noU9NWCgiEluiAiDrSzDh
         VXSh/LaMU+Jki0VqfnVVVzRLwHn4QzJr0MxHKeqg2E9LbrSqrvQbWkxqNPbq7rXxTh5U
         GjuiJmXmawf5hsor9wjb1AF89Lm51MumEM5q6Tj+H4n+ntCvEsylcq0FVQr8hyoSQhnV
         Sr6Afq5mIll1GwM33o3BngYMEQt8dVZpJ4xsW4e3Fe0jVIAOP4O4KEjffWmqOQ7j3QSE
         AhZKq8JBZKy1BNBqE/JCq17HoMNya374Eij6NaQK4VmUBz3CLXhn5AIrFOROVF3dCwgu
         8XBg==
X-Gm-Message-State: AOAM532NyJqjGJiPj7iXeM6vjnHtywboKIWPaNWnw6JbyeuVJQRhvYof
        eqntEQnx6ew36Hd+9+PDLh8IYQ==
X-Google-Smtp-Source: ABdhPJwjWsoF+6aTXesS8YJ625+DMN9GCiyDBwQ7qEmqcmLQGPVUk4SlInxmsMvfuMy9p1LbnGbAdg==
X-Received: by 2002:a17:90b:3b82:: with SMTP id pc2mr20677208pjb.224.1630234299731;
        Sun, 29 Aug 2021 03:51:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 15sm7641004pjw.39.2021.08.29.03.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 03:51:39 -0700 (PDT)
Date:   Sun, 29 Aug 2021 18:51:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 1/9] perf/ring_buffer: Add comment for barriers on AUX
 ring buffer
Message-ID: <20210829105130.GA14461@leoy-ThinkPad-X240s>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Aug 09, 2021 at 07:13:59PM +0800, Leo Yan wrote:
> AUX ring buffer applies almost the same barriers as perf ring buffer,
> but there has an exception for ordering between writing the AUX trace
> data and updating user_page::aux_head.
> 
> This patch adds comment for how to use the barriers on AUX ring buffer,
> and gives comment to ask the drivers to flush the trace data into AUX
> ring buffer prior to updating user_page::aux_head.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

You have given the ACK tag before, could you pick up this patch?

Thanks,
Leo

> ---
>  kernel/events/ring_buffer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 52868716ec35..5cf6579be05e 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -509,6 +509,15 @@ void perf_aux_output_end(struct perf_output_handle *handle, unsigned long size)
>  		perf_event_aux_event(handle->event, aux_head, size,
>  				     handle->aux_flags);
>  
> +	/*
> +	 * See perf_output_put_handle(), AUX ring buffer applies the same
> +	 * barrier pairing as the perf ring buffer; except for B, since
> +	 * AUX ring buffer is written by hardware trace, we cannot simply
> +	 * use the generic memory barrier (like smp_wmb()) prior to update
> +	 * user_page::aux_head, the hardware trace driver takes the
> +	 * responsibility to ensure the trace data has been flushed into
> +	 * the AUX buffer before calling perf_aux_output_end().
> +	 */
>  	WRITE_ONCE(rb->user_page->aux_head, rb->aux_head);
>  	if (rb_need_aux_wakeup(rb))
>  		wakeup = true;
> -- 
> 2.25.1
> 
