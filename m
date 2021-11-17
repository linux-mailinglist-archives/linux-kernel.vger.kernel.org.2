Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB96453FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhKQFMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhKQFMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:12:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56334C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:09:36 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso3012374wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrvdcWcxvEwbfdmc2m1Y3TPgWmvCSYywuOybBoGaU3U=;
        b=Y65X+0FMlEkzchyhA4oXbgQkYAWp0F/+pq5j4hMXmfGYkJfOTRGsMSvoBJJlaA1DV2
         FoTf6rYPUE1l33dJeVWp1wCoskIxtp79FrzcL9QtZa7FBWraJiOjfxk5vk5lH6hDDAUR
         Ypynsx68SR17nzwYh1jY7/ClHapN34PNHSMRiFg8Yodzgn1f7mk5IhgxweGwXPmzoODK
         rZRXPKBmxmMqMDjC6zxwqNjmfozCWOhGozM08elbqx8KvjAtdpDre/J8Fldg9dDx9CC8
         P1+2JJMjzUZQWbKnWM53AzJb4SoX/5g7lymwgxi/fUmlqW0SknsJMgIXwlVUSXLDs7Ny
         awwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrvdcWcxvEwbfdmc2m1Y3TPgWmvCSYywuOybBoGaU3U=;
        b=JLiaJAxOHHEMEJpfoGakinh7rSWQGmBHGSD1di/4Ntc9Ih39hDHQ2FNbpIuZbZwqPR
         OaLiEcl3V6dWMAe02paYkUD54thsCj0rOa8Wqk8D3XHS/5Y4cfK0c4wpkBnbxVSO9j5g
         fqMHJ8JEpj8Rc5gBpIRwYaKA+kNbDHoCFZhQgGmJSe9IhrxQ14Hu9Dx7nO4mjfO0uPiX
         xilKlipbsWdy9Axkl5OY7II0usyl17VuISfkqfO9W/R7CkEYX9s0bqhhKTE4/vFoJX43
         //94gj/5O9xrtzqJLmu21/JnCUfSHcO4JHS8eUfA6jlMfnzNCnXRqPW/NdWW7r6kt93C
         C6Rw==
X-Gm-Message-State: AOAM531t9DEeXBL4Bc0KD305XLmGn7GnGhsfuqkVdtAurqfEXHmkYiRb
        LPqApdf27LqKGH/qwgcS1TnXr4OKU0fsFt1s59Cutg==
X-Google-Smtp-Source: ABdhPJzPp8kyoz0IhAXb+yjfPOmdnmuIHhJtx6aV70+6f/J/bE01TbukDk/KFJ+68UXnZSRQoM7MSzceQfbJ5ixoHM8=
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr14514413wmg.118.1637125774601;
 Tue, 16 Nov 2021 21:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20211116060959.32746-1-rocco.yue@mediatek.com>
In-Reply-To: <20211116060959.32746-1-rocco.yue@mediatek.com>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Wed, 17 Nov 2021 14:09:22 +0900
Message-ID: <CAKD1Yr02W-WuLx8ouvP+wTtkxeyTBW_dp1deo9sim7wfLA2LXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv6: don't generate link-local addr in
 random or privacy mode
To:     Rocco Yue <rocco.yue@mediatek.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, rocco.yue@gmail.com,
        chao.song@mediatek.com, yanjie.jiang@mediatek.com,
        kuohong.wang@mediatek.com, Zhuoliang.Zhang@mediatek.com,
        maze@google.com, markzzzsmith@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 3:15 PM Rocco Yue <rocco.yue@mediatek.com> wrote:
>
> In the 3GPP TS 29.061, here is a description as follows:
> "In order to avoid any conflict between the link-local address
> of the MS and that of the GGSN, the Interface-Identifier used by
> the MS to build its link-local address shall be assigned by the
> GGSN.
> [...]
> 1) IN6_ADDR_GEN_MODE_STABLE_PRIVACY_NO_LLA, this mode is suitable
> for cellular networks that support RFC7217. In this mode, the
> kernel doesn't generate a link-local address for the cellular
> NIC, and generates an ipv6 stable privacy global address after
> receiving the RA message.


It sounds like this would violate RFC 4291 section 2.1 which says "All
interfaces are required to have at least one Link-Local unicast
address. It is also not what 3GPP requires. 3GPP *does* require a
link-local address. It just requires that that the bottom 64 bits of
that link-local address be assigned by the network, not randomly.

Given that the kernel already supports tokenized interface addresses,
a better option here would be to add new addrgen modes where the
link-local address is formed from the interface token (idev->token),
and the other addresses are formed randomly or via RFC7217. These
modes could be called IN6_ADDR_GEN_MODE_RANDOM_LL_TOKEN and
IN6_ADDR_GEN_MODE_STABLE_PRIVACY_LL_TOKEN. When setting up the
interface, userspace could set disable_ipv6 to 1, then set the
interface token and the address generation mode via RTM_SETLINK, then
set disable_ipv6 to 0 to start autoconf. The kernel would then form
the link-local address via the token (which comes from the network),
and then set the global addresses either randomly or via RFC 7217.
