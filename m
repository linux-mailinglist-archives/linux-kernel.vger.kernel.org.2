Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37744EBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhKLRSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhKLRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:18:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594D5C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:15:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b15so40202231edd.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Xqv5C+GYpPh4j2RX0q9dDaU93K0u7NpWAnWtn3BWYY=;
        b=PJZImTBJYuimRsRDkSAfKa6otbMdECBBqTS1bpNgAjJYFpY8Qe6x5A4rP11XCJVBTG
         l2a0OWOtryfUO+MTuLBKVVjJLDCyA5sL3jiHCaKSqFnMF74h/bowQT7JnPpJaB/HA9h3
         8D6xaQGQnbwCLCeT3myXYSHZCTSItax6l/mTyr2ZvK3cKht9JPUPEHzmMHJf1vchsKkT
         YrrxwePyJCS8MucgDT4h3YfwkqkAnd5gGEDUpIc+THWL8zBGEBEaoqCAq+kw77F2DAVv
         W3oXJAZjJSuoDrbcXu7/LKpRfXvDxR8G/Bp6JLMnZ1ZCxp8MSe+Ft07gtQtr2nzwGuPT
         GdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Xqv5C+GYpPh4j2RX0q9dDaU93K0u7NpWAnWtn3BWYY=;
        b=B2brNjAZ3LNQUCuPUxnmAWQjXVVrmEkPpl3A60M5bGFRZt/XmisgdIwZrGyAv870iG
         YWSswNaDDUuYKH5t3Um9ZBVVZunJ6BIVZbggJ7cchAXaz+4zLD6+0z7zLGeZjiq22+jC
         CoUcFCFC0rQlFQioIPkpeLgHsTM3AY/0XCxpBwjTIebD28XRl/kuDiK5nIRAtZ0g0Zno
         vyOKBd2yGNtMBe8l6nzB1QoXEAyGAoZUZHBfGYQVz0hezEP4DnUx1zSt2YTIvqxYiPs7
         F9rLKNLzbya9PcZSC9HY/HKe1iLjXI92kZy+q7c+/Ve2rp8O4Ac9DQnOQpRE6bgrQFB0
         FkIA==
X-Gm-Message-State: AOAM530PB/P82m0Fkoz9BuioJ1Dc8Xyu6P++ox0Qd6ei6d+vLfp8vHDF
        Joz3bNB3h+g/XzwHkGuV7SU=
X-Google-Smtp-Source: ABdhPJy9Dvs/4sx0LPUARuz0i3jfGXcEplCdjIzvmSzJ1M6XsiqLVLFPPsRkFDDgYmMl4rft2o1TAQ==
X-Received: by 2002:a17:907:d07:: with SMTP id gn7mr21116960ejc.272.1636737345891;
        Fri, 12 Nov 2021 09:15:45 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id f25sm3234619edv.90.2021.11.12.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:15:45 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
Date:   Fri, 12 Nov 2021 18:15:44 +0100
Message-ID: <4117061.qmFDOAJpEW@localhost.localdomain>
In-Reply-To: <YY6WB9wMx/0VaqDx@elver.google.com>
References: <000000000000f43bb905d06c8b7f@google.com> <1805242.PYQNYDVmnG@localhost.localdomain> <YY6WB9wMx/0VaqDx@elver.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 12, 2021 5:27:51 PM CET Marco Elver wrote:

> My guess is that in this case '!preemptible()' could work:
> 
> 	#define preemptible()	(preempt_count() == 0 && !
irqs_disabled())
> 
> But still am not entirely sure.
> 
> Thanks,
> -- Marco

Oh, I didn't even know that we have that preemptible() macro. 

Instead, I should have known that in_atomic() won't do, since last week I had 
copy-pasted in an email that I sent to someone on the LKML exactly the same 
inline documentation that you have showed now.

Thanks, Marco. At least, this thread was useful to make me recall how these 
macros should be used :)

Regards,

Fabio




