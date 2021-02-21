Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB37320A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBUNGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:06:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhBUNGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:06:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C0F864E5F;
        Sun, 21 Feb 2021 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613912773;
        bh=XJ3AQNwDKIqBR42LqAlzdvpxb0rywbbMa+0xV7ULKj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kTwjJ+QulLTgXsF3EGaoDkxI79RrK9s2rkk9QQ8xI13dM/broDrXAvfZ5Y5l9gG1O
         ziK4IbZ3+BmMYtq8XJ2ZgD26je/EL6kZPXINbIdbmKVOBI2iPWdMqvJtH1qctbjqwm
         x8jpTpP/LT5o9y9/mbDonebHG5xxRmjz38VELYlg=
Date:   Sun, 21 Feb 2021 14:06:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
Cc:     sfr@canb.auug.org.au, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wimax: i2400m: add space before open
 parenthesis
Message-ID: <YDJaw5p/VM2qhULU@kroah.com>
References: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
 <20210220134652.16127-1-sssraj.sssraj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220134652.16127-1-sssraj.sssraj@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:46:52AM -0800, Rajesh Kumbhakar wrote:
> netdev.c
> 
> fixing style ERROR: space required before the open parenthesis '('
> 
> Signed-off-by: Rajesh Kumbhakar <sssraj.sssraj@gmail.com>
> ---
> Changes in v2:
> 	- Removed filename from commit message.

filename is still in commit message :(

