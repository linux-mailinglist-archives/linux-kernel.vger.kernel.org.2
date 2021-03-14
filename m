Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB32333A340
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 07:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhCNGHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 01:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhCNGGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 01:06:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F325C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 22:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=C0DrpgRbaGF0H7koezbt7fwrKO0dvrh/LGeoVncaaaw=; b=Rya8PpioNcq2XGA5BEIYOmw4mS
        IfdABIHrQVdfQKzrlkVH+T5PH/TRY2kxOXH/6U3RO2RuMvG6Ng8YrVvknEWfUY0NESPjWPXidOSOG
        DdON8Npd2xBpMjI9xVWDCO+O0BUtHMcQnJ9FWO3sEwfI0dXFVwEgeljwTNo8ETcBpC62/PTudqXzY
        MqYGBcl9GDhki7t/Ydd+VSbyKNCCwFg/Txr97zj92TkZJlQUzrsLJg95X4uTbVv/W66eowF4cUskK
        IJqLAA99XCv18amQhyKiSFz2WrsDEOeDreAlOWMwIqnMrT+D4K22bhe6kSjRA5Ev91DuAB+IMf127
        FxOR5NNQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLJtH-001B4H-T8; Sun, 14 Mar 2021 06:06:18 +0000
Subject: Re: [PATCH] tty: vt: Mundane typo fix in the file vt.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, nico@fluxnic.net,
        linux-kernel@vger.kernel.org
References: <20210313233842.12275-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <90e710bb-bebb-311e-0e7d-b2862c090385@infradead.org>
Date:   Sat, 13 Mar 2021 22:06:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313233842.12275-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/21 3:38 PM, Bhaskar Chowdhury wrote:
> 
> s/spurrious/spurious/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 284b07224c55..c29e16505dd9 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4448,7 +4448,7 @@ void poke_blanked_console(void)
>  	might_sleep();
> 
>  	/* This isn't perfectly race free, but a race here would be mostly harmless,
> -	 * at worse, we'll do a spurrious blank and it's unlikely
> +	 * at worse, we'll do a spurious blank and it's unlikely

also:
	   at worst,

>  	 */
>  	del_timer(&console_timer);
>  	blank_timer_expired = 0;
> --
> 2.26.2
> 


-- 
~Randy

