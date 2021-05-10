Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534EE378AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbhEJLzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhEJLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:05:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7C4C034632
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:52:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r9so23823597ejj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4j+T1/lO3597tPevHlrW6evOjrr6G8etz61AeHJbyQ=;
        b=wwAEKmat5aqvSwS475i7VYb7Dt1PS2TJjR3Mv2EhqgPGVvdqR/h6/h1JfuaXvAkVXV
         N+JDjegCW77A0Kssv4TdqlgL4kMfoHkSiK6zfWnDdsBdonOdjikInThJiKmA9hZ0umq6
         OZrcvSx2sztQsW2mHYrdRB7OdQyFEUN0Nv3M9SCjUs2E6IiRjgNtLE/dKhgj9XBvtmFr
         Ffb6833o9zKrefHBRoZbC5CL4El311nikSClJOMcBNy/dn2JGLtzCowOZCox+Wvbc2Uu
         qs94P0DurHrP+ucp+Z73fu2mF7MUF9SxhHFH8qb3Q+73ztmMFQG0RduUkr8TLJScgWyd
         4OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4j+T1/lO3597tPevHlrW6evOjrr6G8etz61AeHJbyQ=;
        b=mLJNADWqyxfwBGsFiEuM+ccna3Wup+cQh6QneHw8mTUwl6RcyEIZF1N02fTkuHM9jH
         7zftd48zUPMerIeSjiTjzNXB60rSeoSXGSrNAuGbBHgCXi6gy+A63BeLWolisbsmdBaw
         9KXWX284yM5bjm3b5XmkhmMrN9DJ+wfi2b/GK2a5VgkegsOBOC7ULvWWonCm643PF7Qc
         ebg5JtIwILDQ8UwMguP0kWx03/4TKxtFpVh9kXTjSIimx8Q2Ez8NtWNrrbHcbla7UGuo
         NJkhSnOieNFkCdhC+HU0/4Z9Yo4iDAX9XUMdfNc9vTutmq6qPS8VRc8XnSSO6vXTy/Xc
         BclA==
X-Gm-Message-State: AOAM5329vk8qXB4EZkD93ly6hzX2RLxM8VTJWLC0H7ZaQ49Crs8Svy0Q
        ln7ZS5H0808MStqXZoeM4s4n86pHM1UChoMn5bcEcQ==
X-Google-Smtp-Source: ABdhPJzIssnplywWZVqr3lrsOiL49JGzBQ2LDDMN5qIW3PMaWXMdwq+9knMjMecTV9lSUKLBc64VVUiMEREDphMg3UU=
X-Received: by 2002:a17:907:6ee:: with SMTP id yh14mr24722036ejb.375.1620643965545;
 Mon, 10 May 2021 03:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtZZoX53PjJ0VV54beMN6COccES9agttNYSzW=FbC=NFg@mail.gmail.com>
In-Reply-To: <CA+G9fYtZZoX53PjJ0VV54beMN6COccES9agttNYSzW=FbC=NFg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 May 2021 16:22:32 +0530
Message-ID: <CA+G9fYvrhB5-Zfh7Xudetsw+rC=LE3JatW6eh8K+mXQHdDKpHQ@mail.gmail.com>
Subject: Re: Unhandled fault: imprecise external abort (0x1406) at 0x00000000
 - PC is at xhci_hub_control
To:     linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     peter.chen@kernel.org, jackp@codeaurora.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        mathias.nyman@intel.com, Li Jun <jun.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 at 16:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The kernel crash reported on arm architecture BeagleBoard-X15 device running
> Linux next 5.13.0-rc1-next-20210510 while booting the device.
>
> [    4.956085] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
> [    4.961639] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
> assigned bus number 2
> [    4.969360] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
> [    4.976165] usb usb2: We don't know the algorithms for LPM for this
> host, disabling LPM.
> [    4.985321] hub 2-0:1.0: USB hub found
> [    4.989196] hub 2-0:1.0: 1 port detected
> [    5.002197] Waiting for root device
> PARTUUID=6b10e805-12ad-b44e-88b8-3abf3d5f52ed...
> [    5.022918] 8<--- cut here ---
> [    5.026000] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> [    5.033root
> 081] pgd = ff6a1748
> [    5.035797] [00000000] *pgd=00000000
> [    5.039398] Internal error: : 1406 [#1] SMP ARM
> [    5.043975] Modules linked in:
> [    5.047027] CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted
> 5.13.0-rc1-next-20210510 #1
> [    5.054809] Hardware name: Generic DRA74X (Flattened Device Tree)
> [    5.060943] Workqueue: pm pm_runtime_work
> [    5.065002] PC is at xhci_hub_control+0xd00/0x248c
> [    5.069824] LR is at arm_heavy_mb+0x44/0x48

Since, this crash is not easily reproducible I could bisect it.

- Naresh
