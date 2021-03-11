Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98009336BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhCKFq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:46:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhCKFpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:45:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DB164E46;
        Thu, 11 Mar 2021 05:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615441553;
        bh=gFsS+ZhcKhKH6qL5gTXskivdxZUxVLc/m9X2ZpgUe+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OHIU/hI3nryGud2Pg/Db1a3HTIa7a/JS5yCaEueouoftYOkBFAOYSXC0KWPSu+6IY
         UPYRLsZBWqZxUgk9Wxrp9phIFNrgrFv9phUaIoiwANzRGv6YhL4ybYEoWAxNoC0iWe
         Uw3M+AKFMDXjT2gy+e7dqRLpdp5nSa/w75Os8qGc=
Date:   Wed, 10 Mar 2021 21:45:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@google.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH v4] kasan: remove redundant config option
Message-Id: <20210310214552.6dcbcb224c0ba34f8e0a0a54@linux-foundation.org>
In-Reply-To: <1615426365.20483.4.camel@mtksdccf07>
References: <20210226012531.29231-1-walter-zh.wu@mediatek.com>
        <1614772099.26785.3.camel@mtksdccf07>
        <1615426365.20483.4.camel@mtksdccf07>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 09:32:45 +0800 Walter Wu <walter-zh.wu@mediatek.com> wrote:

> 
> Hi Andrew,
> 
> I see my v4 patch is different in the next tree now. please see below
> information.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ebced5fb0ef969620ecdc4011f600f9e7c229a3c
> The different is in lib/Kconfig.kasan.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/diff/lib/Kconfig.kasan?id=ebced5fb0ef969620ecdc4011f600f9e7c229a3c
> 

They look the same to me.  I did have `int' for KASAN_STACK due to a
merging mess, but I changed that to bool quite quickly.

