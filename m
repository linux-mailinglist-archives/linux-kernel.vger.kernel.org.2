Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B6232F189
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCERkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCERkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:40:12 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD4C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 09:40:12 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k12so3780327ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vk913xlln+/lnAFL9m3uYtGSeZcmPVbTMVjkjjTaGBo=;
        b=GhndKDzQzM94hqe40MtxD0SnptXBVM4J9SX229bd/syGiKxsZHR/4a7H+bc6zzOJI7
         XF4mpvEKvQ/3TZoQr2bkZm5Qa0pOZQ9qQewm68h5xBmfPMg+EQYMVUfO0Dgs9BcIPskK
         YvoywHbVHqPyT/ZVQrusxqEvj/XDfyzmH53HpCEsfsjYcGP6oFrltBVq36TbA8OiG45p
         LF8r4klV6foAu1PgdmDHsAV37QUtmIFFkKJVHgqveZnSstaFOZwttJQeOGpKneFQbh4J
         v0G/9/tTKEag/W8bwwKxvs98e9FXoSpQ7ncWGjCjXWzOxJvp/FvKRrhLW0V1nDeL5baQ
         BLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vk913xlln+/lnAFL9m3uYtGSeZcmPVbTMVjkjjTaGBo=;
        b=THH+ke29LYsdyeR0Q+ts4qSSogiq1OaSo3/tHuOedQ55gNhH0AMu2394uoDyiZOHAI
         JJvBtv7N5uPYRYBc9VYnCSLymL/h2j20oDB3gCQS43nQOFK77cnc3e8HaBiPzMdzP7Bf
         o9MqkgJomHjsD2ReXNKw8JbZ7PFUB0ehThK4Qos//bFXy52vlA1NhbVQEt9JT3SvE+pm
         jX6tX3M9HkfIuDThz60JhEZ3pJtHbTl4Lm+I1wNdqEs9LB8Ik9K6Dl3ueIzn/ulcwifX
         8E6fcT8X11DxXtB+Gb2bBVvG3F34Fffo6Q3WtzyuVnzAa/1QGf2CgB/mWLzEJaWBLI1j
         iCag==
X-Gm-Message-State: AOAM531bJvNBfW3LJcZRJi1o0n9dmpVQB7RpaXhGmvWnIem76GK1DWM8
        ZM+gfRZil/JqaGvqs5HoK5cYNw==
X-Google-Smtp-Source: ABdhPJyl8eN5UlRGZLhzBG/kOop8hQaBmTkDKl8NH20D8i/D6Gny6QTrr8N5CrccyVv6p4Fc8Ocb3g==
X-Received: by 2002:a2e:854b:: with SMTP id u11mr6060434ljj.318.1614966010642;
        Fri, 05 Mar 2021 09:40:10 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x14sm381159lfg.165.2021.03.05.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:40:10 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id F1E1310257C; Fri,  5 Mar 2021 20:40:09 +0300 (+03)
Date:   Fri, 5 Mar 2021 20:40:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, riel@redhat.com,
        kirill.shutemov@linux.intel.com, ebru.akagunduz@gmail.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/5] Cleanup and fixup for khugepaged
Message-ID: <20210305174009.ugxpn223j7aoi4bc@box>
References: <20210304123013.23560-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304123013.23560-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:30:08AM -0500, Miaohe Lin wrote:
> Hi all,
> This series contains cleanups to remove unneeded return value, use
> helper function and so on. And there is one fix to correct the wrong
> result value for trace_mm_collapse_huge_page_isolate().
> 
> More details can be found in the respective changelogs. Thanks!
> 
> Miaohe Lin (5):
>   khugepaged: remove unneeded return value of
>     khugepaged_collapse_pte_mapped_thps()
>   khugepaged: reuse the smp_wmb() inside __SetPageUptodate()
>   khugepaged: use helper khugepaged_test_exit() in __khugepaged_enter()
>   khugepaged: remove unnecessary mem_cgroup_uncharge() in
>     collapse_[file|huge_page]
>   khugepaged: fix wrong result value for
>     trace_mm_collapse_huge_page_isolate()
> 
>  mm/khugepaged.c | 47 ++++++++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)

Apart from patch 4/5, looks fine. For the rest, you can use:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
