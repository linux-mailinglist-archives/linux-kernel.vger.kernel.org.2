Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49235E5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbhDMSD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbhDMSD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:03:27 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:03:07 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x27so8537796qvd.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NSrJ5NIY0R4389SCMTdtOH8upYr0YvZv/ZgSkyJwyus=;
        b=VnpjPcAGmH3B9oaraFs5c3At2DlWv6qrUX0ktFGyFlB0FUeEGDHv5lfQ51Pt+dW72N
         ovX9zOE5BBcUoqpsXHc1Vp/eOyblW+U8xleT7HkJrzz1d54XY3Jlp/arzyDaRF38E1sB
         CUDEMnzh2lsV4Zw3975pXCrtg9uSf7pUIOtR+6C0izW9YO/+qqUkvouSsmlIRdKQGkka
         gA0yi+N7kA/SHj3FZ1qznjUjJz4bYj9nUQ+yqgB48YqYGTyWkDbkM3vkowchepbq7FWu
         QQ6QsdfNyPXYzd2D6c41nQCVF4eYeIQc5RQx9GPhCWFNrGZLgQf3z2JZGQe1KmiKC2uO
         W0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NSrJ5NIY0R4389SCMTdtOH8upYr0YvZv/ZgSkyJwyus=;
        b=UGw73sh62l1vMq6xnm0VguNPGX/Qvd3DVBWVyPv1HfA3Nay/bFy6rW57lt0xHHGm5r
         QKKEwpinvpDeqad+Xz5SjPmXqznQacCRRDSBH+jSfmdNBGC1YOYEdqeWg5AZD9nuRpVA
         HO8cUAmDXD2iyF+0TJoIwJEJPi8HIzO01nU2VUHzs3A7jQz+ijWwtJby2yONBcruC1NO
         ynkXAX0Z0vrbS3TBG1hcxxo9+Yik8vwDJ2t5IxOVb1YGWW9NI8gLDBAcqmTvfXT8CcyZ
         /HLYnv+IR7QVubr2PpqeHh9/AAtnqpbyg9rt+/n40OZW3X8qP1ckEhyQRaV6l/o8r/G8
         RpiQ==
X-Gm-Message-State: AOAM533/Pv3nHsLAVHD08fD33+vA06OPSrsCotBJKUXoj8RsRkKcCXir
        eIGa087IhnBLj4qmT33SzPRtjg==
X-Google-Smtp-Source: ABdhPJz897Dcw3QPB8/7AWf305sGrYBRKU9lOl2NXYK+bX8SGJpHrb+P3XTKLHzq/UfsXEc9GGHlRw==
X-Received: by 2002:a05:6214:ca4:: with SMTP id s4mr33985788qvs.44.1618336985771;
        Tue, 13 Apr 2021 11:03:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:216d])
        by smtp.gmail.com with ESMTPSA id v6sm10188142qkf.132.2021.04.13.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:03:05 -0700 (PDT)
Date:   Tue, 13 Apr 2021 14:03:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH 6/7] mm: memcontrol: move obj_cgroup_uncharge_pages() out
 of css_set_lock
Message-ID: <YHXc2HH/pkKwgYoz@cmpxchg.org>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065153.63431-7-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:51:52PM +0800, Muchun Song wrote:
> The css_set_lock is used to guard the list of inherited objcgs. So there
> is no need to uncharge kernel memory under css_set_lock. Just move it
> out of the lock.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
