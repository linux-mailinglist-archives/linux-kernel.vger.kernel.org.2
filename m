Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2398830EA4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhBDCia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:38:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57896 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbhBDCiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:38:25 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l7UWc-0003cr-Nm
        for linux-kernel@vger.kernel.org; Thu, 04 Feb 2021 02:37:42 +0000
Received: by mail-lj1-f199.google.com with SMTP id c1so1591333ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 18:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azbWs7ZD4+6Ar0t1pBb2H4Mtgu0Vsr9n0qu2CiY2eBQ=;
        b=Gy1QAkvP8Dtz9Agt94oEYcmAlrxQ3GIITXFgXIpbVVNNteZ1imK4RBKocY4fA7AjI+
         0Ei0kqVn9MZbq28kyDKvCk1UtW2cLlaQXmnOkZuJ+Ii1yzTCi4gyUQlM89BSYGI4O331
         Xmqgyq0H8hzP4rwvsDwc28LchcHPLvuQkJAi0Rl5kZGWpX23MYNzuRyFL5bV21ZYTPd8
         lbaHcjsqvA0hVqRRsB/5PR/0a8hogH4G8inNZhtnE4MjYfkg+0EwU/Buy5W3oUCDhmjh
         vLpqwXYcREYkViXSivhaB571MPYqXHqJ+Ghn9dJgIov7fvO7Yh4U8KhT8OHeTeOhqNIO
         lWeQ==
X-Gm-Message-State: AOAM533R5FyQzKCqTYW+mg+rFsNkTr36Zi2fXPBlrIdVkZBlYeE6CXGO
        mvWMw1+WMrYn4Fi4Ksmq/TcwRMZif6XmS9f2nBQUPn0xamZf0gKnUa2Key9ibTUnvC5oZ6Thddf
        /zk4x9b7C7fEIFaypVnIw7id6LShgBBd23b7l3L9vPR9pOQfw+nFknlZXSQ==
X-Received: by 2002:a2e:9bd8:: with SMTP id w24mr3423324ljj.126.1612406262236;
        Wed, 03 Feb 2021 18:37:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEVPLLXFO6iRnQdbK0dcPElIqzITbQ+eHDsyN1Bhrh8vZrbecO5E15DYaFFP78Dihi5Tyi32Y7L9+TnnLVIdY=
X-Received: by 2002:a2e:9bd8:: with SMTP id w24mr3423316ljj.126.1612406262014;
 Wed, 03 Feb 2021 18:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201213019.1558738-1-furquan@google.com> <e77e0569-568a-f7fb-9f0d-e64943b467f0@gmail.com>
 <CAJZ5v0jhniqG43F6hCqXdxQiQZRc67GdkdP0BXcRut=P7k7BVQ@mail.gmail.com>
 <X/2fzghPXnuDNBPU@kroah.com> <CAEGmHFEpPTuRuWFt0ba022BmGfaDmSTAgEApW9EzAa5CitmtbA@mail.gmail.com>
 <b4a931cf-5974-64d0-fdf2-693e418f3110@gmail.com>
In-Reply-To: <b4a931cf-5974-64d0-fdf2-693e418f3110@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 4 Feb 2021 10:37:29 +0800
Message-ID: <CAAd53p6PtdCRe50PFdn35S1mXHBACKUpmVVcE2qfZgVT3MKj5Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: Detach device from power domain on shutdown
To:     Furquan Shaikh <furquan@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Furquan,

On Wed, Jan 13, 2021 at 10:31 PM Dmitry Osipenko <digetx@gmail.com> wrote:
[snipped]
> Thank you all for addressing this problem!

Are you still working on the alternate solution? This patch can
address S5 power consumption issue for some laptops:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1912935

Kai-Heng
