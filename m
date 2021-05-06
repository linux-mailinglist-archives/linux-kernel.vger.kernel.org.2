Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D922537543D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhEFM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhEFM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:57:40 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723AC061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 05:56:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v6so6911389ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aClTJeWbL/qxhEs2nSQK0NRaAKt2JmCluDJCHpda6Y=;
        b=qpppjZbeVuYwOFuRDH3TurulhVeiNksaHsn0Kj11NYmMJgdCA/egI11Fpv8L0Pkc+W
         ImwL5c4YoILHr5gI+x5kseYDAK0Fd4F4of1zGd/rIOE7KynX4HjImcyies3aZPlkXwO6
         MjWXIBgfVa/6DbCi29C75Z8+AID9L68PSTguvGbZHGrny1QxCOt4TGHWuCUea9WCgS4L
         XtOkixgeTFs/bTt9Sx5T+PMMb1iFsb442i0qHKWSUKDNxRr6s/0S4awebmt0gqsaziyz
         mlF1tTU7iPjftZJ1yd5fB2bBvN+eJcmCI7dERHu7I4JdF23il9xWJB9XX9+qJ8YkzM52
         vYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aClTJeWbL/qxhEs2nSQK0NRaAKt2JmCluDJCHpda6Y=;
        b=nVLQujf3c685asEgBhOUOeytLGDnHwYgahJ1s67okOX7euWobrgmzIxUemA1RT0ObH
         P9iKwqd3+eaLjFonyW0LxNuEEKZQJ+ZTTqMgfnluZrZqONPN4id9NoCyGX5t38tGVM/Q
         ixr9xfXoIBQAOuBHRhAfFNpEwLNrvsPbEn/oOEaXFgLqqgJN3x/mSvlQXMgXMc9rZYZJ
         TyjmcgQVltbR19tK7CMZcKztpTokL60Pf2UY+yk5rp3i9f0fF6ivkbCEOXIVzTvxWe6q
         yHKplst3sxNnbtZXG+6oQbSdgDHrFvBCI7CuDcuQ8Gcw011NKSJj0EH+o56VYiOVuOGz
         Em7Q==
X-Gm-Message-State: AOAM530lMb2B5ZUh3HFV1Y0gU6VkJrK8H1ibP/vM0GyVat2eCu2Z10Ah
        aC07sYFiMZZOEqkYFNccM8Lane9X36ZBQUtVvpEokw==
X-Google-Smtp-Source: ABdhPJzALvXV18URUN/FUKmi8gb0S8rqfJCUb4ZzD6gaSpgfzDqWDwdzjXqVQUzitR+KZE9s9iaAZOiE1GT/PoEXvC4=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr3153318lju.200.1620305799721;
 Thu, 06 May 2021 05:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-7-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-7-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:56:28 +0200
Message-ID: <CACRpkdZWHQ3WS_zKOji9YZv3BMJnLxbsFjZjsUtiF0DPiq+sCg@mail.gmail.com>
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The function mmc_send_cxd_data() sends a data read command of ADTC type and
> prepares to receive an R1 response. To make it even more re-usable, let's
> extend it with another in-parameter for the command argument. While at it,
> let's also rename the function to mmc_send_adtc_data() as it better
> describes its purpose.
>
> Note that, this change doesn't add any new users of the function. Instead
> that is done from subsequent changes.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
