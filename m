Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FCD3375E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhCKOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhCKOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:39:40 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4028C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:39:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p21so40081169lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRX3JxL9ArLTMgxvg9Vap8aqfjFmbYdIVVaZ27whFws=;
        b=o6Zm2K0Fr8q5q9PtKQteoTYia0u2gqkf/Nfpmd9Ysmr6n38jRx+78XcJwzjUSg91Rb
         A23aGhbCJa6L8HeF1S/Ub9dRlfL8ykT8HfDZAX5H3/HFAhJqrC/ojzdfTLH0krNFL2bX
         x/gzA5b10kGzYV9MXCZLGuO5Z/OEXlqmEovymnceQermlW1yLXtN5LuFqTn0/NOEmyBm
         BwPrIhPxh8DdzHbxYrItrFOBf14Et4bQuvVQjid9zzJU3DTdCqTvkt3GVRSdohDBMOc2
         9VBO5DPPpJ1mIrqzdNVTxHA40GFPoXACkldx1qnJfxKFuy1RmZce7QNkb7ytkPZfFdjc
         EsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRX3JxL9ArLTMgxvg9Vap8aqfjFmbYdIVVaZ27whFws=;
        b=m6UsqrxNlqrYDyjQoo9Z0DxP0OsvGkMW7JWbeTQ77HItJPkV9guaU4RCCfxWC0BaTX
         95TYIZykCyc1g+5h7ihazOFcmc8qOnV+RrzrIQgE40oNZRw9nuuknsaZyqK5cDrTNCZi
         cQUc/596XmrjzStXBqEgVOjBPojisN1gy5Ghbl5DzakHWbDeXH1e8nk37iidc1oSrbMG
         Nssb02fsjtnhzjKCaDal7SKlR61OeKtqFEV3WAOT2xlAAkXO3ry/B+EsqRP8gtwxQvLK
         EFaaMzAZsSZr7uBNq0obIkhatATugDT1khHWGbIHTlbDcp38Nao+dbiMwwJoEuHIB3Cn
         wWcA==
X-Gm-Message-State: AOAM533M7RENdteaGYu6PNCP2WcQp4hM5Pg9ODgDh3Dm3Vy/3Cb3XYB9
        hZtfFU5YV2nJm7BBKTLNYSmgv/cakfOkp9MKYtlfqA==
X-Google-Smtp-Source: ABdhPJzL7b1QCjpPuDvu5hMDtVElSv+oLOTPmam9LzLVeTqzRxH6pQkh+F02MtmXCazZCgtaLEU618wN5tWM9Pdnu3Q=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr2608064lfe.29.1615473578223;
 Thu, 11 Mar 2021 06:39:38 -0800 (PST)
MIME-Version: 1.0
References: <d66e78e3-2000-611b-cd74-8a61461153e8@canonical.com>
 <5c08bd61-688f-e95b-5fa3-584f190ed4bf@xilinx.com> <bf508c29-4a51-5f97-8459-06c1fe74b60f@canonical.com>
 <f6cd3eb3-c8ce-9b40-e5dc-82b6748d4084@xilinx.com>
In-Reply-To: <f6cd3eb3-c8ce-9b40-e5dc-82b6748d4084@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 15:39:27 +0100
Message-ID: <CACRpkdazxVZCwLK6sJb7-hqhzuWs-HJ=2yiVr-UX4+AoEAWAZw@mail.gmail.com>
Subject: Re: pinctrl: core: Handling pinmux and pinconf separately
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:28 PM Michal Simek <michal.simek@xilinx.com> wrote:

> > It will take me 2 hours to re-run the analysis, but from eyeballing the
> > code I think the assignments will fix this.
>
> would be good if you can rerun it and get back to us on this.
> I will wait if something else will pop up and then will send v2 with
> this that Linus can apply this one instead.

Just send an incremental patch, that reflects the issues found
in a nice way in the development history.

Yours,
Linus Walleij
