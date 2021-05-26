Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432FF3922B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhEZWbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhEZWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:31:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:29:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 27so2168482pgy.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qSkyuRLIywOgSpc4Exwi+hfwQCVFKBm/lXDqy5wmBnk=;
        b=r9U6b0w69kuX9cpBYYQ+ro++7IHUTvMcCWcpXHg3I+zP880ZXbtVedIaVGnN8MF00U
         dI/lELbxhOv7z5Pfz4Vd1ChrGE2Fa/nwR/Ezl2G97xJ9rktvrLCqRLVwvE5GkINly+gJ
         qNm0Zxm9QIIatcdkSC1WsBPjlDfifh2uOnjHwfQwmhLeHfo5yy9Pc3MVaXqW8IiEataS
         04OQVyLN+yhwLzwLcG8As05euEReAkPUFGGOVQuwmS3VxF06AQXPfM8uiIiBR9Jy5oKm
         JxiJyj4tONmIcPn3lXFUMu8PAADi/f87anwdrLbZteg7tJUNj2YKgzGsZX/hjK3aVR5N
         XN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qSkyuRLIywOgSpc4Exwi+hfwQCVFKBm/lXDqy5wmBnk=;
        b=Rm3L4VTcemRrjecN1XFVk+ikK2rSsSGVJYtwQNTvDmMW67sSKyqRRNCJu4z6uTUZVY
         lCuvXZevORdjERBcXUnnZLR2uDA32IxQNdNTp/1FhuyrEC6QeegudKxnzQfVVdomEmIE
         gX7QLYfCu/ldAbnrR6ANBcZm6mOjhOz53dbarRvtni6xL4e0+PpLYjpXgLVBUgt+eJqX
         uSKL9XgA8chRLhWfc4S5JIu3+OpkhB+xreKkK+0q+f+MtZsm7V7oaE+n47n8gV28aROJ
         FnDASg6P97ktpYNX12sY/N7DfB86UNzdB3DgJmHzzAiDBq9Wj/r0V8fKGtB0umLu6fSx
         Tfzw==
X-Gm-Message-State: AOAM533n6YTfWaNGsZc+VAvfY7meYXTcBPhsub96MG2iHhSn83EK/axn
        VTkzCvKukymtSISAMD6awHE=
X-Google-Smtp-Source: ABdhPJyhluupXGvNB3jQonGlCku2FVrdJ5z41FMGM97XET+rfk2B3/0QqgzoGEqd1TbHYVdBKJhKRA==
X-Received: by 2002:a62:1496:0:b029:2e7:2674:147 with SMTP id 144-20020a6214960000b02902e726740147mr281572pfu.51.1622068172854;
        Wed, 26 May 2021 15:29:32 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3dcc:6421:abe4:95d0])
        by smtp.gmail.com with ESMTPSA id 4sm87124pgn.31.2021.05.26.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 15:29:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 26 May 2021 15:29:30 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        naoya.horiguchi@nec.com, wangyugui@e16-tech.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 2/2] mm: rmap: make try_to_unmap() void function
Message-ID: <YK7LykQE0LzysBYU@google.com>
References: <20210526201239.3351-1-shy828301@gmail.com>
 <20210526201239.3351-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526201239.3351-2-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 01:12:39PM -0700, Yang Shi wrote:
> Currently try_to_unmap() return bool value by checking page_mapcount(),
> however this may return false positive since page_mapcount() doesn't
> check all subpages of compound page.  The total_mapcount() could be used
> instead, but its cost is higher since it traverses all subpages.
> 
> Actually the most callers of try_to_unmap() don't care about the
> return value at all.  So just need check if page is still mapped by
> page_mapped() when necessary.  And page_mapped() does bail out early
> when it finds mapped subpage.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks for the update, Yang Shi.
