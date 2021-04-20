Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4C366111
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhDTUlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhDTUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:40:58 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C13C06174A;
        Tue, 20 Apr 2021 13:40:23 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i22so28456354ila.11;
        Tue, 20 Apr 2021 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kry+U86OyspoO4d2pLMc68TiRp5ZV9OLSFUVCrELgSU=;
        b=rwTN51EXkz1bm7UeWKxWcaGqFffyWM1mTU7nlEuvy0TdV3U4uhj4JzdpzOCXEoVc/s
         WlG+kTdLreAvAC02nHPVarjd8pTqbOD5JtQaotSaX7FgrSFOjvv2/H7lxIzEa1mp0ssF
         0ibOzUiUtDsWQ6bbSrDdjbbIBeUWX/sLvFiVtb6at5D1XUgTeQsbwyIBdJRdU3jHI2/Q
         U1T2Yzbl2CsFn/LCRf8pPD1qJ39As6RrfDpA7LXELqEMjH4EF/9CQ05KplUk0p1VhBn3
         cccSV6eW8SyTvV2zmFMu9SZi3kG0alOF3+cJWHoEcD8lqpuWlTRWRCuqhNs2eFMqVw/h
         C7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kry+U86OyspoO4d2pLMc68TiRp5ZV9OLSFUVCrELgSU=;
        b=kzE/lG4/bkj9GVlIfX6xWNUH4aytRsdABs/QTaUA2+lCr0YmscD7306S9S+7ijJrYT
         XnHju9aF6dO9gnbIYwMnkzZABWVY3AIerJNBXzPgdCmRPpw8vOcDagcyQY0kCpjdOwhH
         OoYx0tJjbxocLKIgbOD5SDrJSW4HB7S+N67sFtffJ/Atrb0MQ+CZt+3NLgLF8FDQG+AB
         9cUa+wcYzzByCWKcuS2X1U0ii3jOz3m2ibnlCvSKIs9DZ1c0YIeMyt8mwuXvtKeXmnuk
         4T1yiBJe7OpeSq4PyGS5Yqu/4XO+pBP1Fjl4KOfJx8EsmQZl0Ea2MrKAbZXaKYf1EuT4
         45gw==
X-Gm-Message-State: AOAM5320tYT202RR6q0xbM/sAQvsNnJsw/cs9ViwTiVk+ohJgAiUZf2b
        KFkpP0uSAPU3r2af6bjcKhQxH12sBDsrT46Z+fs=
X-Google-Smtp-Source: ABdhPJwGjq+vOzjCw4CMNmbVY9D9Ly31mSZioAiKDoC+oHgxFpI2lcukUnc//qdkpnI6dVWmYArAPy+8wghI9SLOozM=
X-Received: by 2002:a92:1910:: with SMTP id 16mr22995124ilz.201.1618951223190;
 Tue, 20 Apr 2021 13:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <84d07c8510abf95c9e656454961c09b14485b856.1605896059.git.gustavoars@kernel.org>
 <5adf738a-315b-a80e-46ff-06822441a789@embeddedor.com>
In-Reply-To: <5adf738a-315b-a80e-46ff-06822441a789@embeddedor.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 20 Apr 2021 22:40:11 +0200
Message-ID: <CAHpGcM+FKd9PPcW-X-FzkOmp62RgNzqZYbkMUPahabFO3ETKaw@mail.gmail.com>
Subject: Re: [PATCH 006/141] gfs2: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 20. Apr. 2021 um 22:29 Uhr schrieb Gustavo A. R. Silva
<gustavo@embeddedor.com>:
> Friendly ping: who can take this, please?

Oops, that got lost. I've added it to for-next now.

Thanks,
Andreas
