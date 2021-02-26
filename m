Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA9326448
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBZOmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBZOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:42:43 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47745C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:42:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id f17so9247393qkl.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aiCmYhXNlLmYvqysrua9w657uIfuMXAdivhZFAKEpXA=;
        b=NpKzeFXzuOhQbPo6fKVGMdf8+6iELovgUdCKZpMjN2+fdRPxMj98bWKMPa5Y7KF4/N
         vdL3T58tWpe6je0uydaDGpnNIAtNYbCDXb3HxGBOzIghdhU4d87IipH4ECbR6hIuHYL2
         OE4vaDcL+OI76JrDT110BgkIXDKANwC6gCSc9nelFg1RXHfxsTBuTo2BHt3HTkq+empV
         emd0QwJTTpMSsuAj4VMYxzsN04yBeIGuNxeQNqGKbXDSLy2e/LLZE2oB5yAYKcSuV1DG
         aecXjS/f39eZ6dU0YumxMHbEXGM5IPG7jTLpdrY6p3P4TFb7KAt2gn4o2nh2Yv5IT7vh
         IYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aiCmYhXNlLmYvqysrua9w657uIfuMXAdivhZFAKEpXA=;
        b=bW9wd7EU5MB1Dsrm3+BUBVSlRLQXmDfQg0Lc2hNww1QnbUXBjKM7WXfErhy5Wv9VQw
         fVluMqbcvKNqZidSEkAcfcSFHGpZVRnWNBsuYohUxPb38j5oopaciRuWqB1UYS8eNHwZ
         QB+eyoe9xKB29Bxj5yC946i6up/craMcebne+qNyU0tpFzArUToXUpLtzv1PAZ9HUv1S
         m7b4B39auetSQzTZfCWRPRHMlEblSxf7buyj27A8C8tzkGiOB96XUPLbrxK1CFoOdozs
         R30QCpWRTBSa0s/LQrWMVHqsKDqVf4weC3RRRPkG6nOQ6TRuS91Hauq0OAxE0XHxe/bP
         s0nQ==
X-Gm-Message-State: AOAM531Syzie76jq2EQ+lBo1EP4BeOSXqYosEiQHlosnlg+Rjg2vd1Gl
        Cvl5QNwlPZzRqymKuhpqUOJBdVr3U1j5Bg==
X-Google-Smtp-Source: ABdhPJy2NOOfE5ZleC1vNC6+D2fTtJXEm1J15WIn4t802EjUbQ4eaTkrRyQ86tK+Y+nBiiCdVzv/WQ==
X-Received: by 2002:a37:7c8:: with SMTP id 191mr2908942qkh.53.1614350522094;
        Fri, 26 Feb 2021 06:42:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id t71sm6437470qka.86.2021.02.26.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:42:01 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lFeJc-000tBv-SJ; Fri, 26 Feb 2021 10:42:00 -0400
Date:   Fri, 26 Feb 2021 10:42:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Freeing page tables through RCU
Message-ID: <20210226144200.GV2643399@ziepe.ca>
References: <20210225205820.GC2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225205820.GC2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 08:58:20PM +0000, Matthew Wilcox wrote:

> I'd like to hear better ideas than this.

You didn't like my suggestion to put a sleepable lock around the
freeing of page tables during flushing?

I still don't see how you convert the sleepable page walkers to use
rcu??

Jason
 
