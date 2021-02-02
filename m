Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF430B44E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBBAul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBBAuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:50:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:49:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b8so11434450plh.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lyDxKpFLYEIFhDSFlv90rmUQ9DjyIRRYYsBTc2zYzus=;
        b=IvcIauqBfcWEPcZYFfbPffPEqNA8Ff1bKTED6KA+tVDv3qnuE1XwllYSiowEpMKHX4
         zlSA7BQAJxBCKN/AqGkPd+VBywOt8wx+V0HAhee0ozWa/tPu39B9rXzDXC2IgYA8HaGN
         Qs4ub/Tyu5qhBl6uOlj52KuNFUar6SVZ2N5NVFc+GV2IJ3eK6r9bA7/Z25Wut6x4fd6X
         RIxAZ56Zwz3yzPuxCD5ExHKAxLT/RMV9tGccCMTke3mzzw0+KxW3s1L1JSw0Bsj+BfUl
         ipEDTSVWWz584+OoyCyM14EvAmbLNL0WIj1z6Tb1m4v0Ai5wzj+mOQn5w654BFTZ/7yN
         0Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lyDxKpFLYEIFhDSFlv90rmUQ9DjyIRRYYsBTc2zYzus=;
        b=AcvLekbRcIp1bBt3/2SrrKr1Bf2geu4R7PEvOStbYuBnL7k46nWnEe5esnt8WSFfCn
         Nk6jFcwacNK4jKiLq4Dbk8ORisu44f3rmzBdyHieWDbcjkoBJpCqBw1HNtALE+XXdLR0
         0vJm4knZTIBy+pYCTIH3PtmLxy/JsB4Hq+dgcQrsrwJPLnlknrqEJDNvldURV7tj1Tsx
         bNROZDAmFAc3FgVgIs2RNaNJEwVQXOjHGdqijFbF8cOgXpIlgYz0hoAeGc856sSHaQXH
         JXvHrIz5b9kjRWGX5GkrMEoyjCYKEGr5r58Q8T49PhHtPZ4ShpihqoEWNKp8iB97J10N
         bYdA==
X-Gm-Message-State: AOAM533x+Gt55olFutRSbQdKgEMMv86wReSGf9ARvZU5V8F3NBX47mMH
        OC9p645BrXeNAUEcE+xkf05Drw==
X-Google-Smtp-Source: ABdhPJzeoaVLeZnCQPwLpf9+abzuUoEMVRiGmc7vWQMfD1tXuLinXkvOswPMl9BrtBLKprfIn9u35A==
X-Received: by 2002:a17:90a:a516:: with SMTP id a22mr1530763pjq.192.1612226998952;
        Mon, 01 Feb 2021 16:49:58 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v26sm18276373pff.195.2021.02.01.16.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 16:49:57 -0800 (PST)
Date:   Mon, 1 Feb 2021 17:49:56 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/17] remoteproc: Add support for detaching a rproc
Message-ID: <20210202004956.GD1319650@xps15>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
 <64b559dc-9e89-c351-ddee-f9cebd155ed7@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b559dc-9e89-c351-ddee-f9cebd155ed7@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:21:24AM +0100, Arnaud POULIQUEN wrote:
> Hi Mathieu
> 
> On 12/18/20 6:32 PM, Mathieu Poirier wrote:
> > Following the work done here [1], this set provides support for the
> > remoteproc core to release resources associated with a remote processor
> > without having to switch it off. That way a platform driver can be removed
> > or the application processor power cycled while the remote processor is
> > still operating.
> > 
> > Of special interest in this series are patches 5 and 6 where getting the
> > address of the resource table installed by an eternal entity if moved to
> > the core.  This is to support scenarios where a remote process has been
> > booted by the core but is being detached.  To re-attach the remote
> > processor, the address of the resource table needs to be known at a later
> > time than the platform driver's probe() function.
> > 
> > Applies cleanly on v5.10
> > 
> > Thanks,
> > Mathieu
> > 
> > [1]. https://lkml.org/lkml/2020/7/14/1600
> > 
> > ----
> > New for v4:
> > - Made binding description OS agnostic (Rob)
> > - Added functionality to set the external resource table in the core
> > - Fixed a crash when detaching (Arnaud)
> > - Fixed error code propagation in rproc_cdev_relase() and rproc_del() (Arnaud)
> > - Added RB tags
> 
> 
> I tested you series, attach and  detach is working well.
> 
> Then I faced issue when tried to re-attach after a detach.
>

