Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3D316A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhBJQAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhBJP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:59:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA6DC061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:59:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x136so1539002pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RAtFVgzHhLfyixwTlntvq13DCjkeX6xQPOokD6zZ59o=;
        b=eNbRweMnAvSvlJagkl41Ph0xJKzfdSp0f8fnnQpHRm+GpXtd30L0rk41sjjaq4Is0c
         V2AhuuF0MtAlk5tHjNDnqfChmmV2+tFHch88/05gzeKz0N0VxVNni21x4S5tKp0UaoA+
         /XWb7PG+lhHAmc4M1oxA3Uy2mdD8jxDTWbhk991dBz217RkPYddl6fzSm+ECR9dCqU0+
         QqcAWp5Qwp5rYvOYw1oLx9efsTa94jdaMSxCf7x4LgxKVF99sbrJNscv7Bjawpx32ud5
         15OcrmyWWeIPVKVUuWKFlZNIovt8bNVU2fEo/PsHkwssUJ6uol0hQd3z3ki+XTNpJXvH
         PwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RAtFVgzHhLfyixwTlntvq13DCjkeX6xQPOokD6zZ59o=;
        b=D7C63hepAlKXpQzY8G/E5CKB8bvFoo+89NZaE0VIqzpqAtllQEjwxezq/H1wsV29gM
         tGrGsdwVWL6Y3VPRhQBvJKv0KVcePf5s6b/UYr7q7kUCKHZM5mebiMKEWObJV5dNPTtI
         KXfpqr5tCSd54H//dKqn/xf9zvQv2rDcaBLjIHrcp/VIcVgAQKgX8SMYpgIkAG1dHcQR
         5KoKk1KjPTAMH6ntQvZP3onGDalX1I1eQLGk4HiLJfjnkDSz3bhpxR5N89WscIuaieAM
         Fy8tiWt/ZWNRJUCgvWuMa+wjjdX3SuYT2tkNiIoOnQjyktNNbpWuZW4jUq9c/alAD1aM
         fXlw==
X-Gm-Message-State: AOAM530um+IeUWfc0JLud26UP9XFZATqquX97+1klS1w6SM52thywdxp
        FHPI6euuK2AmtU7mE5xCZUI=
X-Google-Smtp-Source: ABdhPJwAu19LKeDwjjzO0jCx3QFJ6wmEbRWuzKHKjyHpFzetsD2LeVVswnKzvtX3fLr50am8eqrgkA==
X-Received: by 2002:a62:d0c5:0:b029:1d8:61e0:c5ae with SMTP id p188-20020a62d0c50000b02901d861e0c5aemr3662084pfg.52.1612972758275;
        Wed, 10 Feb 2021 07:59:18 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e5b0:be96:1dfb:a1f6])
        by smtp.gmail.com with ESMTPSA id o124sm2998887pfg.108.2021.02.10.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:59:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Feb 2021 07:59:15 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] mm: cma: support sysfs
Message-ID: <YCQC02Qr417cdnSI@google.com>
References: <20210210075509.3788729-1-minchan@kernel.org>
 <070ca72a-c99f-a2a7-c460-0a823cc262f4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070ca72a-c99f-a2a7-c460-0a823cc262f4@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:05:48AM -0800, John Hubbard wrote:
> On 2/9/21 11:55 PM, Minchan Kim wrote:
> > Since CMA is getting used more widely, it's more important to
> > keep monitoring CMA statistics for system health since it's
> > directly related to user experience.
> > 
> > This patch introduces sysfs statistics for CMA, in order to provide
> > some basic monitoring of the CMA allocator.
> > 
> >   * the number of CMA page allocation attempts
> >   * the number of CMA page allocation failures
> > 
> > These two values allow the user to calcuate the allocation
> > failure rate for each CMA area.
> > 
> > e.g.)
> >    /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
> >    /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
> >    /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> 
> Looks good.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Thanks for reviewing, John and Greg!
