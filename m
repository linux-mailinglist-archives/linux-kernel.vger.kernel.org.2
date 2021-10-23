Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD9438508
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhJWTjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 15:39:07 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:51284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230230AbhJWTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 15:39:06 -0400
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D9BBB181C43D8;
        Sat, 23 Oct 2021 19:36:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id B196D240234;
        Sat, 23 Oct 2021 19:36:42 +0000 (UTC)
Message-ID: <663d3820f118c37a81529b3362b95e09c8e75e9f.camel@perches.com>
Subject: Re: [PATCH] coresight: Use devm_bitmap_zalloc when applicable
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Sat, 23 Oct 2021 12:36:41 -0700
In-Reply-To: <e5fe23370794e2f5442e11e7f8455ddb06e4b10a.1635016943.git.christophe.jaillet@wanadoo.fr>
References: <e5fe23370794e2f5442e11e7f8455ddb06e4b10a.1635016943.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.54
X-Stat-Signature: cn5t8cb9epzithy65nu1xystn5p8usud
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B196D240234
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18iFmpi7RwWrxrwqT0wAZ7yhteFsFr3AGo=
X-HE-Tag: 1635017802-700607
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-10-23 at 21:24 +0200, Christophe JAILLET wrote:
> 'drvdata->chs.guaranteed' is a bitmap. So use 'devm_bitmap_kzalloc()' to
> simplify code, improve the semantic and avoid some open-coded arithmetic
> in allocator arguments.
[]
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
[]
> @@ -862,7 +862,6 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct stm_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct resource ch_res;
> -	size_t bitmap_size;
>  	struct coresight_desc desc = { 0 };
>  
>  	desc.name = coresight_alloc_device_name(&stm_devs, dev);
> @@ -904,9 +903,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>  	else
>  		drvdata->numsp = stm_num_stimulus_port(drvdata);
>  
> -	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
> -
> -	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
> +	guaranteed = devm_bitmap_zalloc(dev, drvdata->numsp, GFP_KERNEL);
>  	if (!guaranteed)
>  		return -ENOMEM;
>  	drvdata->chs.guaranteed = guaranteed;

guaranteed is also pretty useless



