Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB63A3F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhFKJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230460AbhFKJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623403667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EjQ75pzRW46jNGz4ITAwUMQJJd/gfHRk6c+Tjf8keZA=;
        b=Q0+ywd3SY4NG10Fp/n2EaKZ/hIIWizBAIoR+5fJgY6slTyI6nF6Cj+ZZoEI+uO8SCdt1W9
        DMGG2s/KWw0meczGf26O76baUvkgXtWIwVlqACWXa/xmXJ70dr6Qu1iMdKJWFOS6pV/9Np
        hswxLybNoq/MnwurHa0/lv1MMryQUrs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-NjHEYeG6MpirBGruqfsBoA-1; Fri, 11 Jun 2021 05:27:46 -0400
X-MC-Unique: NjHEYeG6MpirBGruqfsBoA-1
Received: by mail-wm1-f70.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so5254657wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EjQ75pzRW46jNGz4ITAwUMQJJd/gfHRk6c+Tjf8keZA=;
        b=YNb/kVA9bGr0UtvlkBbK8KGE2ngwrTdsVRN6tRzP884Dh2luQwit1RXLJn2LnIo07x
         91JllvwCo38OBAg95u43dKEelaHaF4qvfrVUgWrrtNBS9H9v5w64f3fSFrLR4uyCdZJ2
         /FM3iacHUsgrSZVLgOUNWaYS6fyiLCpPYIt0W3zGP5D83yhfnZX51RiH7+aEKoZPbmuk
         d+cZ4oq2QLQWTfZUkMJlmx4tfEx5zUnFZPqCGGJM7ui4VBoUnGjcwjOJcKdPX+5tgKHv
         StEQAr9+76SrdkA+EpKC7AEc2f53ZL9j45uD7LOmE6DeZHrXzU0SV33+iebNilnI1S7r
         mBBA==
X-Gm-Message-State: AOAM5313KKD8FcVWO7tCjmtNgMMRGDg1w4px8XvxZ0iKXIcMYhLr6Xzu
        ty/ce8kSCQfZqlQ9jIVvvJex2sKs/tR+ScrExUYhrKF9oy21DUTr7gR2afGZ73+nyW8BDajb7Jj
        0Ob4p4vSv8oTJwldTvJQvnoM=
X-Received: by 2002:a1c:e409:: with SMTP id b9mr19341329wmh.63.1623403664994;
        Fri, 11 Jun 2021 02:27:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypLlNhSd9B2mho35MdpAtGcTFj3iRLbBwv2eXbg0Fdwwmw8we8zY+tKdYlvp3qfBDxy/7Iww==
X-Received: by 2002:a1c:e409:: with SMTP id b9mr19341314wmh.63.1623403664826;
        Fri, 11 Jun 2021 02:27:44 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b26sm11431339wmj.25.2021.06.11.02.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 02:27:44 -0700 (PDT)
Date:   Fri, 11 Jun 2021 10:27:43 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <llong@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210611092743.lsxfavezj3sps5ay@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210609143534.v65qknfihqimiivd@ava.usersys.com>
 <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
 <20210610122323.6geriip66jjmdstj@ava.usersys.com>
 <YMII3OMPoZPuCe0r@dhcp22.suse.cz>
 <20210610133644.zpoqfvlchaey24za@ava.usersys.com>
 <c205367d-f47e-61f3-3aed-fd8142a0010f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c205367d-f47e-61f3-3aed-fd8142a0010f@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-10 23:06 +0900, Tetsuo Handa wrote:
> Yes, marking ineligible (i.e. oom_badness() returning LONG_MIN) tasks
> would be useful.

Sure. I'll send a patch to append this information; and the reason why
i.e. "yes: oom skipped" or "yes: oom score" or "yes: vfork" to dump_task()
with the use of some helper function e.g. is_task_eligible_oom().

> By the way, was the task namely "node" (i.e. PID 1703345) multithreaded
> program?

Unfortunately, I cannot confirm since the scenario/or situation is no
longer present in the vmcore; albeit, I believe so.

> Your kernel might want commit 7775face207922ea ("memcg: killed threads
> should not invoke memcg OOM killer").

Tetsuo-san,

Yes, this does appear to be a match.
Thanks for this.


Kind regards,

-- 
Aaron Tomlin

