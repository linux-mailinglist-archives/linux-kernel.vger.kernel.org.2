Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64E35FA12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350980AbhDNRuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhDNRuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:50:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:49:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 18so5437595qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Kzf8X1d0+K76SXVSOKe6DeC1BEbVx5t53APJl1jYBk=;
        b=POnNI+WsKl8yWcU4W+LDNHqNDo7rIIE4dL9tPELPmCbIsqYSnqdag4O0RIAljelvhp
         eq+lS+FtyrtaMGyhFasqes30iasqTw7p5i1j0roCRyjWE+H8DBmd8rZ/GauYjwT7kFmH
         orMvUAYZZx8wstflGyfL5XsbisPmORXC2Wso0gW4iTc2RoqG7vgQ0oU19IvIcOTgPWQr
         5ykFGOwW3PfO+UxcdreKz5OYLsF6FjwIs0cFqQO3TIh0LpfoQNDpCL39gHRYjomyvogK
         23GBNLbIh82nu6RoFq+6Dq/nnCHWyEBLDMViP5biVf9qCknrarWZkWiOg4PEx0V2YbTT
         Y0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Kzf8X1d0+K76SXVSOKe6DeC1BEbVx5t53APJl1jYBk=;
        b=MeEBT7Zf3q+JFNf535MYqwgrqDEd7/W7ux/AsiBm2+r3vin7k6muQrDw0qj6TgIOAM
         F/RJ6ccJBsSIOd+QoGmILNbT7VLhk7dXEURNiUB6uE/pqKiLarI38AdmFi26lx++6fQ5
         ofByXOVpnbyEUgzmGAvKAuHz+ACghku3qax1dLVcJZDK50fZbIbPr6gpiSgKe6vnStvJ
         tVu9fhYozU3AFkuDVyS0lPAtN0wPrDB0JhDWqxbeJscCDiEQtqXIVKoHHLi+Mk1GBZOu
         LeE5XZOC2ss2UMejd2WQzaboCVM2nZmpF8UZ2bci/V9CHVY7iTWEW1J2AC6Wtbd0L9zN
         z0Jw==
X-Gm-Message-State: AOAM533mOSfo6npzMQqij0EfJIGuKcHz4JsWcOPXYm91uXhWL88Mxb89
        ygQ0oNEPckcgDXWEpOzFRDM3OQ==
X-Google-Smtp-Source: ABdhPJxIwsEzHtEQ2YHTLka9+4LLiJK+mXi8p25eVOfz6ij9Bj7WypO2+/GsCz+X1L85SxPZYCUyow==
X-Received: by 2002:a37:6711:: with SMTP id b17mr26954820qkc.332.1618422598562;
        Wed, 14 Apr 2021 10:49:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f8bd])
        by smtp.gmail.com with ESMTPSA id h23sm59950qtr.21.2021.04.14.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:49:58 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:49:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>, guro@fb.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com
Subject: Re: [External] Re: [PATCH 4/7] mm: memcontrol: simplify
 lruvec_holds_page_lru_lock
Message-ID: <YHcrRMsmrXd5n3oQ@cmpxchg.org>
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-5-songmuchun@bytedance.com>
 <YHa5ao/JgoqHQh0Z@dhcp22.suse.cz>
 <CAMZfGtXBqxxgNaB5dcNGvtoH7Gn-1+Ara1YOGS-OahNXaExhsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXBqxxgNaB5dcNGvtoH7Gn-1+Ara1YOGS-OahNXaExhsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 06:00:42PM +0800, Muchun Song wrote:
> On Wed, Apr 14, 2021 at 5:44 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 13-04-21 14:51:50, Muchun Song wrote:
> > > We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> > > do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> > > lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> > > page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> > > of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> > > to simplify the code. We can have a single definition for this function
> > > that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> > > CONFIG_MEMCG.
> >
> > Neat. While you are at it wouldn't it make sesne to rename the function
> > as well. I do not want to bikeshed but this is really a misnomer. it
> > doesn't check anything about locking. page_belongs_lruvec?
> 
> Right. lruvec_holds_page_lru_lock is used to check whether
> the page belongs to the lruvec. page_belongs_lruvec
> obviously more clearer. I can rename it to
> page_belongs_lruvec the next version.

This sounds strange to me, I think 'belongs' needs a 'to' to be
correct, so page_belongs_to_lruvec(). Still kind of a mouthful.

page_matches_lruvec()?

page_from_lruvec()?
