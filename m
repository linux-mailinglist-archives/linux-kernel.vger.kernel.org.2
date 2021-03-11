Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92871336D25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhCKHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhCKHdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:33:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05DDA64FA6;
        Thu, 11 Mar 2021 07:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615448025;
        bh=7dTehs9P2eSp8sPbhZSelcrxKBy+711FsOPQ49ldA2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQrojNVlTFN7S2w7V6r70oZ6JR7PULc6szKdgpvs5dN2lZT1ILTgl2y4wcW2Eiw5z
         T+OoyGSB4CaFAkvbVt9MfHkp/VVSEYzfSsF51gsA4ffmBakBn2BJgewmLidaee8pul
         j8C3XGKtcv2fvkenUfOl8nPfLi1clTc7ePLBcBaU=
Date:   Thu, 11 Mar 2021 08:33:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Li <dualli@chromium.org>
Cc:     dualli@google.com, tkjos@google.com, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v1 1/3] binder: BINDER_FREEZE ioctl
Message-ID: <YEnH1qd527g/neY4@kroah.com>
References: <20210310225251.2577580-1-dualli@chromium.org>
 <20210310225251.2577580-2-dualli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310225251.2577580-2-dualli@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:52:49PM -0800, Li Li wrote:
>  	if (target_proc) {
>  		binder_inner_proc_lock(target_proc);
> +		target_proc->outstanding_txns--;
> +		WARN_ON(target_proc->outstanding_txns < 0);

WARN_* is a huge crutch, please just handle stuff like this properly and
if you really need to, warn userspace (but what can they do about it?)

You also just rebooted all systems that have panic-on-warn set, so if
this can be triggered by userspace, you caused a DoS of things :(

So please remove all of the WARN_ON() you add in this patch series to
properly handle the error conditions and deal with them correctly.

And if these were here just for debugging, hopefully the code works
properly now and you do not need debugging anymore so they can all just
be dropped.

thanks,

greg k-h
