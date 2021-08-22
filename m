Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0103F3F8C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhHVNsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:48:19 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:60957 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhHVNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:48:18 -0400
Date:   Sun, 22 Aug 2021 13:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1629640056;
        bh=rC8QqqVgLGHNgSOqRi7D47ap4bOojabP0Kp2f7scnBU=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=AeSy77lxSNttZGiBN8ijKitnp5m96t+DfTJsdebI+Uwp8BEMhorUz2NSyzyJ0P7VA
         kfx9mBPKfgiokXn+kXuwyJESekOJ5//cVdQvH3SkOsc1nk9P2vUGUMkCHxSWpqGYp4
         5mcQv3BdL/nHEcTExy72aBW9nJaSlggxQ+FLK7gdbBIVymvKwBLOXGQUiARQpYlt/R
         rbgLRWKE0MAGFbsXdxjoijsT5ViUmg7PfK+ymxQaBJ1ElfYrEsUzLiapSSdFJzQSAf
         9XypiNo7WG1X15MYddgx1zYdnvTSSvk+9CaznjdhVkHWYBvSnkFgmMdhb/oslDNY2j
         5xCcurWTM4xdQ==
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH 3/6] staging: rtl8723bs: remove sdio_read_mem()
Message-ID: <20210822134723.cuzzogvujokqiw3l@h510>
In-Reply-To: <2537053.yL3VPc0Jk4@localhost.localdomain>
References: <20210821235456.2502681-3-hello@bryanbrattlof.com> <2537053.yL3VPc0Jk4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2021 08:25, Fabio M. De Francesco wrote:
> On Sunday, August 22, 2021 1:55:29 AM CEST Bryan Brattlof wrote:
> > The sdio_read_mem() function is unused. We can remove it.
> >
> > Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> > ---
> >  drivers/staging/rtl8723bs/hal/sdio_ops.c   | 11 -----------
> >  drivers/staging/rtl8723bs/include/rtw_io.h |  2 --
> >  2 files changed, 13 deletions(-)
>
> This change adds a build warning, which is not allowed.
>
> Please merge this, and the 4/6 patch into a single change, so that it
> all is removed together, causing no build warnings at any point in time.
>

Will do.

Thanks for the review, Fabio!
~Bryan

>
> thanks,
>
> Fabio
>
>
>

