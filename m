Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3063F44751A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhKGTIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhKGTIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:08:05 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B6C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 11:05:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bi35so31244875lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 11:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6K/HDk/5sXG3OR/4KUrGDRbz5Z2eOVXUmxNmMllvJI=;
        b=Cuycn6/QB+0/MgeOmvlXt+4lNtjwed3pxDuArqf/HMcILwTWRYgLPyWfQ3W1ci4g/2
         P8MNmFNdKEDeMSvfIG8aMHgiUo63eXC2m+IfbAtzLW5BJ9h9Qtm7mCJAsl/4o6nQvr/U
         O8HxRDhUDtnOL2gIcrsrzpSvc87OkdPj/H6ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6K/HDk/5sXG3OR/4KUrGDRbz5Z2eOVXUmxNmMllvJI=;
        b=uHE/RGdH3wwJ6jW48QecDXUudqdK9l5z9Gy9Y+OSQ1YuVArcqB9ewWoAm9y/jM7Qq0
         sl90CHogqFkB5XRyIWZRC3Ah7m5VSmTnZGv+DeBvU+yMQjU5lGGL6htc431iasMkmr6+
         n03NxAkAcB+3VeTnAtv9OEFFVCWDrkm36k3LHaiqqhEfXfNn67mDnbg/9q2y5f3qkjsN
         tsesBljOyu9alis5H2CXWJQeyPFT8Wv/JrEYyFxdP7Ym9cSyURNH9/2Y/1zBYObM7sgq
         21YNVsec+/caPi/Bbir78RnkZWvNcZKtBgVK+LS8KBSHsVuOHNuWZo+cO0D4Pgdxkr3S
         G26w==
X-Gm-Message-State: AOAM531dpTuKTO18lnBlWYLrJ2WYK18Gns8M1qlu/2lBY7/G65gKibM4
        BN6n+pcSTqLh8mnHfKqJydaxy81YXwSK8sgWNmU=
X-Google-Smtp-Source: ABdhPJxefzgydau0q59eVGd6aUwzM4nd4BL+cmy/s4MzEOXHRVbcj8Sw72pRxYnqDPVNmumdJ8Ddfw==
X-Received: by 2002:a19:3844:: with SMTP id d4mr18634765lfj.64.1636311920178;
        Sun, 07 Nov 2021 11:05:20 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id i1sm1545666lfr.287.2021.11.07.11.05.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 11:05:19 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id h11so25277885ljk.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 11:05:18 -0800 (PST)
X-Received: by 2002:a2e:86d6:: with SMTP id n22mr2270552ljj.31.1636311918266;
 Sun, 07 Nov 2021 11:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20211107174555.2d1a5eec@xps13>
In-Reply-To: <20211107174555.2d1a5eec@xps13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Nov 2021 11:05:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFoXSsfQwa8x_Ne0HYJtnLcpku67QiRn+q5tXrqiyBiA@mail.gmail.com>
Message-ID: <CAHk-=wiFoXSsfQwa8x_Ne0HYJtnLcpku67QiRn+q5tXrqiyBiA@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Changes for 5.16
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 8:46 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> This is the MTD PR for 5.16.

I want _explanations_ for what I'm pulling.

Yes, I can see it by looking at the diffs and shortlog, but I shouldn't need to.

I want a short blurb about what the pull is getting me, and why I
should pull it, not just a "here's a random pull".

I wrote my own explanation, and then decided that no, I'm not going to
pull at all because the pull request was so bad and deficient.

             Linus
