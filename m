Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7423351BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhDASLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbhDARz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AE9C0319C0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 10:15:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d13so3938998lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVDGqZfP8CTFi7i9UziPzlSl+qgQw2QPqRQAU0O6vCI=;
        b=IX55qoHfL8y3EtErFQYBvPcpWM6kg4j9Lq7Vuh5ufhjKJGc3KczMGzc39TUpbbMzVT
         CSpHGFsKsQjzUA+LqiSMVyfny3edaLBYuDm341QVKfxWacX5CDe3xo8Gab0ojqeah7fX
         ZGURyN/PM7LJn8ERrBrnbEetwPBOpv2Izcp5McUcxF7YsVw2cGtb3ma6B3xaHbuP5beZ
         pDd0HTgJInatB++grkOkHnOxfrMSvpLovoiaq+elQ4XjXk0GKhKLf5po4n4tYIteamhq
         Unar5bdRt0RiBRd1sHJ3AFfkPmNg7Rn2gESb6l9hDtCPl4h838xz/1HIYYpEcL5qs08Q
         Q1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVDGqZfP8CTFi7i9UziPzlSl+qgQw2QPqRQAU0O6vCI=;
        b=RGwfFCwBXO05jHkg1G3E21uHrwkIWJqo+fh/522hky4PopFXnmZPh2GhdsdsWdlxua
         uVwCJ08s3yzH4SApu34DyDxai4WqUPEmbTFBB/rOmYpkX/PvLlBz4Er3o7KAjLYLG4de
         +iX9lxYRrwV4yMxvESVAPoLUGMJQVsCKpHpMUoJxFEMpRbRGd2BaXYEYmoDM/xjIbZXD
         BYfGaEOm9newxSQELChy1X07epfgTZYdJiOvjfuDkjJrFF7Nv9M+DlIe0sHRXd/lQoQd
         +t+2plU6gS9xZiDB1i37MMJQtdyBBMylJ7rlhtmK95VbCAHTBxLpGLqyS8YFbOI2WT+I
         JpRg==
X-Gm-Message-State: AOAM530bQlvfd3gVPlTptM0OZSpf3C/W0iC8MEqxTEtIU2XczgxhlpdI
        uBZtiGyufuKYLrl3t3Nmr89d1Li4EKPuOcgPkZXzfg==
X-Google-Smtp-Source: ABdhPJyTtcQEz3dDdExeyagC8hu6fOgWKz7iFXCveSspTZ6Jukk9GiQddSqWeVrwsI2KQRRtDE1x/0e3S0nFutElX6A=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr5958452lfu.347.1617297356582;
 Thu, 01 Apr 2021 10:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <CALvZod4xHNmTQMd+zg71s7uyXUHEfwnQ-zqRXSWphwi9RogeNg@mail.gmail.com>
 <YGN0141iu5HTGiNJ@carbon.dhcp.thefacebook.com> <YGOYYgWbwiYlKmzV@cmpxchg.org>
 <YGOgth4IUflVE/Me@carbon.dhcp.thefacebook.com> <YGSSemLLpiHJHanV@cmpxchg.org> <CAMZfGtVYMDt_3CyH1g8d+Sey8J+W2HVY73xwCk_anm3UgHcr0w@mail.gmail.com>
In-Reply-To: <CAMZfGtVYMDt_3CyH1g8d+Sey8J+W2HVY73xwCk_anm3UgHcr0w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 1 Apr 2021 10:15:45 -0700
Message-ID: <CALvZod6EeDeb8S-LT8BgFP=KqUKqGS-EnRTKCy+ajAthMC2Vfw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 00/15] Use obj_cgroup APIs to charge
 the LRU pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 9:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
[...]
> > The zombie issue is a pretty urgent concern that has caused several
> > production emergencies now. It needs a fix sooner rather than later.
>
> Thank you very much for clarifying the problem for me. I do agree
> with you. This issue should be fixed ASAP. Using objcg is a good
> choice. Dying objcg should not be a problem. Because the size of
> objcg is so small compared to memcg.
>

Just wanted to say out loud that yes this patchset will reduce the
memcg zombie issue but this is not the final destination. We should
continue the discussions on sharing/reusing scenarios.

Muchun, can you please also CC Hugh Dickins and Alex Shi in the next
version of your patchset?