Right, in this case don't expect the re-attach to work properly because function
stm32_rproc_detach() does not exist.  As such the M4 doesn't put itself back
in "wait-for-attach" mode as it does when booted by the boot loader.  If I
remember correctly we talked about that during an earlier conversation and we
agreed FW support would be needed to properly test the re-attach.
 
> But I don't know if this feature has to be supported in this step.
> 
> The 2 issues I found are:
> 
> 1) memory carveouts are released on detach so need to be reinitialized.
> The use of prepare/unprepare for the attach and detach would solve the issue but
> probably need to add parameter to differentiate a start/stop from a attach/detach.
> 
> 2) The vrings in the loaded resource table (so no cached) has to be properly
> reinitialized. In rproc_free_vring  the vring da is set to 0 that is then
> considered as a fixed address.
> 
> Here is a fix which works on the stm32 platform
> 
> @@ -425,7 +425,7 @@ void rproc_free_vring(struct rproc_vring *rvring)
>  	 */
>  	if (rproc->table_ptr) {
>  		rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
> -		rsc->vring[idx].da = 0;
> +		rsc->vring[idx].da = FW_RSC_ADDR_ANY;
>  		rsc->vring[idx].notifyid = -1;
>  	}
>  }

In light of the above let me know if these two issues are still relevant.  If
so I'll investigate further.

Thanks,
Mathieu

> 
> Here, perhaps a better alternative would be to make a cached copy on attach
> before updating it. On the next attach, the cached copy would be copied as it is
> done in rproc_start.
> 
> Thanks,
> Arnaud
> 
> 
> > 
> > Mathieu Poirier (17):
> >   dt-bindings: remoteproc: Add bindind to support autonomous processors
> >   remoteproc: Re-check state in rproc_shutdown()
> >   remoteproc: Remove useless check in rproc_del()
> >   remoteproc: Rename function rproc_actuate()
> >   remoteproc: Add new get_loaded_rsc_table() remoteproc operation
> >   remoteproc: stm32: Move resource table setup to rproc_ops
> >   remoteproc: Add new RPROC_ATTACHED state
> >   remoteproc: Properly represent the attached state
> >   remoteproc: Properly deal with a kernel panic when attached
> >   remoteproc: Add new detach() remoteproc operation
> >   remoteproc: Introduce function __rproc_detach()
> >   remoteproc: Introduce function rproc_detach()
> >   remoteproc: Add return value to function rproc_shutdown()
> >   remoteproc: Properly deal with a stop request when attached
> >   remoteproc: Properly deal with a start request when attached
> >   remoteproc: Properly deal with detach request
> >   remoteproc: Refactor rproc delete and cdev release path
> > 
> >  .../bindings/remoteproc/remoteproc-core.yaml  |  27 +++
> >  drivers/remoteproc/remoteproc_cdev.c          |  32 ++-
> >  drivers/remoteproc/remoteproc_core.c          | 211 +++++++++++++++---
> >  drivers/remoteproc/remoteproc_internal.h      |   8 +
> >  drivers/remoteproc/remoteproc_sysfs.c         |  20 +-
> >  drivers/remoteproc/stm32_rproc.c              | 147 ++++++------
> >  include/linux/remoteproc.h                    |  24 +-
> >  7 files changed, 344 insertions(+), 125 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-core.yaml
> > 
