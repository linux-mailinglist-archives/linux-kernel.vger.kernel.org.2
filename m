Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA53B698F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhF1UQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhF1UQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:16:50 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E029C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:14:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e33so16441407pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ZnGDtl1tfzZOtqDAq6jjVvtwOuBD0ilGwgxqjlrpl0=;
        b=xOia3izt7iY8wngK+5KXACBIu+zIQfxgrqgjif9gw0nfalcOoMkpoR/Msi2WhM5y7E
         PIAFQwe8w3irXL6E3icdJ7MiVz4VF9QLtnAOv6TOKAAEtYfRGlgYQdscBfs6ZIwtetQg
         kouiyKS1lMZG/MBGFK7O/rDaqnGma1YHo/eZHD1BnrReneRvxl4Dqpn91gQLFVp5B1yD
         K95hcyXUpG4/7nwJP1/1IrBLILyeaCXxinCBe2RUNG6KxZmH8blXX63qYH7xmh7g+pEd
         XDj58YxTgt2D9cDSEpxurD4ESpE+H744cYpJKgApC30N6gCHeKx32u951Kv5AmnvejO1
         y34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ZnGDtl1tfzZOtqDAq6jjVvtwOuBD0ilGwgxqjlrpl0=;
        b=cO3ZxCIwcjSaMJCoG93N4lTBjH9F+UAwcid+75COg0x9KM1weQkwOtAvrYuDnM8dtp
         IePxbEqVBrzFrd9AUFKDYIc7Gzwca9u3fpRnBGknliQK/0V7oi4WJGyD6SRIEoqfdvQh
         smnk1wmSBTcl27UVqd7VLb+K5TL2+5f3AXxSjtxJgUDljCQZ1nvdFW6VE0cG91wBPbq5
         GFLzMof9vaYoZGJjoWFcS5hNy/Q/Su6GYgpv6ENt9fhVe1soEIXjAxhwhtlcu446Ss6H
         46T0c3L7uHpoM6tdH+SC/1KHKYSJpCvQjx4M6uLqC8FA/nQ0zmLbyOxvCHDZTJDdvRs1
         N/hA==
X-Gm-Message-State: AOAM5332wg/GVJQPM7orm6LrENZALhXqzhoBke91Zxgm0IMu3ysg55mw
        EqXDmMU2jiocEIZA4yRI+aXQ+iAt1uUS/g==
X-Google-Smtp-Source: ABdhPJxVVN3NPc4d9nLhD1Dfr/CZoIM2R8nyecogy9yQcGx2BveE4Qsh5qPv1sZ5R4fRCSu0WHx3Yw==
X-Received: by 2002:a63:445b:: with SMTP id t27mr24798686pgk.413.1624911262721;
        Mon, 28 Jun 2021 13:14:22 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y6sm15293195pjr.48.2021.06.28.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:14:21 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:14:19 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: remoteproc DMA API abuse status
Message-ID: <20210628201419.GC1200359@p14s>
References: <20210623134307.GA29505@lst.de>
 <20210624193514.GA1090275@p14s>
 <011dac94-cfe0-d276-980a-b8ffe1447521@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011dac94-cfe0-d276-980a-b8ffe1447521@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:27:09AM +0200, Arnaud POULIQUEN wrote:
> Hello Mathieu,
> 
> On 6/24/21 9:35 PM, Mathieu Poirier wrote:
> > Good day Christoph,
> > 
> > On Wed, Jun 23, 2021 at 03:43:07PM +0200, Christoph Hellwig wrote:
> >> Hi remoteproc maintainers,
> >>
> >> did you make any progress to get remoteproc out of creating fake
> >> devices that fake their dma ops status and the abuse of
> >> dma_declare_coherent_memory in removeproc_virtio?  I remember we had
> >> a discussion on this a long time ago, and there was an unfinished
> >> patchset to change the memory pool handling.  What happened to all that?
> > 
> > I believe the conversation and patchset you are referring to are pre-dating my
> > time in this subsystem.  To make sure I am looking at the right thing, can you
> > (or anyone else) point me to that discussion and related patches?
> 
> 2 references:
> 
> 1)Previous discussion thread on the topic:
> 
> https://patchwork.kernel.org/project/linux-remoteproc/patch/AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch/
>

I remember that one.  Glad to see there wasn't anything else before that.

> 2) My patchset related to the refactoring of remoteproc virtio which tries to
> address the point by creating a remoteproc platform driver and declaring a
> virtio subnode in the device tree remoteproc node.
> 
> https://lkml.org/lkml/2020/4/16/1817
> 

I thought your current work on refactoring the rpmsg_char driver was part of the
early steps on the way to splitting that patchset up...

> No time yet on my side to come back on the patchset :(
> 

I know the feeling.

Thanks for the info,
Mathieu

