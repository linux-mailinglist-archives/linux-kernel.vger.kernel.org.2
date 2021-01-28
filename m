Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404853072CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhA1JcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhA1JWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:22:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE1C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 01:21:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u14so5346105ybu.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 01:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=wIBUTVGHIg6gXpFBoxosuSvN89uYeSslgY6GnwvtvqM=;
        b=oYgXl9L1NuQMmPwFJHZauMaZ3aglVOiQk6E5rY8VZ+7sDuvqU5XS8bo39C2cTCKUpr
         XYLQGqHJpfy+kJy3yOL1Pw2DabJM7QchG3qD3hiqyrM0Nu1OQE9444i0GOI5I14SJPNP
         CcJmpBGqJie+WuSQpjRaMGrEDk5xWDvlRyW/4q8iGS0/uCCNnelXvtwvx84g+vNeEJ+8
         6rRhvK2UxvKH0DNPYnAxNmg2g/zpvAaS9lNhHQSiIZGKCgIXF2Yg/gpdFB8qw+1jb7vr
         nitn/Vzf83uXjKx1XtIHhWvS3tD4GiBTk/XsG+ZZnKvfALHnJkZzG4nDQfa2y17uj8ES
         ++Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=wIBUTVGHIg6gXpFBoxosuSvN89uYeSslgY6GnwvtvqM=;
        b=ZtnOdDn7YCMHiIM9aC1MObV0JOlJrW38VFsw/wtH1gJvIXjKJv4Qtn5OYMSHLwLB6l
         Eu4tDnuWeTo6QirAHgQ6ceffDfg9tTadRNi5ZeZClE91IEi13Sv4S0LUYo8s416EqKKN
         1sM0zPP+qyjro60nCZg0ZyT2WwsLzImL4aeCLyE3B14aDukOny82RjL1RLKKYl4FQq8t
         uB+J6Fkp8BY0R4NCu6Eq79YiddZrmUM4e58XuAStKRCZKV26qF0azTFlexBzJS/JNH8q
         A/VJJDExVro9717gYBoom9SQZv8j/E3OiYAaaeCpK0gRGfwv/f+FAh0xByxwmSPeD+XD
         9x3Q==
X-Gm-Message-State: AOAM531s658GpmKOWKy6UBxXMkN4xkHaw/Hq1ssl1+KTJ31sV//rc9St
        if5wGlJqa+YHbRNidvkAxGAz64d9y4Fy2QmF
X-Google-Smtp-Source: ABdhPJySXiM69uvOnkpK2j2D4HX+QWmgqg6MD7iQEC+4H8MMXhJTem552VCGCX68HuZXc/Bq7t5i/3mefpqtdFWu
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:a5e2:e68a:ef67:8128])
 (user=josephjang job=sendgmr) by 2002:a25:3a04:: with SMTP id
 h4mr22140678yba.285.1611825712228; Thu, 28 Jan 2021 01:21:52 -0800 (PST)
Message-ID: <00000000000004f27505b9f26bca@google.com>
Date:   Thu, 28 Jan 2021 09:21:52 +0000
Subject: Re: [PATCH v4] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
From:   <josephjang@google.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 867157311dc8..ecd988b4a838 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7788,6 +7788,8 @@ F:        include/linux/freezer.h
> >  F:     include/linux/pm.h
> >  F:     include/linux/suspend.h
> >  F:     kernel/power/
> > +F:     kernel/power/suspend_watchdog.c
> > +F:     kernel/power/suspend_watchdog.h
> >

> The kernel/power/ file entry already covers all files in that
> directory, including suspend_watchdog.[ch].

> So, why do you think you need to add these two further entries explicitly  
> here?

> >  HID CORE LAYER
> >  M:     Jiri Kosina <jikos@kernel.org>
> > @@ -16630,6 +16632,8 @@ F:      include/linux/freezer.h
> >  F:     include/linux/pm.h
> >  F:     include/linux/suspend.h
> >  F:     kernel/power/
> > +F:     kernel/power/suspend_watchdog.c
> > +F:     kernel/power/suspend_watchdog.h
> >

> Same here.

> I think you can simply drop the changes in MAINTAINERS in this patch.

Sure~
I will drop the changes in MAINTAINERS and send PATCH#6 again.

Thank you,
Joseph.
