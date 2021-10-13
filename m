Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4D42C91B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhJMSyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:54:50 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:52:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bl14so3209599qkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0HU+U56E0Lrcr8H6vwMSPlZZnY8aeLcodPp7JstL30=;
        b=qPMVA8oKa/JA3c4vLQPRtrq5Dcg8ETvfRoQqgUHfA3tj0J1T/nRxileoSuOJndSctP
         AvYYdzrekCeUka3/3EVHv1bVsBTJpgKxHPQzfZ0htqucd6rh7oXJBJl0pVRJnfwyj2KK
         KsBsrqqcBxs/WKlc7WVfoqaZtwHylsk5A4UmWgHOdAB2zoJJFIK0cbY2PSoaxUBXx3uY
         CEadwhIPiXu0IqBW4a8ifJdMUlLzPNZrYkd6AdlcEXJ/C6eYGBphqAmQfd3yCRpdvvmD
         Dq9VLuDiqQbLejcEdNrR5XxxJ94FVql1jYxuTI0FVrHuHY/DfbbGrHwec1b80jxqqV2q
         qy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0HU+U56E0Lrcr8H6vwMSPlZZnY8aeLcodPp7JstL30=;
        b=ljsZhxQUuWhBhGMXgp+DLr0iM2E9m7ygLhCmXXVGIebd7tppmAJ5ewOhhFtXxeger6
         UDSE2muJgc7gdkiZ15vQyJpBDnu9eCMKNLucBghZv7B2HwHQvf68Un3bLIqfuctLfivw
         7NKqRIdl/jQrWOhjkiE8seTop3cU93UiTAKW4Zdn6Ho1e1sLXAIfLBUzyoFgRWmpg1Vn
         P3Nu2xAFOTCQfmjluLrd8Mevntu0LNSAz61QJMDZni2CvJxtyjmvEaV99DFN3EQ3XHwO
         dS4wvcl/urxjkd3U66oD0X2mpCFpF+63qkW6LCV7/zax/8i4fr7I889XSCYZSgryNm/1
         agPg==
X-Gm-Message-State: AOAM533VC1C7RPockZd6q6L8aWIN9OC+ujs2yCUEDDKPzSXd89FqrKp1
        mIgGsbmMGb5ZmeNYhRjVdB4yV1sWxTMLhg/RNwNAew==
X-Google-Smtp-Source: ABdhPJwWvNtlw06dYAKU6vOVSO3pES+jWJ4WEEgJu8sob65rOPjmGmzkF4V3C3zITajRZvfQeWvRsJ2r7q4L/FrlQAk=
X-Received: by 2002:a37:be87:: with SMTP id o129mr846941qkf.213.1634151165602;
 Wed, 13 Oct 2021 11:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211011172236.11223-1-mkoutny@suse.com> <CAFpoUr1KrXKdiCp-DVQLnu-c2YS91AszZB6RdZNVLBm9sGjMEw@mail.gmail.com>
 <YWXUuXsA+1nNjZYN@geo.homenetwork>
In-Reply-To: <YWXUuXsA+1nNjZYN@geo.homenetwork>
From:   Odin Ugedal <odin@uged.al>
Date:   Wed, 13 Oct 2021 19:52:34 +0100
Message-ID: <CAFpoUr1AO_qStNOYrFWGnFfc=uSFrXSYD8A5cQ8h0t2pioQzDA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Use rq->lock when checking cfs_rq list presence
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Odin Ugedal <odin@uged.al>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

tir. 12. okt. 2021 kl. 19:31 skrev Tao Zhou <tao.zhou@linux.dev>:
>
> Er.. this is considered specific to this fix I think. Normal unthrottle(not
> race with delete, avg maybe used in after) also need the normal avg decay.

Yeah, it was more meant as a way to express my idea, should probably have
said that more explicitly. It would essentially be a revert of a7b359fc6a37
("sched/fair: Correctly insert cfs_rq's to list on unthrottle"),
while "temporary" fixing the problem it fixed, by removing the load from the tg.

But yeah, it would still need to decay the load properly to _actually_ be fully
correct and work as it does today. But in most cases nr_running>0 on unthrottle,
but yeah, it is definitely not always the case.

Thanks
Odin
