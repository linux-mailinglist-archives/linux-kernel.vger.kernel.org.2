Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2453031DD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhBQQ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhBQQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:26:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E696C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:25:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id n4so15040145wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ut0i3UNMCZuvoqWdNAPofqX9H/0FtbpaXgUvulT7kdY=;
        b=E0EkzspLd5Ur2E3db92QRZU0V0t7WTJUwsm3ZBzUuefl2pAHkLPhHMdliyATroRyc1
         FJ+q/8OtaXo5LQ44krV5MAsxSF6/lbkK1qOC6JwTSgIe4lSHUlR6f44zk5h5leg+T8TO
         EZNYusBkYWNpFbw/86a6Ykypdhh7Zg0+Um8/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ut0i3UNMCZuvoqWdNAPofqX9H/0FtbpaXgUvulT7kdY=;
        b=VoYEp3XKCdwge7Jo0nV13jViWm9WikJTVic7Bo39lXiCa+zcAv9n+uXW/Fokavtf1v
         ssVGhgl8sqqHZtVvKACPuaN/tOIYDXulJTqVr4uiTw1fJL4LG44V7v1/mgmWImfYOaD9
         r9+wtEcYfr4hCuMEnssxGo4OdVOSTmkBsb9a42t3xmUg1Tvzh9J+BaIkxS48uuozWj/V
         PD651KKPonwZ45JrxG2O6KxMv6jboGMeQZqjGq7Uzn3ha1yWRNXsNh2Mock+upVELjBq
         +WxKLBLQ74uCImzwp3/HUfqrenznnZWhXbHrLmtP1p+tQzKfLkyS03lHN5XiplQLYJXz
         D6Yw==
X-Gm-Message-State: AOAM530nv7zJnbGsv5cj/M4brGM1dmv7QTP84fu5LnI3tqIqHgu+Kf6z
        uPOOundN9PfAqWsHVl23miFkSg==
X-Google-Smtp-Source: ABdhPJzyI1Wh3rwp9Dqv8O1YyxhOoZscyz/ob4GZ2MgZPT9xhnC9HYTzvRmnyMylWlJXquJ2e8g0Qg==
X-Received: by 2002:a5d:5185:: with SMTP id k5mr53944wrv.352.1613579149779;
        Wed, 17 Feb 2021 08:25:49 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id l1sm3584790wmi.48.2021.02.17.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:25:49 -0800 (PST)
Date:   Wed, 17 Feb 2021 16:25:49 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC1DjeZmBWmJe35c@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YC0/xQTephcfo6GL@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YC0/xQTephcfo6GL@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>What about storing the pointer to struct pf_object into
>struct printk_fmt_sec *ps into the s->file->f_inode->i_private?
>Then we would not need any global list/table at all.

Unless I'm misreading the debugfs code, I think the following is possible:

open(f);
   debugfs_file_get(f);
   fops->open();
     inode->private = ps;
   debugfs_file_put(f);

remove_printk_fmt_sec(); /* kfree ps */

read(f);
   debugfs_file_get(f);
   fops->read();
     ps = inode->private;  /* invalid */
   debugfs_file_put(f);

That's the reason why the code looks up from the module address again during 
_read. Maybe I'm missing something? :-)

>> Oh, I meant to change the name for v4 but neglected to do so. Sounds good,
>> will do.
>
>Thanks a lot. I am sorry that I ask you to do so many changes.
>I talked about the style early enough to make the review easy.
>Also I think that it is not ideal and annoing to do these
>mass changes and refactoring when the code is already reviewed,
>tested, and functional.

Quite the opposite: thanks a lot for taking so much time to provide valuable 
feedback :-) As someone who mostly works on mm code, having you to provide 
feedback as printk maintainer is really helpful. Even if we disagree on some 
stuff, it's really important that we have a good shared understanding of what 
we eventually agree upon.
