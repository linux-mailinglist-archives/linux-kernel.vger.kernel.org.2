Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081E3390B07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhEYVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhEYVH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:07:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 581AC6140F;
        Tue, 25 May 2021 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621976786;
        bh=OUwef6EtHXmnVekXYiaA4JSE4qmt1VGKzGgBd5VR8tQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SNtEYGO5dJbhEHmM2PLqEksXCNkP3QPJLWmzgiNDHIRmRADawxo2tSM/osdPPA8hX
         AFKyDq3nkGw/j3ou02h7TKdMGIarwsVeGev1QA965iWHuqJG0BNpmM+EaboAAlY7l/
         yzj5AG3rMHzO+JnyaZXSnqzzFrFFZwYq05D2EiFFcIZvd2y3bf8ATBxr6PB3FdYWAM
         d6Jk9wbVihFe0w9UWFJLrpe3NMqTgaSWu9U2dce/WP6D4LOMfd+tdjHztI43wyeKD6
         xtYIafiwthyiVXFoIEITz7K8BThH/bJII6FpfevbF6hlF6k66TVLiyXtGqTPx8gAYk
         YjvUO4ak7HVSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 195675C037F; Tue, 25 May 2021 14:06:26 -0700 (PDT)
Date:   Tue, 25 May 2021 14:06:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Haocheng Xie <xiehaocheng.cn@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Fix a typo in Documentation/RCU/stallwarn.rst
Message-ID: <20210525210626.GV4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210525093152.26627-1-xiehaocheng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525093152.26627-1-xiehaocheng.cn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 05:31:52PM +0800, Haocheng Xie wrote:
> Add the missing ')' in the documentation.
> 
> Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>

Good eyes!  Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/stallwarn.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index 7148e9b..a9381e43 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -224,7 +224,7 @@ is the number that had executed since boot at the time that this CPU
>  last noted the beginning of a grace period, which might be the current
>  (stalled) grace period, or it might be some earlier grace period (for
>  example, if the CPU might have been in dyntick-idle mode for an extended
> -time period.  The number after the "/" is the number that have executed
> +time period).  The number after the "/" is the number that have executed
>  since boot until the current time.  If this latter number stays constant
>  across repeated stall-warning messages, it is possible that RCU's softirq
>  handlers are no longer able to execute on this CPU.  This can happen if
> -- 
> 2.9.5
> 
