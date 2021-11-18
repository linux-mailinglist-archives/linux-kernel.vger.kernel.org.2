Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E54456110
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhKRREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbhKRRE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:04:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D41DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:01:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x6so18275943edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bC+nM2ymxmhczmda0Fd8ML7xRCTVqUNeEVu4AX6wCkk=;
        b=XouoDx0BWKNXem6TrrFJ2gnc/ctw6rko1v7/np/oJIPdnmB0oiM7HFQLlzym8yyc+V
         HIJjpm20D22NP0eqryWil8GYdRefCZDrLg94//TN7hxmAHOl/ul4IIX0pGr7+03cytgA
         GFiKmaaCsz1FlwJMjZZy6vb8XUVpfH7TTvfOwTQo8LyGnJOiGh4Nv3UR4fhi2gFEB4fE
         dP3gDc9+W3nf5viGApjHSTwGqSyp+7vE9fhzM+loMFxtDVNTyJreJK2oMTnYwLlu5Ksv
         qsbPpaPqBKSJoH/dvsiGcWGCP6Ob6J1KZE0Lw8XMEATWk0pRgPXJ0QM/tIu0ruz2gvUW
         Ci5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bC+nM2ymxmhczmda0Fd8ML7xRCTVqUNeEVu4AX6wCkk=;
        b=L6EqZUV2VCh22JX3S/yVJois+gTThyfKETx2Vcl+PbmRza40xlHfVR7+wPe2Zkiu3X
         WpO/ojlPxcK0KOrdenK/U7xF198js4LQHFfLc6hnT6Bnvxqm6bGoRHjPphJFl8zMACh0
         WMDYG8ViQunjn0gqhJwLV68nLqxSapjtd4iDKjZQ6KamB70q+OXS5LgNodiXdTeUzVAt
         Fk61YdCWDQ2BtDbEqOJXdps+Z/WsXo4ScoLBvHout5zjhU5ED0vfs3t5WeUsbzsSc/S0
         qrVtThnD7Mz3piQgDbUmPV3JBUvoyx9NoTmxNVXIObyf1I/mL/ct2znmibxUzfCl9jVC
         BNQw==
X-Gm-Message-State: AOAM530HbKUH6p8O8aCFYlbkv1BPEX8/kW5xrRZLX8k2b9Vp8a5dKNVh
        FP8DzH/v/NSE0wPdM7CGR3o=
X-Google-Smtp-Source: ABdhPJzDAUKxgkP/+WG/V8buWdig3jefQfHq1Ep1E3OG5WI392Bbu/sTyXtGkIC0tlvqmsxpNpc7Ug==
X-Received: by 2002:a05:6402:1a58:: with SMTP id bf24mr13369557edb.16.1637254886158;
        Thu, 18 Nov 2021 09:01:26 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id s18sm268086edd.15.2021.11.18.09.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:01:25 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Date:   Thu, 18 Nov 2021 18:01:24 +0100
Message-ID: <1701119.OD4kndUEs1@localhost.localdomain>
In-Reply-To: <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <1825634.Qa45DEmgBM@localhost.localdomain> <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 18, 2021 1:14:59 PM CET Tetsuo Handa wrote:
> On 2021/11/18 18:38, Fabio M. De Francesco wrote:

> If ->flow.lock were held from only schedulable context, replacing this spinlock with
> a mutex would be possible. But stop_tty() says "may be called from any context" which
> means that we can't use a mutex...
> 
> Making do_con_write() no-op when called with IRQs disabled would be the minimal change
> that can silence the syzbot. But this does not fix the regression for drivers/tty/n_hdlc.c
> introduced by f9e053dcfc02b0ad.
> 
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
>  	struct vt_notifier_param param;
>  	bool rescan;
>  
> -	if (in_interrupt())
> +	if (in_interrupt() || irqs_disabled())
>  		return count;
>  
>  	console_lock();
> @@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
>  {
>  	struct vc_data *vc;
>  
> -	if (in_interrupt())	/* from flush_to_ldisc */
> +	if (in_interrupt() || irqs_disabled())	/* from flush_to_ldisc */
>  		return;
>  
>  	/* if we race with con_close(), vt may be null */
>

For what my opinion is worth, I like the solution by Tetsuo that is reported above. 
The bug is real and I suppose that it must be addressed. This seems the most straightforward
and effective way to fix it.

Regards,

Fabio M. De Francesco
 
> According to scripts/get_maintainer.pl , Greg and Jiri are maintainers for the n_hdlc driver.
> Greg and Jiri, what do you think? Is sacrificing ability to write to consoles when
> n_hdlc_send_frames() is called from __start_tty() path considered tolerable? (Maybe
> OK for now and stable kernels, for nobody was reporting this problem suggests that
> nobody depends on this ability.)
> 
> But if we must fix the regression for drivers/tty/n_hdlc.c , we need to use something
> like https://lkml.kernel.org/r/7d851c88-f657-dfd8-34ab-4891ac6388dc@i-love.sakura.ne.jp
> in order to achieve what f9e053dcfc02b0ad meant. That is, extend tty->stopped in order
> to be able to represent "started state (currently indicated by tty->stopped == false)",
> "stopped state (currently indicated by tty->stopped == true)" and "changing state
> (currently impossible due to bool)", but this approach might need to touch many locations,
> and I worry that touching many locations introduces some oversight bugs.
> 
> 




