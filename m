Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452E53206AF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 19:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBTSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 13:37:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55548 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:37:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA7CAA2C34;
        Sat, 20 Feb 2021 13:36:41 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=KqoCn39xmNhOTQk46ZqLtsrra/o=; b=wOY6fg
        ksf6XBE7QVSHedfb8nvK1o4kzx0HKpyE25DpMQc5HAsbGfaZE9YvAvSg+Us8MLDo
        8lbDuLHCWAq6q8UAve+DlqLViDNq4/tWa+KwZuj7aNXM+h/QSFVaOcMhQ7fcfHHk
        5SoUve/QO71rkCq3KpxgNbDl4BEOneuhke1VA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C260EA2C32;
        Sat, 20 Feb 2021 13:36:41 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=QKF/B4e6NYtv0pMbTy2WxlqUpmStZjtrrFy73d9SP0k=; b=OyKhZMi8BSfetEFPXSUbqFvLKYXGE7ku4Wy+6ZzROAbpRkhWkp4iWIEdvbnjUkVc2mCvTEFK46DbhFW1xqH92P2gpsEvt4kPdqqETIelK6HvVtKqSFXuhPwBQ/+gblaunie9Q2w1AY1PoVf30j8+qx2/ohzDH3H1vEqmyO2v4Q8=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48157A2C31;
        Sat, 20 Feb 2021 13:36:41 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 597202DA0084;
        Sat, 20 Feb 2021 13:36:40 -0500 (EST)
Date:   Sat, 20 Feb 2021 13:36:40 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        patches@armlinux.org.uk
Subject: Re: [PATCH v3] arm: OABI compat: fix build when EPOLL is not
 enabled
In-Reply-To: <20210220183311.30197-1-rdunlap@infradead.org>
Message-ID: <3391os3-o03p-63sn-5o20-5s23o377998s@syhkavp.arg>
References: <20210220183311.30197-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 93047B32-73AA-11EB-9365-74DE23BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Feb 2021, Randy Dunlap wrote:

> When CONFIG_EPOLL is not set/enabled, sys_oabi-compat.c has build
> errors. Fix these by surrounding them with ifdef CONFIG_EPOLL/endif
> and providing stubs for the "EPOLL is not set" case.
> 
> ../arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_ctl':
> ../arch/arm/kernel/sys_oabi-compat.c:257:6: error: implicit declaration of function 'ep_op_has_event' [-Werror=implicit-function-declaration]
>   257 |  if (ep_op_has_event(op) &&
>       |      ^~~~~~~~~~~~~~~
> ../arch/arm/kernel/sys_oabi-compat.c:264:9: error: implicit declaration of function 'do_epoll_ctl'; did you mean 'sys_epoll_ctl'? [-Werror=implicit-function-declaration]
>   264 |  return do_epoll_ctl(epfd, op, fd, &kernel, false);
>       |         ^~~~~~~~~~~~
> 
> Fixes: c281634c8652 ("ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com> # from an lkp .config file
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: patches@armlinux.org.uk

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
> v2: use correct Fixes: tag (thanks, rmk)
> v3: add patches@ to Cc: list
> 
>  arch/arm/kernel/sys_oabi-compat.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> --- linux-next-20201214.orig/arch/arm/kernel/sys_oabi-compat.c
> +++ linux-next-20201214/arch/arm/kernel/sys_oabi-compat.c
> @@ -248,6 +248,7 @@ struct oabi_epoll_event {
>  	__u64 data;
>  } __attribute__ ((packed,aligned(4)));
>  
> +#ifdef CONFIG_EPOLL
>  asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
>  				   struct oabi_epoll_event __user *event)
>  {
> @@ -298,6 +299,20 @@ asmlinkage long sys_oabi_epoll_wait(int
>  	kfree(kbuf);
>  	return err ? -EFAULT : ret;
>  }
> +#else
> +asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
> +				   struct oabi_epoll_event __user *event)
> +{
> +	return -EINVAL;
> +}
> +
> +asmlinkage long sys_oabi_epoll_wait(int epfd,
> +				    struct oabi_epoll_event __user *events,
> +				    int maxevents, int timeout)
> +{
> +	return -EINVAL;
> +}
> +#endif
>  
>  struct oabi_sembuf {
>  	unsigned short	sem_num;
> 
