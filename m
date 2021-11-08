Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10CA447BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbhKHIUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbhKHIUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:20:12 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C05C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 00:17:28 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id s186so41304858yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 00:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5oR4Pjfl2f9V3U4NznnV9nmWC35FYhUexm9JqQPUc8=;
        b=1l41nRhnO7I1eGxP/c68wJ5DBQ0XGJ8lN5DMwqlVc/7TN/zU+ltPwjk8SMVijZZr43
         eAte3DcmoUJbVu6tTD67QKQxITk86RNdt1g3Iu9FVzXm1igJcyVg1zFefew5YtEvohju
         DRw9pjf6fuoYB6rSQ8M9J1F9y0fyTeFEz2ORBG/PWuvC0w/4zGUxJhEHmbrSGpllYJrZ
         GCa7cRNQl3xJL+Wissy/mStNpQzol9QX+pnfBbfBQFW7P64oOvBsmAMWOw7sNgFIt9lI
         Ht+HHwOot42mQ0ttkylEG/2dYgeGM8ch28daWUmtADUH/XOC+9ngAAySIn3u9tAGZOms
         lH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5oR4Pjfl2f9V3U4NznnV9nmWC35FYhUexm9JqQPUc8=;
        b=dLXNRuFA+VoF1ntH128eUPQlftcFxLOiUdx43Isep0v0RuNXqt45RupUxLsYX2AKVT
         WQNmm4AhlZZ1S4KugfpBdPXaRFRItUU2/VElFEJiyV1Fk/upKcNedSLzzux6vvJt3S46
         aBoHKSmalB6naQNqVNleaA8vykjmsk+T2uYtpGRqyqEyCAAaWjGewib1U1yiILUgeBb5
         K6OKfdp1hIBUWNLidkkhnM/KTbG/4TsRVBwvI2eFRoFyBaKA3Sm5k8R6EDaMEwYNHrCo
         rF5vf5OkhcEMMXkEq90Bvt/8xHWZtsnCQrSUp4nNLYRFe1qFuJP9L4THR9ns35qUzj4o
         Q1eA==
X-Gm-Message-State: AOAM533AqetYig8np4G1laAh2RlWoLHBRNgnBVaW+Hrr5gKDXkzV+GXg
        joYsLiEnADqzZXavDhtnycBnEj0Us/eeqetsCDCL/A==
X-Google-Smtp-Source: ABdhPJwmhfFlfIbBhUPOG+fkwXvAiAmkbEzb2MCS5TsfMgmxfcPioM+5zjlOaUdX46bcUTxs4a1OEJUOaxjqDID9e70=
X-Received: by 2002:a05:6902:1342:: with SMTP id g2mr74674633ybu.419.1636359448098;
 Mon, 08 Nov 2021 00:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20211101031651.75851-1-songmuchun@bytedance.com>
In-Reply-To: <20211101031651.75851-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 8 Nov 2021 16:16:50 +0800
Message-ID: <CAMZfGtUeL45=WG3ceaZ_tALMGZTLtuD9jbfKEzeQv270OnaLYQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Free the 2nd vmemmap page associated with each
 HugeTLB page
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Barry Song <21cnbao@gmail.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 11:22 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> This series can minimize the overhead of struct page for 2MB HugeTLB pages
> significantly. It further reduces the overhead of struct page by 12.5% for
> a 2MB HugeTLB compared to the previous approach, which means 2GB per 1TB
> HugeTLB. It is a nice gain. Comments and reviews are welcome. Thanks.
>

Hi,

Ping guys. Does anyone have any comments or suggestions
on this series?

Thanks.
