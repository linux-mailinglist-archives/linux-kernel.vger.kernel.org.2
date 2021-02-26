Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA9325BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZCxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:53:39 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:12469 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBZCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:53:38 -0500
X-AuditID: 0a580155-713ff700000550c6-27-60385b685238
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id D9.AF.20678.86B58306; Fri, 26 Feb 2021 10:22:32 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 26 Feb
 2021 10:52:51 +0800
Date:   Fri, 26 Feb 2021 10:52:50 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210226105250.3a15e35c@alex-virtual-machine>
In-Reply-To: <20210225113930.GA7227@localhost.localdomain>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
        <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCFcGooJsRbZFg8LOB3WLO+jVsFp83/GOz
        +Lr+F7PFtI3iFrcPrGG0uLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJVx4OVS1oJHLBUnjjUwNTDeYu5i5OSQEDCROLLsAmMX
        IxeHkMB0JomTb44wQTivGCX6mw6ygVSxCKhK9O/bwQRiswHZu+7NYgWxRQTUJKa9amQHaWAW
        6GaVOLtxPTtIQljAS+LL/bWMIDavgJXE/OYmFhCbE8hetX46K8SGz4wSMxf0gW3gFxCT6L3y
        nwniJnuJti2LoJoFJU7OfALWzCygI3Fi1TFmCFteYvvbOWC2kICixOElv9ghepUkjnTPYIOw
        YyWWzXvFOoFReBaSUbOQjJqFZNQCRuZVjCzFuelGmxghMRi6g3FG00e9Q4xMHIyHGCU4mJVE
        eDf/M00Q4k1JrKxKLcqPLyrNSS0+xCjNwaIkzjt1q0mCkEB6YklqdmpqQWoRTJaJg1OqgSnt
        sMaDi3tubduy4f8LxWq2F2/2LZ2yISE6PyXxzRfzziUC9a8stfjOGu9t2s7k/+Hl4rlib7xP
        fFlSK98QJO/kF7Q1/MLq/gjBfbExP+RNynqaspc1HpAp40mx87pl3ms6a/cfT+57Pj76GgJL
        w4uL05y8vuZUX3ykzFeRNkH2lGz933c/zPweuU50rGDnWzpZcu3OptbuPIHpT3hftxtp/sri
        Ws51Pcdk7blFH0qv/XfWdhV26PaX4nzuM2/tv7+7OGr+WL656rN8dunCCZ89flw2ky97U/3Y
        XeNyaRvXd8GL8gzmK085ye/Sty6rzfR3cuq6pbtzgcuTe7vUttUt3GHpsq79WnnwgpBJQUos
        xRmJhlrMRcWJADSJYpIwAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi naoya,Oscar,david:
> 
> > We could use some negative value (error code) to report the reported case,
> > then as you mentioned above, some callers need change to handle the
> > new case, and the same is true if you use some positive value.
> > My preference is -EHWPOISON, but other options are fine if justified well.  
> 
> -EHWPOISON seems like a good fit.
> 
I am OK with the -EHWPOISON error code, But I have one doubt here:
When we return this -EHWPOISON error code, Does this means we have to add a new error code
to error-base.h or errno.h? Is this easy realized?

Thanks!
Aili Yao

