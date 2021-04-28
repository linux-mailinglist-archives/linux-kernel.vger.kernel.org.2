Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6015436D1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhD1GDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1GDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:03:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0698661418;
        Wed, 28 Apr 2021 06:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619589757;
        bh=kcmuxZ34uqFq9GE4wl1DeJi7Sr/MXOr2RMW9KsnXcO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=14k/rnzNJJQirnoXmYWMShKRg/Sl+/mlALFp1YTiZOXhvYTggB8fs6R9VQR8aO18N
         9tPACnJTRuxqXQkwiB12z3Ro5E9SvSHFrN99Z678aQyjwHjLuScz2s880MmkQRelZq
         jIXGZUFJmE7aznFHzAGMNGb1qGia6witd6nGCLiQ=
Date:   Wed, 28 Apr 2021 08:02:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ashish Kalra <eashishkalra@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: silence incorrect type in argument
 1 (different address spaces)
Message-ID: <YIj6dw5afJ1bBYWK@kroah.com>
References: <20210427165844.GA35857@ashish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427165844.GA35857@ashish>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:58:44PM +0000, Ashish Kalra wrote:
> Corrected data type for variable data adding __user to make it cleaner and silence the Sparse warning. This is version 2 of patch, version 1 can be found at https://lore.kernel.org/linux-staging/20210420090142.GA4086@ashish-NUC8i5BEH/
> 
> Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
> ---
> 
> Changes from v1: removed type casting of (void __user *) for req->data and corrected type for data to include __user

Did you send this twice?

And please wrap your changelog text and put proper information in it,
not references to previous patches.

thanks,

greg k-h
