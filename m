Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2774D44BD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhKJJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKJJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:11:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC571C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:08:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso4011414wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 01:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=teTpbIWMqP19cYw1tGp6eE48hT4P1O4XsJC6/1SCuq0=;
        b=J1B8gY57c0HGSQTVBkK6Wzx/tQUfOa65/KSM1dz8AKNHKnU6TxbE3rw0JQ3MpW0PNa
         ZhFiBhiDuJROo+fwg1YojPwLAgmoMwn/5JKM/u5Gmsfx75nn3QVytYdbw9rx8sGWQzI5
         45u3M3MLM6+GGsiOymi13U2U5D7kOZVR253Xp0M0hn77LxNaCM+T/Qq7nC8MVvBwrwhh
         sYvPAx53VBKeJ3bcWQxdRfUhhkujxGQLoYk7NgdSM5A+I6/0xsGI5mHIWNV9KmOqwjDf
         JcSuQG8qSVKVBzBkLi0mx0zmV1RTKDvh7Ne3wZKqp6Pr6WfisdCOTtlg42lBOh7IIAW9
         jgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=teTpbIWMqP19cYw1tGp6eE48hT4P1O4XsJC6/1SCuq0=;
        b=g9RyhwPRzcMlUUYdkLw3yh4+ZqNJEsJB8O3yjJzolcvQ+/kDQ1RBx3/GaK+xsOlVYa
         efwqOtR9RbDgOxc6V0K+hvGVHR9/0gkYgKu23iGIsJzeGC4SCbMWh1gpyZijjYlPcuoY
         zOG1O9VIQHoIP04oLOUxgDQvVlBtVfiTwqJWoPz66Fq+owO9YMKTtKgqfIHxnnE2lYYg
         hwnVE0+zBNdr2uI8avZN24rVh3dhdFfJ3L0Rzb34ydzHHPJO3vsYl1GiXM3l2rotjF9t
         V1NZmpzD09iZsl/v1Eh349o29Af9YybxMoFSbzljcCQm7xfTgsPCFPcq9MNF3WFT6wnE
         Ctnw==
X-Gm-Message-State: AOAM531wSI0h+odjt5phjwq0YeUh5Z2YXh7CFPdPNiugUDXAI9AErOGa
        tKzd/P8iCbky3IfQX9XI+G00YCM90v6oNA==
X-Google-Smtp-Source: ABdhPJyMi57au9h9/Aqfcx+Azuam1ghDXSU0NgI1nzqrK8fT3t+0fOnhaTCeKd+cjqC8JDoz9UEblw==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr14390600wmi.107.1636535332123;
        Wed, 10 Nov 2021 01:08:52 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:5b79:8e57:35c2:52])
        by smtp.gmail.com with ESMTPSA id x21sm4942772wmc.14.2021.11.10.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 01:08:51 -0800 (PST)
Date:   Wed, 10 Nov 2021 10:08:45 +0100
From:   Marco Elver <elver@google.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [syzbot] upstream boot error: WARNING in __context_tracking_enter
Message-ID: <YYuMHchsq7UKwiD8@elver.google.com>
References: <0000000000004f14c105bde08f75@google.com>
 <CACT4Y+bLkFSc8manYrCukj-_nzwVsV9y6xYWXmGyYFS-PoBRPQ@mail.gmail.com>
 <20210319101043.GU1463@shell.armlinux.org.uk>
 <20210322172241.GB80352@C02TD0UTHF1T.local>
 <CACT4Y+ZaFKB6xd9BiPjYsE+13GJb3d_4aRTkB8xrNMaexpLaFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZaFKB6xd9BiPjYsE+13GJb3d_4aRTkB8xrNMaexpLaFA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:14AM +0200, Dmitry Vyukov wrote:
[...]
> Hi Russell,
> 
> Does Mark's comment make sense to you?
> lockdep_assert_preemption_disabled() also checks "&&
> this_cpu_read(hardirqs_enabled)", so is it that we also need hardirq's
> disabled around user_enter/exit?
> This issue currently prevents ARM boot on syzbot.

We've disabled lockdep on syzbot's arm32 instance now as that instance had
been dead since March:
https://github.com/google/syzkaller/commit/be386ae8800e02b4a9a3239c9565e9d40e253c84

It's running again. There may be an influx of new bugs.

Thanks,
-- Marco
