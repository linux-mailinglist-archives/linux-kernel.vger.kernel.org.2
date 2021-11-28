Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E4A46028A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 01:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356655AbhK1AZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 19:25:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49256 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhK1AXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 19:23:48 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 209A3B80B23
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 00:20:32 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B29560524;
        Sun, 28 Nov 2021 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638058830;
        bh=CKZ+e8k135ZZUhwVMJEQB8rHyvFCB7GPOLchrJ0D5go=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0AOvXxVGgboRb7eA1NwxoOrMf3dtsAtHRbiyZJL4nEy3F08Oa/ZLj16GfcnXRIJmQ
         zNZm5UQQ+WtO20dXMQTea3IZT5FwLccbE4YPuMfSs7Jp9bVSU1rj6fTkfWTJcosPWc
         rf2Z7VW47FypZ3+a0a+W/VfSsCykoRdSyig12/zE=
Date:   Sat, 27 Nov 2021 16:20:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
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
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] kmemleak: fix kmemleak false positive report with HW
 tag-based kasan enable
Message-Id: <20211127162028.07d1a9fc392d91e7d234daae@linux-foundation.org>
In-Reply-To: <CA+fCnZchvHjU9G_SSf_M2--jHPqEa6PEr3u_5q-wJWvZK4N2pA@mail.gmail.com>
References: <20211118054426.4123-1-Kuan-Ying.Lee@mediatek.com>
        <754511d9a0368065768cc3ad8037184d62c3fbd1.camel@mediatek.com>
        <CA+fCnZchvHjU9G_SSf_M2--jHPqEa6PEr3u_5q-wJWvZK4N2pA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 17:13:36 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> > > kmemleak_object *object)
> > >  static struct kmemleak_object *lookup_object(unsigned long ptr, int
> > > alias)
> > >  {
> > >       struct rb_node *rb = object_tree_root.rb_node;
> > > +     unsigned long untagged_ptr = (unsigned
> > > long)kasan_reset_tag((void *)ptr);
> > >
> > >       while (rb) {
> > >               struct kmemleak_object *object =
> > >                       rb_entry(rb, struct kmemleak_object, rb_node);
> > > -             if (ptr < object->pointer)
> > > +             unsigned long untagged_objp;
> > > +
> > > +             untagged_objp = (unsigned long)kasan_reset_tag((void
> > > *)object->pointer);
> 
> The two lines above can be squashed together.

That would make a too-long line even longer.  In fact I think it's
better to go the other way:

--- a/mm/kmemleak.c~kmemleak-fix-kmemleak-false-positive-report-with-hw-tag-based-kasan-enable-fix
+++ a/mm/kmemleak.c
@@ -384,10 +384,10 @@ static struct kmemleak_object *lookup_ob
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
 	while (rb) {
-		struct kmemleak_object *object =
-			rb_entry(rb, struct kmemleak_object, rb_node);
+		struct kmemleak_object *object;
 		unsigned long untagged_objp;
 
+		object = rb_entry(rb, struct kmemleak_object, rb_node);
 		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
 
 		if (untagged_ptr < untagged_objp)
_

