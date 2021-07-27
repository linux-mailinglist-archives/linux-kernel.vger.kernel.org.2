Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF83D81BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhG0VXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhG0VXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:23:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C377C05177E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:22:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d17so41776plh.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAf7u4TJvs5Sv03AGISvam/0mpJzusFYzH1iCFFxX7w=;
        b=RWnugz+5AV737Gf+cyi+F/L4qo6NnU2NBvtxokZOKlsDxwPxaSYUu2sab01LSQlkRj
         o09/ztAXNOM8eZFwswoUPLdBEhl+jR6bKniGOK/0nglciRzG82oGYrkwt9GcOB1LGpyX
         3EdZCWfOTTO0OIVdVGuGOZLa0VxcbYI9UHsPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAf7u4TJvs5Sv03AGISvam/0mpJzusFYzH1iCFFxX7w=;
        b=OjWp9/NQ0CSufR3QOC/Q38r+eDyWDb/wevFfUAbfsZKwbVDCYWOP1ZwJ0zSlXirq9k
         ZeQIMjyPzgVuimO7plAPDaHTqv+ICmDykToBGLfUPxJz5u2Iq68CXDxUUPGU3YK2zVCL
         9PoaedDOTbOBdqv0BtcIo2Mfp982PRaGgUyOBULptyYJxos54E5fbrO/Q7jw15+TO0wo
         29AZ9gimQaMyJrknkCg93pTkvfJDZn8thADYA8Skp945aMTekS7dbd2N6KOr9EzYIWiT
         mjEjaniw9IMO4uQgHOLg4aBjxOyoegHuUFGNeJk08ge67PS7F23rCuSuDF+QA4yEDiCb
         JEJA==
X-Gm-Message-State: AOAM530So9FFX/dyzrX0ZcmxyP36w76dLULxveZ5hq4YRAcCsoxC/Nsj
        Kq8zyT1ynKM/HD3/hIMd6jXWV8vLNTGNQgpTgGPgqQ==
X-Google-Smtp-Source: ABdhPJwQBliYlJnfdssUkXjs3c/B4SZJzNwIVCGrM5vFGuthQVt5Tb4mIQhB6JsP+G1okjrNzoFt7eOfVZ8zT/WNqWo=
X-Received: by 2002:a17:90b:1612:: with SMTP id la18mr15746789pjb.95.1627420946711;
 Tue, 27 Jul 2021 14:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210727190001.914-1-kbowman@cloudflare.com> <20210727195459.GA15181@salvia>
 <CAKxSbF0tjY7EV=OOyfND8CxSmusfghvURQYnBxMz=DoNtGrfSg@mail.gmail.com> <20210727211029.GA17432@salvia>
In-Reply-To: <20210727211029.GA17432@salvia>
From:   Alex Forster <aforster@cloudflare.com>
Date:   Tue, 27 Jul 2021 16:22:10 -0500
Message-ID: <CAKxSbF1bMzTc8sTQLFZpeY5XsymL+njKaTJOCb93RT6aj2NPVw@mail.gmail.com>
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

> It should be possible to update iptables-nft to use nft_log from
> userspace (instead of xt_LOG) which removes this limitation, there is
> no need for a kernel upgrade.

We have been able to migrate some parts of this workload to the
nftables subsystem by treating network namespaces sort of like VRFs.
Unfortunately, we have not been able to use nftables to handle all
traffic, since it does not have an equivalent for xt_bpf.

Alex Forster
