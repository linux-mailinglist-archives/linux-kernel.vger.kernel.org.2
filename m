Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79313D9D28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 07:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhG2Fl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 01:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhG2FlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:41:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:41:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so13805568pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 22:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HcpLcsh3CNoV+plaqHbpcChysjrZ/XdusYt6GxVw9c=;
        b=DcIJNfrfd9acLnz+K8zFDe8LrcphOUGZZBq5aI6EbzPV4L6yHCZBeg1Rw7ApJaCO4X
         HWfwLpABI1tGiw7g3IelNruyBKpK5WgwIrpxo3p/2bTitSDU2ef7Sunmcz2GA21O2me6
         SyRYFQFvp62zsqWo9VpE8BWa6sLniiXXzkixlsYKgAxUFUef6lZFVrafwg46MxYI0Yl8
         q+ilXoXQ9Fh4HacyntUfd9FEI3LiDg24dusH1D0C8KgT1RjN8+seFzZKXssTZ4wfPP8m
         VpL3X+NwcDOrO2Bh7OEPL8/dpwbxxXA684mSsmxQKBxPqdJtUNdXLA3gkGGg28hwHao3
         fvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HcpLcsh3CNoV+plaqHbpcChysjrZ/XdusYt6GxVw9c=;
        b=S3Y/IOPIqZ0MMssB+CsJSNIBWS6W5T+BHlGRqfrokit8coY8pVQnRRU/8hbHUuJaP0
         tufWigWmY3QK/wWS89DaxycPWVS0gMC6QB1W9/2xeuLbYnv+jgxZJA97pbOODtwKGTew
         wiZZlMDe6g14iUoz4DhSn+DVZW45xgJGSs9/eyK8b2YKDHJy37hvrADm/2PAkfNN+fav
         h1h35JA6EMqwTZh6yzszXdiKzBF87QHiOLv28ted+qP5v2PHGLvhSfEx6YR9xGilX8q6
         KMbpFuTohyxl61VCqdWVwnJuCP1aHVYwJpK5FloJ64Q+MzdOfVDffARxvBZ9GbESa/DZ
         BYkw==
X-Gm-Message-State: AOAM531mkIpmi7pFfeHepmDuoQeAO3uZWvLAIFMhfSsFcIzGgcvmrH/M
        mW+rgQaLmOdPaLkq0fa7DEgYAUK5aKr/xxmZDLO00g==
X-Google-Smtp-Source: ABdhPJzIH77wtaexeyTdeU5SwfT/arZde8HQawX/NMnry5UO5r2XsSkpJedRgNwR2CgaGzJ4adMaVOdYIsd71kiLb7A=
X-Received: by 2002:a17:902:e742:b029:12b:5431:24fe with SMTP id
 p2-20020a170902e742b029012b543124femr3215224plf.20.1627537277324; Wed, 28 Jul
 2021 22:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210728155354.3440560-1-shakeelb@google.com>
In-Reply-To: <20210728155354.3440560-1-shakeelb@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 29 Jul 2021 13:40:37 +0800
Message-ID: <CAMZfGtW+XMp=EKqH4EgRzAG+RiZeOgj5=c73UE5SB7rTNWcR+A@mail.gmail.com>
Subject: Re: [PATCH] slub: fix unreclaimable slab stat for bulk free
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:54 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> SLUB uses page allocator for higher order allocations and update
> unreclaimable slab stat for such allocations. At the moment, the bulk
> free for SLUB does not share code with normal free code path for these
> type of allocations and have missed the stat update. So, fix the stat
> update by common code. The user visible impact of the bug is the
> potential of inconsistent unreclaimable slab stat visible through
> meminfo and vmstat.
>
> Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
