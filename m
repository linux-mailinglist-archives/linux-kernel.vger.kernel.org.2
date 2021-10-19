Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6CB433647
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhJSMsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:48:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47794 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSMsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:48:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 78B391F43975
Message-ID: <2a854d67-39f8-508e-10f0-7d571d853a0c@collabora.com>
Date:   Tue, 19 Oct 2021 09:46:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH -next] Documentation: futex: handle source file rename
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <20211019022212.6914-1-rdunlap@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20211019022212.6914-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Às 23:22 de 18/10/21, Randy Dunlap escreveu:
> Handle the move/rename of kernel/futex.c to kernel/futex/core.c.
> 
> Prevents docs build errors and warnings:
> 
> Error: Cannot open file ../kernel/futex.c
> Error: Cannot open file ../kernel/futex.c
> Error: Cannot open file ../kernel/futex.c
> Error: Cannot open file ../kernel/futex.c
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-version 1.8.5 -internal ../kernel/futex.c' failed with return code 2
> WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -sphinx-version 1.8.5 -internal ../kernel/futex.c' failed with return code 2
> 
> Fixes: 77e52ae35463 ("futex: Move to kernel/futex/")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: André Almeida <andrealmeid@collabora.com>
> Cc: linux-doc@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>

Thanks for your patch. I had already sent a fix:
https://lore.kernel.org/lkml/20211012135549.14451-1-andrealmeid@collabora.com/


Peter, can you get my fix at tip/locking/core?
