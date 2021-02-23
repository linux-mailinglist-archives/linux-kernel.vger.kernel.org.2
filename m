Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C26322ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhBWMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:45:25 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:12139 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhBWMpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:45:23 -0500
X-AuditID: 0a580155-713ff700000550c6-4e-6034f1ae9785
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 6C.18.20678.EA1F4306; Tue, 23 Feb 2021 20:14:38 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 23 Feb
 2021 20:44:37 +0800
Date:   Tue, 23 Feb 2021 20:44:36 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "YANGFENG1@kingsoft.com" <YANGFENG1@kingsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210223204436.1df73153@alex-virtual-machine>
In-Reply-To: <20210205170135.22f771a2@alex-virtual-machine>
References: <20210201161749.0e8dc212.yaoaili@kingsoft.com>
        <20210204072555.GA22850@hori.linux.bs1.fc.nec.co.jp>
        <20210205170135.22f771a2@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXCFcGooLvuo0mCwa9fVhafN/xjs3ixoZ3R
        YtpGcYvLu+awWdxb85/V4vyutawWlw4sYLK42HiA0eJ47wEmi82bpjJbvLlwj8Xix4bHrA48
        Ht9b+1g8Nq/Q8li85yWTx6ZVnWwemz5NYvd4d+4cu8e8k4EeL65uZPF4v+8qm8fnTXIeJ1q+
        sAZwR3HZpKTmZJalFunbJXBlLL08l6ngJVvF9wUZDYx7WbsYOTkkBEwkPj/7yNTFyMUhJDCd
        SWLmuZmsEM4rRokXb+4wglSxCKhKTH+8hR3EZgOyd92bBdYtIpAksXj2V7BuZoEFLBLz1kIU
        CQskS5yZ9ACsmVfASuLQ44MsIDangLXEzY2XWCA2LGKU2Pv+JzNIgl9ATKL3yn8miJvsJdq2
        LIJqFpQ4OfMJWDOzgI7EiVXHmCFseYntb+eA2UICihKHl/xih+hVkjjSPYMNwo6VWDbvFesE
        RuFZSEbNQjJqFpJRCxiZVzGyFOemG21ihMRd6A7GGU0f9Q4xMnEwHmKU4GBWEuFlu2uUIMSb
        klhZlVqUH19UmpNafIhRmoNFSZx36laTBCGB9MSS1OzU1ILUIpgsEwenVAOTiKPksZT0aXaW
        qZpTTVqaf4V0ruMxN963O+FaQmdXxrXGm5fmNnXWyFiXv9q/8oVEgWiGh2eF+NNZ7QoOjpHu
        W0yfbZyY+G9+16PSq+zFh5mXRJzfvLi78+l1gULpu+9Da4xto64f27rsEctfEbn9+094bIoR
        s5n88TrvNvGGc92amwLju8UPTWUxXSj+tH4Fg/exj0z/ohZH8kqbvjhza7V8w3V3x+d6rGcv
        G0qtTVcLlD2/aUPcRL22G1PKHb/rryvi/y7nPllW+MUk9qfdfluVOP59++n78WJeor7FnsPp
        4UrHYg2eOC40NzPa5NqwbfGvhMkGq8WKjoqJC96dWHZf+dPT1E3beHTv769QYinOSDTUYi4q
        TgQAYhT6lSoDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 17:01:35 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> When one page is already hwpoisoned by MCE AO action, processes may not
> be killed, processes mapping this page may make a syscall include this
> page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
> mode it may be fixed by fixup_exception, current code will just return
> error code to user code.
> 
> This is not sufficient, we should send a SIGBUS to the process and log
> the info to console, as we can't trust the process will handle the error
> correctly.
> 
> Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
>  arch/x86/mm/fault.c | 62 +++++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 22 deletions(-)
> 
Hi luto;
  Is there any feedback?

Thanks
Aili Yao
