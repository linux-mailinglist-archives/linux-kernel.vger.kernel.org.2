Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8C35C706
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhDLNIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241676AbhDLNIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:08:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A16F6128A;
        Mon, 12 Apr 2021 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618232900;
        bh=+gF3uqIXavl3hMrOghe8B0SiT2ksN2Qd1LhyosV53go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbwiRoVspb29bqg8e/3ppeaDXykbxSHRBpjaDlHedmqky9OuVKYGfU3+c3qEwtQB/
         gpUXRcx61QcRWRRWz6EQn60j5b8JdfYghszN3CX+xsEUD87zvoc1XuW4mdE94mZaZu
         cqwjVI6U3iAtRxfTarN0XoPpYuCuqoBSOJF0qZMbjdatOwk3YvIjvbG2UsqzPdKN5a
         kxAO92d66Rh2P7xnc3H6e/3RHYmjSODNglm9AvxdeWgmwEvbiFh0dBzqUq4t57O6JI
         JLSvw906nSA5ARIIwKaXsM7XGBcp2so24ZzU+aT40aE+14K9lx/w3CD5ZjEzPZ6tYQ
         u+9JefcIQGTyA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVwIY-00028W-Bh; Mon, 12 Apr 2021 15:08:14 +0200
Date:   Mon, 12 Apr 2021 15:08:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        lkp@intel.com, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Gerald Baeza <gerald.baeza@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>
Subject: Re: [PATCH v2] serial: stm32: optimize spin lock usage
Message-ID: <YHRGPpQ03XgBMkiy@hovoldconsulting.com>
References: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618219898-4600-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 05:31:38PM +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> To avoid potential deadlock in spin_lock usage, use spin_lock_irqsave,
> spin_trylock_irqsave(), spin_unlock_irqrestore() in process context.

This doesn't make much sense as console_write can be called in any
context. And where's the deadlock you claim to be fixing here?
 
> remove unused local_irq_save/restore call.
> 
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Gerald Baeza <gerald.baeza@foss.st.com>
> Cc: Erwan Le Ray <erwan.leray@foss.st.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> v2: remove unused code from stm32_usart_threaded_interrupt() according from
>     Greg's review.
> 
>  drivers/tty/serial/stm32-usart.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index b3675cf25a69..b1ba5e36e36e 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -1354,13 +1354,12 @@ static void stm32_usart_console_write(struct console *co, const char *s,
>  	u32 old_cr1, new_cr1;
>  	int locked = 1;
>  
> -	local_irq_save(flags);
>  	if (port->sysrq)
>  		locked = 0;
>  	else if (oops_in_progress)
> -		locked = spin_trylock(&port->lock);
> +		locked = spin_trylock_irqsave(&port->lock, flags);
>  	else
> -		spin_lock(&port->lock);
> +		spin_lock_irqsave(&port->lock, flags);
>  
>  	/* Save and disable interrupts, enable the transmitter */
>  	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
> @@ -1374,8 +1373,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
>  	writel_relaxed(old_cr1, port->membase + ofs->cr1);
>  
>  	if (locked)
> -		spin_unlock(&port->lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&port->lock, flags);
>  }
>  
>  static int stm32_usart_console_setup(struct console *co, char *options)

Johan
