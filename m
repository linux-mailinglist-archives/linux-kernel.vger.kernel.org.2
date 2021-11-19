Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93F4578F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhKSWrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234720AbhKSWrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:47:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E767E611F0;
        Fri, 19 Nov 2021 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637361841;
        bh=/8D+DWwiOLrMlIDqL9IKYgJ9r6bICMktA9e46Vj/SXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fw4+VpZGxF2/jqYJa04GV+BNGu9xw9HBBPZSNzLAGos4KZWJpmip59Je0jxAguAHA
         lGVIxlfSXZE3iZaIE0AJcoLifsIh2Wb4yXmDAhfOW77+nF4jjZXBNx5gGEikmxE3Eb
         JF+3PlpsYq6suO/cIx4EmS3D0NdLfHwdV51o30Cg=
Date:   Fri, 19 Nov 2021 14:43:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chinwen Chang (=?UTF-8?Q?=E5=BC=B5=E9=8C=A6=E6=96=87?=) 
        <chinwen.chang@mediatek.com>,
        Nicholas Tang (=?UTF-8?Q?=E9=84=AD=E7=A7=A6?= =?UTF-8?Q?=E8=BC=9D?=) 
        <nicholas.tang@mediatek.com>,
        James Hsu ( =?UTF-8?Q?=E5=BE=90=E6=85=B6=E8=96=B0?=) 
        <James.Hsu@mediatek.com>,
        Yee Lee (=?UTF-8?Q?=E6=9D=8E=E5=BB=BA=E8=AA=BC?=) 
        <Yee.Lee@mediatek.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        <kuan-ying.lee@mediatek.com>
Subject: Re: [PATCH] kmemleak: fix kmemleak false positive report with HW
 tag-based kasan enable
Message-Id: <20211119144359.b70d2fde7631bd14cd9652e3@linux-foundation.org>
In-Reply-To: <c5cfd0c41dee93cd923762a6e0d61baea52cec8d.camel@mediatek.com>
References: <20211118054426.4123-1-Kuan-Ying.Lee@mediatek.com>
        <754511d9a0368065768cc3ad8037184d62c3fbd1.camel@mediatek.com>
        <CA+fCnZddknY6XLychkAUkf9eYvEW4z9Oyr8cZb2QfBMDkJ23zg@mail.gmail.com>
        <c5cfd0c41dee93cd923762a6e0d61baea52cec8d.camel@mediatek.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 23:12:55 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:

> > > > Call sequence:
> > > > ptr = kmalloc(size, GFP_KERNEL);
> > > > page = virt_to_page(ptr);
> > > > kfree(page_address(page));
> > > > ptr = kmalloc(size, GFP_KERNEL);
> > 
> > How is this call sequence valid? page_address returns the address of
> > the start of the page, while kmalloced object could have been located
> > in the middle of it.
> 
> Thanks for pointing out. I miss the offset.
> 
> It should be listed as below.
> 
> ptr = kmalloc(size, GFP_KERNEL);
> page = virt_to_page(ptr);
> offset = offset_in_page(ptr);
> kfree(page_address(page) + offset);
> ptr = kmalloc(size, GFP_KERNEL);

I updated the changelog to reflect this.
