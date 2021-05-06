Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCA375CAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhEFVNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhEFVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:13:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD88C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 14:12:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m12so10401580eja.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Bo72AhzB7+YSm7P0FOaU4jBEaqpN8AUfQcj2KwnpSs=;
        b=EmQm6WP8xnBarAmW0tbVcq2guRKhMynQBssqW77oYTTdGxewJWfZVDB7LniaaCTfDn
         3bFKOxj88KY6VTLGpdEY2lh/ra0Vn1rJemjOg7n3rVimIDr61OB/Z2pY+HRawUccNXgg
         fiASLFCrI9IPpv07Oi4CW8zxL91BVT+bcVcPaQoEWcB7Wi1fk1cj3JklcQOQBcgj4JTL
         24t3DafoFc7WEltRLDt/ou3CNVV4DoH+mi3LzP7upvhVpdz+YIFEUOu1b7nA27X9Zi5J
         6Svj+cRemnJEIyuoBreK8bch+ytTxgYqxfEg1BzU7fJGeBdMDLy57hL37qwjTAFrgTMa
         wuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Bo72AhzB7+YSm7P0FOaU4jBEaqpN8AUfQcj2KwnpSs=;
        b=ICA8RdZGwN/Zp7TCZSBLe/v+llpSxCpLZlTrR01bHqzOJMzKY5eN73CXB6WgLulHSw
         /VUve3neB/9tUwXt2d2mMx1Zkhsl/zRA/mjZS8Rw1DVpthGcrN0TiWk4galRd7FxRQsk
         x28O9Et3eea3gNMbwg+GqVds0EZHCmGC0bhDBuGr5CixHzQxfmlbt6PxN+5YZNvEfzCD
         Ng6RkfptDx/1jR2vc6ekvIEtYP55ri8lOgf8OqZjYswSJkbRAhviVlStgVOCzlwMYwTT
         rgodGU1KHx//C4lCNtF1lwVmxpQWkfpoKSsERAEqHi6ntRaGvlRHterjVcoCFHNuu9Xg
         giBg==
X-Gm-Message-State: AOAM531mMslQg25nwWvmB79R4vlMzi0gawotlawbHA7bxmO0mWLYejrU
        saN/MyXEmMKwG14q6Yw5kbKuIuigQ11PWHiNYa1AQg==
X-Google-Smtp-Source: ABdhPJyRbsDtuDRJDSnnFr/ZTy4qRioqxLMO9sbJSoNwal2Fa23tpqV1RXhjMDeUEmMOfv1ttwnH7JanY0o40ElFWAU=
X-Received: by 2002:a17:906:e206:: with SMTP id gf6mr6430277ejb.434.1620335527095;
 Thu, 06 May 2021 14:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210506180530.3418576-1-wdu@google.com> <cc2f068d6c82d12de920b19270c6f42dfcabfd11.camel@sipsolutions.net>
In-Reply-To: <cc2f068d6c82d12de920b19270c6f42dfcabfd11.camel@sipsolutions.net>
From:   Weilun Du <wdu@google.com>
Date:   Thu, 6 May 2021 14:11:55 -0700
Message-ID: <CAD-gUuCt5ugOyo-9Ge5omTgNJu26OORZFEZ2tSnQEiNLZN9ZyA@mail.gmail.com>
Subject: Re: [PATCH v1] mac80211_hwsim: add concurrent channels scanning
 support over virtio
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, kernel-team@android.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 11:19 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2021-05-06 at 11:05 -0700, Weilun Du wrote:
> > This fixed the crash when setting channels to 2 or more when
> > communicating over virtio.
>
> Interesting, I thought I was probably the only user of virtio? :)
>
> johannes
>
Hi Johannes,
Actually, Android Emulator uses mac80211_hwsim for wifi simulation
over virtio and it's working. This patch fixed the crash when we set
channels=2 to speed up scanning. I am trying to see if it makes sense
to upstream this patch since it's not Android-specific. Thanks!
