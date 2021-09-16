Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D940E9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhIPSNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347846AbhIPSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:11:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E252C0470ED
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:39:49 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id bi4so9815504oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qy3pOAsrra7KT/ngtb/QFh7afi84SrbV2cOHQJxGstg=;
        b=h/Wj+RXf+luqlt8A5CP0bsUtHT8NqxT8VRlOcVq2tdjCMr//bVYG9NOA6uTE31YvMC
         zoWi3PWFnfgwnzpUo0BzuU1DK45wZIOd/RCxSfOKeGMD8N8zMAWhns0zeb3QZL6RKoK9
         maRg9jM+f+Dil7H/ctPWb9jixsB8SFilbC+sNZBZ04J+z1R6jc3YGyET/sTSWvIye9RW
         7cgyhLeiCxJhI0dl5CLxCNeXLJjBdSppPHSnvc9+AQIpTUur+6C5AOngB392efXib13S
         IqxAb/GFwW1vBxRCtozEmtcqPhuSrJkKl1U1D3m7IzItHroVQ4dS4DZlPOwprnhhTGd+
         M5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Qy3pOAsrra7KT/ngtb/QFh7afi84SrbV2cOHQJxGstg=;
        b=Nl6FZ6eoO5TUWDB6zYzwN+oI20zsWZylGCbf0av/TpAi4jntat79K+n2kVyyDPUyVf
         My6zICaePywGfB4wpIG5jz9JMXSwgp3p3ipR38eEPCOG4irwHkKUcL6s216Izs8VIyy/
         sEpLmWq0Qg4lnnEciwH0kkFYxEeHzKCtxCxvGqD4w1k+/3TfUQ6G7TRcYLVEEFR4eYHN
         5Lk44wtEj0k5t9i/aPdaH3qoXejDrBX1WGkm4OxLTt8oDQl87LcOeqRSpW6ac5LXcBUB
         1Y0ba4BMXNqkgEz6W+WEXLgMo7xGZO1HRHDx/kjXBn11Pb0C8itVpJyCrgB1Bg/AYOEi
         Tfxg==
X-Gm-Message-State: AOAM531PZu1opKTpVPKowYh6wiMzr9WtbuGNaFgSV4OGWVy/gl+HzDTp
        JzHq7IbXpzpSQnr9puN7ag==
X-Google-Smtp-Source: ABdhPJzwncS5iHvX5bxcRrpNe4012zEgfmItpvnAJ4Oo6PfiPrtFGz2pH3WTJzW1phlYCbyJq+Nghg==
X-Received: by 2002:aca:2b05:: with SMTP id i5mr552713oik.55.1631810388587;
        Thu, 16 Sep 2021 09:39:48 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id a11sm803798oiw.36.2021.09.16.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 09:39:47 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:1df5:faca:2d59:6c4c])
        by serve.minyard.net (Postfix) with ESMTPSA id 496E918000C;
        Thu, 16 Sep 2021 16:39:46 +0000 (UTC)
Date:   Thu, 16 Sep 2021 11:39:45 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Anton Lundin <glance@acc.umu.se>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Issue with panic handling and ipmi
Message-ID: <20210916163945.GY545073@minyard.net>
Reply-To: minyard@acm.org
References: <20210916145300.GD108031@montezuma.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916145300.GD108031@montezuma.acc.umu.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:53:00PM +0200, Anton Lundin wrote:
> Hi.
> 
> I've just done a upgrade of the kernel we're using in a product from
> 4.19 to 5.10 and I noted a issue.
> 
> It started that with that we didn't get panic and oops dumps in our erst
> backed pstore, and when debugging that I noted that the reboot on panic
> timer didn't work either.
> 
> I've bisected it down to 2033f6858970 ("ipmi: Free receive messages when
> in an oops").

Hmm.  Unfortunately removing that will break other things.  Can you try
the following patch?  It's a good idea, in general, to do as little as
possible in the panic path, this should cover a multitude of issues.

Thanks for the report.

-corey

> 
> I tested just reverting that and both dumps to pstore and the panic
> reboot timer started working again.
> 
> 
> //Anton

commit e28aa211190b7d3a1135f051f0c30b0195016489
Author: Corey Minyard <cminyard@mvista.com>
Date:   Thu Sep 16 11:36:20 2021 -0500

    ipmi: Disable some operations during a panic

    Don't do kfree or other risky things when oops_in_progress is set.

    Reported-by: Anton Lundin <glance@acc.umu.se>
    Fixes: 2033f6858970 ("ipmi: Free receive messages when > in an oops")
    Signed-off-by: Corey Minyard <cminyard@mvista.com>

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index e96cb5c4f97a..a08f53f208bf 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4789,7 +4789,9 @@ static atomic_t recv_msg_inuse_count = ATOMIC_INIT(0);
 static void free_smi_msg(struct ipmi_smi_msg *msg)
 {
 	atomic_dec(&smi_msg_inuse_count);
-	kfree(msg);
+	/* Try to keep as much stuff out of the panic path as possible. */
+	if (!oops_in_progress)
+		kfree(msg);
 }

 struct ipmi_smi_msg *ipmi_alloc_smi_msg(void)
@@ -4808,7 +4810,9 @@ EXPORT_SYMBOL(ipmi_alloc_smi_msg);
 static void free_recv_msg(struct ipmi_recv_msg *msg)
 {
 	atomic_dec(&recv_msg_inuse_count);
-	kfree(msg);
+	/* Try to keep as much stuff out of the panic path as possible. */
+	if (!oops_in_progress)
+		kfree(msg);
 }

 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void)
@@ -4826,7 +4830,7 @@ static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void)

 void ipmi_free_recv_msg(struct ipmi_recv_msg *msg)
 {
-	if (msg->user)
+	if (msg->user && !oops_in_progress)
 		kref_put(&msg->user->refcount, free_user);
 	msg->done(msg);
 }

