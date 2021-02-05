Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8846E310257
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhBEBpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhBEBpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:45:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06AFC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 17:44:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d2so2900187pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 17:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8auo+sSN8LUCz7eHTWD1b9cMbXkiEhCmkanvQ8Grsig=;
        b=lSP+/pdh3y2lFN9b/qpJuWN5sk4tPHXU9ntDqio/ZXgxGVnag1PzvR9CE1ydFmIOVM
         qPPvlMfjpO2+bnMbTOz17WgumqEBmNOwD+/igWomlhES5IjUOAge+6DKCcxNQQkHvgOw
         y0P7o09kg/SWPt9LpPPTCEMOn0YbyIe7It3SlygVh9hg5kCdmfv2xCTISJDtLigGwyPf
         Qpu1kbvWZHYsLQLKF1IG018wGhaYi3XNOP43+UvJHlcKAdjlNCsYU+8EkmbmbMzfj70i
         ifVdMyMpDMJU99yhW27hF9FOM+ciH2+/xiQ11E1gvmDXrbTwShUCsiZpuAFpbTnmOIyj
         WE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8auo+sSN8LUCz7eHTWD1b9cMbXkiEhCmkanvQ8Grsig=;
        b=MXyiVzBM9lM8OvpnKNZraxdTeJwWkEa4cVfzIYSin+t1AejPxb2SZQM77SrOmYx5fC
         ckvqcpsbl4WCwl4kz2BYMTBYeTsdjurdfE7yGQ6BFcv2e70w0+S81QT19JvYi6B3ctMb
         fZtcpfiNGZAyrDfLIRHg+He52cEU1RnCCP7T4MWUvHltXrVdGRGQCyqnfyjMKE2i2DUs
         SY7Ot2oJiikvGLG0NRFB8UPG2y6ztYEmfzDYBy3V9N6VVuLoIAiraww9oJZgB65BWTqT
         W6L4qBvMizhp5Y5mTaqVCDqmWCqnFNC/UR5X/YRURZqPKZuz7jFOCFkH6pdfH/fnNZ7p
         tJGg==
X-Gm-Message-State: AOAM530tH4U6+CfqeTBSk2QkXj+DazD80YlPbND3sR6e8Brk7rFgH7Vh
        z4emu0Bu5C0HUWG9RSFEdyA=
X-Google-Smtp-Source: ABdhPJyhnPOTnyG1gNOgRhrsWsaDbd/taOxvYyyd0yPNXSqaA1gHQyraOSVux35p5H/gRljI1J8vCA==
X-Received: by 2002:a17:90a:7ace:: with SMTP id b14mr1824677pjl.208.1612489473455;
        Thu, 04 Feb 2021 17:44:33 -0800 (PST)
Received: from google.com ([2620:15c:211:201:598:57c0:5d30:3614])
        by smtp.gmail.com with ESMTPSA id y73sm1675009pfb.17.2021.02.04.17.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 17:44:32 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 4 Feb 2021 17:44:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: cma: support sysfs
Message-ID: <YByi/gdaGJeV/+8b@google.com>
References: <20210203155001.4121868-1-minchan@kernel.org>
 <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com>
 <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com>
 <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 04:24:20PM -0800, John Hubbard wrote:
> On 2/4/21 4:12 PM, Minchan Kim wrote:
> ...
> > > > Then, how to know how often CMA API failed?
> > > 
> > > Why would you even need to know that, *in addition* to knowing specific
> > > page allocation numbers that failed? Again, there is no real-world motivation
> > > cited yet, just "this is good data". Need more stories and support here.
> > 
> > Let me give an example.
> > 
> > Let' assume we use memory buffer allocation via CMA for bluetooth
> > enable of  device.
> > If user clicks the bluetooth button in the phone but fail to allocate
> > the memory from CMA, user will still see bluetooth button gray.
> > User would think his touch was not enough powerful so he try clicking
> > again and fortunately CMA allocation was successful this time and
> > they will see bluetooh button enabled and could listen the music.
> > 
> > Here, product team needs to monitor how often CMA alloc failed so
> > if the failure ratio is steadily increased than the bar,
> > it means engineers need to go investigation.
> > 
> > Make sense?
> > 
> 
> Yes, except that it raises more questions:
> 
> 1) Isn't this just standard allocation failure? Don't you already have a way
> to track that?
> 
> Presumably, having the source code, you can easily deduce that a bluetooth
> allocation failure goes directly to a CMA allocation failure, right?
> 
> Anyway, even though the above is still a little murky, I expect you're right
> that it's good to have *some* indication, somewhere about CMA behavior...
> 
> Thinking about this some more, I wonder if this is really /proc/vmstat sort
> of data that we're talking about. It seems to fit right in there, yes?

Thing is CMA instance are multiple, cma-A, cma-B, cma-C and each of CMA
heap has own specific scenario. /proc/vmstat could be bloated a lot
while CMA instance will be increased.
