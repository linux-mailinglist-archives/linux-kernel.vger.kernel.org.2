Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99B8459371
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbhKVQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbhKVQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:55:02 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 08:51:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i12so16713234pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kkcZpxwJdLn49QvPplnQeq1xBVbbby14p9/pBOIfqqM=;
        b=Vif/l0ua51+nM1M2unICFR7KOnuQBMt0aKHjkJif6KkKhR0Vp+PTP0+qIKs++Y59DR
         JZSqOOaMuLnoU07Y+mbEIUM1GnN+Dje9Cw8wuxKvHNU32EHG9ZP++9GTWMdk73TNPeFy
         Kt1l7Ll7fe+qzp3Eh30ABRvzF6TKeMIgsuBS63lOHjM5MZv/B+bnrb9xNvBIacxwU+M0
         VF1rao0RtzhkO/QbBuXH5FMgn5yALmG6x22+GWUs045G0S1hmK2jegfMcQLhbX7OfpKL
         m5rce2bxVVmHHGBCKqnLcigU41/yOcad2SqwPbeQmoqOFJpOqwlVquubUY5QzntywrPL
         xtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kkcZpxwJdLn49QvPplnQeq1xBVbbby14p9/pBOIfqqM=;
        b=oRHle6Vt1T2580jti4Y52oaW79EoVoulo+SC4vlEoL246yuLKwOz/zjebYkUMnBv3S
         vrCSIc4uxM/UdErobtLXXItH6B1sKln2Qyb0sx41K8O/t9eAIZR+gMIcpzy6pVrnCbrG
         hXIuxNrtjuOafjTDvi52anbfaREAeuE/tN4SmR4JwBQerzhvikWt2Jb0M+9z41KmscJb
         cjs3FGf2ixaCHt9lIIS3ozdqToOcx7HNQgKIz3jGhvEAKNyJIH5Gg9g3k3EGKzj5isZS
         nPEG6TdBv84bEfRscjXXQ8Vfz9dl589lzVJ7K4hyv649VNTTZrEhj0WupQpW15McZHdW
         BhaQ==
X-Gm-Message-State: AOAM532h2tDl90DUMsIe3hNVs1/gbloL5oGUWM2rb25uwokDpz8bNfpU
        6ULZQiLFI/e5HU8jInxVA0rzIA==
X-Google-Smtp-Source: ABdhPJyAAS/QMWosQ8N/KPAftVysvLdvUMVGWInRdyVaT3JZIWwtvtbrj9OdIFaym2/zYAkqu4TqqA==
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2e43 with SMTP id f17-20020a056a00239100b004a2cb642e43mr45739529pfc.49.1637599915577;
        Mon, 22 Nov 2021 08:51:55 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o2sm9788981pfu.206.2021.11.22.08.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:51:54 -0800 (PST)
Date:   Mon, 22 Nov 2021 09:51:51 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jinlong Mao <quic_jinlmao@quicinc.com>
Cc:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: Re: [PATCH 01/10] coresight: add support to enable more coresight
 paths
Message-ID: <20211122165151.GA2686563@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-2-git-send-email-quic_taozha@quicinc.com>
 <20211028180659.GC4045120@p14s>
 <b7ec5d50-cc42-fa94-2053-8d652f455a9e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7ec5d50-cc42-fa94-2053-8d652f455a9e@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:12:03PM +0800, Jinlong Mao wrote:
