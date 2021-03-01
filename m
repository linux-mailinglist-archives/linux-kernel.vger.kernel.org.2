Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B843278BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhCAH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 02:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhCAH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 02:56:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91852C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 23:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QAQJQ0qmXF6Tx2VwyrhQkP4ZkfIEkw8+V7GcaWHlQX0=; b=b5Kife2PXZ/bMiWsza3vCNWzwg
        chG4jygqGka2fRIeWGJ0YC3FX3IudhMF0WBsjEf9ruZYf6L8nlTDkNkQJtqOEZYwwdj1reywiergA
        r4p6SUnQY7tfkejdeDkxozOu76K7yAGNRz+kWUSUplZAZC4Ira2tP8sL4jLPG21eQlp1cdXxO88lK
        LFFktmmw1I9xnxmetkDIcIKBt4YvIgVKYDQN/2M9T/KRXdhlnMQ+48TQojQGtyMoqC3aGJmkaxR07
        DXdZs1+Q8L+xd6hWrBnHVMYbSNKxQC0+qzm5n6jDC4tRNhKf7JA/yob/ZJiR3fU2qwFpKtg51UUUz
        2r0H+xJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lGdPA-00FRpW-0r; Mon, 01 Mar 2021 07:55:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF03B3003E1;
        Mon,  1 Mar 2021 08:55:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D55B42B612D4F; Mon,  1 Mar 2021 08:55:44 +0100 (CET)
Date:   Mon, 1 Mar 2021 08:55:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 08/11] pragma once: convert scripts/atomic/
Message-ID: <YDyeAJjVTR5n2jyE@hirez.programming.kicks-ass.net>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
 <YDvM1vGPArSgUMPC@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDvM1vGPArSgUMPC@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 08:03:18PM +0300, Alexey Dobriyan wrote:
> From f10fe79897fa9600f144c76bc5df52dba28b7a66 Mon Sep 17 00:00:00 2001
> From: Alexey Dobriyan <adobriyan@gmail.com>
> Date: Tue, 9 Feb 2021 01:37:55 +0300
> Subject: [PATCH 08/11] pragma once: convert scripts/atomic/
> 
> Generate atomic headers without include guards.

-ENOCONTEXT, why ?
