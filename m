Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBD33975C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhCLTYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhCLTYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:24:34 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E233C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:24:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f12so4678213qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pEeTkEyXCfwqMVGSwUe44009Y4fam47Rux0tIaathAw=;
        b=o+0Wr4xkcRXdqUXtgfCtTFILjSgiNCLOf8HVzZyATUpxMeDMS4pbm5pWF9BZSPUcNg
         RvjmjZ1+lbmuZA+hyUxHfwM+r+p6EpC9eXskkmQt/2MfyJ4ogrxpOp6uLaYUn4xLuy27
         cEdDXBY0aRy0wDONyH/LTL2Xzc3gQQvG2fb6vc/7PBkbzH0nkit8+EW+8n98PLzySgo3
         rcmEBLO+Za3DH4J5ruW3yl+uRWnrpPD9F00QWK7sk9vpulDHAOXWy4jhO6DtqaZtlsAA
         O5qI6TKdS4KhZXdBjd9Wgh0LQKBZQQ4G5nGMqYIO8j51x5qMHv2F0tCTm4D+Yz5xvaHk
         WjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pEeTkEyXCfwqMVGSwUe44009Y4fam47Rux0tIaathAw=;
        b=Tto36VGtV5xNPs1enlXBcOvBiNBLsZ/G9GqM2X2ACylmoMlkzdiZbhGGybOiO6SgQj
         zQt0zu9iMhbVd+Do3+D/+dI+ZeE06bqjWQkfrpKnE5AVLcTCEfQbUTMAeVizW4RTthxx
         FYqNuOyE7WCqlMRO1bjFwrMe54oaTfasX+7OP3PON0uZQkJWRD5FdQGZ/EQiVhzIWErc
         Jw8m2i0quO14xlhlSWfQ6NZgpK+odov6WrqggJ1lbYuQe1h133LTMj7od/w33snmrHb6
         UXRPX4/cdY3ff5uoonEPXgEOE7KNf/bpCdSvwRTIoHbTSQEk5KtPx1RQRnkqCFKVq7US
         gxWw==
X-Gm-Message-State: AOAM530+K9Cwq+AG6zotZEqB57R5tzHFvEm4nKUKk/oUDaHHJRXfwZM6
        5XjehUrdy4XMCPqxnkEvwjZrgg==
X-Google-Smtp-Source: ABdhPJyHpoXz+krFmX117IHeSWej/wRy9Y0LADvEsDmUM3LlxQIqK9L/gvpZAJGEpCNki6o+kZu1Ug==
X-Received: by 2002:a05:622a:14f:: with SMTP id v15mr13552545qtw.212.1615577071277;
        Fri, 12 Mar 2021 11:24:31 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id j6sm5191840qkm.81.2021.03.12.11.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:24:30 -0800 (PST)
Date:   Fri, 12 Mar 2021 14:24:30 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v3 4/4] mm: memcontrol: move PageMemcgKmem to the scope
 of CONFIG_MEMCG_KMEM
Message-ID: <YEu/7vqMnwfWmiB7@cmpxchg.org>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309100717.253-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:07:17PM +0800, Muchun Song wrote:
> The page only can be marked as kmem when CONFIG_MEMCG_KMEM is enabled.
> So move PageMemcgKmem() to the scope of the CONFIG_MEMCG_KMEM.
> 
> As a bonus, on !CONFIG_MEMCG_KMEM build some code can be compiled out.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
