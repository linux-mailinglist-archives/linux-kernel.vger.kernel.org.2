Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B35322B43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhBWNMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhBWNMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:12:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:11:28 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id v5so10993725lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=58Vl6MdTDmvOpytzkwrUHMlB/23h8vA0IENULWrl6dY=;
        b=MH3OmbwBejCINO6iEeH3lQHAeNNuSSvnB8ObDUY5/Y6k6aSd7va3qPSFG0BlnJ97qB
         baLhc70dMw8bPcL2atw4yF0ol8/4l/ZT59GKmVfxkthtbfW8IQ/273ErCqrgzn+NQPCk
         PJuMgrenDbT2DV9nXaf4Vn9b+eH9uiFIJxTXMyE4/5LSTAVCoj4sSRAXQG/LCvF1S6V+
         7jvWBkHQ5ZrsPppScMi4c+RCXoWYaRlxU+YlOHy3yFvV++9Qviq5mp0Z4Gi7Vb8y3gvO
         sVzdJIQ6oYyJ3cQPaI/GS/CLcWwuEbQocEL3GvcvZhEpex0MPwxLIJ1vm2UaSmIJx042
         R4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=58Vl6MdTDmvOpytzkwrUHMlB/23h8vA0IENULWrl6dY=;
        b=RSIVZWGq9Y7P6cZRbbw1iJKtgd4+hW7bjDzH9terbajRuEHTKXUpHxpPAnXU8Ri2qD
         PbK6+Jkuu5i1sfY7tgqHDkNBlnqy/sLuMvSIi0hOu2v9QcA1o6Df8JrM38FMZPYeBsQN
         RqZdkiUYzizL9dGLLJzTCDlzdtyGTtxOxOg/KTt2UUE+mKjHIgXOstoMW423MhykRLZN
         yQ24CCCH/Ndqhi4e3tWbl+KvzFCeIwzySZ039Jd/qu1pi19OoViZz1A3tFMO5RHwGY4N
         rbl9/coGIAy3a9Lb0gHw6IRO6lP+9RCrYMhF88zjAQPFrWIf1rqNCMQxTDTHnIqdEyUh
         9+/A==
X-Gm-Message-State: AOAM5334egMsFtDZxHcyQ8Q6Zh0sRJm8vWZdh09t5zI283zzHJijnJ9F
        LF5X55UyvdZyRNhCjtQyCLQIVvwAe9MCsQ==
X-Google-Smtp-Source: ABdhPJzBn1+hHYrCfYGYXrVxS8zkjZxNp5SjFO3AGPTItBvE3mIES0AjqSuwk/9tZIuSpGxUP+u3sg==
X-Received: by 2002:a05:6512:108c:: with SMTP id j12mr12127512lfg.431.1614085886767;
        Tue, 23 Feb 2021 05:11:26 -0800 (PST)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id p13sm2886020ljj.49.2021.02.23.05.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:11:26 -0800 (PST)
Date:   Tue, 23 Feb 2021 14:11:24 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210223131124.GA2303918@jade>
References: <20210210144409.36ecdaed@xhacker.debian>
 <CAHUa44E-_czjhRxr2JjggYu0sDCsRvOA3Uc=hqp7j5Cmtb9q0w@mail.gmail.com>
 <20210223184026.22c86356@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223184026.22c86356@xhacker.debian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 06:40:26PM +0800, Jisheng Zhang wrote:
> On Tue, 23 Feb 2021 08:59:22 +0100 Jens Wiklander wrote:
> 
> 
> > 
> > Hi Jisheng,
> 
> Hi Jens,
> 
> > 
> > On Wed, Feb 10, 2021 at 7:44 AM Jisheng Zhang
> > <Jisheng.Zhang@synaptics.com> wrote:
> > >
> > > Add tracepoints to retrieve information about the invoke_fn. This would
> > > help to measure how many invoke_fn are triggered and how long it takes
> > > to complete one invoke_fn call.
> > >
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >
> > > Since v1:
> > >  - add BUILD_BUG_ON() macro usage to make sure that the size of what is being
> > >    copied, is not smaller than the amount being copied. Thank Steve.
> > >  - move optee_trace.h to keep include headers sorted
> > >
> > >  drivers/tee/optee/call.c        |  4 ++
> > >  drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 71 insertions(+)
> > >  create mode 100644 drivers/tee/optee/optee_trace.h
> > >
[snip]
> > > diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_trace.h
> > > new file mode 100644
> > > index 000000000000..7c954eefa4bf
> > > --- /dev/null
> > > +++ b/drivers/tee/optee/optee_trace.h
> > > @@ -0,0 +1,67 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * optee trace points
> > > + *
> > > + * Copyright (C) 2021 Synaptics Incorporated
> > > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > > + */
> > > +
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM optee
> > > +
> > > +#if !defined(_TRACE_OPTEE_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_OPTEE_H
> > > +
> > > +#include <linux/arm-smccc.h>
> > > +#include <linux/tracepoint.h>
> > > +#include "optee_private.h"
> > > +  
> > 
> > Checkpatch has some complaints below. Is that something that could be
> > fixed or is this so far from regular C-syntax that we don't care?
> 
> I tried ./scripts/checkpatch.pl in Linus tree to check the patch, there's
> no any error, and except the "MAINTAINERS need updating" warning, there's
> no other warnings.
> 
> git log  -- scripts/checkpatch.pl
> shows the latest checkpatch.pl is at commit 62137364e3e8afcc745846c5c67cacf943149073
> 
> I'm not sure what happened.

I used the -strict option.

./scripts/checkpatch.pl -strict 0001-tee-optee-add-invoke_fn-tracepoints.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#44: 
new file mode 100644

CHECK: Alignment should match open parenthesis
#68: FILE: drivers/tee/optee/optee_trace.h:20:
+TRACE_EVENT(optee_invoke_fn_begin,
+	TP_PROTO(struct optee_rpc_param *param),

CHECK: Lines should not end with a '('
#71: FILE: drivers/tee/optee/optee_trace.h:23:
+	TP_STRUCT__entry(

CHECK: Lines should not end with a '('
#76: FILE: drivers/tee/optee/optee_trace.h:28:
+	TP_fast_assign(

CHECK: Alignment should match open parenthesis
#89: FILE: drivers/tee/optee/optee_trace.h:41:
+TRACE_EVENT(optee_invoke_fn_end,
+	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),

CHECK: Lines should not end with a '('
#92: FILE: drivers/tee/optee/optee_trace.h:44:
+	TP_STRUCT__entry(

CHECK: Lines should not end with a '('
#97: FILE: drivers/tee/optee/optee_trace.h:49:
+	TP_fast_assign(

total: 0 errors, 1 warnings, 6 checks, 86 lines checked

Thanks,
Jens
