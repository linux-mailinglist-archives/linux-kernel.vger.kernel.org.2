Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE789334265
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhCJQEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232821AbhCJQEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:04:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9311964EFC;
        Wed, 10 Mar 2021 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615392260;
        bh=R3nAU4oVFrRwftJI5JeDSFqVV4m8k4B7Lvbt1v2OarE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOEVCC5QgsCOXP3AnAXgwYzvpFav7dN7o4G9iuNgYWNG4CteV01kAdYe8b1xNW6Gb
         LR2W/31F29lkIQFxPatQy3Kq/BahHPGxtsS3HYuNI0aLkpEXbHZhadJsF6lmJfuauy
         O+Up51d83JDGOKt56vFQ/PPnutq9/UwUj12pjYq4=
Date:   Wed, 10 Mar 2021 17:04:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mahak Gupta <gmahak1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Match alignment with open parenthesis
Message-ID: <YEjuAbShCtldatvT@kroah.com>
References: <20210221234409.11627-1-gmahak1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221234409.11627-1-gmahak1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 05:14:09AM +0530, Mahak Gupta wrote:
> This patches fixes the checks- 'Alignment should match open parenthesis'
> of 'checkpatch.pl'.
> 
> Signed-off-by: Mahak Gupta <gmahak1@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 32 +++++++++++++------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

This got lost as you didn't put the subsystem on the subject line :(

Please resend with "staging: " as a prefix on the subject line so our
tools can pick this up properly.

thanks,

greg k-h
