Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03F3D7ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhG0UG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhG0UGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:06:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0DFC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:06:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e5so15535517pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qD/PBt3CNf26h7b3FD4L2B5zkfWzkBxO/uqzlPboJk4=;
        b=RtKqi/DcgLMxnMaj3mmxGPKAlnxq8ASoHJIzENVvIf3qFiGfkOTG3XdpIhr6YpXXDj
         NIq54XP3HiGYLgLnhQCb5WsbrWd2m9bnyWVyvbsDVfIVyeGddeJXCgxZXd5HVQ/6cFFQ
         oLWOXdmGT91LEzQMFj1574ESYTGDz9iCP7LxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qD/PBt3CNf26h7b3FD4L2B5zkfWzkBxO/uqzlPboJk4=;
        b=aE9iWd54lLh2W4IHzUGpMnmis2dCdoQCxQsi/oewPaFn5xr3k103TmoWHCvqDMqwmn
         /RhAGlv5Pc9vR1ydIa3MCJsSItMSS9dFlgP7Yo6LQD86mKblN9LuSuFqlCZFWoeShjdP
         WEFoN3l/T9PYv1WUiVEvU1uT5RnYW27cBqNQ6nWkD++8BCnqCdp6A0SoACmhxoih0my/
         zBQtsKCR4XDwTgGHIcfgARfw4sJlUCB4mTYCjgzP6luaf+T8Q249fiIWTb1ztQGzhfog
         4r6KAQnb+qjtLozlEkvA8FYHo0110tyVANIo/aYkGc1UXgb1fdSeJMEMjCCN4k5T3FQR
         74OA==
X-Gm-Message-State: AOAM532HvzZPpE4W0PaXhkYUT9YaO8tlzuHj3I9guLzYeMdWGEKVHNV6
        5kD0ayWqAtB3oFDJrmqMdwqN8zmOOXGNiqkTeThJgg==
X-Google-Smtp-Source: ABdhPJwHwSVtXYZElTiWWA6Bv52JZubsCu2gGXGiKvvmMRBeVFTzoiIWcaSwvUKA3i3Aa/uGinn2/U6KKAmEYcASojQ=
X-Received: by 2002:a17:902:7885:b029:12c:437a:95eb with SMTP id
 q5-20020a1709027885b029012c437a95ebmr4647830pll.80.1627416381609; Tue, 27 Jul
 2021 13:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210727190001.914-1-kbowman@cloudflare.com> <20210727195459.GA15181@salvia>
In-Reply-To: <20210727195459.GA15181@salvia>
From:   Alex Forster <aforster@cloudflare.com>
Date:   Tue, 27 Jul 2021 15:06:05 -0500
Message-ID: <CAKxSbF0tjY7EV=OOyfND8CxSmusfghvURQYnBxMz=DoNtGrfSg@mail.gmail.com>
Subject: Re: [PATCH] netfilter: xt_NFLOG: allow 128 character log prefixes
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Kyle Bowman <kbowman@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(And again, this time as plain-text...)

> Why do you need to make the two consistent? iptables NFLOG prefix
> length is a subset of nftables log action, this is sufficient for the
> iptables-nft layer. I might be missing the use-case on your side,
> could you please elaborate?

We use the nflog prefix space to attach various bits of metadata to
iptables and nftables rules that are dynamically generated and
installed on our edge. 63 printable chars is a bit too tight to fit
everything that we need, so we're running this patch internally and
are looking to upstream it.

Alex Forster
