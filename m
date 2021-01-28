Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66330815D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhA1WrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:47:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:48384 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhA1WqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:46:21 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 756CD6173;
        Thu, 28 Jan 2021 22:45:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 756CD6173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611873938; bh=pKlA1wCqIPKqJF4CMFRPlVennY+CpW7wzlpMvVlXI1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XoDWBYQfaxpSOgrZKc7nSVh2UXNLy4CjdCFmSmNlDOkB+NE5/YVEuV+Zd6OGecd8m
         VTAEWi+wXWTfdXwrOS6VQ8QO3JtgjKtK4OryBQZvVre2R8olI5bWN5UbXhLzXvJMUJ
         oGGCGOPUVpEgau+t/igHDW1x0yJCzG+3PPLPjKtmLPj4z843OoclkjqmORPvzMRPnA
         2V5IC/qtAZwL78iVZmcpSHflTXBFiCxYJFI+wvX/6IKaL93kEYvSmI3lGHn8piHJOx
         jgkMNEwQcqTvMwKB305gfas4505XH86QKa+a8Yfl5NjR0lIN9ljriV25UWN6YEayOH
         Qz7nWFRO2rNmg==
Date:   Thu, 28 Jan 2021 15:45:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Eric Curtin <ericcurtin17@gmail.com>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] Update Documentation/admin-guide/sysctl/fs.rst
Message-ID: <20210128154537.2ed50d06@lwn.net>
In-Reply-To: <20210120132648.19046-1-ericcurtin17@gmail.com>
References: <20210120132648.19046-1-ericcurtin17@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 13:26:47 +0000
Eric Curtin <ericcurtin17@gmail.com> wrote:

> max_user_watches for epoll should say 1/25, rather than 1/32
> 
> Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index f48277a0a850..2a501c9ddc55 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -380,5 +380,5 @@ This configuration option sets the maximum number of "watches" that are
>  allowed for each user.
>  Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
>  on a 64bit one.
> -The current default value for  max_user_watches  is the 1/32 of the available
> -low memory, divided for the "watch" cost in bytes.
> +The current default value for  max_user_watches  is the 1/25 (4%) of the
> +available low memory, divided for the "watch" cost in bytes.

That does appear to be the way of it...patch applied, thanks.

jon
