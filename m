Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABBB348245
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbhCXT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhCXT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:57:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB2DC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:57:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j25so18190578pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6wje3u9/LXf+fY5O7zx9Tl/wzeXgMCXQSJ1thmeKKYE=;
        b=UXnapM+uUzWVFHRiBlLLL1zWvGJKqjoZF2CvY3BY7ukyM1pwtw9wFyNYL/bugsIi5H
         1fd+dM1XyXiniMl2xByDVLvLwUEALXjQ5RIr7lhx6bymj8e/i68g1k2Ojjg5e3/cVkai
         92hByEyaYIfObfW/yEOAQGbVxV36E6HqKgePvZq17Ab1SIUFr6Smi/sL1/SoJXCAcntH
         sokHXuZrupuVmCjDHXWJEAXzh/HDPTNLpgo52MtaW8359nAJiuF4BFOvcF/4mqyZAGmH
         KJFaZt5VmGPDDDMQRkMykO2daw9YWHWayZ3J/YJXVwDY31VYa92jNpblNQIqkUj1Xnr3
         wqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6wje3u9/LXf+fY5O7zx9Tl/wzeXgMCXQSJ1thmeKKYE=;
        b=UXsu2ZChiqDkGrkl+lq+GWMw+a32eCLYRMSrN1nd1iisqdYLCjV6sQDG7nZL2aNI+F
         5q+PKRok8BQIVdLkhNHxThivYuSGE+OCEwzDii5UEiqcIDvaCyBwKipOrn7wlh0oYLyk
         lUsFAJD84Of0m9tJGZVHYjiyIJohdclhVoQG6iVRO8SKG2wD/HUUVrRsS5qNxgpmbnb9
         0Iv9Ti7eWU5Q6VlW0p03WK3KkUWgEgofqPs32lIFKgu65SrQLk74jLPVV5SuKrxUhLAV
         zGHb53zsZVPv91vZcut1qQEzrcbDn4BXMzs43LnC3OyxpgGWO+l1Y4nb2gYxnB//Obwm
         Xg4A==
X-Gm-Message-State: AOAM532dt0y4ecv0Mjio0Fly9E8GjxF+/GHLTmfd7oTzg3VTCRlyGy+X
        MDMoqEM6NvssN0FjULyDV7A=
X-Google-Smtp-Source: ABdhPJyuSSTR7hFg4UxeOh1mBDNhBv6Kz8XMiQUHzSnDVQ8723pC26jcLbkhDhxaBOjWDHyaU6B40A==
X-Received: by 2002:aa7:980a:0:b029:20c:5402:5de9 with SMTP id e10-20020aa7980a0000b029020c54025de9mr4708822pfl.18.1616615868433;
        Wed, 24 Mar 2021 12:57:48 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:7dfa:1e53:536:7976])
        by smtp.gmail.com with ESMTPSA id e8sm3314971pgb.35.2021.03.24.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:57:47 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 24 Mar 2021 12:57:45 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
Message-ID: <YFuZua1TIEkXtqoL@google.com>
References: <20210324192044.1505747-1-minchan@kernel.org>
 <18ee5c3e-fba2-0d8d-bd93-5fb8d0dd7a01@gmail.com>
 <89ba4c7a-42d2-5412-2367-cc1cffc1117b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89ba4c7a-42d2-5412-2367-cc1cffc1117b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:49:58PM +0300, Dmitry Osipenko wrote:
> 24.03.2021 22:43, Dmitry Osipenko пишет:
> > 24.03.2021 22:20, Minchan Kim пишет:
> >>  static int __init cma_sysfs_init(void)
> >>  {
> >> -	int i = 0;
> >> +	struct kobject *cma_kobj_root;
> >> +	struct cma_kobject *cma_kobj;
> >>  	struct cma *cma;
> >> +	unsigned int i;
> > 
> >>  	while (--i >= 0) {
> > 
> > Do you realize that this doesn't work anymore?
> > 
> >>  		cma = &cma_areas[i];
> >> -		kobject_put(&cma->stat->kobj);
> >> -	}
> >>  
> >> -	kfree(cma_stats);
> >> -	kobject_put(cma_kobj);
> >> +		kobject_put(&cma->cma_kobj->kobj);
> >> +		kfree(cma->cma_kobj);
> > 
> > Freeing a null pointer?
> > 
> >> +		cma->cma_kobj = NULL;
> >> +	}
> >> +	kobject_put(cma_kobj_root);
> > 
> 
> Please try to simulate the errors and check that error path is working
> properly in the next version.
> 
> Alternatively, we could remove the cma_kobj_release entirely, like Greg
> suggested previously, and then don't care about cleaning up at all.

Does he suggested it to remove cma_kobj_release?(Initially, I did but
was rejected from Greg)

