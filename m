Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28730F203
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhBDLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhBDLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:24:37 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036B0C0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:23:57 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o16so1878204pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V7rULbaG104yDDjFdCtwJRa6RUjo/05yFDNeO4JtaHA=;
        b=C7ZiWmSrGeODfkXEGEpjdykW+98WjIcptGxEOqlC3RJeYOqpzVBGXv7BdvYrm0gCEB
         M1M93TlBRl3d4CucYu48KGzZU/+L3AgjynwBUzefZ54YLFAfhGMw8Y1gA/OeuoMymZ7S
         wTazGC5lQA/cfRHLqXUUEVMlBtgjKkKWdQCunPdVKG3YMWMTtdXyIx8mPsfd25Xp3pjN
         +taCuLag0SA9HIY+HKl94eIe6eYlG0rwQgKQDeGdocvYL4d/RTtlrr6H4NiC0eGbMtJF
         xLxIFD50DdIbMpy7/ognjZ31wkVi+iAbroH07xKWrG8RWGdA9L4Z3SHOkELRY5f5S4rC
         tLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V7rULbaG104yDDjFdCtwJRa6RUjo/05yFDNeO4JtaHA=;
        b=qmp5p/56ubw4XTYjE4bBCdo1K87bkPbD2yrzw9gV20WvC8X4KuvkN27/94ExZAKrzp
         JXR8q+FPCkyiKgcJakYlhoScvz5NeFWxn1Cm1civlHs0yfoGwpnqjIDxh1n7Jbedz2Fw
         NmU3lmgmgVhomGLV0j/BiZrsojdcIcRTTDLJ5ErWfcQ2dsP9FxBQBFt2ervu2FHaKK9N
         rC8o4nm+BTSY+pX2TiJrnqQTyvHuXfgWk7N/PBPXOt2J3FvnhJ/a4f6fzMr1InjOC5Kf
         h2tjcfjQZMCFAe6qkJNfuH6+qJOKH2pfC/ZXWi4LC8AtxhXa5RQRdENLy39YII7gMbXR
         EMUA==
X-Gm-Message-State: AOAM5319fg4dos7Mlf1Eb2HTv/7ggBxdMCbbgZXu1rjmv8/pHsnI7dZF
        SVSYUp90a070fCKGXfDmRsLk5Q==
X-Google-Smtp-Source: ABdhPJxP8Tg5PNgxlzWSgKs1us0dllC703LhNsBDnEfjrpix9Ew9+wtzTM2p8dAxirTYjD6HjMf8LQ==
X-Received: by 2002:aa7:87d8:0:b029:1bd:d756:bdc9 with SMTP id i24-20020aa787d80000b02901bdd756bdc9mr7815954pfo.68.1612437836456;
        Thu, 04 Feb 2021 03:23:56 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id i7sm5012158pjx.13.2021.02.04.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:23:55 -0800 (PST)
Date:   Thu, 4 Feb 2021 19:23:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] perf cs-etm: Add helper cs_etm__get_pid_fmt()
Message-ID: <20210204112349.GB4737@leoy-ThinkPad-X240s>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-6-leo.yan@linaro.org>
 <51a1e845-f9a4-3c6e-88a2-c105f5b5adfe@arm.com>
 <20210204034743.GE11059@leoy-ThinkPad-X240s>
 <afb60e3b-697d-4503-a8de-11cd1a0bf97d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb60e3b-697d-4503-a8de-11cd1a0bf97d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:54:24AM +0000, Suzuki Kuruppassery Poulose wrote:

[...]

> > > > +int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
> > > > +{
> > > > +	struct int_node *inode;
> > > > +	u64 *metadata, val;
> > > > +
> > > > +	inode = intlist__find(traceid_list, trace_chan_id);
> > > > +	if (!inode)
> > > > +		return -EINVAL;
> > > > +
> > > > +	metadata = inode->priv;
> > > > +
> > > > +	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
> > > > +		val = metadata[CS_ETM_ETMCR];
> > > > +		/* CONTEXTIDR is traced */
> > > > +		if (val & BIT(ETM_OPT_CTXTID))
> > > > +			*pid_fmt = BIT(ETM_OPT_CTXTID);
> > > > +	} else {
> > > > +		val = metadata[CS_ETMV4_TRCCONFIGR];
> > > > +
> > > > +		*pid_fmt = 0;
> > > > +
> > > > +		/* CONTEXTIDR_EL2 is traced */
> > > > +		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
> > > > +			*pid_fmt = BIT(ETM_OPT_CTXTID2);
> > > > +
> > > > +		/* CONTEXTIDR_EL1 is traced */
> > > > +		if (val & BIT(ETM4_CFG_BIT_CTXTID))
> > > 
> > > I haven't looked at how this gets used. But, Shouldn't this be :
> > > 
> > > 		else if (val & BIT(ETM4_CFG_BIT_CTXTID)) ?
> > 
> > Actually it's deliberately to set both bits ETM_OPT_CTXTID2 and
> > ETM_OPT_CTXTID if user has enable configs "contextid1" and
> > "contextid2".  So this is exactly the reversed flow in the
> > function cs_etmv4_get_config().
> 
> The point is, we don't care if the user selected both options. What we
> care is, where can we find the PID. CONTEXTIDR_EL1 or CONTEXTIDR_EL2.
> As such, get_pid_fmt simply should make that decision and pass it on.
> So, if the CONTEXTIDR_EL2 is selected (which can only be done successfully
> on an EL2 kernel), thats our pid.
> 
> So we should return the format for the PID here. i.e
>  ETM_OPT_CTXTID2 OR ETM_OPT_CTXTID. But not both.

Okay, if so I will follow your suggestion.

Thanks,
Leo
