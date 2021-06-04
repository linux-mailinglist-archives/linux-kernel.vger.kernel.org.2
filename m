Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08B839C129
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhFDUUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhFDUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 16:20:53 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8027CC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 13:18:53 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10287405otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JIUKDgLWjb5adyuGQWg8djEN36TGFJnaegIkNxv9nZk=;
        b=c8Qx3JTaUfRwguENdVAi4AmY/SvFm/9bS4pOGeTGgWv1uIsKQvO34HgTlLzzf86m9c
         RQzj0EP/g+tktXDE2/Qk9F0SzsaP9zarJdeY/am6T9T+JaN4mzP0VT6D6nnubrC9Y4Dw
         1NN7+5eVCgS9g97OjfyzhqvZKnsOY3jV6TaBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JIUKDgLWjb5adyuGQWg8djEN36TGFJnaegIkNxv9nZk=;
        b=S6BUxqtLB42+X2DvecrezSShDi+iJJu0SQm1YVW9xb98Rw7ZB7Pj37VN9WdY9ssvVm
         2y9x8gF1TPhPBTwwQIPZs0B6uNFVZ4/+jQ3+hlnhyURU3YYFurBBO/Y2eGVBGX763k6J
         m0OfUaRjz2k2v4nHcPcOR2TEWdz2qKhc4En88Y9VRhz3G2bjlPqpoShO557rSxRVwbtA
         pFlCRlf96/cfuT5CG3L5fknOHHr2H/VPbS2ZRS6KKikUmlFsiN92KY0kHp3vU3PqRjUy
         p9NG2E1wgnfqOOnLXi2nochYbft+F3pSZxA/afiuyc0/DGMzTAPsL6AHQzsOdSRqQBCK
         HO6w==
X-Gm-Message-State: AOAM5312fa7WHzh4HTq1Uxt/r7OJ7TgN4CbhltuXwAFTmCeqvJSi3wft
        fuzJMsWtVhQsSUYOm2ex2xcfcPSYVXOwSCEKt9HiHg==
X-Google-Smtp-Source: ABdhPJwAYnjRUHcRU3fQ9fHS5YzZI3bFT1EC/tJo1UmLyM68Mex37acWpg8A1SuIP0Z+u66aSLFMJmvMN2ul/8BnOEQ=
X-Received: by 2002:a9d:18e:: with SMTP id e14mr5058613ote.34.1622837932886;
 Fri, 04 Jun 2021 13:18:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jun 2021 20:18:52 +0000
MIME-Version: 1.0
In-Reply-To: <YLoj/2XmCo9OWjTS@kroah.com>
References: <20210603202116.1841261-1-swboyd@chromium.org> <YLoj/2XmCo9OWjTS@kroah.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 4 Jun 2021 20:18:52 +0000
Message-ID: <CAE-0n52SonMvf+c3YFt-u-LcrfOj4Nhg30JqyGyceSpdFhK2WA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Make cycle dev_info() message dev_dbg()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg Kroah-Hartman (2021-06-04 06:00:47)
> On Thu, Jun 03, 2021 at 01:21:16PM -0700, Stephen Boyd wrote:
> > This seems to mostly print debug information about device link stuff at
> > boot. It doesn't seem very useful outside of debugging so move it to
> > dev_dbg().
>
> What messages at boot time are you seeing with this that should not be
> there?  Shouldn't we fix the root cause here and not paper over it by
> just lowering the logging level?

Is there any problem? If they're a problem then shouldn't the printk be
at least warning level, pr_warn() if not pr_err()? I thought that
sometimes devices have cyclic links so we want to back off at that time
and stop trying.

>
> What drivers are having problems to trigger this?
>

It looks to be mostly the coresight devices that print this info message
for me. The other one is the display panel. The coresight devices are in
arch/arm64/boot/dts/qcom/sc7180.dtsi

[    0.545197] amba 6041000.funnel: Fixing up cyclic dependency with 6002000.stm
[    0.547173] amba 6045000.funnel: Fixing up cyclic dependency with
6042000.funnel
[    0.548032] amba 6045000.funnel: Fixing up cyclic dependency with
6041000.funnel
[    0.549899] amba 6048000.etr: Fixing up cyclic dependency with
6046000.replicator
[    0.551371] amba 6b04000.funnel: Fixing up cyclic dependency with
6045000.funnel
[    0.552781] amba 6b05000.etf: Fixing up cyclic dependency with 6b04000.funnel
[    0.554258] amba 6b06000.replicator: Fixing up cyclic dependency
with 6b05000.etf
[    0.555136] amba 6b06000.replicator: Fixing up cyclic dependency
with 6046000.replicator
[    0.560889] amba 7800000.funnel: Fixing up cyclic dependency with 7740000.etm
[    0.561726] amba 7800000.funnel: Fixing up cyclic dependency with 7640000.etm
[    0.562553] amba 7800000.funnel: Fixing up cyclic dependency with 7540000.etm
[    0.563388] amba 7800000.funnel: Fixing up cyclic dependency with 7440000.etm
[    0.564205] amba 7800000.funnel: Fixing up cyclic dependency with 7340000.etm
[    0.565034] amba 7800000.funnel: Fixing up cyclic dependency with 7240000.etm
[    0.565867] amba 7800000.funnel: Fixing up cyclic dependency with 7140000.etm
[    0.566693] amba 7800000.funnel: Fixing up cyclic dependency with 7040000.etm
[    0.568196] amba 7810000.funnel: Fixing up cyclic dependency with
7800000.funnel
[    0.569047] amba 7810000.funnel: Fixing up cyclic dependency with
6042000.funnel
[    0.623637] i2c 2-002d: Fixing up cyclic dependency with panel
[    1.108625] platform ae94000.dsi: Fixing up cyclic dependency with 2-002d
[    1.115646] platform ae94000.dsi: Fixing up cyclic dependency with
ae01000.mdp

I suppose with the graph binding making links we get these cyclic
dependency messages now.
