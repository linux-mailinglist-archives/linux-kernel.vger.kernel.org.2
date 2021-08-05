Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85723E14A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbhHEMYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbhHEMYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:24:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9438C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 05:24:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q17-20020a17090a2e11b02901757deaf2c8so8982190pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=481kLgNLhz1yneJKKCHLaWwT3IQ2qIrRbMfTuoiWLpI=;
        b=jmzDOOepPLmJiZ/bbOkFEvXBAtiR9fVO4+LNguA3FIU+LGlS+4BFQ2afsIDZ4OIsoq
         NaPN8JX/ivIW/padho8izo3e7YWe1TsQ4CmqZwEhoTHCzTvzZbkJYPJpuMiVdcSO2FIK
         u77wpkFg+fzP/a2yU/bSQLE0e+GT2K6CWKBbrn4600S0D0eKONipSRNlnVymL1BT+o06
         6OM4k8qf7zHKZbhiwsfqI2PFtGKGnYUnEOE1pV3H9GltI6sEthKlqCDgVUSUIOCIoV6Y
         AiJSImRSYsgJ+gzEOpDMkW16tXPCHA5h0JRjTbdy7Q8scmUy9VC4jnL59vl+wP4BX5bU
         c9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=481kLgNLhz1yneJKKCHLaWwT3IQ2qIrRbMfTuoiWLpI=;
        b=CR1+r6wwbCW/F55f2XSlqXJsoahsQfEswJCyAHMKrjMj/UQfM8H492mOlbcIrD7/hf
         MkqeQ835xJNidBqEEgbkB3lMbKnUH2Vc+fXWJQP+oOz3FXju3wVAtZ5dpxhJvebVB8Ff
         nECoambUoGOVyf1C9RJx40W8YzPqAv6CSLwJNNLAX1/83urcH6W6qMlssm8xE2Tk5d0N
         iY1PASJJYMOtq1Er9y0ud5UWu09yBps2PR+YWfbSRq0aYIef4a7yX5EJUOMBX/sZmghB
         57mskpmPMZGS4W+4xmrL/+py76OFcV7Tyc9/dm+IWxlkthmjLF2E0OYJV3rSWqJppO+f
         2TNg==
X-Gm-Message-State: AOAM533qPX/1GPAuoAstArM8inIYXIdimbThGiRzKGycPuv/Mjr2maXD
        1vhFqqzzSVhWEcY42Kd5ebOfqP8KT0c/zUtYjbz0Rw==
X-Google-Smtp-Source: ABdhPJyv8N2IN3o+g5lnf89frWzv3h5tJWYb8BR4N5wI6PHWEX9oKKo+NluxGDDt/UcMG3Y4rwQ+FJP1/Lj6QVJnXi4=
X-Received: by 2002:a17:90a:5982:: with SMTP id l2mr4594903pji.18.1628166260292;
 Thu, 05 Aug 2021 05:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210805120138.23953-1-broonie@kernel.org>
In-Reply-To: <20210805120138.23953-1-broonie@kernel.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 5 Aug 2021 14:34:02 +0200
Message-ID: <CAMZdPi-sKcBmQx99o75ta0DrVnXxaUk=v9j+8BgpE1Jvnz9F+A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Mark Brown <broonie@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 at 14:01, Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,
>
> After merging the mac80211-next tree, today's linux-next build
> (x86 allmodconfig) failed like this:
>
> /tmp/next/build/drivers/net/wwan/mhi_wwan_mbim.c: In function 'mhi_mbim_probe':
> /tmp/next/build/drivers/net/wwan/mhi_wwan_mbim.c:611:8: error: too few arguments to function 'mhi_prepare_for_transfer'
>   err = mhi_prepare_for_transfer(mhi_dev);
>         ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /tmp/next/build/drivers/net/wwan/mhi_wwan_mbim.c:18:
> /tmp/next/build/include/linux/mhi.h:726:5: note: declared here
>  int mhi_prepare_for_transfer(struct mhi_device *mhi_dev,
>      ^~~~~~~~~~~~~~~~~~~~~~~~
>
>
> Caused by commit
>
>    aa730a9905b7b079ef2ff ("net: wwan: Add MHI MBIM network driver")

Thanks for reporting, I see David already fixed the issue in net-next tree.
Actually, we also need the same change for mhi_net driver to fix
7ffa7542eca6 ("net: mhi: Remove MBIM protocol").

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index d127eb6..975f7f9 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -319,7 +319,7 @@ static int mhi_net_newlink(struct mhi_device
*mhi_dev, struct net_device *ndev)
        u64_stats_init(&mhi_netdev->stats.tx_syncp);

        /* Start MHI channels */
-       err = mhi_prepare_for_transfer(mhi_dev);
+       err = mhi_prepare_for_transfer(mhi_dev, 0);
        if (err)
                goto out_err;

Regards,
Loic

>
> That API has been modified in ce78ffa3ef16810 ("net: really fix the
> build...") in the net tree.  I've used the net-next tree from yesterday.
