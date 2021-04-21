Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90433671A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbhDURoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243048AbhDURox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:44:53 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:44:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso37757161otb.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/BXgNj41Emp91IJeL0ZlkH3BYkvRGM2ZK7KMf3kiC2k=;
        b=h/C+48D3PWUs4Qa4ZPOAwY8TrqzbXXo7UVZV6OX3mmtt9fcljbqJW+5YzG9/DdCXPm
         hydSzJb6OP7nm+xP0El44tu2I3HBS5C9MXDNIrCx4uuvwluUwms2cNg94g/f+AWCs7fQ
         Q7T68Kx16FRshI4fuDH5e4RKj1+CkkeUKlJOAw297TuRdyZs8uzgoD4XWN3OyAyBdUJH
         3C2j5ojCgzwG6Z/5FCmNX7fv2ftms+ppXIEKE7ekqZXfs34nHv6vrQvNLXXXTO6jkBwM
         3+syuou8IO7MyN9zbrI+jGgiacAx/t5fh9uPXXTpeg8+oUeCuw7wpe0z7SbYiQY9QDvf
         8CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/BXgNj41Emp91IJeL0ZlkH3BYkvRGM2ZK7KMf3kiC2k=;
        b=SyOCIQnOz9iUAQNafOg5AbFuncuBI3RIRiDoprfAEBC++gjdVUdI2tpl1ZL/wSwWIm
         35jy0nPgvjTG5PviPD66UvsXTbC4xI5OuzWGRhPnUnHyy5hzyZfADSBY/um+95lO5R1R
         J4inIt4Ts6qtKJ41DnpjresGxheWMXOeL7uOVxZPXNQgl+TPKjOHLJeV49aisVW+X+m2
         yXCQ+IYmVpZ63cQU8OGHRbSmyHFTngLBujRArc15UleVsbjCWuRKOlGqRJbZJX4uSKK/
         Cg4E7SmEBb78JI5Q0M/sBDbG8L4nPlBHR/uQ7m2EgTHI84dGFDNfkKIvt5lxiq/Pe8Bh
         ZpSw==
X-Gm-Message-State: AOAM531C+gYVnFLS0vihT3nkCwzSzwTK1kGek8w+Q2SpXV5RRcmo0RSF
        s2UT1jE/dWkeXu4jDMfnKVBDeA==
X-Google-Smtp-Source: ABdhPJwN8IraGxuBnTNo7hsiM2YWM0ZjJ0I5M+X9SqgmTNPLdHgCZxVQJHgAT0mNWcp454SgFLSGCQ==
X-Received: by 2002:a9d:7342:: with SMTP id l2mr24289310otk.175.1619027060206;
        Wed, 21 Apr 2021 10:44:20 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t3sm59071ooa.18.2021.04.21.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:44:19 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:44:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 16/26] serial: msm_serial: drop low-latency workaround
Message-ID: <20210421174417.GA1908499@yoga>
References: <20210421095509.3024-1-johan@kernel.org>
 <20210421095509.3024-17-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421095509.3024-17-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Apr 04:54 CDT 2021, Johan Hovold wrote:

> Commit f77232dab25b ("tty: serial: msm: drop uart_port->lock before
> calling tty_flip_buffer_push()") claimed to address a locking
> issue but only provided a dubious lockdep splat from an unrelated
> driver, which in the end turned out to be due a broken local change
> carried by the author.
> 
> Unfortunately these patches were merged before the issue had been
> analysed properly so the commit messages makes no sense whatsoever.
> 
> The real issue was first seen on RT which at the time effectively always
> set the low_latency flag for all serial drivers by patching
> tty_flip_buffer_push(). This in turn revealed that many drivers did not
> handle the infamous low_latency behaviour which meant that data was
> pushed immediately to the line discipline instead of being deferred to a
> work queue.
> 
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks
> around.
> 
> Link: https://lore.kernel.org/linux-serial/cover.1376923198.git.viresh.kumar@linaro.org/
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/msm_serial.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 770c182e2208..fcef7a961430 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -757,9 +757,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
>  		count -= r_count;
>  	}
>  
> -	spin_unlock(&port->lock);
>  	tty_flip_buffer_push(tport);
> -	spin_lock(&port->lock);
>  
>  	if (misr & (UART_IMR_RXSTALE))
>  		msm_write(port, UART_CR_CMD_RESET_STALE_INT, UART_CR);
> @@ -819,9 +817,7 @@ static void msm_handle_rx(struct uart_port *port)
>  			tty_insert_flip_char(tport, c, flag);
>  	}
>  
> -	spin_unlock(&port->lock);
>  	tty_flip_buffer_push(tport);
> -	spin_lock(&port->lock);
>  }
>  
>  static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
> -- 
> 2.26.3
> 
