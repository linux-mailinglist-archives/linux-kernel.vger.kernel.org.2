Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9132E32AE6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360966AbhCBXI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575120AbhCBWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:43:45 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8FEC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:43:04 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id u75so22416522ybi.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SFIG3NcmFU7ZJk++M1oU1XsZdgzUfvtqIHtpJ6D3C4M=;
        b=ra7ZatQkikW55ZhlwFe9CMYvyt7RK1UUC8gJy4wFvDOhgBxGHbS5WTBaBUtFdS4gp3
         GI+s93pDlo4BovOSgDUaJTzPGHAVD+s6LhPgBreDFLo5oLaoFHxQZeRleyxtgzX+/qOZ
         7dUBT8y7AQ/CEucfSnOyYEGwrtAk1gfNcNlx38rpnXRPRyfM1Pih/gMa9yAEbd+IJVim
         KK4jh6B3ue25+N+bd9AkResujg/ZsTs6J9stkxSqkpMo57hUH/ULeEXKF/LZ9FcZeRuh
         NwdbLDf1m6lTD39rvBJS2/I5bf1bmdUIk/B3L6uhe8F30NTiI4m3XTSZ4/iHmne6PBul
         JrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFIG3NcmFU7ZJk++M1oU1XsZdgzUfvtqIHtpJ6D3C4M=;
        b=Gi+BxpgIgnaEO1ILGuCRTe4JzxTO7qkiom91hLOPtUUjI8kOvDEY8My0Z4YysN6T6L
         vbBTB6468w5P+YB5FPAOZw5HJUL0ylqLfoe3RnS/vZV5XAwfELxiGIIE9VlLyMePfpm3
         fal/BkODcJauFGwcy2YfEQmXnOMCV1cA+/PRuRxtdd8RBUpMd+CVZZeKm58NtVWvcNip
         Pix3i1ezJglZSdP/4uKHZTYPIliHXuSjpAnhC9n0ux3r9RQvPXVD72gcJxRZlVH/nJe0
         ysA7OvzCCrq1V/5rDch90VKm7tl29ajH30cxTEvLfj1MU+q5GkLIjbfqorbaw2UHFEFy
         +UzQ==
X-Gm-Message-State: AOAM533fQPO9tlBR+9PKL41962vlu3eALkjjmqYvJ0DLZxG1gmJjuI53
        fk8gbgdW0bclZvGfxS2nfGZJ7vPJwRCB1w98hhXsYw==
X-Google-Smtp-Source: ABdhPJwrnZl/IQ6NjBgAn+GAviXDy3IID91cuYDSYt7l2dNS0Z5BEv388vALGMbKidTiI6vFJMetqnoDnO1cucQMcLc=
X-Received: by 2002:a25:2a04:: with SMTP id q4mr36031520ybq.412.1614724983736;
 Tue, 02 Mar 2021 14:43:03 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com> <b2dd44c2720fb96093fc4feeb64f0f4e@walle.cc>
In-Reply-To: <b2dd44c2720fb96093fc4feeb64f0f4e@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 Mar 2021 14:42:27 -0800
Message-ID: <CAGETcx_xCpid3QW0gQJWLL6ZfT-VJJq-SYX4tG09GRQWucw=qg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 2:24 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-03-02 22:11, schrieb Saravana Kannan:
> > I think Patch 1 should fix [4] without [5]. Can you test the series
> > please?
>
> Mh, I'm on latest linux-next (next-20210302) and I've applied patch 3/3
> and
> reverted commit 7007b745a508 ("PCI: layerscape: Convert to
> builtin_platform_driver()"). I'd assumed that PCIe shouldn't be working,
> right? But it is. Did I miss something?

You need to revert [5].

-Saravana

>
> Anyway, I've also applied Patch 1/3 and 2/3 and it still works. But I
> guess that doesn't say much.
>
> -michael
