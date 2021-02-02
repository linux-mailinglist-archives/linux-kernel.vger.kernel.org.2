Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5F30CEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 23:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhBBW3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 17:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbhBBW1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 17:27:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E9EC061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 14:26:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e15so10253645lft.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDotIy3tcEIJJUi6Xky2qhleZoFwxU7Fh1JVqEU4/ic=;
        b=DWhal97NxQ2UcRObukqIeV8C95ewjDs0qpbMhw0PAmBEJ3xVz68xcmNomNWXA+OJic
         +rIygIVjzV43HN7ioMBwfKyJVQhO9NMVYn1W/9WGwMDdEQx0n+umzXULPrkTJaVyvxyW
         pwgtfY25dcBvIRG2+SgntOFiAi/e+7cOpdNOaU41qnmXgqQTnVFZM1SPbiIQXiOwK+3h
         sTboxTmYqLIVMaT3mXKitQs1ablFfYVbDPpDCLlNnsids3HT3uQifHjR6H/wm2//y/5d
         dY492h/vGDfeQCipU0CkZmnzGYrEoEs0Hia3IDejLkYw16Cn+ZNg9J2G3D0EUmWgllJg
         p5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDotIy3tcEIJJUi6Xky2qhleZoFwxU7Fh1JVqEU4/ic=;
        b=W9VdBQQHKtlDOGD17Bb7hY+JWCf+R2/FbgA3mb/yvOTwCBc2cxSWvCF0ZebIUyPkC+
         E6/+c+0GhjCkJv6o8R5+O6o4JL+IHiZnMeHkMLHFRIes09nsNi/Tx5gHOVtSxDyutd7p
         chxgwCn57CPv2Q3pee1iTbTWmIZ/MIF49yhcSJYLbk3PtjN8itLjldBF2Ygb2RP/9kFi
         /Z7LFcH2M4EXrqc6gV8FiHGQA9lRMCz19h6tBVbfDYU8hV38JobjOhNmWjcG6UX4h62H
         8IVQPNQoLqpYvZZKN7DR7eonNVuxDq4MMYZ5pHIQXNANLL4sL3cCHJf2PWltXkoHgbee
         0W3w==
X-Gm-Message-State: AOAM533nP8m8S2rKKPmMHEAr3ck/rVGIm7oiF8jdw2OO6bDcD5129ps0
        kHyhVan1cx+oAhuk/KdaqVBiybw14cR8CiZ8mvRH+Q==
X-Google-Smtp-Source: ABdhPJxYeKpHUbcT97Z6Lsu9PZiyKmkOvnMWDHB0gHxjysvP+NTXtuuTnVoWdHcs1ZKCFXLcIjEZU4VE5KA8iRSdCKY=
X-Received: by 2002:ac2:5a41:: with SMTP id r1mr60968lfn.117.1612304793006;
 Tue, 02 Feb 2021 14:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20210202184746.119084-1-hannes@cmpxchg.org> <20210202184746.119084-4-hannes@cmpxchg.org>
In-Reply-To: <20210202184746.119084-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Feb 2021 14:26:21 -0800
Message-ID: <CALvZod6kqzoydroO3E59=hrF+DBV6LwRZ282h2p+xeNKezFAgg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm: memcontrol: privatize memcg_page_state query functions
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

On Tue, Feb 2, 2021 at 12:45 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> There are no users outside of the memory controller itself. The rest
> of the kernel cares either about node or lruvec stats.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
