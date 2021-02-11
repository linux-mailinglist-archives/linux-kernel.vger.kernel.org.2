Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D283189DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhBKLxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:53:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230259AbhBKL2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 06:28:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4912D64EAA;
        Thu, 11 Feb 2021 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613042893;
        bh=Qb2FS+uMR5geKIx58CTBh2PFaRklthJkDTlNBlz7hy8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UlQC/3eN92kMP6S03I4Yj6Oxurx73sbgfMc9o0CLW5UjW1K39Fkd7aOmh3Hnh215S
         pOfLqxx0ZJtBIW1yZZIKSZeiPHnWLJTPJavfjyO/lL1yxDe2cJXzmU8odj7nsUjzgG
         2gCpFEj2dVKdRyuXOjL0CuJRVf1KQ2vwahRFWRM8Y8jDEedp7KCZ994a6IvvJJry0K
         6nqmUS0Anw70BmjJ0QI2rWyba3ssZDQjAkY1AOZE2r51PpkPj6fDs0w3qZHVPeO3qL
         k5Dit7o7wi+/TA9EumvaqqyUhay3oPVU6geETr6c9jEmrMk13CRvxWshiVhzDfICK5
         I38NljWgK1CLg==
Received: by mail-ot1-f49.google.com with SMTP id y11so4832909otq.1;
        Thu, 11 Feb 2021 03:28:13 -0800 (PST)
X-Gm-Message-State: AOAM532Hsvx8gaDrQKgqhriw0e00gIsjNP2xLdeFHnlWxRR3rTh5U8R2
        qiQYVQpIeVWDKECBxtIJAG+gYIGXm518oNw89Dk=
X-Google-Smtp-Source: ABdhPJyeSKW5265p9gWdhHvA5UhFuudJw9w2RFAsgFsNvscX2Cr2rp9ID2vSPCWC/ONInNjCR4PphKSeu0QrIYRB8H0=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr5472752otf.251.1613042892515;
 Thu, 11 Feb 2021 03:28:12 -0800 (PST)
MIME-Version: 1.0
References: <ac55738da7710848ef4824d45bdac18fa1d11392.1612189714.git.michal.simek@xilinx.com>
In-Reply-To: <ac55738da7710848ef4824d45bdac18fa1d11392.1612189714.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 11 Feb 2021 12:27:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2FU1eNnUB+RWREnAaxjSvkVxhJDkW-pMpHmsK_NpeaGw@mail.gmail.com>
Message-ID: <CAK8P3a2FU1eNnUB+RWREnAaxjSvkVxhJDkW-pMpHmsK_NpeaGw@mail.gmail.com>
Subject: Re: [PATCH] ARM: zynq: Update Copyright date in DTS
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 3:28 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Update years in header to be up2date.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

I saw this in your pull request, and I did not think this was how
copyrights work.

From what I can tell, most of the files have not been touched in
years, so it's surprising that the copyright would include every
year up to 2021.

Would you mind respinning the pull request either without this
patch, or with a clarified patch description that explains
what you do and a Signed-off-by from one of your company's
lawyers if they asked you for it?

       Arnd
