Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3438037556C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhEFONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhEFONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:13:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 07:12:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t4so3458919plc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wqyyyHnK8FiNMaf9JVPI3razJE+a2ZRHcYe96jC3lb0=;
        b=MeSMvYenteOQAETWwt+P404i5W2zP9ivfegBQCpWp++yIwNvPEwJyPxU3DlepBQ28t
         8lSvInNgZmRM1XlWLMDjbkAyv1pP0oollrKs7UsPf8WyXPPa2ZERIyaTlFBL4dC7xDzY
         FtBAr5kPatLJfpves0RlM4WcmXfvOAPTJvsTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wqyyyHnK8FiNMaf9JVPI3razJE+a2ZRHcYe96jC3lb0=;
        b=kPArQU6obiLDs4S63RDE9AZsNsAIK2dSwSAYPB8NIDqVViHj1MGbJtD7Lx+BQThbJq
         TgUCf0r2/7TZEsUC4E7tFvrlY6fopE+soR/PJ6subXr6bVAsGtds857VII6fg013cR+m
         Pupunll/PZw4njY/xUeIqoOFbgKZzMH0S6cYHnjd3/B08NwUH8VN4AQhiJ+Kn90XQPPh
         izuF/Tki056pmswT7YFSN3AldRfYQ9R49FNpUvUDNX7hvoqd5Akw3CenF6P9twRHmtUS
         pO3/Ia6zZx4l+ysgVr5Z8URNo0CejMA0ES+M/OgFcbqv61c5kt1nMa/0Sj7RAxyaUlGk
         WMjw==
X-Gm-Message-State: AOAM5317c4QCA3Ux6nLwMmgWL9QDjrycC9VGtUTxo5n+JYZFnWkVJnNB
        RTKYrFsPULwAyJKOchQX3f4tvg==
X-Google-Smtp-Source: ABdhPJwt5W28EF0bUkMcCskx9dyuHMHHz0Kxt62Ysg/VZ5ORxUy214EOdczX3dECSRhBnpLFaJp5vA==
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr17446752pjo.171.1620310328048;
        Thu, 06 May 2021 07:12:08 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:421f:8358:b929:bc6d])
        by smtp.gmail.com with ESMTPSA id m15sm2027845pgu.4.2021.05.06.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:12:07 -0700 (PDT)
Date:   Thu, 6 May 2021 23:12:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        bobo.shaobowang@huawei.com,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJP5MnkJ8pJevXM6@google.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJP4F1UIt/eRZ96s@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/06 23:07), Sergey Senozhatsky wrote:
> 
> Can we count the number of lines that we print from the `current` context
> in console_unlock() and if after N messages there is no console_lock waiter
> waiting for the `current` to handover console lock ownership, then create
> one: schedule IRQ work that will become a console lock owner, spin on
> console lock and call console_unlock() once it acquired the ownership.
> That 'artificial' console lock owner will do the same - print N
> messages, if nothing wants to become a console lock owner then it'll
> queue another IRQ work.

Or even simpler

console_unlock()
{
	...

	if (printed_messages > limit && !console_lock_spinning_disable_and_check()) {
		printk_safe_exit_irqrestore(flags);

		console_locked = 0;
		up_console_sem();

		defer_console_output();
		return;
	}

	...
}
