Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B13C5B87
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhGLLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhGLLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:39:40 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3068C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:36:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 37so17930654pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y+E7UM9kDcTj1OatIHLBQBBbGJOQUqV17bP46qe4xL0=;
        b=SOgVkqEOzNScO3XJav73raze/kczq+VDiSGwyDfgebmUaOm6ZdKreXShk9wcURT/p0
         vJXj4NqzUhjhRV+DWB4Xuo7GC5koGx87eLY8aCkGmS1L+iOzYKHp9f/Q53FBBJeE6pVr
         2ggHmLZIJvY/gMHBa07OXMZtjy5kscMeUIBqNpQxq4UU0PLGiGr+Ag3dfykiyoXpW2OD
         B5MzhnW12ZCLcwTjs7u/srn85cbRLhmvgK81svZkCmcMhJoefrAJJOLsku+pzmRaPq1t
         xqkAI6TIIUCI4EAWUFA7tw/w+leFdRlneX2NY4jqt9sr+8fuEZ/0TG0MxQMyIoFcfDKX
         qPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y+E7UM9kDcTj1OatIHLBQBBbGJOQUqV17bP46qe4xL0=;
        b=D7CBWyjj/0qfjSKsoY7bhEOqP8b4TtfrOpUtZU+9ZrdHwPwDnTz+6o2ldkmdHjctxr
         OUyLcUhgkQU1mcliBecO+8c+HA5XThr/b4nPOHM/rmUrQLwX7FripA67zxiAvaXPj9dv
         71tcKdAyK984R4jIixY9ZfsCWcyf5H32RnAGSdEZ27dPCmZtbcJeZn2WmY8O4gy46W4+
         Hc06XnDpeTChRLL2LnKIKujT/Oj/3IFaVReGytyWXLP5aK1t7YVTkD/AwQdIzkbL35Ks
         gZYfV7cP+YPew4NX7vaiaD+axzLKbcUSDOTfa5w0Y8yloiNhdEueDJEjXnBJX2nOtimt
         F/ww==
X-Gm-Message-State: AOAM531SFSSKGmjdlsP0DAZMYo+d8DQH7a2+8zFfUwYU+GDM/oW+ee6G
        Q9BPqwogZtrr6huhstP+uHRnhw==
X-Google-Smtp-Source: ABdhPJz9brakuugW40ZFycuwYcI9zTqD3ilnR8HuqvhDg1VELvrTYhpRXA/8aZ2tymrt+oD8BGeGig==
X-Received: by 2002:a63:f901:: with SMTP id h1mr53579200pgi.69.1626089811384;
        Mon, 12 Jul 2021 04:36:51 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id g4sm18423878pgn.45.2021.07.12.04.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:36:50 -0700 (PDT)
Date:   Mon, 12 Jul 2021 19:36:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: tmc-etr: Speed up for bounce buffer in
 flat mode
Message-ID: <20210712113646.GD704210@leoy-ThinkPad-X240s>
References: <20210710070115.462674-1-leo.yan@linaro.org>
 <f17065d6-5083-74c9-d9ca-a467b640aed3@arm.com>
 <20210712110916.GB704210@leoy-ThinkPad-X240s>
 <5f3148bf-3efa-5866-b426-8bab4eb40282@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3148bf-3efa-5866-b426-8bab4eb40282@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 12:17:04PM +0100, Suzuki Kuruppassery Poulose wrote:

[...]

> > I am doubt why you conclude "always start tracing at the beginning of
> > the buffer"?  I read the driver but cannot find any code in the driver
> > to reset rrp and rwp after fetching the trace data, or there have any
> > implict operation to reset pointers?
> 
> The ETR is always programmed with the base address of the "ETR" buffer,
> which is *not the same* as the perf ring buffer, since we always do
> double buffering. We do not program the RRP/RWP of the ETR (except
> for the SoC-600, where it is mandatory and we set them to the base
> address). Thus there is no context associated with the ETR buffer.
> But at the end of the run, we do read the RRP/ RWP to figure out
> where the ETR has reached.
> 
> As for reseting the RRP / RWP, at the beginning of a session, is
> done implicitly for the ETR (except for SoC-600 ETRs as explained
> above) by the hardware to the base address.

Yes, I finally matched your description with the code.  Will respin
patch for this.

Thanks for confirmation!
Leo
