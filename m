Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E430CEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhBBW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbhBBW0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:26:21 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81396C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:24:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d3so4451631lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXK8oq2DlbA7lyIsSaGTbwXFgGanxEu82dZ8lLRpgRw=;
        b=ABwNqw1tZfnQ+pjITPrqd6B5h0qyKE2MxWTXL9GsCi2M91XYgvXwF7Yl98c8LCnnhV
         /zXHZNkSQZbH8iPevzHgFl0+/BWPbH+9+aUkc2dL4Oc+W8jHh4vFJ6WvIMcapMqmaLIT
         Rbkd/ekRkrGWHJ9hMDQv5pG4d0jF7pdXi2DZhpZk8RUUSipEjBk0eJDul3rKfgl1bOrL
         W8pqkiA+BJJHTf1rYvImkuwiCJbpqq5EXP2UsyQvGjQp6zsDIUnSRqHvPu79JZHrdomV
         hjUVD8PLX9jOyTqvLZv0w29ni00p6EvVp6iQLrkqgrk7cEDz4ucCdkzm/Ly29omQXrZQ
         1GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXK8oq2DlbA7lyIsSaGTbwXFgGanxEu82dZ8lLRpgRw=;
        b=p4F/kmY66d9LBzEvE/LYCxH16G0z4TVOE3tkcTZVz6Yg2F0sj602TvS1B4DveYLh6Z
         Nn8oFpJY+GkCBxb8VC/sPlb5Dhxza9Y2JLmwpGdzrwvz/BhAknzIDfzXXLl5USyRdpO5
         rQPAitU8QQDg3moLKswoGPSVFp69O0p6xqMEk+mXPbOcqOTYXMItY/FauZWRcWdeB7gs
         /Wlv8M+gt5Gxkh6PiWIL3sN4uTtz36NXOd+iCDhozg0byhcqW7ayPa89BUL32fGhWzj7
         h8vkrJPOiZ+AAApP2HQBC6B8BQuh12PoPfnCM8/XFY9z+GxFf0Vuf/q2eGXmagt+C74s
         yhww==
X-Gm-Message-State: AOAM532Q5rkvQApRFgJ3JPvLAdCivby7O6ya2ijkpwqvVe7ADiMYRjsf
        dFnWkh1VycfHdIHPpdRdWvtneqPjQmpjsSj+eej4oQ==
X-Google-Smtp-Source: ABdhPJzkI5c5KALserDCZjBWsZ+/3TOtL3G+pLbT+3aDT9MQkjoZGJqFjhW3meTCkwe2stg+3e9IILm9J90dTadxS1Q=
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr54417lfa.83.1612304692735;
 Tue, 02 Feb 2021 14:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20210202184746.119084-1-hannes@cmpxchg.org> <20210202184746.119084-3-hannes@cmpxchg.org>
In-Reply-To: <20210202184746.119084-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Feb 2021 14:24:41 -0800
Message-ID: <CALvZod5LRn=c0RUQqTgSbnRS6NbV+9XNZi14MHxKSmYSXOnDSg@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: memcontrol: kill mem_cgroup_nodeinfo()
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

On Tue, Feb 2, 2021 at 12:51 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> No need to encapsulate a simple struct member access.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
