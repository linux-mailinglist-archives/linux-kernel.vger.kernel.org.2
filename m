Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B334D3BEE99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGGS0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhGGS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:26:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1A5C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:23:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p1so6310369lfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDHDPMpz014OPz0Z7rLhyIYq3kvqTkpxFqDf5SX+GzU=;
        b=g9cK5amb9g0zP/flqblNVhbEQQrZrQQH3aFvQuW42eK/oKktOrlk5p3V2Wm92VaW13
         uDQjy6p81X7hnAEcQMNdkk8aX4XGhzUZVJAT/JXlhqwQ4oR+jnzNyivCE5Rw6eZ4uLYr
         XrQqbRVK7/84iAx0qYinvVYFLC8OOownnRgE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDHDPMpz014OPz0Z7rLhyIYq3kvqTkpxFqDf5SX+GzU=;
        b=TWfu14cqWTbRT8VnsqqgMmW1lxWn6ElJIS/zLa/AVcHa02FFhkY3FLXsoPUXeFfeQN
         EPpYk6OK+Iv0if/pjO15XilqOJO9DbsHVStKE1YuauK46J2OOGOErTDbn0EekMMJGRBu
         48ljFLwNSCIdxYjOuDCxb1eIuBji9U0hDwYOhGleV6Hrcp5xY0kTpCTP4oPZxmPBI6Z5
         DPytmE7f6MUKn1Yx/dlrTbnvrBFLGj/px0Fq0FI+FGHrr5W4xmVNHYZpkxoAOKCXSJO1
         TBtLQcNzxH/W0C9Uuh/zf4+5u0yhl1zfiMCoU1wjCU31YLQjC//iKgogAeyuFvbyDj/N
         6NMw==
X-Gm-Message-State: AOAM530Az9xljezbnUE2hNdlxHEj1TFyA09mxUSgbGVaFEMgC43yxfG3
        6Dcxiw7WLcBSrx2BbMIRVfJB13J5SkDRFnWy
X-Google-Smtp-Source: ABdhPJyigUwWejW/5R+Xkwy6FBdsiqIM7YG1eL1G92nVTajryAtKXm2OP/7c6hCBGRnTq3R0nopwqg==
X-Received: by 2002:a05:6512:261d:: with SMTP id bt29mr21168354lfb.231.1625682195358;
        Wed, 07 Jul 2021 11:23:15 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d12sm1169538lfv.204.2021.07.07.11.23.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 11:23:14 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u18so6354742lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:23:13 -0700 (PDT)
X-Received: by 2002:a05:6512:3585:: with SMTP id m5mr19626826lfr.253.1625682193528;
 Wed, 07 Jul 2021 11:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210706210228.1229484-1-bjorn.andersson@linaro.org>
 <CAHk-=wiXHZ=v4_HVL5TyP9DaHDd7Xxb8hiXjTQi1eDXOA_XRMw@mail.gmail.com>
 <CAHk-=wiZradn2SLbZcY=sALkhdat-z=Dc07ZuDca+PWjK0mJZg@mail.gmail.com> <YOXvLSKuQPl/5Bh/@yoga>
In-Reply-To: <YOXvLSKuQPl/5Bh/@yoga>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 11:22:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4b=1gUbNm1WOmD+GcB3-EnR6mwRtU-n4oVpj4kLTrVQ@mail.gmail.com>
Message-ID: <CAHk-=wi4b=1gUbNm1WOmD+GcB3-EnR6mwRtU-n4oVpj4kLTrVQ@mail.gmail.com>
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

On Wed, Jul 7, 2021 at 11:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Would you like me to resend this with a correct diffstat?

No, I merged it - the main reason I check the diffstat and shortlog
after-the-fact is just to make sure that I get what the pull requester
_intended_, and that was fairly clear. It's not like the extra commit
looked out of place in any other way.

And the only problem with the mismatch is then that I waste time
trying to figure out _why_ it didn't match. And that's already done,
so water under the bridge..

So I just hope it doesn't happen again, because I'm just lazy and
don't like that "Ok, now I need to figure out what's wrong" part.

             Linus
