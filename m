Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B3376EE1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 04:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhEHCjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 22:39:51 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:3322 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229775AbhEHCjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 22:39:49 -0400
X-AuditID: 0a580157-bd3ff70000027901-d7-6095f9b3d717
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id B0.36.30977.3B9F5906; Sat,  8 May 2021 10:38:43 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 8 May 2021
 10:38:42 +0800
Date:   Sat, 8 May 2021 10:38:42 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, "Luck, Tony" <tony.luck@intel.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Jue Wang" <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaoaili126@gmail.com" <yaoaili126@gmail.com>
Subject: Re: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Message-ID: <20210508103842.7dc6e8b1@alex-virtual-machine>
In-Reply-To: <e6577ace06ca4ce9bbfb8195d7a2bfb7@intel.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
        <d09f178272df4c82b8c090ba79d222b5@intel.com>
        <87ba79daaba1416589b203118be096cb@intel.com>
        <20210507052422.GB2158342@hori.linux.bs1.fc.nec.co.jp>
        <20210507191400.6258dee6@alex-virtual-machine>
        <e6577ace06ca4ce9bbfb8195d7a2bfb7@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXCFcHor7v559QEgz0LuCzmrF/DZvF5wz82
        i6/rfzFb3LxlYnF51xw2i3tr/rNanN+1ltVi1bw7zBYXGw8wWpyZVmTx5sI9FotnrVdZHHg8
        vrf2sXjsnHWX3WPBplKPxXteMnlsWtXJ5rHp0yR2jxMzfrN4vLi6kcXj/b6rbB6bT1d7fN4k
        F8AdxWWTkpqTWZZapG+XwJWx5/UZloKJ7BVLG9ewNTCeZ+1i5OSQEDCRWPztNlsXIxeHkMB0
        Jompi+4wQjjPGCUubznKDlLFIqAi8f1PDzOIzSagKrHr3ixWkCIRgTZGifVrzoO1MwusYJaY
        fmIiE0iVsECoxNlfTxlBbF4BK4mleyH2cQpYSvQ+O8UOsWIrk8T8xqNgY/kFxCR6r/wHauYA
        Ospe4vF6RYheQYmTM5+wgNjMAjoSJ1YdY4aw5SW2v50DZgsJKEocXvKLHeIfeYm7v6czQtix
        Ek0HbrFNYBSehWTULCSjZiEZtYCReRUjS3FuuuEmRkjche9gnNf0Ue8QIxMH4yFGCQ5mJRHe
        04smJwjxpiRWVqUW5ccXleakFh9ilOZgURLnbZwJlBJITyxJzU5NLUgtgskycXBKNTDxZ5ys
        /ZnJyiKb1TPvO19ASIKWjLbDcpV51wPj1rbnyfyZb5Vk9UFD4U3c0U3xh95f4/nh5d6YOUfj
        gNb5E6JN75fnbVrGLHi6Nrr78467z6XsTfg37IxfXr9W+tKp9SqsytzpPyc+yVIoOP7pftZD
        m51zZjk9mCperR3BMrfb+94adYtL/fkbLcXPautsqrpi36F04sq5BQarJFS2GNVfCEk/m9Md
        x7TnRtymx1b375UVmL8uv8h/MMT29eng4wusdQNFtrjGuR1J6l2VEFMfMmXKiaQX3KmRPG1P
        oz5v3Ph19vu93YYR3nvm75u44s+sKerBHzavMFyQzfinJ2rXVTbO2MCrFzf8+hl6VFZQiaU4
        I9FQi7moOBEA29DGoCoDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 18:02:13 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > Before cc:stable, would you please do one stress test first?
> > It failed in my server, but I didn't dig into it, maybe the fail is meaningless.
> > Just a small suggestion.  
> 
> Upstream plus these three patches passed an overnight 8-hour stress test
> on four machines here (running a test that's been failing with hung kernels
> and kernel crashes w/o these patches).
> 
> What were the symptoms of your failed server?
> 

Sorry, I am not sure if the stress test in my server is same with yours.
Usually, I will do one RAS stress test from mce-test/cases/stress before post something.
Maybe this test is not general useful or you have tested it and passed or you may think
the test is not proper though or you tested and you don't think it's one real issue,
then just ignore it please.

Thanks!
Aili Yao
