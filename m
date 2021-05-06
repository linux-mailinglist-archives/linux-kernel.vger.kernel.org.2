Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2F3751A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhEFJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:39:15 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:3140 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232268AbhEFJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:39:11 -0400
X-AuditID: 0a580157-bd3ff70000027901-ed-6093b8f85b22
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id E1.2D.30977.8F8B3906; Thu,  6 May 2021 17:38:00 +0800 (HKT)
Received: from alex-virtual-machine (10.88.1.103) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 6 May 2021
 17:37:58 +0800
Date:   Thu, 6 May 2021 17:37:57 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     <linux-mm@kvack.org>, Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "David Hildenbrand" <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, <linux-kernel@vger.kernel.org>,
        <yaoaili126@gmail.com>
Subject: Re: [PATCH v4 1/2] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-ID: <20210506173757.586580bd@alex-virtual-machine>
In-Reply-To: <20210427062953.2080293-2-nao.horiguchi@gmail.com>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
        <20210427062953.2080293-2-nao.horiguchi@gmail.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.1.103]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXCFcHor/tjx+QEg2U3mS3mrF/DZvF5wz82
        i6/rfzFb3LxlYnF51xw2i3tr/rNanN+1ltVi1bw7zBYXGw8wWpyZVmTx5sI9FotnrVdZHHg8
        vrf2sXjsnHWX3WPBplKPxXteMnlsWtXJ5rHp0yR2jxMzfrN4vLi6kcXj/b6rbB6bT1d7fN4k
        F8AdxWWTkpqTWZZapG+XwJVxs/8SW8EGjoolNwwbGO+zdTFycEgImEg8euzaxcjFISQwnUni
        0LUt7BDOM0aJ95OuMXcxcnKwCKhILF13lQXEZhNQldh1bxYriC0ioCsxYVsvI0gDs8A/JolJ
        Vw8wgSSEBWIkdrzYxwhi8wpYSay6cBmsgVPAXqJh/SGwQUICxRLr7s0Cq+EXEJPovfKfCeIi
        e4nH6xUhWgUlTs58AlbOLKAjcWLVMWYIW15i+9s5zBBjFCUOL/nFDmJLAMXv/p7OCGHHSjQd
        uMU2gVF4FpJRs5CMmoVk1AJG5lWMLMW56YabGCHxFr6DcV7TR71DjEwcjIcYJTiYlUR4Ty+a
        nCDEm5JYWZValB9fVJqTWnyIUZqDRUmct3EmUEogPbEkNTs1tSC1CCbLxMEp1cBUZbvVJ99r
        n4ThOy4mn/e2fWu3dxpECWcFPfi6bndBDPuW+nwRPlHeX7PS5abv/jvnnPfW/lt3F8TdP+v8
        /V4UM9/0PzqrtnYI3Dly9/yEe4t5I0pYlHdaS+mwxjZOcW1dKTol/RKPVui5Y/tr+B9NfnOM
        QX7v+5f/ty4v9RBz6Pbr3u2TMWVjx46K1WGRYp9er07c8IQ1ZTLjkxUfvT13s+tvNrtj2Cn5
        T7Ut9aDBhOh2Tk+dG7tn7bwn+ThW7sSPlpJrrcsCV9dF7i09lS2wOOvewjVFpzsXFztfWln2
        6vXJX5VVeVdePN4Y83St5dfqvq2fip1yZz2TNjEOjTZctq7Bf4mU5zdPC2H+CpWtSizFGYmG
        WsxFxYkAVOlEXCYDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2021 15:29:52 +0900
Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:

> From: Tony Luck <tony.luck@intel.com>
> 
> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
> 
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
> 
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>

Sorry to interrupt, I just thought one thing:

This mutex seems not been bind to the error page, will there be some core case
like test code or multi-poison case whick will break this mutex?

Thanks!
Aili Yao 
