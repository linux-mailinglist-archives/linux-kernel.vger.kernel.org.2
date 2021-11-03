Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA84A44475F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhKCRl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhKCRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:41:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9FEC061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:39:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 17so5232944ljq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8w2VytewPeRX4QkQuUg/BDVtpcxVWCV69c3Z6Wv2sj4=;
        b=kWIx5CS8nvY10TsruGTm4C3fKrM9wXsuvooi2CRs+RYshqzqTzNF0+zH+R36YM1KlG
         SXfOVbgb6TD5u3JxH7olKllrHzG6It7/DWNDjtiH6i7IGeC8VO26drKULHHoTboLtZqr
         qt6acogm5Cw/YIO1D0fm+BHOtNKGbrIkhMajJNiNOM0CHv3OUXeA/JAyXansys5U55At
         D5CyNObB1Mxv4G39O+PuDZVtGKecvzxA0M5Hd3/Weo/TEztQZP5T57VuPaX/aGBBGdHw
         VMOGod5Y4HRwZSVvrWpcFL9AePxL6Vmq4JCuYYm2vgg9x9JX2Ecxpqz7znCnzZDjLfYT
         QOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8w2VytewPeRX4QkQuUg/BDVtpcxVWCV69c3Z6Wv2sj4=;
        b=fInmS/GhF+H5yn2A6Ezhb7Gpr78GiII7/elJOSFnfPpAgtxIucAr8j3nyO6F5p9HGo
         Nistt+xjL0+mYvQOyqwhsZ4dRtWXw2w3xGug9VugFmo/V17AksBCvvjSIYo8xe05Z4XD
         7axAy/0grLEckNlNUNReb5pbxafHf8FdK9Rue/LRjOIEhPn16hifIFjJddHh5SWjOzzb
         dmTO14KTMsEaMKxpVYAlA7CBAklL9lrE7gDK0Fv3LP7FcrUVqVXqff+pnGAu7qbfRLr0
         +4QpxXyDJbg5wBoZrwyobEK0Y8jyaT9Ei5PitmkW0dbSbgi5PrzJ+Rs+AvV1QFgBf2/u
         lCAA==
X-Gm-Message-State: AOAM5339v00l6mHpq3jqHy4902yrevWNgkweVY7f8AdC3JOVYneO9E1J
        Cw8xDj6NFaGN3nE9AJ+WneODEN0u19EFOr1hhz43M8WTSRU=
X-Google-Smtp-Source: ABdhPJzUCQIup4ruIL/7766bJS+Rza0zAtfSCrmG5NSCBtA3dlfznEo/Y1F1YkhwSdQG0ID0DZhtkuT6jhtObbURHpk=
X-Received: by 2002:a05:651c:551:: with SMTP id q17mr18274510ljp.202.1635961155911;
 Wed, 03 Nov 2021 10:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211103165845.38226-1-mkoutny@suse.com>
In-Reply-To: <20211103165845.38226-1-mkoutny@suse.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 3 Nov 2021 10:39:04 -0700
Message-ID: <CALvZod5yLyuagfmG4LpAkNihMhisioYXnruKL7GA3owOTSvy-g@mail.gmail.com>
Subject: Re: [PATCH] cgroup: rstat: Mark benign data race to silence KCSAN
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 9:59 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> There is a race between updaters and flushers (flush can possibly miss
> the latest update(s)). This is expected as explained in
> cgroup_rstat_updated() comment, add also machine readable annotation so
> that KCSAN results aren't noisy.
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Link: https://lore.kernel.org/r/CACkBjsbPVdkub=3De-E-p1WBOLxS515ith-53SFd=
mFHWV_QMo40w@mail.gmail.com
> Suggested-by: Hao Sun <sunhao.th@gmail.com>
>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
