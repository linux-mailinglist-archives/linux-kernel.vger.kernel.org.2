Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D72345805
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCWGvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCWGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:51:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47307C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:51:21 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i9so13322415qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wq9bBiR3En5bxOPpxzb/tl6rU0VYgOW+HhygOcLtWg=;
        b=qRx37Kvlg6FqaxOVZjfkZq6Xf4cHgbJU9/RTF8JtQrPhHpCBd3RfIerjgqUIVBfiWd
         oklV/oPu2oPmoMkt5HeqcTLxciROdHPZU6LcZMen1ZIre3Zu3dc1b3lnJ7IUxvH6Emzx
         ZdRw9ZW4SlBiKJnZ4vVWyLIbrghq/zdwNwq37k9a9qKKLKIsLRpsL6qMDidiAr+21Hrv
         rdhLvh5/Uj0aaRS0EZo3atPbgCQh3zGVhQhEpjbWqbUDGK0+47Ty6YOJEANsPJraK0BS
         AuJ+E1g7TWn6paB+flMohqvpzwWUWcjakIftITi/GVkL5mgpoo0xnx9zReNoxgmcSUbb
         rWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wq9bBiR3En5bxOPpxzb/tl6rU0VYgOW+HhygOcLtWg=;
        b=dsGyKPcTF0RsZPRmZNwNOkc/ffVY5eoll2OPe0CI3ItzqNtzeOuEmvJWC/WDzIO6MQ
         /cpALzBWhgfbIVrhjl9CCh7FRMU9U6pc0VkVFbC8PYbdaW2rcABPNDT7EKNbgOX71Ez3
         d5NA8MrKN0aA/9TtBytuW0wFrYOSfEKRP9Rz7n+TsBHkk8xSc9ySZNJIxn9CuE8M4BUr
         3F2lKUZQDTjYfgqd4UVP3GLdy/fpXJTG6pO0IdfAgaYsg2DLKrXDgX21V6zDXw2EohiT
         hd4+tLSieh1wLASAmjoKbGsgvubREtL+QIiL8E3EmSIhfrSYVQ/UWKBA0PxaR1VYA0UO
         havw==
X-Gm-Message-State: AOAM533Yky3uA58xtR2d6Wzf0VAmU+xmYe/x+ESKnOIuNrQmoifyrFNc
        QwpIG2LhOTB7YdCpgKIfD2nt/OR8GJ3necohcSTX7Q==
X-Google-Smtp-Source: ABdhPJxe3e0CGNNgRzMRYZmLcPejk7aZvUWf0v2NZVYXDcGeNl4IqljK3hGI/77MltAXunr/XJCfZLAMRHhweiQoV+E=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr3836322qkx.501.1616482280347;
 Mon, 22 Mar 2021 23:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210320142851.1328291-1-dvyukov@google.com> <20210322.122613.1113183432857887657.davem@davemloft.net>
In-Reply-To: <20210322.122613.1113183432857887657.davem@davemloft.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Mar 2021 07:51:09 +0100
Message-ID: <CACT4Y+bNsEU3ZbHioBvZ9xbbML3TtX8f4WkyHLGv9OT4go1e9g@mail.gmail.com>
Subject: Re: [PATCH] net: make unregister netdev warning timeout configurable
To:     David Miller <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 8:26 PM David Miller <davem@davemloft.net> wrote:
>
> From: Dmitry Vyukov <dvyukov@google.com>
> Date: Sat, 20 Mar 2021 15:28:51 +0100
>
> > netdev_wait_allrefs() issues a warning if refcount does not drop to 0
> > after 10 seconds. While 10 second wait generally should not happen
> > under normal workload in normal environment, it seems to fire falsely
> > very often during fuzzing and/or in qemu emulation (~10x slower).
> > At least it's not possible to understand if it's really a false
> > positive or not. Automated testing generally bumps all timeouts
> > to very high values to avoid flake failures.
> > Make the timeout configurable for automated testing systems.
> > Lowering the timeout may also be useful for e.g. manual bisection.
> > The default value matches the current behavior.
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=211877
> > Cc: netdev@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
>
> I'd say a sysctl knob is much better than a compile time setting for this.
> That way stock kernels can be used in these testing scenerios.

FTR, I've mailed v2 with a sysctl:
https://lore.kernel.org/netdev/20210323064923.2098711-1-dvyukov@google.com/T/#u
