Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6814547D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhKQN4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhKQN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:56:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:53:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso2653006pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zC2INOq4i9mC2uFkAt9YGh74OyV1gw0rpUisyLgMs34=;
        b=Qwt9a+AM5PE7w3U3o4cmUHlnV8pNjIChykgzmlj1W7PznZlBFNdMK9Jir+PXEP2zGo
         AD6p/c4zYmZUXsZtORbDOXpcVoYMP4nJEU37GjDAhouiNkFQhckx+/4ZkWOASZT9IWCr
         yw1Ibn19kdzE6S77nACF7LvtvNbTR7iz+IqilNJ+hzY4twv0cFrlJqqIhClwdmkYtZKL
         9vQ1tcPjrbDEv/nI+2encB/MuTjFcr37zzq90zTUpRKFPWaMOrNq0rHyXnmTBSkiFANA
         rLZnDBlbkJxa9TJXEARQF8+CPaw4Mcn1i18FrEdeBfTNfXCq4DzKG+9FQxPJjhgH1y39
         23yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zC2INOq4i9mC2uFkAt9YGh74OyV1gw0rpUisyLgMs34=;
        b=BtnSZyT/jHwh0c9fLvawL+ZNG3y+aXU5f/Tc5pYQ5s4Z2D/d9htBhDdb053vqSc+53
         UNEAqjyGuF6eZ0CXYQ4W1GKEc7vDuAGYyXPN2DXriRtQYEWQGMAdiBaw2sjsGGLVjThD
         ilFZaOaV/EinM6z+6ce8V5ad31Nc/mlDDWpIANpFUSExigvixjxDcdTKNoQ7nk56EaRk
         sjEgxOeGrfaiZB777ZO5MqGCxpjh1HxcYH2U7Z+5ehoGNpGKNWFneAe4ykFbENoJ5WWj
         +4iUhLI+n+OHSBobKG0vsHnAOLA2XxZB5qJPY1mrL0R4Hpo+2UAG2LJ/b8znmE6oq+oZ
         cXXQ==
X-Gm-Message-State: AOAM532jQyn0B1pQDLj6Mel1tOG5hMd6MUhG0NNH7hCIhp6DJZU6msQk
        MlOukkz26050I+LSUaCwcKcwGg==
X-Google-Smtp-Source: ABdhPJzhnh2R57kvUTiK2IrlWXaZNIeFr9wFhjrifJwHuJcYigaFdm2oW9QeGOlmT4jB1qeVKE3jwA==
X-Received: by 2002:a17:902:7b82:b0:143:a6d6:34ab with SMTP id w2-20020a1709027b8200b00143a6d634abmr51709366pll.30.1637157231909;
        Wed, 17 Nov 2021 05:53:51 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([66.23.193.242])
        by smtp.gmail.com with ESMTPSA id s7sm25155266pfu.139.2021.11.17.05.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 05:53:51 -0800 (PST)
Date:   Wed, 17 Nov 2021 21:53:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] coresight: etm4x: Don't trace contextID for
 non-root namespace in perf mode
Message-ID: <20211117135343.GB4771@leoy-ThinkPad-X240s>
References: <20211031144214.237879-1-leo.yan@linaro.org>
 <20211031144214.237879-4-leo.yan@linaro.org>
 <07dbd4ac-5847-96cf-eb3c-d24561bb052c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dbd4ac-5847-96cf-eb3c-d24561bb052c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Nov 16, 2021 at 09:46:20AM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo,
> 
> On 31/10/2021 14:42, Leo Yan wrote:
> > When runs in perf mode, the driver always enables the contextID tracing.
> > This can lead to confusion if the program runs in non-root PID namespace
> > and potentially leak kernel information.
> > 
> > When programs running in perf mode, this patch changes to only enable
> > contextID tracing for root PID namespace.
> > 
> 
> The only concern with the patch here is we silently ignore the CTXTID
> flag and the perf assumes the CTXTID is traced, when traced from a non-root
> namespace. Does the decoder handle this case gracefully ? We are
> fine if that is the case.

Good point.  As far as I know, if CoreSight trace data doesn't contain
context packets, tidq->tid is initialized as '0' and tidq->pid is
'-1'.  In this case, the decoder will fail to find thread context and
the user space samples will not output anymore, see [1],
cs_etm__mem_access() returns 0 when the thread pointer is NULL and
the user space samples will be skipped.

On the other hand, I observed an unexpected behaviour is the decoder
also fails to output any kernel samples.  From my understanding, the
kernel samples should always be output, I will check furthermore for
this (I can think one possibility is perf tool fails to find a
'correct' vmlinux when parsing symbols).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/cs-etm.c#n720

> Either way, we don't want to enforce the policy in the perf tool, if we
> can transparently handle the missing CTXTID and allow the trace session
> and decode complete. That said, your approach is the safe bet here.

Do you agree below assumption for tracing in non-root PID namespace?

For non-root namespace we doesn't tracing PID, CoreSight trace data
doesn't contain context packet, so the perf decoder cannot find the
corresponding thread context and perf tool will not generate any
samples for user mode.  But the decoder should generate kernel
samples.

If you agree with this, in theory I think we should not change anything
in perf tool (but let me confirm the decoder kernel samples can output
properly).

> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index e24252eaf8e4..6e614bfb38c6 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -615,7 +615,9 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >   		config->cfg |= BIT(11);
> >   	}
> > -	if (attr->config & BIT(ETM_OPT_CTXTID))
> > +	/* Only trace contextID when runs in root PID namespace */
> > +	if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
> > +	    (task_active_pid_ns(current) == &init_pid_ns))
> >   		/* bit[6], Context ID tracing bit */
> >   		config->cfg |= BIT(ETM4_CFG_BIT_CTXTID);
> 
> As mentioned in the previous comment, please add a helper here, than open
> coding the check.

Agreed, will add new helper for checking root namespace.

Thanks for reviewing.

Leo
