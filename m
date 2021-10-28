Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1764F43E7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1SJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhJ1SJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:09:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A206C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:07:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so5449695pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2aJJjoTlLhFRNMSLNmA2DQYLIxullrmAPX3Kd2+b1NQ=;
        b=RY8sTH9PFqArMSe74G5FFq90x96KTIX6w9btW5btq5WXcgJZzv09lMc2obUvzL4IyY
         cVR1CB7QvgMIiDNhX0NtVW91TkLXr96QVnIKS1DX2iYMzq9bEzujTDD1EQGPZrukFw7C
         P+jSe1/wrMllnExSUCgcPU0mwx01QGqJvvGNodJ7Hi3ivkhS5rWHuOQfYUGRzvrpIpSf
         aK0LhnsIRk3Ck7OktwQwr/mnGRMONCdlcXIU+MIvgXCYzCJzFR0fKsutRNf8GaEvJJmC
         ItPLpeAsuU5VJwuN1DldExHrbZbiBRA2Ov3DlYO03Np5+ilA5bwg2lZsiPqF2tV0aXRo
         2H0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2aJJjoTlLhFRNMSLNmA2DQYLIxullrmAPX3Kd2+b1NQ=;
        b=MdQkKSmnn4HqokoXWWrg359+oqjR5Egn7iGYF+DsamhX9jwwSvU+/mQnD1SpMA7yC1
         0nY/k2uk9Eq8z5IhuGgZjQSNAW1RJaTs/OAkbwtH4VYQvSnr/aK6lFwaIm9hq0yjO8m4
         lIVQiy+osjdfZDzQhvNVog58OvZgoL+TDtcspYruxTR1fdRB1bj1A2XOuh8ScJeF7Mpm
         o97Tfafg4NISn6RdlBD+zDiRJYMHm2onT7Ots/zLGaUzYzIwWWZ1zW45VNia/lGvMsiI
         0be36AgkwFPwRwXBHFCVc629oIgUIrVIP4eY34fRubRzGyz9p3L59eqbp6dmIAP/Kq7i
         pIfQ==
X-Gm-Message-State: AOAM533ZOfReK1Y9SG/WUEH7O1Cg8xz/4KYS0Kz9xoR8UY9PPr1oB7W6
        64MFap0lOik00nZGVhOWPofqTw==
X-Google-Smtp-Source: ABdhPJy3q1U6S5rP+3HrXHm4DpDRV1oBstyFwS9GzmTqwhJYUauZfo++MbXhEgz0U+KaL32k0m4XYQ==
X-Received: by 2002:a17:902:8ecb:b0:140:1934:ea7d with SMTP id x11-20020a1709028ecb00b001401934ea7dmr5264183plo.46.1635444422945;
        Thu, 28 Oct 2021 11:07:02 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v22sm633742pgc.83.2021.10.28.11.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:07:02 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:06:59 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: Re: [PATCH 01/10] coresight: add support to enable more coresight
 paths
Message-ID: <20211028180659.GC4045120@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-2-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634801936-15080-2-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:38:47PM +0800, Tao Zhang wrote:
> Current coresight implementation only supports enabling source
> ETMs or STM. This patch adds support to enable more kinds of
> coresight source to sink paths. We build a path from source to
> sink when any source is enabled and store it in a list. When the
> source is disabled, we fetch the corresponding path from the list
> and decrement the refcount on each device in the path. The device
> is disabled if the refcount reaches zero. Don't store path to
> coresight data structure of source to avoid unnecessary change to
> ABI.
> Since some targets may have coresight sources other than STM and
> ETMs, we need to add this change to support these coresight
> devices.
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 100 +++++++++++--------
>  1 file changed, 56 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 8a18c71df37a..1e621d61307a 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -37,18 +37,16 @@ struct coresight_node {
>  };
>  
>  /*
> - * When operating Coresight drivers from the sysFS interface, only a single
> - * path can exist from a tracer (associated to a CPU) to a sink.
> + * struct coresight_path - path from source to sink
> + * @path:	Address of path list.
> + * @link:	hook to the list.
>   */
> -static DEFINE_PER_CPU(struct list_head *, tracer_path);
> +struct coresight_path {
> +	struct list_head *path;
> +	struct list_head link;
> +};

For sources associated with a CPU, like ETMs, having a per-cpu way of storing
paths is a definite advantage and should be kept that way.  

>  
> -/*
> - * As of this writing only a single STM can be found in CS topologies.  Since
> - * there is no way to know if we'll ever see more and what kind of
> - * configuration they will enact, for the time being only define a single path
> - * for STM.
> - */
> -static struct list_head *stm_path;
> +static LIST_HEAD(cs_active_paths);

