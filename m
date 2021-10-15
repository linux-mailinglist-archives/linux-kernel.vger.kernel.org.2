Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12542F042
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhJOMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbhJOMNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:13:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CEDC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:11:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w14so37027526edv.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGmqR2xzQ/YBThqPJdploWYaJyDetQejJVHNWJNb6sM=;
        b=RS+UVqVo29WU1w+frveoYMaToC8WN74aBe00ipWX34m/BECT3GVYrbOmeRYtBfndxT
         dryzMIyoRa1/ZCEjlTc/JAoo5l4R/xbMG/OtP3LSYxYSPGEOGxB+5eA13AJsTTPx/tTr
         +o3gPer92q1wMZMTohAOV4yWzfiPDeNVsce6IrRT3NfRsjh7DwdYSuvG2owgHV5CWXlA
         aY5Evb7+M9JKI8RnghJ99iKHC3SJlG1QIwM0gxp7ypuz6dhkgH/oXUWoeUIKXxGUVQDJ
         sO0vKLTUxLIJKA/LA0PRmy2CAJEJUNVbqNzmoKVcDDDYJe5RkcRQsbIyQS4FnMISpZvf
         5EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGmqR2xzQ/YBThqPJdploWYaJyDetQejJVHNWJNb6sM=;
        b=vJpPqN6/PFYdHmB+969VpcAcYKxXeE3V9eroU5qbncJxVBQIPf7lhrLr6uFtmy5Q/O
         ogyVZNs/SdnLM/+Y/Ee9uXXL11NIS6RSHiUm47z8mBZwpWEDnqvScX+r5ufrMsBFcP5c
         eURehvgzPQCbtJ6Xff55IxJ7JOPooBB5/P72OMWtY1UdSZUNjRfwPToC9EKCQQMw4Xlx
         NdTu6hU438OdA5NeXR6ZeaW3pEN1Oewl7yQFS9mQlYu3z0xy5cCB7XOmcDLDBTvu9P7U
         YFY++rnysKweGle1jf5lmzAxSTUoVcx8VsOeWoFUtVXptK7gwF1AvRvmnOoEEVQ4D2vX
         re7A==
X-Gm-Message-State: AOAM532Wb8wD4EyYB8XDZe+ykosMy+0sxrHvdarvQ7bueQlpZ3NLVEIM
        rVYjpmxEUprR7VeoibjtsRg=
X-Google-Smtp-Source: ABdhPJw7Y7BgwCPpoYTbRoShU4nSQRSHzGe++lAqHljG9PiM1S7/dEs5KooNi5GvsMtUX+oR4MShtA==
X-Received: by 2002:a17:906:6a2a:: with SMTP id qw42mr6165743ejc.561.1634299904340;
        Fri, 15 Oct 2021 05:11:44 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-180.retail.telecomitalia.it. [79.47.104.180])
        by smtp.gmail.com with ESMTPSA id j11sm3971820ejt.114.2021.10.15.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:11:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] staging: r8188eu: Use completions instead of semaphores
Date:   Fri, 15 Oct 2021 14:11:41 +0200
Message-ID: <2060953.sJFZD89sIB@localhost.localdomain>
In-Reply-To: <20211015113715.GR8429@kadam>
References: <20211015110238.1819-1-fmdefrancesco@gmail.com> <20211015113715.GR8429@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 15, 2021 1:37:15 PM CEST Dan Carpenter wrote:
> On Fri, Oct 15, 2021 at 01:02:38PM +0200, Fabio M. De Francesco wrote:
> > rtw_cmd_thread() "up(s)" a semaphore twice, first to notify callers when
> > its execution is started and then to notify when it is about to end.
> > 
> > It makes the same semaphore go "up" twice in the same thread. This
> > construct makes Smatch to warn of duplicate "up(s)".
> >
> > [...]
> >
> > I'm waiting for Maintainers and other Reviewers to say if this patch is
> > actually needed and, if so, also for suggestions about how to improve
> > it. In particular I'm interested to know what they think of using the
> > uninterruptible version of wait_for_completion*().
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> This is basically what Arnd did to rtl8723bs in commit:
> 
> commit 09a8ea34cf431bfb77159197e46753d101c528c5
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Mon Dec 10 22:40:30 2018 +0100
> 
>     staging: rtl8723bs: change semaphores to completions
> 
> But there are some differences.  His patch is a little bit cleaner
> because it gets rid of "pcmdpriv->cmd_queue_sema".  Could you basically
> just ports Arnd's patch for this driver?
> 
> His patch goes quite a bit further as well, and change some other
> semaphors but we could do it piece meal and just change the
> rtw_cmd_thread() related ones.
> 
> regards,
> dan carpenter
> 
Hi Dan,

Thanks for your review. 

I wasn't aware of Arnd's patch. If I were I would have sent a "normal" patch.

Beyond this, I noticed that other semaphore (pcmdpriv->cmd_queue_sema) but, 
since I was not 100% sure that my changes would be accepted, I decided to 
leave it as-is for now and wait for reviews like yours.

Now that I know that this changes are welcome I'll also make the other 
changes. 

I guess that I have to change one semaphore per patch and make a series. 
However, now I see that Arnd's patch makes all the necessary changes in a 
single patch. What is the correct approach? Is one patch per semaphore 
preferred or one big patch for all of those that need to be changed?

Again, thank you very much.

Regards,

Fabio M. De Francesco


