Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB240988A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbhIMQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345685AbhIMQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:16:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0AC061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:15:35 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k65so21629677yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8e8w0kKoaJhT8dyqa2pOVw4qDbmG7nE5qlFFhzJWFY=;
        b=ijAvSsGpPp+LZHuO/yXuBtmgAn7rBrGWYJtJ3yH1XR4qPpXLVJUhp/AwOC50DL5x1c
         9HUNewJp/2hOYoqvF+b85BazPQw8e0ODASI1ennNmVE78b433h+Syn7K52gylu7TpQ4l
         hHNep6B/3zbO+JGgK1qEOByjhfsEPARziapnap/79qlV2BZQHWxl9D3RcZ9oBfM+5QNc
         n/TMymP23VcICMIL1yAz4DHt3dQvKpkaiCXgAbV0vkflzd6WHumauoz/z/rRDyzir7+P
         5tUZDaD4DyhnJhODwI40Hf6PpIBkmkbcvWlG+v1S/EI20hjQmaxWL1Ny2/yrGdaWYtQD
         h6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8e8w0kKoaJhT8dyqa2pOVw4qDbmG7nE5qlFFhzJWFY=;
        b=RRS+BLK15cNzeNwwaZbtAPo911SJuzFedE7zVmPw98sZmIDtuC5LqzuYampj5IEpL/
         XSFY0zxfnxh/NRGk7wjFqu8l1Bm3tGppGhGlxHQ/e7ggFx7MX3AcHzMCjwfqk+u5iFAm
         sE3TII8LXi6/8babNezVzf5/Wi/o8ceNO8RSxmBVrkTJqXiVWYuLhlenwIh9rsYUs372
         5VSMjUUUJp28fZnPl7GU4xigeak81sbMiqcuvHIX5Xu8kxH9N8Wv2V8KHV3xVchTY1zI
         0nwT6J17IKjfYQslymg+n7aKoteP1gEyMgcFmcQqvlyhR36JylZnPMKwBPALO2c9BvC+
         5nAg==
X-Gm-Message-State: AOAM530c5bb7QwBE0khWoHorzRsFbQljBnhxapkJ7PxclADcPs8GFkMD
        FYaK1S+ql5ZeFP1ikWLrd61Q9OMOHQavmdaTFnhlTg==
X-Google-Smtp-Source: ABdhPJxZauIdWjFzemGLmo0P/MnvtVYjV0hmscUMwkq5xOoh3WsPclsatBdjGpS/uYH5KtQgq33mMalLKAdAjOfKOBg=
X-Received: by 2002:a25:dd46:: with SMTP id u67mr16065628ybg.295.1631549734404;
 Mon, 13 Sep 2021 09:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210913040442.2627-1-yajun.deng@linux.dev>
In-Reply-To: <20210913040442.2627-1-yajun.deng@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 13 Sep 2021 09:15:23 -0700
Message-ID: <CANn89iKsbdMV1JmjzzGNu-2janfudb-t-Le-JempLrroJcNH-Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "ipv4: fix memory leaks in ip_cmsg_send() callers"
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 9:04 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> This reverts commit 919483096bfe75dda338e98d56da91a263746a0a.
>
> There is only when ip_options_get() return zero need to free.
> It already called kfree() when return error.
>
> Fixes: 919483096bfe ("ipv4: fix memory leaks in ip_cmsg_send() callers")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---

I do not think this is a valid patch, not sure why David has merged so
soon before us reviewing it ?

You are bringing back the memory leaks.

ip_cmsg_send() can loop over multiple cmsghdr()

If IP_RETOPTS has been successful, but following cmsghdr generates an error,
we do not free ipc.ok

If IP_RETOPTS is not successful, we have freed the allocated temporary space,
not the one currently in ipc.opt.

Can you share what your exact finding was, perhaps a syzbot repro ???

Thanks.
