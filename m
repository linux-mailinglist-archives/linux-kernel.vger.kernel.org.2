Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F171B3F6106
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhHXOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhHXOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:55:24 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D258C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:54:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m21so23364701qkm.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0HC2Ss1OUr39jmHAZiwkc8UbnZEdytFQwa457XV/kDQ=;
        b=ca041X05YLL8O0QWf0mNKcLYH2X8C1k1c4oSnuebysCbw/hL+Xb8FHYf/yt7BKnBY1
         7eRo1oyxfhIt5fMGdiwv3HeuyKYwyVVTiG3JZpAd534AoFiPV0xi/7yQCc1B1diK0PW2
         lDGzB7vNo/ACrQQ+0UGCAQe9574vv8WbZMmpX9RxzaXRTnpX+8QRNwYnk52vKp9j1W/d
         obyIwoNTrMit0zOQwF/ZnsOR1oLm93p1NHzqtkAEbmRSG8TWqj89PnDgz+8gcnCffMG6
         aPtXz7uSMBdDTLd7Kgnn7hR9PuzV89GJJmRnION2Soc6C+BN+jJtgWH6uYBrQme5sQfj
         si6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0HC2Ss1OUr39jmHAZiwkc8UbnZEdytFQwa457XV/kDQ=;
        b=VZruxetG+q3UxpDn1006an3TQqByVpgpeLnfTB0qVcATvCm9hg/FbwEkWDPzyJsk5h
         yJInZJbF9kDk5hhusb7JsxczKCSNlIrdaLALqWqB5eroQopRIxz6M/1bFQMmc3JP+e16
         WYJw8oaPhPZ5zJ9OQhu4P3KbVsP0DCsgeDkeTaskDMqioJg7S5SvB3zO81I1DX3SmnWg
         ssDo2VK0XmEvo8AWzwl3gRBJqep/q9owetxeT2YI/SUMGPI5DIt++EUEjinkjLukO1oa
         73dyPhL87IEtkvQgnoqx01htbslnVijEXqtUO0zfJZ0+m664kHtgroBUOX1jXRV4x7wn
         67Ow==
X-Gm-Message-State: AOAM530Aa1+gq2EojHOCD7Lb4RFpCv7rORKHYYSEFCvRySWfUkv3lztR
        HdpoymzGrWEEm0RV/7zL4lQnBA==
X-Google-Smtp-Source: ABdhPJzHaoRwYaN4JH+gxlaMb4nXkOMdA5k7dCJ3wx+ZWy3hUSLYLXzkDGKw6Jqi03hXbN7fdV8G2A==
X-Received: by 2002:a05:620a:2206:: with SMTP id m6mr13648421qkh.385.1629816879465;
        Tue, 24 Aug 2021 07:54:39 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id d12sm207370qka.60.2021.08.24.07.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:54:38 -0700 (PDT)
Date:   Tue, 24 Aug 2021 10:56:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/4] mm: Kconfig: group swap, slab, hotplug and thp
 options into submenus
Message-ID: <YSUIlWMmRIIrEutE@cmpxchg.org>
References: <20210819195533.211756-1-hannes@cmpxchg.org>
 <20210819195533.211756-2-hannes@cmpxchg.org>
 <0c438e9d-7879-a1c1-7641-5c0dc00f5163@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c438e9d-7879-a1c1-7641-5c0dc00f5163@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 02:03:43PM +0200, Vlastimil Babka wrote:
> On 8/19/21 21:55, Johannes Weiner wrote:
> > There are several clusters of related config options spread throughout
> > the mostly flat MM submenu. Group them together and put specialization
> > options into further subdirectories to make the MM section a bit more
> > organized and easier to navigate.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, Vlastimil!

> Note:
> 
> > -config ZBUD
> > -	tristate "Low (Up to 2x) density storage for compressed pages"
> > -	help
> > -	  A special purpose allocator for storing compressed pages.
> > -	  It is designed to store up to two compressed pages per physical
> > -	  page.  While this design limits storage density, it has simple and
> > -	  deterministic reclaim properties that make it preferable to a higher
> > -	  density approach when reclaim will be used.
> > -
> 
> The whole large hunk with deletion part of the block move will be rejected in
> current trees because this is apparently based on older commit than 2a03085ce887
> ("mm/zbud: don't export any zbud API") which adds a "depends on ZPOOL" to the
> above. It's thus also missing in the add hunk part of the move and if not
> careful when resolving the reject, the depend will then be missing in the result.

Thanks for the headsup. Yeah I forgot to rebase before sending from an
older branch, I'll be sure to do that (paying attention to the zpool
depends) before sending the next version.
