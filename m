Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF63D9342
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhG1Qd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhG1Qd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:33:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28AC061764
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:33:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so2105981wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jBgoJqrVWqhNJH/0/qE0eCUGumu660a3Td6HU2rIic=;
        b=BWsv8g61vHQLbzfry5hZ7By+XwUoUglPp7BoImYNYuxlIj0THZuwfInv3Yq1VuTtOd
         0LF/seL9sPB54z3ENyqUr1/npsAH/rpRH0G2R7euKkJIdKhvjTpLrL5imZ2IE5YyMEN1
         PERFggNYBCP8DkMGExnupRmy4zCLnWj7OxQA4GRVO9J0+qIEqfgWK3L26QhpRBZOqCbM
         fkyhIjm6r3PULHR08zAmafAnSfd/SJf4y/2NUZ38Q+ATR65eNmDvd9Mc0pD2hHTjNK+t
         D9B8BL/Yhq1SomNmiKk/wezn7w7wpH/8k5foiI+IakXpD5XncSV9qZtZa0VX2vUtNytn
         6y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jBgoJqrVWqhNJH/0/qE0eCUGumu660a3Td6HU2rIic=;
        b=lRP1UbZoEoL7IW+it2tMK8l5sR1SDVyy+JqoNWOmo4eyy9gj37oyiAOCvFdu5jdlIy
         5k4KKA1gcJf+0vPy4N3BMPGm7ICbd6YfEmkcQ6J2ePLV2nQhBtaabFTHJxqMgiOu+rgP
         ZBdLNqYOlBuxzFB6TTwsCvTBS+LE46KSTz24ElGPaJ5ScTSePLzAtP3/BuSpvBwPYrra
         kLSuSrerfDH2wIZVUgNlrvwE8gtfvcG+b/abuJdQO7xCXlJNZ8qYYT097cNzFuaQ0Y6W
         3C8z5qVMKzDQL4wlEmcLVhhgV+7q8R2ebYk95tbsdepb/MfLUBB8Vl8yBSTcRdoN9RPk
         rljA==
X-Gm-Message-State: AOAM530RppxG+DqMmsIdTMZvRimEAk9FcFiQrTm3NRPuMiMc8NEynKwV
        WDtMHOzMhvnMue4G7IrcQqyXb7EJV8OPg08Yg1pliQ==
X-Google-Smtp-Source: ABdhPJzgZ5zNDcZVcEGRA8/+HnaI6aUgvb2FNmvty7eOd4ZgknSFpYpIHAyrtj1rD1A9ke0MeuoprhiWPBOqKu5IVvc=
X-Received: by 2002:a05:600c:354a:: with SMTP id i10mr10375183wmq.171.1627489999984;
 Wed, 28 Jul 2021 09:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210726153839.371771838@linuxfoundation.org> <20210726153842.719316961@linuxfoundation.org>
 <20210728101244.GB30574@amd>
In-Reply-To: <20210728101244.GB30574@amd>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Wed, 28 Jul 2021 09:32:42 -0700
Message-ID: <CAK6E8=cEX6MjxdnW36t9qq8+RqkPp9ZTwwH9Mr=emfbJ4=WV0Q@mail.gmail.com>
Subject: Re: [PATCH 5.10 099/167] tcp: disable TFO blackhole logic by default
To:     pavel@denx.de
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wei Wang <weiwan@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 3:12 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > [ Upstream commit 213ad73d06073b197a02476db3a4998e219ddb06 ]
> >
> > Multiple complaints have been raised from the TFO users on the internet
> > stating that the TFO blackhole logic is too aggressive and gets falsely
> > triggered too often.
> > (e.g. https://blog.apnic.net/2021/07/05/tcp-fast-open-not-so-fast/)
> > Considering that most middleboxes no longer drop TFO packets, we decide
> > to disable the blackhole logic by setting
> > /proc/sys/net/ipv4/tcp_fastopen_blackhole_timeout_set to 0 by
> > default.
>
> I understand this makes sense for mainline, but should we have this in
> stable? Somebody may still be using broken middlebox with their
> "stable" server.
Thank you Pavel for raising this issue. You made a good point.

The enabled-by-default policy has caused disruptions to applications.
We have received quite a few others over the years beside the cited
report. Other major TFO implementations (e.g. iOS, Windows) do not
have such mechanisms and seem to work fine.

On the other hand maybe we do not hear middlebox issues because this
mechanism is working. So I am okay to avoid applying to stable and
keep in net-next to test this new policy.

>
> Best regards,
>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
