Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D554940F742
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344457AbhIQMJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344223AbhIQMJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:09:24 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B28C061766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:08:02 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t189so1141623oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mo3MsrLCcjToOoLfdaQWqfyZQZEDPCzIEFNbjqcQs+Q=;
        b=mjUagJvbPFE45FZHD4ly0abxpm6/5TRIhDk4onLcHETeRwsI3xUCap/4QlUr7JECVF
         lR38Eh7I84nDyANaGgmoxoAqolr6T/Zrd3HyKPYk3sOoQ+3X8zw1ZRDNmVGLtI44VGpL
         NR5aLy1DdBDh50Q0TVGEVqROsNy29MbSHEtfp4igqXWTzO6ItJLG5iBmp8RBMQ4gt452
         NfOEn9CtA5GK3YA24ndIgatLdzQxzLNK9RjdoSgrwvM34/9ZO0c3n3tFXgdWLsSfM+y0
         UItu4zDzOhkZFgzDwMlJxYcaWiTAlUyv9V7neysA/E2VeWfxl+ae+aHRd38oho9dEFdW
         A4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Mo3MsrLCcjToOoLfdaQWqfyZQZEDPCzIEFNbjqcQs+Q=;
        b=mhbpLESuooBQlkwSXai1g7eLtMZmghVoeFiZ1gewsqWnUi9zQuTN/TLMptWITOzJcg
         Q/ytfG2xtjZ8IeO/SQclGRWZviZiqKFronXqZlGepy2j2yrQKj99ZOUrDtWCTjjiTYeu
         LowPIXf10v3GCF8UrmU1s8Q1PsWtLWZXSiFr5l+SIFgVO4kcKbNpeLcNx5G6WaMNP5qw
         YswmjgdIuMv8WtNBhs9B/E5CTUahgHL6h2jUKMVtA4NB1GSWQzXe2cQFZuyMxiNeNGEI
         afDj7XdPzRQF+d01QFZ2qmACakSqChAgQvTjDF3iDxf1K95Z28gbYSUbLPzbkGXWP78y
         TVAg==
X-Gm-Message-State: AOAM531BpCw1vJNzI8ZK7J5Q2aPdpK9ChSsf1j4ofFAeWX7aqdwtTjAi
        lQmYoeduSLfixtOxEWuOdg==
X-Google-Smtp-Source: ABdhPJwoP4LpTWp+dj4c7VONoQhqJgCtQvn4f4dFLcA4kW/jHmmpvKW8XomK7yn8LZK/P+GoTOvJHg==
X-Received: by 2002:a05:6808:95:: with SMTP id s21mr3881492oic.80.1631880481515;
        Fri, 17 Sep 2021 05:08:01 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id k23sm1401001ood.12.2021.09.17.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 05:08:00 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:2dd4:10f2:4a03:3baa])
        by serve.minyard.net (Postfix) with ESMTPSA id 5C54B18000C;
        Fri, 17 Sep 2021 12:07:59 +0000 (UTC)
Date:   Fri, 17 Sep 2021 07:07:58 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Anton Lundin <glance@acc.umu.se>
Cc:     openipmi-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Issue with panic handling and ipmi
Message-ID: <20210917120758.GA545073@minyard.net>
Reply-To: minyard@acm.org
References: <20210916145300.GD108031@montezuma.acc.umu.se>
 <20210916163945.GY545073@minyard.net>
 <20210917101419.GE108031@montezuma.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917101419.GE108031@montezuma.acc.umu.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 12:14:19PM +0200, Anton Lundin wrote:
> On 16 September, 2021 - Corey Minyard wrote:
> 
> > On Thu, Sep 16, 2021 at 04:53:00PM +0200, Anton Lundin wrote:
> > > Hi.
> > > 
> > > I've just done a upgrade of the kernel we're using in a product from
> > > 4.19 to 5.10 and I noted a issue.
> > > 
> > > It started that with that we didn't get panic and oops dumps in our erst
> > > backed pstore, and when debugging that I noted that the reboot on panic
> > > timer didn't work either.
> > > 
> > > I've bisected it down to 2033f6858970 ("ipmi: Free receive messages when
> > > in an oops").
> > 
> > Hmm.  Unfortunately removing that will break other things.  Can you try
> > the following patch?  It's a good idea, in general, to do as little as
> > possible in the panic path, this should cover a multitude of issues.
> > 
> > Thanks for the report.
> > 
> 
> I'm sorry to report that the patch didn't solve the issue, and the
> machine locked up in the panic path as before.

I missed something.  Can you try the following?  If this doesn't work,
I'm going to have to figure out how to reproduce this.

Thanks,

-corey

commit f253c87772b65e2a5971e82dc81ee63d6e9848cf
Author: Corey Minyard <cminyard@mvista.com>
Date:   Thu Sep 16 11:36:20 2021 -0500

    ipmi: Disable some operations during a panic

    Don't do kfree or other risky things when oops_in_progress is set.

    Reported-by: Anton Lundin <glance@acc.umu.se>
    Fixes: 2033f6858970 ("ipmi: Free receive messages when in an oops")
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
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index e4ff3b50de7f..7f71471c7a46 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -342,13 +342,17 @@ static atomic_t msg_tofree = ATOMIC_INIT(0);
 static DECLARE_COMPLETION(msg_wait);
 static void msg_free_smi(struct ipmi_smi_msg *msg)
 {
-	if (atomic_dec_and_test(&msg_tofree))
-		complete(&msg_wait);
+	if (atomic_dec_and_test(&msg_tofree)) {
+		if (!oops_in_progress)
+			complete(&msg_wait);
+	}
 }
 static void msg_free_recv(struct ipmi_recv_msg *msg)
 {
-	if (atomic_dec_and_test(&msg_tofree))
-		complete(&msg_wait);
+	if (atomic_dec_and_test(&msg_tofree)) {
+		if (!oops_in_progress)
+			complete(&msg_wait);
+	}
 }
 static struct ipmi_smi_msg smi_msg = {
 	.done = msg_free_smi
@@ -434,8 +438,10 @@ static int _ipmi_set_timeout(int do_heartbeat)
 	rv = __ipmi_set_timeout(&smi_msg,
 				&recv_msg,
 				&send_heartbeat_now);
-	if (rv)
+	if (rv) {
+		atomic_set(&msg_tofree, 0);
 		return rv;
+	}

 	wait_for_completion(&msg_wait);

@@ -580,6 +586,7 @@ static int __ipmi_heartbeat(void)
 				      &recv_msg,
 				      1);
 	if (rv) {
+		atomic_set(&msg_tofree, 0);
 		pr_warn("heartbeat send failure: %d\n", rv);
 		return rv;
 	}

