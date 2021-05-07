Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549C6376128
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhEGHbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhEGHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:31:46 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FC4C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 00:30:46 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id s15so1418214vsi.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 00:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvrcjht1/ZDjZntlokA/5UTumpWo8GtiALSkNCm95ck=;
        b=sVmWM06agL2q7iV+PrscrJpJ4RWX2ZLaGuM8I7wLPWmsPbzWeJkUjZ4PuAnIGNRSjn
         7ZD/V+47EHcOW3Bu+ogYDAVJ1d3HMNTk5eaXMvB6LFoZJZZ4pPg+iyUQPHsdy2JPZE3K
         pHQj6+2bh5+OZTYYXIjbvhT0g9S64kKvTMKAmgMwV/sDyoivDcBY1YBixszkQbNEqaEi
         v+LWw62YydidKx67qtFimKSQqKYcLcttGDrbhp2nnW/4cmRiDeviCNza/zzCf3n8knA4
         lRzhjUUg112FDP062mmlNLrLUdqrdtgE2TvuuETGa48alWoWhN/O03p1JpLJot2JABf1
         pzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvrcjht1/ZDjZntlokA/5UTumpWo8GtiALSkNCm95ck=;
        b=hTQxPQ8dYPnwUcTF+pXXUVB5JXdhd1LFBld91mjJu2kHdkgd6Zs+1TGYVtTG0SY8ap
         LvsNkL2fQzTovoR1l/qp6+uGaa/ec/TYRkwSp2tYZIsubSiHKfrd5PoDvB8wr/jnmnwv
         yrhfoTzOouzHrWqNSzBW+BUPfGMLKD+65IfW/+irr/Em7oyOhnQFYq5ijUVKKPQfVS7Y
         zGPZTL8eNR8shhsP2Kj/g/iCxcpgukZxUGH0J3LU/zHeDKfDN0kokBQcx1jmpzmRfFDu
         dMjW9cQFBMPR7E78feav34xmeDcDYfr3qeqBtXnCKKQLrVnGDAc7ASRDOzBkWuqWnSO3
         r0nA==
X-Gm-Message-State: AOAM533zDxlnvNAen7mJl7q0vKtu4FjN7Uq3OtYm6Mclg8EW83ce52Ms
        MbObXKt+5yX5MAsW3Y1IeWQTULmaaWRqjpBCyXm1kQ==
X-Google-Smtp-Source: ABdhPJzqsWTLzX8DpmPbA8dxO3PTs2XgbM4cmuBt0cLXfmbGhqm5calOMygFAWSLucTkM9uoqUlMCqZH+WMaZhtvxPQ=
X-Received: by 2002:a67:64c5:: with SMTP id y188mr6598056vsb.19.1620372644882;
 Fri, 07 May 2021 00:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-7-ulf.hansson@linaro.org> <CACRpkdZUWP5hOCLpVvOSfR3YNXF6HC4GaO5ptYify2_EPa=wOQ@mail.gmail.com>
In-Reply-To: <CACRpkdZUWP5hOCLpVvOSfR3YNXF6HC4GaO5ptYify2_EPa=wOQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 May 2021 09:30:08 +0200
Message-ID: <CAPDyKFqq7DZJA8KRhNR_b069ef0+4RCf3GVbsPFYB+kiTg+Log@mail.gmail.com>
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 at 15:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> >   * NOTE: void *buf, caller for the buf is required to use DMA-capable
> >   * buffer or on-stack buffer (with some overhead in callee).
> >   */
> > -static int
> > -mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
> > -               u32 opcode, void *buf, unsigned len)
> > +int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
> > +                      u32 args, void *buf, unsigned len)
>
> Just a note here (the change is good)
>
> When applying please add some kerneldoc above mmc_send_adtc_data()
> and expand the ADTC acronym and add some info explaining what it
> is maybe a small protocol ref or so, so readers of the code get an
> intuitive feeling for what this function does and what ADTC is.

Thanks for the suggestion and the reviews, I look into this!

Kind  regards
Uffe
