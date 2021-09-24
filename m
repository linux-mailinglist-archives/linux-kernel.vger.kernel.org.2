Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E70A416C64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbhIXGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:54:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39751 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbhIXGyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:54:46 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210924065311epoutp03a80ee740e86a4520db4171d3c77404e4~nr4i39-Na1617316173epoutp032
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210924065311epoutp03a80ee740e86a4520db4171d3c77404e4~nr4i39-Na1617316173epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632466391;
        bh=IBhaKYyTeRfh0dr0Rc10b094KSeKEP8cXFcOP6No8rM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=qUolcZnwItUQ5yaD2Z7StbcGJYpYT1PtgZh/JJejiA+fBus3xzn+BEt2h6VralMny
         FOvdS2YXWcAem2ZCqVDYYE16yv/L19KGvEnyPijRBTsY5Dx3dqm0/OGzFMhIXnczQ7
         rX8VMQKabegwVluqmsCy/iwKgG5AwC/kXVmPM7hw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210924065310epcas5p45039cba52ce8373a021c99a9a1c88986~nr4iOMbIC0835708357epcas5p4V;
        Fri, 24 Sep 2021 06:53:10 +0000 (GMT)
X-AuditID: b6c32a49-125ff7000000e972-ff-614d75d6b6bc
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FE.B2.59762.6D57D416; Fri, 24 Sep 2021 15:53:10 +0900 (KST)
Mime-Version: 1.0
Subject: [Issue] timer callback registered with mod_timer is getting called
 beforetime
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Chung-Ki Woo <chungki0201.woo@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
Date:   Fri, 24 Sep 2021 12:23:10 +0530
X-CMS-MailID: 20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7bCmpu61Ut9Eg47/phYXd6danP5+hd1i
        5utuJovLu+awWaz+d4rRYvOmqcwWh07OZXRg99g56y67x6ZVnWwe786dY/fo27KK0ePzJrkA
        1igum5TUnMyy1CJ9uwSujPevL7MUbBOsuPZ9J1MD4zmeLkYODgkBE4n3/3S7GDk5hAR2M0rs
        WesAEuYVEJT4u0MYJCwsECHx+O8ZZogSRYkLM9YwgpQICxhI/NqqARJmE9CTWLVrD0sXIxeH
        iEAjo8Te7SvYQRxmgf2MEt2Ld7KCVEkI8ErMaH/KAmFLS2xfvpURwhaVuLn6LTuM/f7YfKi4
        iETrvbPMELagxIOfu6HiMhKrN/eCbZMQ6GaUWP9uL5Qzg1Gi59E0qA5zifVLVoFN5RXwlehq
        fM8EYrMIqEp82rCHDaLGRWLWrF1gU5kF5CW2v53DDPIas4CmxPpd+hBhPone30+YYB7YMQ/G
        VpVoubmBFeaZzx8/Qj3mIbHleys7JLQCJTZ8+cM0gVFuFiJMZyFZNgth2QJG5lWMkqkFxbnp
        qcWmBYZ5qeV6xYm5xaV56XrJ+bmbGMFJQ8tzB+PdBx/0DjEycTAeYpTgYFYS4f18wytRiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO/H15aJQgLpiSWp2ampBalFMFkmDk6pBiYrb+3L+3llhWva
        UmJvzZmtKeGyuU+g3GBh2WHHPWuj2ZhW61suLZzmtcQ8SViB013n89O3Fy769fyyyjffk9c+
        R//WFJMmlTt+z6QPKraoyO6/6/XRIsUsc+ms1D+zGN/X8MaUTni297K/1UV+nWOt7nlSuqaJ
        8sxhh4K6aq8wmVs0ztR7+V1216UrXvfDp5o8On7hLlO11x8lpzTx18bRPxgKmd9w1DF/bg6c
        Y60WaSzxbKvY2TuKa9ceVc+4O4vT6ObhH2v/MhTv9RRnrjko5Hw9dtXp3MvT+VeIzTvfET1p
        sreRyMFa03m2vqsrDe1bv0bcXlwh8ZiDdx5Daryi/A9Wxk16+5mW1TU/V2Ipzkg01GIuKk4E
        ANSVFB2JAwAA
X-CMS-RootMailID: 20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186
References: <CGME20210924065310epcms5p69dd47a510faaa6bf68c243e02f2d0186@epcms5p6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


we are facing issue of early invocation of timer callback(kernel versio 5.4), Is it known issue for timer callback?

As we checekd code if CPU responsible for updating jiffies value(lets say CPU0) has interrupts disabled for 60 ms
and in mean time other CPU(CPU1) registers new timer for (jiffies + x) value. its callback will be called before time.

As it reads old jiffies value and register callback for x jiffies afterwards, but instead it is called
at x - y jiffies. (y is lapsed period which CPU 1 does not know from jiffies)


CPU 0                             CPU 1

// last jiffies updated
local_irq_disable();              do_some_work()
do_work()                         ....
...                               ....
...                               ....
... // 60 ms                      mod_timer(&timer, jiffies + x); // read old jiffies value
local_irq_enable()                ...
// new jiffies updated with       // timer interrupt reads updated jiffies and calls callback function where x was not actually passed on HW clock.
// jiffies + 16


we tried with TC (with 500 ms irq disable just to check behaviour, in actual issue it was 60 ms IRQ disable)

// IRQs disabled on same CPU0 responsible for jiffies updation for 500 mili seconds

[23.5598] ##### disable IRQs
[24.0600] ##### registered timer 25025334960 5887  //registered timer at HW clock 25.025 seconds for 600 ms at 5887 jiffies on CPU1

[24.0604] ##### ticks change abruptly 5887 124   //IQRS enabled, CPU0 increments 124 jiffies colllectively because of irq disable long time

[24.1595] ##### timer called 25124783406 6037   // as per jiffies callback trigger at 6037 jiffies i.e. after 150 jiffies(600ms)
                                               // but HW clock is passed only 100 milliseconds.



Is it known behaviour for timers?
because only 1 CPU is assigned to update jiffies work to call do_timer utill unless it goes to idle state and pass ownership to other CPU.

we tried by making all CPU to handle code for jiffies updation (it will add performance hit)
but then no issue of abrupt jiffies change occured on system.


Thanks and Regards
----------------------
Maninder Singh
