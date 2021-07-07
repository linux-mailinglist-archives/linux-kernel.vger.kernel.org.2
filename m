Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434A63BED96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhGGSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:00:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80493C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:57:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q18so6127292lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owuNtJdNSbfSyKHzAYt3EuBOjT8SqaPcQMTJvlBjquc=;
        b=f3Iikb/gIIimF7XR7NPHnX5JqGIGjw2miQlyj0BhoTBUO9gXUNLjfVkeEG+cvlEq8I
         qeFiB82EuqkUsiQ0TlQ6wl9YXlvTKz1cE/XY6i6gEXG8RXRo2fe6HgrcZSqTxl5qbNpM
         zeO0lYj9zB1nyfSmm8Mq+N/WlUIExGnVK1Aes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owuNtJdNSbfSyKHzAYt3EuBOjT8SqaPcQMTJvlBjquc=;
        b=rM86ekJeaeq9p1Y0HnDc2dk2GqpiVocdFJ7UQMbRn0fpvzSR1BL6JcxFTO0PYdKZf/
         XEr/n2IKKVy8pQ0QV7doieAZTJHAcWyW51/P9gfGl7g//H2jDqhlDQ4JPm/nfnXWR+MZ
         SxB5pQLmne2P2JoWHnWbBq4OG/qAt63+UD1jlOA8BklgWETZBkeOCh/yPaXHV1ogXM+F
         b8DvUeERachENKaJy4FgjWiyvkfPVLz701GYHi1Vqr+vpsvWmXKNdqAjjM/yFGaXJrJp
         83PvPVuWySTosrJvLtyzszHSnj+lukebb4OFKT3UU2RWHlRRrgHY6iUPAHuhI0iPLiWx
         dEDg==
X-Gm-Message-State: AOAM531QhyJh6UzpW3YrXk4CVAgdJ0nMtImGmuOkJpIiD5yaTDbmVY+q
        7gvWi5Q+E0IoHRDGwyLpgjBaEO1rkXue6NIQ
X-Google-Smtp-Source: ABdhPJzxNewOUTEYoMKoYz73NQ31WuNm74iylvlNR5CaLkL4+IhqmNPSR1zWqk4lS7OfFL/1Zwc5vw==
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr7755296ljk.119.1625680657659;
        Wed, 07 Jul 2021 10:57:37 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id e7sm1916179lft.30.2021.07.07.10.57.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 10:57:37 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id f13so6113292lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:57:37 -0700 (PDT)
X-Received: by 2002:a2e:a48c:: with SMTP id h12mr7468935lji.61.1625680656897;
 Wed, 07 Jul 2021 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210706210228.1229484-1-bjorn.andersson@linaro.org> <CAHk-=wiXHZ=v4_HVL5TyP9DaHDd7Xxb8hiXjTQi1eDXOA_XRMw@mail.gmail.com>
In-Reply-To: <CAHk-=wiXHZ=v4_HVL5TyP9DaHDd7Xxb8hiXjTQi1eDXOA_XRMw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 10:57:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZradn2SLbZcY=sALkhdat-z=Dc07ZuDca+PWjK0mJZg@mail.gmail.com>
Message-ID: <CAHk-=wiZradn2SLbZcY=sALkhdat-z=Dc07ZuDca+PWjK0mJZg@mail.gmail.com>
Subject: Re: [GIT PULL] remoteproc updates for v5.14
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Suman Anna <s-anna@ti.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 10:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you end up adding commits to the end and updating the tag [..]

Actually, that's not what happened, the extra commit is in a separate
branch that got merged early. So I'm not sure why your diffstat and
shortlog were incorrect.

          Linus
