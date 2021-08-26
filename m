Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542EF3F84FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbhHZKEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233880AbhHZKEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:04:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B46460FDA;
        Thu, 26 Aug 2021 10:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629972241;
        bh=lJsmHi+w1ViexqMynoQ/cMzxko90hLvycjVlB1fVtVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCxRB6tiVCwPOvLP4817NkN58ursGzpnuf2PTUuiffWyKw5aZgBc8UjheTpygXi10
         smPk+t2wHV+Q8NSYQVMMWy6mN5QkNrtJx/p3LR+WLht5qtUkVF1YSnzWxREYunlWVQ
         gOWZFEdkPOTBfskZ/AoyShPRK2lo4+GyhJ9Wr/5k=
Date:   Thu, 26 Aug 2021 12:03:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: rtl8723bs: remove sdio_write_mem()
Message-ID: <YSdnDBH7Er7nLr+d@kroah.com>
References: <20210821235456.2502681-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821235456.2502681-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 11:55:05PM +0000, Bryan Brattlof wrote:
> The sdio_write_mem() function is unused in the driver. We can remove it.
> 

How do we know it is unused?

Please remove the pointer as well, at the same time, so that we can
obviously see that it is unused (or not).

Same for the other patches in this series.

Also, when you resend this, please use git send-email properly, so that
the patches are threaded so our tools can pick them up easier.  This
series was not threaded for some odd reason.

thanks,

greg k-h
