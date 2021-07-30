Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3913DB95B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhG3Ncp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhG3Nco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:32:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D78C60F4A;
        Fri, 30 Jul 2021 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627651958;
        bh=//8EMTGFQ3PsCVJ81sYjLhSRQwEHnCX3gMHEDdNpyF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+huX1v/9z7Ir1aZYG0MK+RpWoGVPv3NU1T7RSMq71gSuh9sdV/NuDMiCHUiO9q4d
         rIL27Y5G2NU6NAaBwiqEhAPi8Z76H1V0bhRs9NMldILzP6/TWwuGqVO7ej/JUbHKns
         FsLOSOZ31VqJfRS0eXVNfzOVWs1VWxhvYNUk9438=
Date:   Fri, 30 Jul 2021 15:32:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] staging: rtl8723bs: remove unused BIT macros definitions
Message-ID: <YQP/dFZJiEcOb3yH@kroah.com>
References: <20210730132103.4996-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730132103.4996-1-fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:21:03PM +0200, Fabio Aiuto wrote:
> BIT(x) macro used all over the driver is defined in
> include/vsdo/bit.h as
> 
> - #define BIT(nr)	(UL(1) << (nr))
> 
> which is safer than the local BIT macros declared.
> Local macros shift a signed integer which brings
> unespected results. For example:
> 
> (unsigned long)(1 << 31) => 0xffffffff80000000
> 
> shift.c:
> 
> int main() {
>         printf("%lx\n", (unsigned long)(1 << 31));
>         printf("%lx\n", (unsigned long)(1U << 31));
>         return 0;
> }
> ---
> 
> $ ./shift
> ffffffff80000000
> 80000000
> ---

Don't put "---" in a changelog text, otherwise the signed-off-by will be
cut off.  Can you resend it with that changed to something else like
"---------------" or anything else?

thanks,

greg k-h
