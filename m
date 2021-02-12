Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB93319C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBLKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhBLKNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:13:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2558464E6B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 10:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613124756;
        bh=At3TvYO39sMhS3EJN5CLDSYALJN4MjhiSj36T+O6gOc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KPp1/5J+6Y+K3dUYigQ2VNE9Qxyw0sf5LmOPlAPYVPRzNFYDkcBtYTbbmsIehOkzH
         VfTCCdqU8UdouJD1HtspoqIJHvNtjSIRmSThGkJ7+R0lQLHXsF+fe03o6ta5LNJ1o6
         2ujdpz1pgVN4REvxrEBizP6XoN8+vNMLCObdjLd78W5tR6K/O7za6wZFFLVGSjq5/n
         laS0O3Xy26p5RajQpV9ssHzMCvfNjyx/ZS8oUrARPH49NV4xyfUe5uYxN0pXxaXbzO
         O4yiODRKRrJ/zipFnZ+06WzvGK03x28b2o1+olfH5/EGSIQaXWqT+FsFO9bUMGnz3W
         jgojfJ/UHOhJQ==
Received: by mail-ot1-f53.google.com with SMTP id r21so7867840otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 02:12:36 -0800 (PST)
X-Gm-Message-State: AOAM531QbsYp8UsYr0u7BuxtVBqoKdUJuvgfvfoxZ9XCYB0AEbNC2stM
        B30cJKstxhIkYDyJLEUbbJwuM3+JVprxjOBcylg=
X-Google-Smtp-Source: ABdhPJzFQEMgTZqRXRhGPhM8w+XvkCka8oaHeHRyolVGNuk10Tq8TdyrFdOKy5h3kV0IwHTu64TzzjAknp66S4txf3A=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr1545429otf.251.1613124755488;
 Fri, 12 Feb 2021 02:12:35 -0800 (PST)
MIME-Version: 1.0
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com> <1613121426-15585-2-git-send-email-mihai.carabas@oracle.com>
In-Reply-To: <1613121426-15585-2-git-send-email-mihai.carabas@oracle.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 12 Feb 2021 11:12:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1axvXVg3uWrSLEHP9F5B3-f=YOQ4pGkhKjzBAebN-p=A@mail.gmail.com>
Message-ID: <CAK8P3a1axvXVg3uWrSLEHP9F5B3-f=YOQ4pGkhKjzBAebN-p=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] misc/pvpanic: split-up generic and platform
 dependent code
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:17 AM Mihai Carabas <mihai.carabas@oracle.com> wrote:
>
> Split-up generic and platform dependent code in order to be able to re-use
> generic event handling code in pvpanic PCI device driver in the next patch.
>
> The code from pvpanic.c was split in two new files:
> - pvpanic-common.c: generic code that handles pvpanic events
> - mmio.c: platform/bus dependent code
>
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>

The patch looks fine, but for review purposes it's better to generate
the email with 'git format-patch -M'.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
