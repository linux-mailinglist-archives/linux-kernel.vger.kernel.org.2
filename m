Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7A32F170
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhCERif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhCERiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:38:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198DC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 09:38:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id n16so4986835lfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uuw+r0jQlL0C1Mfdgw9EQ8CLOfFkvjoYJUZ0Y+AoHzc=;
        b=boCRkK/DszBNzEo6K8w24Z7IRM43JPPa4FqpDZKMLitRXqOQkE4RB/WT6Y+yQEFZsw
         byRDsn3/XREGSJ+zs8u8QSzJ69xzjMknQ4MwkKyf2tA0QDhJa6LqMB8+/rCLqgqoDOeZ
         G4qYPw5iC+TbKxHXjmlLoXIEEP5caLaBBGHgUU77nroDrYi4xopwwbu2ddcVMRgKkFAj
         J+9GqzGh3puhiwG0IWWRhW6IeoseKXNAZqypJ5ok50OZd1nmBq2kujFM7wjgeDOAykw6
         k4qk2wIfsnH02GhOLhHALTZb5a4OcUxWIiabrEPWAuDAm1L3epyCT0tv0+B3QHsL/QQy
         4vMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuw+r0jQlL0C1Mfdgw9EQ8CLOfFkvjoYJUZ0Y+AoHzc=;
        b=VOx7k/7Ldxg7/4AZWYeQKMx+NgbEH1rrtvZ6XEO0gV70i7xqFisXxzAA0xQhIYEVkF
         LDKkVDKOfPzfg4yxaVy98wuqAo5rjjll690qe+RKfxSjkOmfqm0fbOq6q6EPpoIOMN8i
         LDar4gTj1rYcrCQOMFGQThdqw6fetKrR9oN3EjxBwKzmrC0BQJyXcktym3ej3j0VF0so
         mLojMbClKKuqUiz+tmqNljllKZ32mKqnqaOH9cVHwhhWGHJR6PmTtiDeANr1uv0AYo95
         7K3NPB823JrhsjZcDcPEWgfxKIhSmdYl0u0wFcmAq3BpzthoNPfYPmio1MNPUAW4R/c+
         Fp6g==
X-Gm-Message-State: AOAM531XSgxAZqk+B3iah49Znsu4N7x83sFqTHN93haT9liMAM4JwIYA
        HRQtVL9qmJnEE+30GkXgtbRURw==
X-Google-Smtp-Source: ABdhPJxlJqPIE7Ga8oqvRozSRl4EZZvdE6mgwzvAi3kTeTXr5gJIDv0zIfSzItTozic4noLTzCQNbQ==
X-Received: by 2002:a05:6512:47b:: with SMTP id x27mr2367793lfd.37.1614965890563;
        Fri, 05 Mar 2021 09:38:10 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v80sm381213lfa.229.2021.03.05.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:38:10 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7B93010257C; Fri,  5 Mar 2021 20:38:09 +0300 (+03)
Date:   Fri, 5 Mar 2021 20:38:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, riel@redhat.com,
        kirill.shutemov@linux.intel.com, ebru.akagunduz@gmail.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 4/5] khugepaged: remove unnecessary mem_cgroup_uncharge()
 in collapse_[file|huge_page]
Message-ID: <20210305173809.ufg6rfgmvgbvwxih@box>
References: <20210304123013.23560-1-linmiaohe@huawei.com>
 <20210304123013.23560-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304123013.23560-5-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:30:12AM -0500, Miaohe Lin wrote:
> Since commit 7ae88534cdd9 ("mm: move mem_cgroup_uncharge out of
> __page_cache_release()"), the mem_cgroup will be uncharged when hpage is
> freed. Uncharge mem_cgroup here is harmless but it looks confusing and
> buggy: if mem_cgroup charge failed, we will call mem_cgroup_uncharge()
> uncorrectly in error path because hpage is not IS_ERR_OR_NULL().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Hm. I'm not sure about this patch.

For !NUMA the page will get allocated and freed very early: in
khugepaged_do_scan() and with the change mem_cgroup_charge() may get
called twice for two different mm_structs.

Is it safe?

-- 
 Kirill A. Shutemov
