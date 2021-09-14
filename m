Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140C740B04C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhINOMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhINOMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:12:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03209C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:11:14 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s12so24202356ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=slk3pRozB5/8yjpVE/tJGzG+CMr4lsHPBapNQfk+ns4=;
        b=RiMZZt2KrPShhP9tQiYP5PJwrzYm6yaRZy9X/P+5Ehl/LiDWwtVLWWq1dx2PsRySOo
         LMRb8YG4/DfFaYbYk02XL2SIiNfc/7pbwYp7Gcl15tV/HgI+to86owkvBB0If6BOxZTU
         +IqAiiwrHyFShcl2CntpkzMtzF9em9DfSHkqapgP6gChzwiBhVf1pfmb7RKQJ2F3g6Pg
         uoN7h7esAerwFd+myq8APzXGMXbGMZNUbZYhg5lbpgfal/u2H/iLT2+pFniRMT8RudmP
         mZwke6wQ+Zk8aYXrlHzyL6z95dZsPZpcUKtSzUwTvtgcpLIyAyLLq9KFJoEAOa8tbLEG
         abhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=slk3pRozB5/8yjpVE/tJGzG+CMr4lsHPBapNQfk+ns4=;
        b=L00SFlw5jGHkW9xWUNs+W4jfCiHkM3wg9r4emGIBr4/IFZTn8+C+Fg8mDKOk2+ULm6
         TvlLCUEy1fIP0YBpDRYQbbvWYiQ3mzrqcZQKe7utSzoKZFiCNc3LhOEMyDCdmBsjon9H
         qppcxD4D+bnQn4YWWmRWus+p2TRlMULB9ZhmKQkuNVk/PGqz5F7G06UP/gZss98S41RL
         Ar7YJMYpDqCBqwOqfRnDDVwO0nMkswgF8RKkpuamv/TAYs0FH3odyDS74NlAClULgHCA
         Q4M34JxG0av1yQBz45/4u9hcWVg0DFo1EVcMZa5uELILuMCn3scPlmQAa9sUTfvAq8lQ
         bBCA==
X-Gm-Message-State: AOAM533HB6cv1ROYIWsBQ+DVgkC8ZPuvJ4JZq5W4oXdaAV50QqJUA/uV
        mnGyPRYqWNQ4cRendOvG0omSb4KUUrQlBlfpNvGyzzoA
X-Google-Smtp-Source: ABdhPJyGO7LPfXcnBiyaVQf2l3FKgsCRTjZ7ZJTPwhfwj8spdEcmP/SUG6QdbTZdeN09CExsrBzcWd/bHBm3LCMvjCA=
X-Received: by 2002:a05:651c:158e:: with SMTP id h14mr12025247ljq.56.1631628673234;
 Tue, 14 Sep 2021 07:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <1631627912-7974-1-git-send-email-u0084500@gmail.com> <20210914140747.GE4434@sirena.org.uk>
In-Reply-To: <20210914140747.GE4434@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 14 Sep 2021 22:11:01 +0800
Message-ID: <CADiBU3-xzopQxPSnwb=LnRhBBgOYyEttS7Jksg2izGv6W5BCAw@mail.gmail.com>
Subject: Re: [PATCH] regulator: rtq6752: Enclose 'enable' gpio control by
 enable flag
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B49=E6=9C=8814=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Sep 14, 2021 at 09:58:32PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Fix 'enable' gpio control logic if it's specified.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > This patch is to prevent the logic error from the below cases.
> >
> > 1. All off and both are sequentially controlled to be on.
> > The 'enable' gpio control block to be called twice including the delay =
time.
> >
> > 2. Both are on and one is preparing to be off.
> > The 'enable' gpio control low before register cache is configured to be=
 true.
>
> This should be in the actual commit message.
OK, I'll send the v2 and add all comments into the commit message.
Thx.
