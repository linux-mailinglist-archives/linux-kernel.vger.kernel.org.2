Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20A415C44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbhIWKvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:51:24 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:40949 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240407AbhIWKvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:51:23 -0400
Date:   Thu, 23 Sep 2021 12:49:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1632394189;
        bh=qjdeXlozuivPeR0eioe8PmC1RMurpCpfF51tRU3+QM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8pmoguZ5rt6w13+fKgEO/8PREU8+OdNS6URzNpfyT+Kup/dnjTmmsm7JbT+FiTFQ
         AO/poVTmHKqo7+aRLtgCJ+A4M20fnLVuN7Ze+iMvj6rRMVIwnJdjfkyyv6x03UJBHG
         c8A+TqBeqqzfFEoWKAnIU4gXkGv83K7gjvJ49HSc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <4bb3051e-2550-43c3-afed-d4b00850126e@t-8ch.de>
References: <20210907124751.6404-1-linux@weissschuh.net>
 <YUxNczBccLQeQGA5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUxNczBccLQeQGA5@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-23T10:48+0100, Lee Jones wrote:
> On Tue, 07 Sep 2021, Thomas Weißschuh wrote:
> 
> > backlight.h documents "struct backlight_ops->get_brightness()" to return
> > a negative errno on failure.
> > So far these errors have not been handled in the backlight core.
> > This leads to negative values being exposed through sysfs although only
> > positive values are documented to be reported.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > 
> > v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/
> > 
> > v1 -> v2:
> > * use dev_err() instead of dev_warn() (Daniel Thompson)
> > * Finish logging format string with newline (Daniel Thompson)
> > * Log errno via dedicated error pointer format (Daniel Thompson)
> > 
> >  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> Applied, thanks.

Hi Lee,

thanks!

Also I'm sorry about my nagging before.
I was not aware you were on vacation and saw you respond to other mails.

Thomas
