Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CFD3F1F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhHSSJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:09:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A78C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:08:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b1so5351525qtx.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bAIiTBPTb8Mkl8cV8Kxh3WxowxrFi5/bhPm5MGwzFe8=;
        b=Nd0h3PKHtULXQTcNfUrbUNLMY+Lcp2GUMrljVSXkJIdb3p4t+DHL7vroVO4gvZbMZZ
         rBhdbmghvCGXuZlQkPccfMDTAKB3hCWFhKMNGAx6A1jQ4o01QI+y0ysBu/HhHyMJ966P
         4CrbtleOSmV5ypqZKqxeed4dpc+NZQtkAwxNIjrcix7c1hbWtJT+U6O7a1x7F9Nybc7K
         +ojOOuA1TcHaFaB8z+NO6rB06iUNFIPDB5XcUJLqC5Fex8vslhYV2LvpY6TNawZbcDRp
         utvOZBmjqDddnbWAuKQ7Eb0vL/7RTcgR59CEQcbzxZoAXzZmRpAAMJn7tXo9w+USd8J5
         0Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bAIiTBPTb8Mkl8cV8Kxh3WxowxrFi5/bhPm5MGwzFe8=;
        b=LJvEs2aWqaTwu0NsAvnci/03JTVAAXmh0Lr8TG4jgxmjdXqSw0v06BqkcovfZaxmwG
         bDTGHj618+uCwL9oNrSUoQGu4hbFUW57D0nPiMTilyuxJNJwFlLUW0K9m/sgiqvIna6g
         0maQJg9ufVuG2nANsptXgN/4/MP0ZAwYjvCPy4TN03SfHwr6fZpMxjCRtSp9MKTktFCB
         0YRLsu0tWf3cqvbjnGXCbP2E2ZnjiGCRmU1ffTHJlHmgjU3yDqNFYmflpy8UZfM/Nw9z
         g/EFI3U6EL7SSwVXA3rNHsfj5ygOh3GvrShfdOrBa02PjiqtxCxmdrjcsz8dW+wISCYp
         eJkg==
X-Gm-Message-State: AOAM532Xc1rHOuhdeUyqNbEKtshnbz8dIrVVFMzj9hX8bRXdYXtp5+7t
        fbOpWBduwWFsBNp2r+iOegaIAg==
X-Google-Smtp-Source: ABdhPJzIlc7ODqmcQFX/Z4hb8tPxDoQi/zEYTAMjg2xfKZBDl8lNXkPrTFdLSbiiZt6hmB3h90y51w==
X-Received: by 2002:ac8:7f89:: with SMTP id z9mr14174937qtj.240.1629396522044;
        Thu, 19 Aug 2021 11:08:42 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 141sm1966700qkn.10.2021.08.19.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 11:08:41 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:10:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
Message-ID: <YR6ejLTuWp2Gm12H@cmpxchg.org>
References: <20210819150712.59948-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819150712.59948-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 11:07:12PM +0800, Muchun Song wrote:
> Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> PAGEFLAGS_MASK to make the code clear to get the page flags.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

LGTM.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
