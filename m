Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6F3CCAF6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhGRVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbhGRVeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 17:34:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B67C061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:31:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b29so1950273ljf.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F9ILCk8N3sERVUTaY+/ZVi6bG07HT24teouMKnXfFEQ=;
        b=ax13dcXsQdSfOz+9HVljsgiGChow9heRlR8KjejNczxJGHDUg6gsv24iZ2QyUExZmj
         wQh6yUun2RAFTurk6dA0NJMkInZBtaW3QlA7diHzWjCJo+2E9x/zMtsYBpzq8Qo7SLNN
         3QqLXkNULJs0Q5LBpjLIp8AmZGk3FhEGYesSLd76i6x6tuJHsj2KlVu5D6OfW/lckUuY
         1zXDoFoI240WefoNiWy3RY8vfT12vc5KjxjdiAWWn7Ms30PAZ75iPsrVwfHABzH7CyWW
         CYtzflOrlbUO8sRAbStI3uJP2bWlBubp097D1XWgZ6WtwdZxvflRVNhAEnHD7tX5BGak
         f/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9ILCk8N3sERVUTaY+/ZVi6bG07HT24teouMKnXfFEQ=;
        b=Rk7KwBVyBgo7vnQyhRpBG/LKQj07ywgfXvRjQYdxOmoipisfQeMkMwJCZlpI2vB4KR
         q/IjugsSKld/ccXdICzELvZ3TYZRjqNzHxH+uFy/ve5tgwsdxRBdKWXIDYdcnSd4TClt
         r29NCJLiuRsnqtY5VuyiAzVko+ipMClZF1vOuAyIGJr/bf9rtsltM22hYrAbmF6GQb/g
         hGc0LeOO9q8bgTYn0UjwFbe/Ocy5amyPPtJmql9/lUqD4KdMLVvAGve0zrjoTEWaL0KS
         ep4uLAtv3PgFg03wZOXaPBldneWS1oZxAq73o2ibZobpvtMXLeUda50ypv6HpEsWi3Y1
         8ASg==
X-Gm-Message-State: AOAM530Q9NgpuJmB1pQoQuMcT2QMtEZgmBBSOCzGqtGIf72mBeanEF9C
        iCThoxxFEgqDcT+YNSOp1CvS2g==
X-Google-Smtp-Source: ABdhPJwtT5qmE/P10UDYjLKt4tr/vkQdwA/jD7zdttq+I56o4yokObToWGuF9FbR11p8WQaMKdSbqQ==
X-Received: by 2002:a05:651c:158b:: with SMTP id h11mr19410663ljq.395.1626643877625;
        Sun, 18 Jul 2021 14:31:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r3sm1237633lfc.280.2021.07.18.14.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:31:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CB77E10260F; Mon, 19 Jul 2021 00:31:20 +0300 (+03)
Date:   Mon, 19 Jul 2021 00:31:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
Subject: Re: [PATCH 2/7] mm: introduce pte_install() helper
Message-ID: <20210718213120.rtqbgseb6drcwxj4@box.shutemov.name>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-3-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718043034.76431-3-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 12:30:28PM +0800, Qi Zheng wrote:
> Currently we have three times the same few lines repeated in the
> code. Deduplicate them by newly introduced pte_install() helper.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

I don't like the name of the helper: we have confusion of PTE being
PTE-entry or PTE page table. And pte_install() doing pmd_populate()
doesn't help the situation.

Maybe pmd_install()? Or pte_table_install()? I donno.

-- 
 Kirill A. Shutemov