Then there are sources that aren't associated with a CPU like STMs and TPDMs.
Perhaps using an IDR or the hash of the device name as a key to a hashing
vector would be better than doing a sequential search, especially as the
list of devices is bound to increase over time.

>  
>  /*
>   * When losing synchronisation a new barrier packet needs to be inserted at the
> @@ -354,6 +352,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>  	if (ret)
>  		return;
>  	coresight_control_assoc_ectdev(csdev, false);
> +	csdev->activated = false;

I don't see why this is needed and without proper documentation there is no way
for me to guess the logic behind the change.  The ->activated flag should be
manipulated from the command line interface only.

>  	csdev->enable = false;
>  }
>  
> @@ -590,6 +589,20 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
>  	goto out;
>  }
>  
> +static struct coresight_device *coresight_get_source(struct list_head *path)
> +{
> +	struct coresight_device *csdev;
> +
> +	if (!path)
> +		return NULL;
> +
> +	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
> +		return NULL;
> +
> +	return csdev;
> +}
> +
>  struct coresight_device *coresight_get_sink(struct list_head *path)
>  {
>  	struct coresight_device *csdev;
> @@ -1086,9 +1099,23 @@ static int coresight_validate_source(struct coresight_device *csdev,
>  	return 0;
>  }
>  
> +static int coresight_store_path(struct list_head *path)
> +{
> +	struct coresight_path *node;
> +
> +	node = kzalloc(sizeof(struct coresight_path), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->path = path;
> +	list_add(&node->link, &cs_active_paths);
> +
> +	return 0;
> +}
> +
>  int coresight_enable(struct coresight_device *csdev)
>  {
> -	int cpu, ret = 0;
> +	int ret = 0;
>  	struct coresight_device *sink;
>  	struct list_head *path;
>  	enum coresight_dev_subtype_source subtype;
> @@ -1133,25 +1160,9 @@ int coresight_enable(struct coresight_device *csdev)
>  	if (ret)
>  		goto err_source;
>  
> -	switch (subtype) {
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		/*
> -		 * When working from sysFS it is important to keep track
> -		 * of the paths that were created so that they can be
> -		 * undone in 'coresight_disable()'.  Since there can only
> -		 * be a single session per tracer (when working from sysFS)
> -		 * a per-cpu variable will do just fine.
> -		 */
> -		cpu = source_ops(csdev)->cpu_id(csdev);
> -		per_cpu(tracer_path, cpu) = path;
> -		break;
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -		stm_path = path;
> -		break;
> -	default:
> -		/* We can't be here */
> -		break;
> -	}
> +	ret = coresight_store_path(path);
> +	if (ret)
> +		goto err_source;
>  
>  out:
>  	mutex_unlock(&coresight_mutex);
> @@ -1168,8 +1179,11 @@ EXPORT_SYMBOL_GPL(coresight_enable);
>  
>  void coresight_disable(struct coresight_device *csdev)
>  {
> -	int cpu, ret;
> +	int  ret;
>  	struct list_head *path = NULL;
> +	struct coresight_path *cspath = NULL;
> +	struct coresight_path *cspath_next = NULL;
> +	struct coresight_device *src_csdev = NULL;
>  
>  	mutex_lock(&coresight_mutex);
>  
> @@ -1180,20 +1194,18 @@ void coresight_disable(struct coresight_device *csdev)
>  	if (!csdev->enable || !coresight_disable_source(csdev))
>  		goto out;
>  
> -	switch (csdev->subtype.source_subtype) {
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		cpu = source_ops(csdev)->cpu_id(csdev);
> -		path = per_cpu(tracer_path, cpu);
> -		per_cpu(tracer_path, cpu) = NULL;
> -		break;
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -		path = stm_path;
> -		stm_path = NULL;
> -		break;
> -	default:
> -		/* We can't be here */
> -		break;
> +	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
> +		src_csdev = coresight_get_source(cspath->path);
> +		if (!src_csdev)
> +			continue;
> +		if (src_csdev == csdev) {
> +			path = cspath->path;
> +			list_del(&cspath->link);
> +			kfree(cspath);

See my comment above - I agree that sources _not_ associated with a CPU should
be handled differently.  CPU bound sources should be kept untouched.

That is all the time I had for today, I will continue tomorrow.

Thanks,
Mathieu

> +		}
>  	}
> +	if (path == NULL)
> +		goto out;
>  
>  	coresight_disable_path(path);
>  	coresight_release_path(path);
> -- 
> 2.17.1
> 
