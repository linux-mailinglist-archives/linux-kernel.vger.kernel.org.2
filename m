Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6EA3E860F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhHJW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhHJW3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:29:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44D7C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:29:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y34so1114845lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+K5d5HFyEYJUKP3ivTYllnbYiCqitEoC85CfSmt0e+g=;
        b=Hrkw2qxUqyJCW5cBuNERF6g+b4JZjOVA1u+VyG71fRRV7WqN5ov8/VW+YCRmYwHuuw
         8FGTkP9fYWuOXANDzYiHEeqatNY0c4cdIvHXddm4TK+RM/GcKKp0NS09Erjl0Mwhqsb1
         9w8KE1kmFttP0LX0Dg8sr7ciV1Xzt36HpKjNdKMxFFBwWLNRbLuKjiMSQEKHuRAJ8klE
         Am8A7ZtE02cBTO1ZuWBcos7+HlJbt+1GoB33qiDp0mEiGQE7v3yWO7YoS5h4rEqMTqGL
         DU/u0FUzt1Q0JXSJwfIST9jSNsNyFnTKtKmaOW1NRNdDuTHLtb0RozO5d/leKTHfpjFw
         mLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+K5d5HFyEYJUKP3ivTYllnbYiCqitEoC85CfSmt0e+g=;
        b=P/Evz9xPXMzAEgpGUKd1PENOe0BSNfdqo7wpFm6+7bRibhOtUvq19l5ZvVOb+Fb0Eo
         LJuppg3ha9sSQcncR4t1QzKJQm/TKePRNsiXEMvKILPoNHylzuySNF1kKddt0pn3qLlL
         /UcbXzt8GTm+bHV55H1YvSy1ocF7dX5vaWtJNJXdtgBoYiCE7Fhs7eIgL7OOLGQPYY5T
         jx/wuvQu76eCTnSl/6SXi8pmiyOm0FUXk6HCHtaqlTjAt0TDVgsGQdCJESLTrcaiRUKu
         Z1R7PHuk2S8Ecm3uSWfHR0In8DzKwe3hHA9wyacgzNYNJQaoEzm+y4B4AaDqqlS747Ic
         SN+A==
X-Gm-Message-State: AOAM533JlyONWIaGyEFZIuS2Sm9tnksvXVT1JYhT4S5BGV2MjdDFiZfg
        53WFXlIOTm8aEnWr9QX7wR4KwyuOxBhlz7QFtjRr296h1C8=
X-Google-Smtp-Source: ABdhPJxEdd4qm9lFRsHWJHo2uxKG9ACbOKSLQxG77UFzYaKlRqEdcsmumzb+ow5L0g9WnEXvheA/o6HIwbmhKcin0rM=
X-Received: by 2002:a05:6512:10d4:: with SMTP id k20mr12684545lfg.299.1628634566029;
 Tue, 10 Aug 2021 15:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210809223740.59009-1-npache@redhat.com> <YRKa0yzEDALtvSZO@cmpxchg.org>
 <a7afc485-9036-8f09-e582-f2eb45620670@redhat.com> <CALvZod5L+cyON5qRX3eSdHbo+-H7VDQeFuYYNqpK5diCcv9OMw@mail.gmail.com>
 <cbdbeae9-010e-ca11-eeab-44fa7d78c83a@redhat.com>
In-Reply-To: <cbdbeae9-010e-ca11-eeab-44fa7d78c83a@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Aug 2021 15:29:14 -0700
Message-ID: <CALvZod44ge5Ny8y5xpW4YUjUSAvnU0rR=b+xyMFjAt_oOUtkBg@mail.gmail.com>
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
To:     Nico Pache <npache@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@suse.com>,
        hakavlad@inbox.lv
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 3:16 PM Nico Pache <npache@redhat.com> wrote:
>
>
>
> On 8/10/21 5:17 PM, Shakeel Butt wrote:
> > On Tue, Aug 10, 2021 at 12:24 PM Nico Pache <npache@redhat.com> wrote:
> >>
> >>
> > [...]
> >>>
> >>> I'm wondering how you're getting anon scans with swappiness=0. If you
> >>> look at get_scan_count(), SCAN_FRACT with swappines=0 should always
> >>> result in ap = fraction[0] = 0, which never yields any anon scan
> >>> targets. So I'm thinking you're running into sc->file_is_tiny
> >>> situations, meaning remaining file pages alone are not enough to
> >>> restore watermarks anymore. Is that possible?
> >>
> >> Yes DEACTIVATE_ANON is enabling the file_is_tiny case in shrink_node(). That is what im trying to prevent in the swappiness=0 case.
> >>
> >
> > Can you please explain how DEACTIVATE_ANON is enabling the file_is_tiny case?
>
>
> You're right. Just did a second pass... I misinterpreted the assignment to
> file_is_tiny. This is not the case that is causing the issue. So back to the
> SCAN_FRACT case. From my testing the refaulting still seems to be causing the
> issue; however, to your point in earlier discussions, if swappiness=0 then the
> get_scan_count *should* be 0.
> So my patch does solve the issue by preventing the shrink_list from deactivating
> the anon, but it may be hiding some other issue that is the ultimate cause.
>

Yes, I am suspecting the same. BTW which kernel version are you testing with?
