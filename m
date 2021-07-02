Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43953B9A91
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhGBBec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhGBBeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:34:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CECCC061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 18:31:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v13so4739859ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 18:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2VS8QrT4FkOZf/FxdigYQ26l7luOXyTJp7RV8GPJrdE=;
        b=YOglFXKrkWo5dpfRFx0RdzPtuj4a/f0VTge5boEtc45ZjeSKS8YYTXDaYG8IOGMukk
         Xm/WELpFafE2KhJgnmw0qnx2ArVyuGn1DxP6UAFkFtMb617XPjzn2glQ3gOVaWuZStaO
         Gr37qU+YoI9TKhtO6l7ppHSmuaAGUa8DhVMmc8hg9AB8KV9Q1kjrWAB4el6OwPt/Q1zO
         8bnwQ3WvNCUDpG9DuEJPpztMOBVjlbiADAns3GXj+kCNbgBv88a8HHBzWinGKdy3xXu2
         hy9MxJbV2nqnEE+AbQiKuFtgGTVAzH0oX+iZVEOpc2PuQVKrpmtHVd98Ym8XRTyajM3X
         FEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2VS8QrT4FkOZf/FxdigYQ26l7luOXyTJp7RV8GPJrdE=;
        b=HNX5AFKO6TmSt5Ef6njF6svMeEI/Lnm80AAe2BP6SPHj04ZU2YtZqNx0sk9QYcWuyW
         aUEeH1vjEHbL3NItSYd1pE1pYoEC1llATu/ZLbFzkzWcCOStaquFeLYzWp0H2BAdgrXB
         pIVA54nxE2Y7EQz4V2JD/g2BEHJyrQ9U7gUPMB/Ve5RU2XpwLRYlk6eHUxsPqfqHC3bo
         kN/bpp+fR/cqG+DMkNXWUlkC4R8XwqzZwM1yNH/OirF0kIidsFpO4tOTTQLmkMLglrR8
         eqI7q5atCIBJFfNz/KDmy+3lwLx+9xiF+CkQhM3VfU0GtbHgi+OLNeTG64gJO0/p64Qa
         WQ0g==
X-Gm-Message-State: AOAM530RnH5br00o/8ooFX5krOSsAYdT6ekvzIMx6qXX272eguf3y0JM
        ge63Lc6AdAav8ItHvIcfF/fhKQ==
X-Google-Smtp-Source: ABdhPJwBlYWe733SkOJLsfGovF+cVSjYu3148ezEuyNifXWhyvR+fX8TyG2SEVd/heJH5iHnBVGNFw==
X-Received: by 2002:a17:90b:4b8d:: with SMTP id lr13mr2402518pjb.89.1625189513083;
        Thu, 01 Jul 2021 18:31:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id gz24sm852593pjb.0.2021.07.01.18.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 18:31:52 -0700 (PDT)
Date:   Fri, 2 Jul 2021 09:31:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT
 event
Message-ID: <20210702013143.GB251512@leoy-ThinkPad-X240s>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
 <20210519071939.1598923-6-leo.yan@linaro.org>
 <369fd454-d94d-daa1-ead4-b42645ec4282@arm.com>
 <20210628121217.GD200044@leoy-ThinkPad-X240s>
 <YN31VC9e/33QYhwn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN31VC9e/33QYhwn@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 02:03:16PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Hi Arnaldo, I confirmed this patch set can be cleanly applied on
> > the latest acme/perf/core branch, so could you pick up this patch
> > set?
> 
> Applied, thanks, please let me know if there is still something
> outstanding,

Thanks, Arnaldo!  I confirmed you don't miss anything.
