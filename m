Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0131654B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBJLey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhBJLdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:33:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4857164E2F;
        Wed, 10 Feb 2021 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612956739;
        bh=rTGoNBqeHfLvgGxbtm2GkSLr/2PTILgEQN9IKQ1G/AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABmk3S6ctRPwHoK5aNEgAYJ3Cbnuycpi0n3nNDofQgjZxdDkBaIpZ/PT5OLtiDQI7
         usLpPwLf9mMveh1pfqOqM9PNSbWOvAjcDxGgOVgtfQeEGdbvNtaElTCM24kmgKT5n1
         vVUDEzvc0B0RS6HfLIKUaLpVPRW9GJN7afLWqYI8=
Date:   Wed, 10 Feb 2021 12:32:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com
Subject: Re: [PATCH] MAINTAINERS: replace my with email with replacements
Message-ID: <YCPEQY2ZeDlLpCVs@kroah.com>
References: <20210210110116.49955-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210110116.49955-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:01:16PM +0200, Alexandru Ardelean wrote:
> This email will become inactive in a few weeks.
> This change removes it from the MAINTAINERS file and adds the people that
> will be responsible for the parts moving forward.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Now applied, thanks.

greg k-h
