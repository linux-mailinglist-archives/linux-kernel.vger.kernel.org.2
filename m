Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C071232390D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhBXIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhBXItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:49:32 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:48:51 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k22so784734pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KFqIVPbE5ZdblNI5ye22qmuhyz5ygfjDdXNq8vyjqw=;
        b=xjGMavmCPdP1Vb4M3FpMy7QoXmyG6+7FbIjCUclqjEUYMlLV15IptGHKs6SMDiOgHE
         QVP8+YIiEE2wXXgyQDZINoM0fwhKHbwKeLAiGT7TlZozmqTa8LpHXIGB/8E5cc9rEV56
         NSQBUXg/lDd4TEdPW2FENxWHVdWN1Ok0sOL4DM2C50D302aNl2Xy9c60d4mZcDcWoKUR
         S+Qb1nR3s/TVhYsBbsyaK/2tGKcWTltGUM9WyTmRQlL90Piwxe1doOkmB+DUhIQTlaHw
         VfJweWin9fOQY01lyWFe5Y4W1cF66A43zKcrcPcSoNENyHPW0/b+eq0a2sHI6JE7fNbT
         gnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KFqIVPbE5ZdblNI5ye22qmuhyz5ygfjDdXNq8vyjqw=;
        b=TALEtAzUn48lAz7L+MwalbeRocdmUF/R4+7B5ggU2MjlKLZ4FGJD1NhmMQ3Knj5KkN
         xUn3Emp+0nxosLG1ZED9vRs2PR7gpC7eL+TAeCsdtRCKBp+SgabJdf9MHUCedn4Y3qf0
         MJy84H4BO10Gp1+oYlbOp/lCUbGhV2yn9DbA6lm/hRLN86X53xnd13QNim+ukCRzIK/E
         IGxSTQK3Rw/9LBNDP5DETjZMYX+hzJIspmo0yh2CTQgQAs8oSzzh9j8d7gAAnaNmD8PR
         w/RiX/k9to8DfGyNvp84BDe3dyaNWC/C6hAw3gqQflSCREaW+8/LldxQSR8faKLyJFL6
         RjyQ==
X-Gm-Message-State: AOAM532Oh0kCsLmPuTaLkrdMSSafry92hZiLstwzUK3MAqo0DtRyb5Ch
        OnrboamVEswWq29wXEXO03zjLLnbkAGeNKFCbPDqdg==
X-Google-Smtp-Source: ABdhPJx1DaLSyiqD+F7sh1Ya2/foxqsCNSSC/o6wUiZ3aaPlKyawOYejecqj0UFQZXmUtmT90E4E9Y2tfwZ/tVPYehM=
X-Received: by 2002:a17:90a:f18d:: with SMTP id bv13mr3546617pjb.13.1614156531491;
 Wed, 24 Feb 2021 00:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20210223180820.ee39f1544f2630d0eecf3a57@linux-foundation.org> <20210224040439.351882-1-mike.kravetz@oracle.com>
In-Reply-To: <20210224040439.351882-1-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 24 Feb 2021 16:48:15 +0800
Message-ID: <CAMZfGtU-TUZjMccm1BBp15YB6DyUufRTf-z-AqqB9ovWVx=KqA@mail.gmail.com>
Subject: Re: [External] [PATCH] hugetlb: document the new location of page
 subpool pointer
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 12:04 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Expand comments, no functional change.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks

> ---
>  include/linux/hugetlb.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cccd1aab69dd..c0467a7a1fe0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -476,6 +476,9 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * huegtlb page specific state flags.  These flags are located in page.private
>   * of the hugetlb head page.  Functions created via the below macros should be
>   * used to manipulate these flags.
> + * Note: The hugetlb page subpool pointer previously located at page.private
> + * was moved to page[1].private to make room for flags in the head page.  See
> + * hugetlb_page_subpool().
>   *
>   * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>   *     allocation time.  Cleared when page is fully instantiated.  Free
> --
> 2.29.2
>
