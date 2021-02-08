Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF803128F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 03:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBHC3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 21:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBHC3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 21:29:31 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E3FC061788
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 18:28:51 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id c18so15106933ljd.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prVjlOxJgxegYr5WyW9Puejur2UOLsJUAHlf/hcHxi4=;
        b=P3vCF0PGHm1O1esy5AM5oRBJYOvhkYL9KaghBGfStowxVodRdE6aeYoKVs07gQqCRV
         /KDTE5iE1GBcC277I9pstoXCyEU29eULNB63ExV6UmFLrRdZgK8cat9bk3XBYQWEqBKZ
         /u53kzhG9DHRjLKqrk6f1wV8sTD2D+qeNK6tUSVqb8+zFZWF61kH4Xc8fRs9lLv3r3MI
         6HdoVrX+/2iVx51pPmhaEOfLaGjMlZY73hR6+llJr0bs/KK4S8dT42noXnH9cMoNKDav
         oH6zlOgD5ZCAqGqOIFzXdtV42/msvCRIF4YGwFet67mFYidyVgIrsOpZ9fhTmaF0qdpd
         wr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prVjlOxJgxegYr5WyW9Puejur2UOLsJUAHlf/hcHxi4=;
        b=j6eZQuARfAYTmaEPXZrBbIlgujG8mTCpY8K9Fpe+cJzWTGdvhk/4hLQ1ZviLDKTdW4
         ViRzRQ3sstrW9eTNTfIe+fQjFvyDXDno3S5czRPSBhZ1pSZuBGHhnaHRW9TM/VNmzdzp
         J4aZi8FaMFQWSd/0DnF9gEdzDLWuc7+lMVdhH+Qeb7SfFjp9AKKsl1hRgYlIfvqxMOwO
         8MKgcRWyUAQq1G/h12cS9IBgWJFaBL7JFlacAK22E0dSAOASDk39f9JcJ9nX5l9NLoal
         B4Ad4rYbT6Tzw3UxAnTbGbn8yRvycrD6fjy7iJNafGEZ2FIT/8qGbUkJUXVphx9Lg2PW
         eGHA==
X-Gm-Message-State: AOAM530zJvNRl5TFAzT3iH24KCnViOFaxMggKViZT0eHQLp3D9zxcJG6
        I22pFtKnFR1m+fGQzqtWtGaBTw4U4fSztMHNd25j5Q==
X-Google-Smtp-Source: ABdhPJyR2XSql3j3ajSmpY3/49a+HuQOKrA+Qf06VGVaO4rMyCBZU/zvyKPc/CticUgxxzDHes9zb693NtXnPSTSvbw=
X-Received: by 2002:a2e:9801:: with SMTP id a1mr10029568ljj.122.1612751329278;
 Sun, 07 Feb 2021 18:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20210205182806.17220-1-hannes@cmpxchg.org> <20210205182806.17220-8-hannes@cmpxchg.org>
In-Reply-To: <20210205182806.17220-8-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 7 Feb 2021 18:28:37 -0800
Message-ID: <CALvZod4ex5V2Xs_6YHmmLJw91rjKTSZ9XobXiRx4ftj=L=A6MA@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: memcontrol: consolidate lruvec stat flushing
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> There are two functions to flush the per-cpu data of an lruvec into
> the rest of the cgroup tree: when the cgroup is being freed, and when
> a CPU disappears during hotplug. The difference is whether all CPUs or
> just one is being collected, but the rest of the flushing code is the
> same. Merge them into one function and share the common code.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

BTW what about the lruvec stats? Why not convert them to rstat as well?
