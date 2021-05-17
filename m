Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC59383121
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbhEQOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240017AbhEQO3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:29:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A05EF616ED;
        Mon, 17 May 2021 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621260904;
        bh=UiFMXSRuVmmK2AdeQooSJ00/WD/WTu2bQsu3juWAFvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AH+rpM7lRDsvRy6hN78bapKSTbRFQ00On0HKFsS5K+/6NBDpEn5A7Hp0sWXd0yTvs
         hg59vnRTZeii/H24mf16Pk3JU+bXeZ54mSpxAHbRC7t1ocjoo/5u6CEVtNtK6VhAlR
         PBQdESytERsO/EhkyqWivLo5nzV9JJ5nIb+KEQojqBNasY3NEcWm0uLSrs5p1aYhu5
         mommExuT2XSTbCTC7iCUz5NUg2H19kPkZ15oPTI4p+KdczS1bYS8SKvReKoVTQ0yHH
         qZl9qS/FgvWdUy89AIVHEHrTE/Tez2NPt/w3EcDMqFGieF3yDysS5QyWP2sslOKAY8
         t8R0wMW40VbHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lie1O-0004IP-HI; Mon, 17 May 2021 16:15:03 +0200
Date:   Mon, 17 May 2021 16:15:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH 6/9] tty: hvc_console: Fix coding style issues of block
 comments
Message-ID: <YKJ6ZjT8o5xJmBCr@hovoldconsulting.com>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
 <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 02:37:10PM +0800, Xiaofei Tan wrote:
> Fix coding style issues of block comments, reported by checkpatch.pl.
> Besides, add a period at the end of the sentenses.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/tty/hvc/hvc_console.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 39018e5..a61cdf0 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -177,7 +177,8 @@ static void hvc_console_print(struct console *co, const char *b,
>  			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
>  			if (r <= 0) {
>  				/* throw away characters on error
> -				 * but spin in case of -EAGAIN */
> +				 * but spin in case of -EAGAIN.
> +				 */

How is this an improvement? First, the multi-line comment style is

	/*
	 * ...
	 */

Second, that sentence is not capitalised so why do add a period?

Third, why are you sending checkpatch.pl cleanups for files outside of
staging?

Unless doing some real changes to the files in question as well this is
mostly just churn and noise that makes it harder to backport fixes and
do code forensics for no real gain.

Greg may disagree, but I don't think we should be encouraging this kind
of patches.

Johan
