Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81EC44E35C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhKLIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhKLIlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:41:17 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64673C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 00:38:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y8so2404017plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 00:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gr5eo6lh6tOCmqLZBPxylS6DQQWushgkeRkakiksvqM=;
        b=AcbubQbvJYtTNJPR9YUQ3l4fihMXd4tvXzbiLJEU+CtAZpagjrtwTIHwo9NOMLDumT
         vsErY2wgGazp9qtULJRl+3UJmsBiE+HVsnpiNGMNCNMsSE8Q6j5jA50ubTzeyCRmRN+a
         xdWktaArWzIYfFwOJ9By0h+hq4F3g3LKtz/NLf/etja30zrgIpDX16KNRUGEvzDRkKuO
         2Z5SWP6+fuwvQW9DTZ0mbGf4fFf3HGpKSND1nrXMOiC7T24vYYtPOc/4Ox6jBn3kOK3E
         etbpq9Fmlj1VcstFaU1lKnIa58F3OHONXr285tkjyHD8Rgd9ZMg1oDRgj6Tr8Vv7lNSt
         o5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gr5eo6lh6tOCmqLZBPxylS6DQQWushgkeRkakiksvqM=;
        b=PDreZAkxLLNWV0rVQBR6o0ZTQnSXny4whBIHlt+8rbZeU1iRNZ93Q/t+mJNHvJVMfW
         TLJKGRKUM2IY42IdNbiKARn9+fCyS8FZQOksxQlMwf5eofCvdZObwwGNoeUJNrkWGmfI
         4kia2snzb7xt9YA2HaHPvKuS++qbF3BwodXSgKZ7LASatE3tXeausJtzAsjQMOl/jlBe
         HfSwyW1a/fI+UopswfORC45fpBL9sOU9agQUpM6JgJKtDU5iV6boFxt6l9mkWXmGae4l
         Qcnl8M8OJpjbuNTSkxe9QdGB9NhFA17vOzf7963iuZCOkQoeZnoRN1NsMSo5YTyt7Om1
         gksg==
X-Gm-Message-State: AOAM530eAmcwEDr8d0+ukxDsZo/Ny1eZn3s45bxPMORZ5KgOIm2IlSKB
        d+rFT+CoO2mWYbXgq9NVBZ4EUA==
X-Google-Smtp-Source: ABdhPJzzUAz3lEYq+ljbLBoCEcvv7E3wlCIkE/msZHBv1aCcYqnGaITkGIqkPsNRmjSIgA6ZIRH1dA==
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id i11-20020a1709026acb00b0014276c3d35fmr5978730plt.89.1636706306920;
        Fri, 12 Nov 2021 00:38:26 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id v16sm4270928pgo.71.2021.11.12.00.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 00:38:26 -0800 (PST)
Date:   Fri, 12 Nov 2021 16:38:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yihao Han <hanyihao@vivo.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: Re: [PATCH] perf cs-etm: use swap() to make code cleaner
Message-ID: <20211112083819.GE106654@leoy-ThinkPad-X240s>
References: <20211112023344.3642-1-hanyihao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211112023344.3642-1-hanyihao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yihao,

On Thu, Nov 11, 2021 at 06:33:44PM -0800, Yihao Han wrote:
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.

The header 'include/linux/minmax.h' is used for kernel but it's not
provided for user space program?

> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  tools/perf/util/cs-etm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f323adb1af85..aaa3ec725002 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -408,17 +408,13 @@ struct cs_etm_packet_queue
>  static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>  				struct cs_etm_traceid_queue *tidq)
>  {
> -	struct cs_etm_packet *tmp;
> -
>  	if (etm->sample_branches || etm->synth_opts.last_branch ||
>  	    etm->sample_instructions) {
>  		/*
>  		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
>  		 * the next incoming packet.
>  		 */
> -		tmp = tidq->packet;
> -		tidq->packet = tidq->prev_packet;
> -		tidq->prev_packet = tmp;
> +		swap(tidq->packet, tidq->prev_packet);

NAK - This patch will introduce compilation error:

util/cs-etm.c: In function ‘cs_etm__packet_swap’:
util/cs-etm.c:417:3: error: implicit declaration of function ‘swap’; did you mean ‘swab’? [-Werror=implicit-function-declaration]
   swap(tidq->packet, tidq->prev_packet);
   ^~~~
   swab

Thanks,
Leo

>  	}
>  }
>  
> -- 
> 2.17.1
> 
