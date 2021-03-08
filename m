Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D3F33160D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhCHS27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCHS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:28:36 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19BEC06174A;
        Mon,  8 Mar 2021 10:28:35 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id s23so2419460oot.12;
        Mon, 08 Mar 2021 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LuIwvzCUDfZloulb9ocbHPnHSCwuY4CM3xU1xu7OT9g=;
        b=cBdatRzYegoLFGRAypIr96ZtOJY/j9o0pISpnfLUMAL6SdelYsQis1+hqNsdH//wCX
         z9lUOogJTagR4lcx95g8SMQzQUU7gg1teq613sOjES6Q9oX7yO5tY8T/Rq3cMlXDLwRP
         aLq1L5DH2Vpn5GCtmfaMIqXQWUY8p+nhyFyYak7YgCFfkP6ocvuQ9/Zblaj8QcVfhp3y
         /rqs0KX+ZHP3bnQ+wz5d6dEz26SN6UbXCpjWGAtaAdxw7GBqPhKX80BTVyBC50gsmnJt
         lfe4jD+3ABoYFJF2CdbzaU1WOoTLJ+OnVWn7agCiBoaBdYB5TN0Tgb2pyC0o/DFkimdm
         JfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LuIwvzCUDfZloulb9ocbHPnHSCwuY4CM3xU1xu7OT9g=;
        b=VBJJXIDbTZe5whAy8qGsclS4s9qhJv3Ohy5D2l704VUwx5ZorDbMmGocmy7xEAR6iL
         wES0VWIPjfwE+S5JkdQkER60Deq0SauRY94gPhQlsKApC/rDt0XRhUZYS5dTdfs5HKSK
         REWNqqXbNhsvxX9CmnwzGjKO628GP1xmCiZmH8ytBhD8GWX7FpIuHPMxwJkBxhY287bE
         hEwR1DEDxWdZuPtEKGBGacGF0qjpkyhW2T43MBSTy/SspIZf9mlX+OzB81Pn57XETiZv
         a8n3BQ+9WkF3Oe5Zzf08/WJv8/DQZqpivIAtGBKHXS4oCzw/w5o1h/IOSH7Xe6NIEeJa
         I+zw==
X-Gm-Message-State: AOAM532oypplou9u94yC/U+AlRUQx9Q9fI8ZZ4U/ZSrH3eROudzpCd5H
        3tVijHrqphOstonUu8QexuD5T32WBWU=
X-Google-Smtp-Source: ABdhPJzfqswAcmhcg6S2dO2+QLvfetrYsQhPLHru3DIfZDpCvwpXSesaMQGmRQQk9d8N5+xNErgwmg==
X-Received: by 2002:a4a:ca94:: with SMTP id x20mr19600559ooq.86.1615228115287;
        Mon, 08 Mar 2021 10:28:35 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13sm2458154ooo.45.2021.03.08.10.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Mar 2021 10:28:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 Mar 2021 10:28:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: turn tcpm_ams_finish into void
 function
Message-ID: <20210308182833.GB225316@roeck-us.net>
References: <1615185330-118246-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615185330-118246-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 02:35:30PM +0800, Yang Li wrote:
> This function always return '0' and no callers use the return value.
> So make it a void function.
> 
> This eliminates the following coccicheck warning:
> ./drivers/usb/typec/tcpm/tcpm.c:778:5-8: Unneeded variable: "ret".
> Return "0" on line 794
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Change in v2:
> -remove the unnecessary return statement
> 
>  drivers/usb/typec/tcpm/tcpm.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index be0b646..8159229 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -773,10 +773,8 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
>  	return TYPEC_CC_RP_DEF;
>  }
>  
> -static int tcpm_ams_finish(struct tcpm_port *port)
> +static void tcpm_ams_finish(struct tcpm_port *port)
>  {
> -	int ret = 0;
> -
>  	tcpm_log(port, "AMS %s finished", tcpm_ams_str[port->ams]);
>  
>  	if (port->pd_capable && port->pwr_role == TYPEC_SOURCE) {
> @@ -790,8 +788,6 @@ static int tcpm_ams_finish(struct tcpm_port *port)
>  
>  	port->in_ams = false;
>  	port->ams = NONE_AMS;
> -
> -	return ret;
>  }
>  
>  static int tcpm_pd_transmit(struct tcpm_port *port,
> -- 
> 1.8.3.1
> 
