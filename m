Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6C3FB7D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbhH3OV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbhH3OV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:21:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF80C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:20:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u3so31413078ejz.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AhXC7FsliCDbgMBllCtVSrepgVuX0YpwGQp9z/ekM1Y=;
        b=aizIAHzAv3IZCt4XAp2HBi2nBu99U5vp1261GVSeUsVCmxPQ9XcjIJUXm+PnBPp1p2
         On1W34iNSDUP3GuA5Sk3YMWsBc8udP1Sq1YRFH+b19ypOZOfudgnwfu5gUzZrHfELV4D
         oidZKe5e9SyEJkDw2IlyR62BYFOWuY37PetkpS4Be0IGVvVpB0yQ9ADVWhhXS0wssujW
         MfhUKI0hpYkDC6aegg89z3B+sZ/dDeRE9DD+7HmnLr9MoMrvgNVWRytKOYughnseaiZm
         1E2gfW21Y+O2tOlLu2G4+4KQo/E3IzsUD5zJhbpAkMuxM8t0R4MTEXKT1yYElZcKH6lS
         QPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AhXC7FsliCDbgMBllCtVSrepgVuX0YpwGQp9z/ekM1Y=;
        b=UURKKSqSzO3kYHUaoMe3W1GIpYeCpp+lbZimvAmhtZen9+GxtO37DfI6xigcJOH4kb
         6yKZ4bJsfTv3tInXlwy3h7pO/99XQqR+KkJ6sJsORLbo2wTuB2ZU28uzipkPAqfqZN5Y
         GAvO+C5xl7oxY5tgVKK+mgbxS5mn7VGtyNZaqqXNcQjfBa4H9YeOOAraMVtEyakbQc+n
         BYbZwnD4lFNYj96rj86lg+ezlMn4BRLG0ySC3wumcPFaVxUm5GWuyyCYsbTGtCYrYXJQ
         dt8sqipDN6DuDDrkVnrrcs74qJlL4Fc3GNkwc+AtH5khACdfmMdcrS9sEwBPO0m3LSo8
         dwaw==
X-Gm-Message-State: AOAM532IeiS0a3zt7HvZmz8pX3KNfUpCjfz4Ucb9kiLbCVbYs/USr12/
        Z5PxTo0SflFtWrIgI6QYuiDIv6jazwXNewkD4ko8
X-Google-Smtp-Source: ABdhPJzofMywvHG9GYplqHaT8BalSiL9uoUxDKQw/jVvGW+oC9BvtDJV521UIbWSBHNfDlNS5rfeQLoPnlOP789groQ=
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr24982312ejd.488.1630333232912;
 Mon, 30 Aug 2021 07:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210830115942.1017300-1-sashal@kernel.org> <20210830115942.1017300-13-sashal@kernel.org>
 <CAD-N9QUXXjEMtdDniuqcNSAtaOhKtHE=hLMchtCJgbvxQXdABQ@mail.gmail.com>
In-Reply-To: <CAD-N9QUXXjEMtdDniuqcNSAtaOhKtHE=hLMchtCJgbvxQXdABQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 10:20:22 -0400
Message-ID: <CAHC9VhTjFMw111-fyZsFaCSnN3b-TuQjqXcc1zVu2QTTekTohw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.13 13/14] net: fix NULL pointer reference in cipso_v4_doi_free
To:     Dongliang Mu <mudongliangabcd@gmail.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Abaci <abaci@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 8:42 AM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Mon, Aug 30, 2021 at 8:01 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > From: =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com>
> >
> > [ Upstream commit 733c99ee8be9a1410287cdbb943887365e83b2d6 ]
> >
>
> Hi Sasha,
>
> Michael Wang has sent a v2 patch [1] for this bug and it is merged
> into netdev/net-next.git. However, the v1 patch is already in the
> upstream tree.
>
> How do you guys handle such a issue?
>
> [1] https://lkml.org/lkml/2021/8/30/229

Ugh.  Michael can you please work with netdev to fix this in the
upstream, and hopefully -stable, kernels?  My guess is you will need
to rebase your v2 patch on top of the v1 patch (basically what exists
in upstream) and send that back out.

--=20
paul moore
www.paul-moore.com
