Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E03416410
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbhIWROF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbhIWRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:13:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A82C061766
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:12:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i4so28920208lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/CxnIoh9vGI3IXe2n3zSyhD1ELxDhirk2SHmfQlOLQ=;
        b=RMG/Scp8QfSxAZON5Uq51XOAc0XNXVcBG2GnnrniXglTgraSBvZ9RTKockwhPH4mGf
         WeyPErky+FsOoPedYN2c7qDYCZw5WhZNubXkskDS/lKdYEHUbPqNnam84t6nOFdacy7a
         Ly9YiJwUacU0hCuahpkwUe3ElAzj5gwsY1c2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/CxnIoh9vGI3IXe2n3zSyhD1ELxDhirk2SHmfQlOLQ=;
        b=s5uJS7eNTNj+4ebhtVbPeI3o+CpI7F0z/1lJuxnSsZMRj6USGY5j1xl2/crI3L3t+m
         PKOOGVcy7+ovKbUHjogh6pCe9y9Zj0kN1zcUbhh/2HVsb8TAlgXIcwkY7RMMBpm2X3sA
         4XbzETCI0sPlYSJ5XLjcTtg4VVjVGu6nCO6Htvm4VKoNoStkP0hwT3gsTExO6+q+Mt0P
         SNMyZpDnauq6IYKKcmhsY6DlBjQB3Xl2VkInT1DaLtEAKnpwkzz8OUhiMXlZWbaSAUG6
         c3zcNHyAjB1I/mpWwT4L+K/bdmXsYo1mvr0cSaqv5EdTjTT9uyBRr2IqGO4ozSGIYAL3
         jfKw==
X-Gm-Message-State: AOAM530FIq0mgKpDkXIFhOZrDNmLJXmw0QL5K5WKAMSQ40MWbu0XAzSS
        Y5b+c/CF8AW1sr1npZnpjzcup02MXx/LrgRyAjc=
X-Google-Smtp-Source: ABdhPJxT3k8j7fIM83cNT5O3sauRFY1hcsi7I1PSGgPIcKZJ6iasPz2hIwMvX9IjseHM/J72HxK0Fw==
X-Received: by 2002:a05:6512:33c7:: with SMTP id d7mr5272619lfg.28.1632417142012;
        Thu, 23 Sep 2021 10:12:22 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b14sm647626ljr.111.2021.09.23.10.12.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:12:19 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m3so29132214lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:12:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr5080713lfv.474.1632417137194;
 Thu, 23 Sep 2021 10:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210922224906.676151-1-shakeelb@google.com>
In-Reply-To: <20210922224906.676151-1-shakeelb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 10:12:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgL6H0fYt9o2qOVwExZJy_nmZ9=_hTcBUKf=YHXDJVxQ@mail.gmail.com>
Message-ID: <CAHk-=whgL6H0fYt9o2qOVwExZJy_nmZ9=_hTcBUKf=YHXDJVxQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: flush lruvec stats in the refault
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 3:50 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> From the above result, it seems like the option-2 not only solves the
> regression but also improves the performance for at least these
> benchmarks.
>
> Feng Tang (intel) ran the aim7 benchmark with these two options and
> confirms that option-1 reduces the regression but option-2 removes the
> regression.
>
> Michael Larabel (phoronix) ran multiple benchmarks with these options
> and reported the results at [3] and it shows for most benchmarks
> option-2 removes the regression introduced by the commit aa48e47e3906
> ("memcg: infrastructure to flush memcg stats").

Ok, I've applied this just to close the issue.

If somebody comes up with more data and the delayed flushing or
something is problematic, we'll revisit, but this looks all sane to me
and fixes the regression.

Thanks,
              Linus
