Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7252A3F0656
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhHROSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240049AbhHROOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:14:52 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC31C061796
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:13:47 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id c14so1711142qvs.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rg02+w1DlkJobhoJY9bM97YQwIjcX3dhjCH/vsEFgP0=;
        b=IJM3/57oMfrwBGTxX1IHTSufxeq6P3Ds6XRZvE9DZaQYu6SrVcwDRerEYF25qu7X1B
         P60N9RrgrRNag8tqLyPwd2wzaLi9O55qN9diwm9sZAtemcAodh0vkx7GORHTW9R5W2LY
         rV/W0SNTLdFLW8cLcW0Qu/6ySAJpxaO6I9bAxGJSjR5kQXqiY7nMpO/wVGbIlV0HDfjw
         dYuz+g7ZxYVhUxmQisLCpNH+9kMNrqw8fYLGpqtTiUzPzHScZLMpGUR7odgvREoOGyvq
         uG3PAzekn0lUz/hG2/KBgIhbNa18vFUOGqnNMOmaodYK+aTh4+ylfiWpcrP7Zlm5Pd0x
         G6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rg02+w1DlkJobhoJY9bM97YQwIjcX3dhjCH/vsEFgP0=;
        b=o1silUbXGaurKLEfsp4OOfHQScZsRL5W1oyYjRjpjDrpWa4nYaIm6i7CjP6H3/MDoK
         O49GuHJVe3ph4Yzl1zc5ftc5yMWrO5kO0ZD9ygXOPTg2m23FoPckYV1HJ6UZSaDowE33
         J5TFIyYj8wP47gOiOSgHnVGs+1R91asa4KZQvkRwIJjK3CNpF0Y1GaaLiuNqR8eWHw86
         pM7kiI9460hx0ivtKO2ExvXKBjh5StAX2r0FPwBFmIsqoOv8i2BmR/94K0r349rwolk2
         8O93x4UPvJcpc22gc+WEuoPovRvkCT4uvkgUgJZdYoxxHRpHrCB+5sTII2oCvhQaetld
         LiwQ==
X-Gm-Message-State: AOAM531HpLWo69dP4QExvfRm4B2erWb5rRU55g+BlN7UFQQNnUaJG4+G
        3xXOwebejxNUtU2bwvraTmD+lA==
X-Google-Smtp-Source: ABdhPJz/+BjLkxJrAxTTKQlm/p7qbbRBNIQAU4NUKJL55u3lLL5nfMNPDLp17j/ZoFTBbZcRaBPgGw==
X-Received: by 2002:a0c:fd21:: with SMTP id i1mr9140058qvs.29.1629296026700;
        Wed, 18 Aug 2021 07:13:46 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id o10sm59259qtv.31.2021.08.18.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:13:45 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:15:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YR0V/KhKSYZs+ksn@cmpxchg.org>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
 <YRwRzjOexeXbkirV@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRwRzjOexeXbkirV@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 12:45:18PM -0700, Roman Gushchin wrote:
> On Tue, Aug 17, 2021 at 02:05:06PM -0400, Johannes Weiner wrote:
> > We've noticed occasional OOM killing when memory.low settings are in
> > effect for cgroups. This is unexpected and undesirable as memory.low
> > is supposed to express non-OOMing memory priorities between cgroups.
> > 
> > The reason for this is proportional memory.low reclaim. When cgroups
> > are below their memory.low threshold, reclaim passes them over in the
> > first round, and then retries if it couldn't find pages anywhere else.
> > But when cgroups are slighly above their memory.low setting, page scan
> > force is scaled down and diminished in proportion to the overage, to
> > the point where it can cause reclaim to fail as well - only in that
> > case we currently don't retry, and instead trigger OOM.
> > 
> > To fix this, hook proportional reclaim into the same retry logic we
> > have in place for when cgroups are skipped entirely. This way if
> > reclaim fails and some cgroups were scanned with dimished pressure,
> > we'll try another full-force cycle before giving up and OOMing.
> > 
> > Reported-by: Leon Yang <lnyng@fb.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Roman Gushchin <guro@fb.com>

Thank you.

> I guess it's a stable material, so maybe adding:
> Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")

Yes, that Fixes makes sense. Plus:

Cc: <stable@vger.kernel.org> # 5.4+

I initially didn't tag it because the issue is over two years old and
we've had no other reports of this. But thinking about it, it's
probably more a lack of users rather than severity. At FB we only
noticed with a recent rollout of memory_recursiveprot
(8a931f801340c2be10552c7b5622d5f4852f3a36) because we didn't have
working memory.low configurations before that. But now that we do
notice, it's a problem worth fixing. So yes, stable makes sense.

Thanks.
