Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2552352C20
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhDBPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbhDBPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:07:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BB7C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:07:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q3so5464810qkq.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7HVWCbCIlwicEC3tXxdkJfcKRnZb8hdpo8Pc4WV2B3U=;
        b=zYMJ7t+xUYy61M8Pgg2mhBJkZL0ARZ1Rh1BZ5k03K8E/rel4lYqH3SJG9KlY9dr+Xf
         mPNpI96E9mwnDAA1KdU7hWfUVENJPYWntKSVtHB3XvBJ98x8VEJ/lykJM/q7uCDK7BJJ
         FSb+lcH1zE9+tYEOl0+73NQm4uUBhqGVBOllXNCJtsZvzxwrrX4/ZW5D57BMyhiJvGyJ
         +Hr1Q5trem7ZhxAauADGOo8X2opIvwItBm6ddYGpdGmlw+QC85nwPW3TeL7H+NMcPuqY
         CMBT4jxEtCQodNTYb5DWLMlJLfmXGufE+DaBbdNKoIAQyut72/qWw1XN+hw41RuH/5WY
         2hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7HVWCbCIlwicEC3tXxdkJfcKRnZb8hdpo8Pc4WV2B3U=;
        b=ptGnXGvqJZGZ0PWJeM23h6BQPaB0YQlEh/ZJzZaZCYGCPdr/We/IWRjdzwnpVUJPCm
         DMOlEQSNBQnb/JhCDXhTpXnUMJtaW9u+XV6dd3zDDShwEi93hUKGsywV8C6FntDhIKd3
         WeKG4ukzrbF2m7r87o5RD7vP0iS0f7xiaS2jy5R9uwjJMWYYkqhti+vXEDhbBvXZ558c
         tLlwBmhF0GPeqpcYhsldjmFxK9Mv0p+YGNdlI6Se6apipSjUaN9ToD14bAvx+XaEbRVK
         pFQWuRv5UJi7Ee+SthmB8QlEvXJEwjwXSBJ5cKjFJrc3x3nyQEpktDyY/lfclweC44as
         Dylw==
X-Gm-Message-State: AOAM530cyC8JisTP4LfUc+FWbSVBQjwSZicxQRUyZv0QLAfSIwuEv8gB
        4J0zcB2RzKVUUayZyII+CJ9C1g==
X-Google-Smtp-Source: ABdhPJzkKmbOUtwBtQyItIwzarzVuVejnWKLkLpGMj93VDGzJxqIeeNQl0hBs+M0p99ahtXzEcgizg==
X-Received: by 2002:a37:46d5:: with SMTP id t204mr13276136qka.211.1617376052450;
        Fri, 02 Apr 2021 08:07:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8ca7])
        by smtp.gmail.com with ESMTPSA id d10sm7512522qko.70.2021.04.02.08.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:07:31 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:07:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [RFC PATCH 01/15] mm: memcontrol: fix page charging in page
 replacement
Message-ID: <YGczMjv3JbXQmzW8@cmpxchg.org>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <20210330101531.82752-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330101531.82752-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 06:15:17PM +0800, Muchun Song wrote:
> The pages aren't accounted at the root level, so do not charge the page
> to the root memcg in page replacement. Although we do not display the
> value (mem_cgroup_usage) so there shouldn't be any actual problem, but
> there is a WARN_ON_ONCE in the page_counter_cancel(). Who knows if it
> will trigger? So it is better to fix it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
