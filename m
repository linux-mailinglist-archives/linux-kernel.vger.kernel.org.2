Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8460030A365
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhBAIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhBAIgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:36:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E80EC64E3B;
        Mon,  1 Feb 2021 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612168551;
        bh=ilcz+Y93+Mf7nTghLiOjWPXwwhl95bx/s+peEzSWKhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y/H4yDOlpzc3ne26W/3rDyyoc5TInPhvnlsXg/kOq7cyDe0gRC80Nqyy5psalI7Bo
         TnLFth/7m/05UcbszRWtU5VHSrPRXhnVvk07Vu8hT9uMZgjGISQWY5ZY6Xtc6tA1lB
         sP5sjyts3Sjw/FHwBu7ARkcmPSvcWln9S278OZoGBMRKTAMCIcAhmnrO0O25dzSaUe
         2M9IMeh6si5ZNLaZ2JUIi+NQxlAjAC/jHCReUE3aFBSZkBOZonqJMtoynekuq4nyrr
         BJ0II99x/V6qltZG3+4c6qkxKUr5RSXUicqmQMzl+vqW1tHG7xszjL3jv912ku0bNG
         /mu4b7IwNLMZQ==
Received: by mail-oo1-f48.google.com with SMTP id x19so1837776ooj.10;
        Mon, 01 Feb 2021 00:35:50 -0800 (PST)
X-Gm-Message-State: AOAM533KGyVsrGvxpqdquSdet85EMBi/VJm5ZBKUMqEPjba3urFe2g/F
        gXt4DGhToHsg7AFbx0wTcaI7fwgpjecUjSMuYZg=
X-Google-Smtp-Source: ABdhPJw7lE4N5wH61oRsCsUfQmU+7L3U6dLpYzx3owjee4udNggzGx9IxfJCK5hIGvqy+5KzGIKKE+YkIghohrR/fiw=
X-Received: by 2002:a4a:88c9:: with SMTP id q9mr11434202ooh.26.1612168549883;
 Mon, 01 Feb 2021 00:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20210201033601.1642-1-thunder.leizhen@huawei.com> <20210201033601.1642-3-thunder.leizhen@huawei.com>
In-Reply-To: <20210201033601.1642-3-thunder.leizhen@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 1 Feb 2021 09:35:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a142CkJ0kOD6mK+H-E2NrKZ6Ec-aYasddAUmAhTWhrjcA@mail.gmail.com>
Message-ID: <CAK8P3a142CkJ0kOD6mK+H-E2NrKZ6Ec-aYasddAUmAhTWhrjcA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] ARM: hisi: add support for Kunpeng50x SoC
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 4:35 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Enable support for the Hisilicon Kunpeng506 and Kunpeng509 SoC.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Russell, do you have a preference for how to get this series merged
after the last comments are resolved?

I think there is no technical problem in having patch two merged through
the soc tree, while merging the other three through your tree, but it
seems more logical to keep all four together in either location.

       Arnd
