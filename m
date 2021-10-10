Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D1A428166
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhJJMzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 08:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231833AbhJJMzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 08:55:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D14461076;
        Sun, 10 Oct 2021 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633870397;
        bh=+pgBpB9wb063kQqiFxmCI5i/gjopKf7QgGd8mf4fb6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7F2CoxyJkoJHhHtAEmjMG4dfnsmrk5szA3G3CAEBtvIhPGEv+Q66FHza+oevpGRZ
         OeEkwIzJ+OUKkIWuD+Zq/uuxQKcJX6nOJOYbhjBvsV8C45T14H5GxrrOBYynk1UUUD
         IWiRRX8dFWLXdKuysK6R7m7jdjb8l7p0MCdfyVl0=
Date:   Sun, 10 Oct 2021 14:53:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fix camelcase in byLocalID
Message-ID: <YWLiOUbdBEJcq2u3@kroah.com>
References: <20211008174512.36617-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008174512.36617-1-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 07:44:57PM +0200, Tommaso Merciai wrote:
> Replace camel case variable name for variable byLocalID
> with snake case equivalent.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/staging/vt6655/baseband.c    | 2 +-
>  drivers/staging/vt6655/card.c        | 2 +-
>  drivers/staging/vt6655/channel.c     | 2 +-
>  drivers/staging/vt6655/device.h      | 2 +-
>  drivers/staging/vt6655/device_main.c | 6 +++---
>  drivers/staging/vt6655/dpc.c         | 2 +-
>  drivers/staging/vt6655/key.c         | 2 +-
>  drivers/staging/vt6655/mac.c         | 4 ++--
>  drivers/staging/vt6655/mac.h         | 2 +-
>  drivers/staging/vt6655/rxtx.c        | 2 +-
>  10 files changed, 13 insertions(+), 13 deletions(-)

Does not apply on top of your other patch series :(

Can you rebase and resend?

thanks,

greg k-h