> Hi Mathieu,
> 
> Thanks for the comments.
> 
> I double checked the code. Please see my comments below.
> 
> 
> On 10/29/2021 2:06 AM, Mathieu Poirier wrote:
> > On Thu, Oct 21, 2021 at 03:38:47PM +0800, Tao Zhang wrote:
> > > Current coresight implementation only supports enabling source
> > > ETMs or STM. This patch adds support to enable more kinds of
> > > coresight source to sink paths. We build a path from source to
> > > sink when any source is enabled and store it in a list. When the
> > > source is disabled, we fetch the corresponding path from the list
> > > and decrement the refcount on each device in the path. The device
> > > is disabled if the refcount reaches zero. Don't store path to
> > > coresight data structure of source to avoid unnecessary change to
> > > ABI.
> > > Since some targets may have coresight sources other than STM and
> > > ETMs, we need to add this change to support these coresight
> > > devices.
> > > 
> > > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-core.c | 100 +++++++++++--------
> > >   1 file changed, 56 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > > index 8a18c71df37a..1e621d61307a 100644
> > > --- a/drivers/hwtracing/coresight/coresight-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > > @@ -37,18 +37,16 @@ struct coresight_node {
> > >   };
> > >   /*
> > > - * When operating Coresight drivers from the sysFS interface, only a single
> > > - * path can exist from a tracer (associated to a CPU) to a sink.
> > > + * struct coresight_path - path from source to sink
> > > + * @path:	Address of path list.
> > > + * @link:	hook to the list.
> > >    */
> > > -static DEFINE_PER_CPU(struct list_head *, tracer_path);
> > > +struct coresight_path {
> > > +	struct list_head *path;
> > > +	struct list_head link;
> > > +};
> > For sources associated with a CPU, like ETMs, having a per-cpu way of storing
> > paths is a definite advantage and should be kept that way.
> 
> Hi Mathieu,
> 
> Could you please share what is the advantage to handle the sources
> associated with a CPU separatly ?
>

It is a question of efficiency.  There is no point iterating through all the
sources if we don't have to.

> From the code, cpu id is only used to get the path of the ETM source.
> 
> As there will be many tpdm sources, I think it will be easier to only
> maintain one list for all the sources.
> 

So many TPDM and many ETMs...  That is definitely a reason to do better than a
sequential search.

> > > -/*
> > > - * As of this writing only a single STM can be found in CS topologies.  Since
> > > - * there is no way to know if we'll ever see more and what kind of
> > > - * configuration they will enact, for the time being only define a single path
> > > - * for STM.
> > > - */
> > > -static struct list_head *stm_path;
> > > +static LIST_HEAD(cs_active_paths);
> > Then there are sources that aren't associated with a CPU like STMs and TPDMs.
> > Perhaps using an IDR or the hash of the device name as a key to a hashing
> > vector would be better than doing a sequential search, especially as the
> > list of devices is bound to increase over time.
> 
> Agree with you. I will try to use IDR or  the hash of the device name as a
> key to a hashing vector.
>

If an IDR (or some other kind of mechanism) is used then we can use that to
store paths associated with ETMs as well.  That way everything works the same
way and access time is constant for any kind of source.

