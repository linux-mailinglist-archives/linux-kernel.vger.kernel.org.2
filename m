Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781953C2280
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhGIK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhGIK73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:59:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C0EC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:56:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a18so22439294lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YnbpmGiI0AVvnbW96O833QxpSyboMs0HVXnxkDEC9ms=;
        b=j+FVtqtPOWZf6dYtVHigE9cQpxTjaCwgGfWaY2sFM7X2cMTJGx7AAlEWoObMfjzP2a
         PBF6PisE5Oe8cr4sKEMrYC4HOgr3tdXcQjLyD26qPjrEfibOT+SjJ6y/K70LveP+lqcn
         NkxYeIbsMe65CNoi6GH7gVKJv0o1ghoEs3leycUf1vqNF7rYKjJ+Um+D+fXvQvePzBAt
         7oRCb2nY2yHwYbkeM0+h0Ma9E7Coc2zmLHe1lMCXgDK+sesoljzyXe+6asOYloYI5Dpq
         Nk3Krkjf6gy2mjby4O3oRup52iGFaoHvgUdMAk5zXsw26aJYNpLETgeslzbmiGaMydFN
         JOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YnbpmGiI0AVvnbW96O833QxpSyboMs0HVXnxkDEC9ms=;
        b=SOUzKzOfnWziJrs6Y90ziPE0++vxa9D6u3oQ/K+eNp1wUD+31QeKyutLcSF/hxScKk
         EouFXm3TpY9rGOTMef5n/OMyo37PpSbrNS6WLjaKTghQk5kthXLIpXVTZsfim43jyd8B
         eMdRn4hpF94hw+TPB4VkBA5Ro/oiZgNKuyNIiiUzFYWZ36SCLMashUrxHwkHc8gn7XQT
         kOCBp6oRE0s0iPaNVp2SjxHBzr0bPlsEs28iQD9QqEP8T7dtSQiSWyj8R+bEQZzDdCQX
         Jb1g13abMiRuxLe+BlaxdeUXvwx4Q/FuhbW4zKyj8TO+YitQam2Jt0kwZNB7KUGCbLBm
         PCZQ==
X-Gm-Message-State: AOAM531fPNXtIqhcbQXLiOa+W7PyHuI98zXQRr8m8dhbgU4i/eVKuog9
        vPIjLBcCtB9Z5I64hRsOF0665Q==
X-Google-Smtp-Source: ABdhPJzWjYQilljlXP9Elz3TOCbDWyedxbVuuHFb1E0DkyCgzTr78kOk0MAQ8v4HvUfe9Tu5LTTYLw==
X-Received: by 2002:a19:c20c:: with SMTP id l12mr2560648lfc.296.1625828203096;
        Fri, 09 Jul 2021 03:56:43 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g4sm431170lfu.84.2021.07.09.03.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:56:42 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 65440102944; Fri,  9 Jul 2021 13:56:44 +0300 (+03)
Date:   Fri, 9 Jul 2021 13:56:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/rmap: fix old bug: munlocking THP missed other
 mlocks
Message-ID: <20210709105644.vfiw4ilj6a5alaeh@box.shutemov.name>
References: <563ce5b2-7a44-5b4d-1dfd-59a0e65932a9@google.com>
 <cfa154c-d595-406-eb7d-eb9df730f944@google.com>
 <20210708135811.775drqgwkwc76vcb@box.shutemov.name>
 <6c4d46aa-4d73-76a7-bcce-a09024768f63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4d46aa-4d73-76a7-bcce-a09024768f63@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 07:50:26PM -0700, Hugh Dickins wrote:
> Here's a v2 of just this patch (others remain good): what do you think?

Looks good to me. You can use my

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

for the series.

-- 
 Kirill A. Shutemov
