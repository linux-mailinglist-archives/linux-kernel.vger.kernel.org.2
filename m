Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43559407B28
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhILAuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 20:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbhILAuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 20:50:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AA9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 17:49:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n27so12450530eja.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 17:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djPK8cia5m0qX5Zxp7M6GNMnA/J0EGKvTFEvrA/orKo=;
        b=BeZ4wj46QWUIa1PRMxDJJzSxU067c8arLPq359/YAIYM2Pa0vDxJ8SxI9wU5chvg6x
         BdROVYGYeqJj5fLU+2WKja4e3teRqDF//UpkYy1+DfaBSxLpp8qry0a9vpB11tJA8BrZ
         wqMor7qv9Hf7pXq+K01/g7ViYfTGbH32VnwLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djPK8cia5m0qX5Zxp7M6GNMnA/J0EGKvTFEvrA/orKo=;
        b=1be8NtFG0LNQlmJekg7XInHLZ3kADdAZzwBsFp98EZN2ZcpjcuFz+W5Cy3qciQCG03
         Lb5SR5XljBgAKuxCRle0o4tLPk0ciCY9z6i60ACjpXWqyRGAkzTXwYvHW0Klw/F+4PzL
         y8jWE+SxCtzPlO8SUjLc7DMJ1ezwZJkYfJmgfx2toBadqxQJezA68w0iS+Jvp+Cw7s23
         jFd7y1csrcyVdXgObca/0Wua/qeFmCiBoQGbF/8T6OVqzj0VjN41RMuphuCEj2E9AR+V
         ZXApPP5Hp5LmbgFqws7IUFwaLzWP0MiMnB/pjK7lNHk+L0gr3SWts4v9Z2rEdQPirGH9
         PvUA==
X-Gm-Message-State: AOAM530fcnnDH/QvrxKn7WqyBgIOTnI32TTBQkAeFCc8gGv9o92lPToA
        RiLccERLDOAQAklj3GA54CZytaZv3kbKqMpo5F8=
X-Google-Smtp-Source: ABdhPJw7B0huchin7mDGuEDpqaSbzl4bdAnSLpbtHJQWmp9SedKvJ+P6XmiLE2CoFi3XcvskmmXJYg==
X-Received: by 2002:a17:906:30d6:: with SMTP id b22mr5356150ejb.442.1631407745406;
        Sat, 11 Sep 2021 17:49:05 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id u11sm1371141edo.65.2021.09.11.17.49.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 17:49:05 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id b6so8518908wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 17:49:05 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr3705182lfr.173.1631407431833;
 Sat, 11 Sep 2021 17:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210909095608-mutt-send-email-mst@kernel.org>
 <CAHk-=wgcXzshPVvVgGDqa9Y9Sde6RsUvj9jvx0htBqPuaTGX4Q@mail.gmail.com> <20210911200508-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210911200508-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Sep 2021 17:43:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguv1zB0h99LKH1UpjNvcg7tsckE_udYr3AP=2aEUdtwA@mail.gmail.com>
Message-ID: <CAHk-=wguv1zB0h99LKH1UpjNvcg7tsckE_udYr3AP=2aEUdtwA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio,vdpa,vhost: features, fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arseny.krasnov@kaspersky.com, caihuoqing@baidu.com,
        elic@nvidia.com, Jason Wang <jasowang@redhat.com>,
        lingshan.zhu@intel.com, mgurtovoy@nvidia.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        xianting.tian@linux.alibaba.com, xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 5:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> It's in the tag for_linus_v2 - the point of keeping for_linus
> intact was so anyone can compare these two.

Well, since I had already spent the effort in trying to figure things
out, I had merged the original branch.

I just didn't _like_ having to spend that effort, particularly not the
weekend before I do rc1.

This has not been one of those smooth merge windows that we occasionally have.

             Linus
