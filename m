Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9D408317
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhIMDWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbhIMDV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:21:58 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:20:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m21-20020a17090a859500b00197688449c4so5490994pjn.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvjAfdMGc0TGSBNCXXOfp9eTXnGD+BLjalLtFXGEwNg=;
        b=zx8MdaVaJTKEFi84nLllBeqnvpDCbryk+86ryq3PeVdGciZQWuXWApYXiZU+vpHIua
         4auBFBrjVwFvfynotWMrYvCspi63M69XDBef877mrk4+8OX/ntCV/JZN7yMXbd1lQcSj
         2QN/X0ooJEBsiOHmYMdEb+S8RG7uHOeQvWUSfB/EW18hyl5CDU3Y1hd2ZUPw/r0Cs19W
         AUYsQEleNJD/cn9YDg2w9BSKlnwCdokq2s1nyG1F9ivTvEduL+z/fWjwRIBTmbJikgC0
         nSxOEDj+SmfWeqMfmNbCsARvbCx40bqZmt4l+7COh5M7LH3amMGxAPNE0zDgnTAnWtVI
         dFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvjAfdMGc0TGSBNCXXOfp9eTXnGD+BLjalLtFXGEwNg=;
        b=xonc6xWobcLi868WMdakcn8sPB/tJTlDYeBfB+kUi5WvL50lLpFTWZBtjee45vpX66
         NM92UEwmrbrNAPzbBPMK/rK8aUr6HS9FH3mlb+YvEvfPKogfB8hxR/42w30LOtABLI25
         JNlJxpH+7eXcI7ELaAvsdxw9SyBtyEpru5r5FM+dAP0IHNgGOCbc/3nF2taeFk2uZq6X
         h9K4SgGHaxlDvimtL9p4K5T0FynW6hfSSY9xhcPgoexKTLsXWiS5OG7S9PK6ANiH2fnZ
         0lGSH8o/blegvGUbsJkTP92nKKBPProhTERxrgHkWpZhN/aZuu5UhtcU+P9Lc3g5vSKI
         5UqA==
X-Gm-Message-State: AOAM530T2jQMrn+gA0z0eVlIpJh7oEZT8pvClmoCeLDUJxd8Vs+Q/V6Z
        MTGXA68bWHLXpMEXybz50AP2w2Bq98fMZ37pNo/syg==
X-Google-Smtp-Source: ABdhPJyET22o17lmmxiiSRxXCkLqDeZtEMmzWp6jy7ieUEooxpxIyKFfqHWzCk1uF11g59TtExSO/xhSnOIX4JcQI8c=
X-Received: by 2002:a17:90b:4a90:: with SMTP id lp16mr10644077pjb.5.1631503242721;
 Sun, 12 Sep 2021 20:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210913024534.26161-1-tangyizhou@huawei.com>
In-Reply-To: <20210913024534.26161-1-tangyizhou@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 13 Sep 2021 11:20:06 +0800
Message-ID: <CAMZfGtU5o0Fr6ERRsTubqHCMaW=jYxhf+EvbWzVcvD=dmJ51_A@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: Add static qualifier for online_policy_to_str
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 10:26 AM Tang Yizhou <tangyizhou@huawei.com> wrote:
>
> online_policy_to_str is only used in memory_hotplug.c and should be
> defined as static.
>
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