> > 
> > >   /*
> > >    * When losing synchronisation a new barrier packet needs to be inserted at the
> > > @@ -354,6 +352,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
> > >   	if (ret)
> > >   		return;
> > >   	coresight_control_assoc_ectdev(csdev, false);
> > > +	csdev->activated = false;
> > I don't see why this is needed and without proper documentation there is no way
> > for me to guess the logic behind the change.  The ->activated flag should be
> > manipulated from the command line interface only.
> 
> When source is disabled, but sink is still actived. It will be confused for
> end users.
> 

That is how it has been working for years now.  It was done this way to give as
much flexibility to users and keep kernel intelligence to a minimum.

> > 
> > >   	csdev->enable = false;
> > >   }
> > > @@ -590,6 +589,20 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
> > >   	goto out;
> > >   }
> > > +static struct coresight_device *coresight_get_source(struct list_head *path)
> > > +{
> > > +	struct coresight_device *csdev;
> > > +
> > > +	if (!path)
> > > +		return NULL;
> > > +
> > > +	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
> > > +	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
> > > +		return NULL;
> > > +
> > > +	return csdev;
> > > +}
> > > +
> > >   struct coresight_device *coresight_get_sink(struct list_head *path)
> > >   {
> > >   	struct coresight_device *csdev;
> > > @@ -1086,9 +1099,23 @@ static int coresight_validate_source(struct coresight_device *csdev,
> > >   	return 0;
> > >   }
> > > +static int coresight_store_path(struct list_head *path)
> > > +{
> > > +	struct coresight_path *node;
> > > +
> > > +	node = kzalloc(sizeof(struct coresight_path), GFP_KERNEL);
> > > +	if (!node)
> > > +		return -ENOMEM;
> > > +
> > > +	node->path = path;
> > > +	list_add(&node->link, &cs_active_paths);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   int coresight_enable(struct coresight_device *csdev)
> > >   {
> > > -	int cpu, ret = 0;
> > > +	int ret = 0;
> > >   	struct coresight_device *sink;
> > >   	struct list_head *path;
> > >   	enum coresight_dev_subtype_source subtype;
> > > @@ -1133,25 +1160,9 @@ int coresight_enable(struct coresight_device *csdev)
> > >   	if (ret)
> > >   		goto err_source;
> > > -	switch (subtype) {
> > > -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> > > -		/*
> > > -		 * When working from sysFS it is important to keep track
> > > -		 * of the paths that were created so that they can be
> > > -		 * undone in 'coresight_disable()'.  Since there can only
> > > -		 * be a single session per tracer (when working from sysFS)
> > > -		 * a per-cpu variable will do just fine.
> > > -		 */
> > > -		cpu = source_ops(csdev)->cpu_id(csdev);
> > > -		per_cpu(tracer_path, cpu) = path;
> > > -		break;
> > > -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> > > -		stm_path = path;
> > > -		break;
> > > -	default:
> > > -		/* We can't be here */
> > > -		break;
> > > -	}
> > > +	ret = coresight_store_path(path);
> > > +	if (ret)
> > > +		goto err_source;
> > >   out:
> > >   	mutex_unlock(&coresight_mutex);
> > > @@ -1168,8 +1179,11 @@ EXPORT_SYMBOL_GPL(coresight_enable);
> > >   void coresight_disable(struct coresight_device *csdev)
> > >   {
> > > -	int cpu, ret;
> > > +	int  ret;
> > >   	struct list_head *path = NULL;
> > > +	struct coresight_path *cspath = NULL;
> > > +	struct coresight_path *cspath_next = NULL;
> > > +	struct coresight_device *src_csdev = NULL;
> > >   	mutex_lock(&coresight_mutex);
> > > @@ -1180,20 +1194,18 @@ void coresight_disable(struct coresight_device *csdev)
> > >   	if (!csdev->enable || !coresight_disable_source(csdev))
> > >   		goto out;
> > > -	switch (csdev->subtype.source_subtype) {
> > > -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> > > -		cpu = source_ops(csdev)->cpu_id(csdev);
> > > -		path = per_cpu(tracer_path, cpu);
> > > -		per_cpu(tracer_path, cpu) = NULL;
> > > -		break;
> > > -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> > > -		path = stm_path;
> > > -		stm_path = NULL;
> > > -		break;
> > > -	default:
> > > -		/* We can't be here */
> > > -		break;
> > > +	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
> > > +		src_csdev = coresight_get_source(cspath->path);
> > > +		if (!src_csdev)
> > > +			continue;
> > > +		if (src_csdev == csdev) {
> > > +			path = cspath->path;
> > > +			list_del(&cspath->link);
> > > +			kfree(cspath);
> > See my comment above - I agree that sources _not_ associated with a CPU should
> > be handled differently.  CPU bound sources should be kept untouched.
> > 
> > That is all the time I had for today, I will continue tomorrow.
> > 
> > Thanks,
> > Mathieu
> > 
> > > +		}
> > >   	}
> > > +	if (path == NULL)
> > > +		goto out;
> > >   	coresight_disable_path(path);
> > >   	coresight_release_path(path);
> > > -- 
> > > 2.17.1
> > > 
