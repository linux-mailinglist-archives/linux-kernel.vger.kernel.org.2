Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D275245CD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhKXUJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243522AbhKXUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:09:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D4C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:06:21 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id v15so7959536ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8PJKWzcbQpRMg5m74p+6M5/kpC7urCmsmIsgiELsr/0=;
        b=2ZI5vegyIoG6acR+kes/uJROMaJ2aACSGz8fkks5dalVL6jEzk/bg1qADHSrxMw8Ak
         ZLDvpgwSebeBHFwRnyP15LK3wqXoX6+W36RzJBA88un2EVbETvqS3aUhwPZl271ycToQ
         NZ7x1Qx5L5Mbz9js5gkhQFof9aV1vjQOZ9v6Msim0ndNC0neZ+uGREpuzMTihwcVLVDP
         XPAX6Z+PEVfcWC+bdm2ilovuhVcXcRTwdpGyLqpfmELKe7eFk0HvlJPdLWQ/ZTH4T+AF
         G+VJMqLMFqxt94ukbvVZjntbjt/agckVjxLk5zSrtUBgtIZkK21l+aW+j5DnYXcjz6N2
         IYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8PJKWzcbQpRMg5m74p+6M5/kpC7urCmsmIsgiELsr/0=;
        b=Kj0e/g2273KTV+VtaLAi/7ELpJsY017rnJD4D0TjaD/6MQ+6Gh3C2UUxPFP90AAbS/
         HsjXOaTfoFlKXhWh314k40ZCyujZwPhke9krmHqLllXysIxsT0OYeazrgY30TROY8BLB
         kFt4+ApXNeFLoasNk8SwN8fKOj3Zvoq6VGk3oM6sorC5C/+yEInAUQSWn2V5WVBMV4MD
         hLiYWIkIAb8UE4zW1fZptGZlR4OfDEO08vjbWjwYpztJ4Zes2dmrrm3yyRpGGIkSQPPp
         c7ovUd7E7oanmvb36sA1GdpdggFLxjKrtBPrZ7MV4M6ztxFK6gyxOz/lwNhXaDAk0eLL
         gkBQ==
X-Gm-Message-State: AOAM530wmIx4dRqvZPcu0ArDIbeQRSA0DMeZdnU75YFXBjwX277dN2ET
        i5rKPGG5advs/gwTmMvMI8lgLQ==
X-Google-Smtp-Source: ABdhPJwS1eI5DF4E4Jhqei1WkuHP8bIqOzemopEz+xA19/4wma3Htfmcv9QuvhYnueV5DivwW/o8tg==
X-Received: by 2002:a2e:a27c:: with SMTP id k28mr19256756ljm.98.1637784379894;
        Wed, 24 Nov 2021 12:06:19 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l18sm73720lfc.97.2021.11.24.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:06:19 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8C7E1103635; Wed, 24 Nov 2021 23:06:18 +0300 (+03)
Date:   Wed, 24 Nov 2021 23:06:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] shmem: fix a race between shmem_unused_huge_shrink
 and shmem_evict_inode
Message-ID: <20211124200618.adaxuxuksrinkigv@box.shutemov.name>
References: <20211124094317.69719-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124094317.69719-1-ligang.bdlg@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 05:43:16PM +0800, Gang Li wrote:
> +move_back:
> +		/* inodes that are on @list and will not be deleted must be moved back to
> +		 * global list before iput for two reasons:
> +		 * 1. iput in lock: iput call shmem_evict_inode, then cause deadlock.
> +		 * 2. iput before lock: shmem_evict_inode may grab the inode on @list,
> +		 *    which will cause race.
> +		 */
> +		spin_lock(&sbinfo->shrinklist_lock);
> +		list_move(&info->shrinklist, &sbinfo->shrinklist);
> +		sbinfo->shrinklist_len++;
> +		spin_unlock(&sbinfo->shrinklist_lock);
> +put:
>  		iput(inode);
>  	}
>  
> -	spin_lock(&sbinfo->shrinklist_lock);
> -	list_splice_tail(&list, &sbinfo->shrinklist);
> -	sbinfo->shrinklist_len -= removed;
> -	spin_unlock(&sbinfo->shrinklist_lock);
> -
>  	return split;
>  }

Okay, I guess it works. Locking is not pretty, but well..

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
