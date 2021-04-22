Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0B36856A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238320AbhDVRCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbhDVRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:02:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0073C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:02:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e2900329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:2900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 279641EC047F;
        Thu, 22 Apr 2021 19:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619110921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V9HbXQ0do/5kolNtrmxXCTBW4RIorF+m2CxiqXYrMkA=;
        b=G8wRccL+4ing5H+EGOTjGZcQWlEIEnnysR9kZJe/ZMV67xSvcItpJhGF9nmjKVglPadRcT
        U1sxGuTge9x5mqQcPpV6pordkU2ienB/SUMpur3xpaCxBodg9ytUOUeBdjX74ZDFEn2+uo
        Rh6AHTZSC+oF9EPWARes4lsWOwv18xo=
Date:   Thu, 22 Apr 2021 19:02:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm,hwpoison: return -EHWPOISON when page already
Message-ID: <20210422170204.GD7021@zn.tnic>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <20210421005728.1994268-3-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421005728.1994268-3-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:57:27AM +0900, Naoya Horiguchi wrote:
> From: Aili Yao <yaoaili@kingsoft.com>

> Subject: Re: [PATCH v3 2/3] mm,hwpoison: return -EHWPOISON when page already

		... Return -EHWPOISON to denote that the page has already been poisoned"

> When the page is already poisoned, another memory_failure() call in the
> same page now returns 0, meaning OK. For nested memory mce handling, this
> behavior may lead to one mce looping,

s/mce/MCE/g

> Example:

For example:

> 1. When LCME is enabled, and there are two processes A && B running on
> different core X && Y separately, which will access one same page, then

				  which access the same page...

s/&&/and/g

> the page corrupted when process A access it, a MCE will be rasied to
> core X and the error process is just underway.

... and you lost me here. I don't understand what that is trying to say.
Is that trying to say that when process A encounters the error, the MCE
will be raised on CPU X?

> 2. Then B access the page and trigger another MCE to core Y, it will also
> do error process, it will see TestSetPageHWPoison be true, and 0 is
> returned.

That sentence needs massaging.

> 3. The kill_me_maybe will check the return:
> 
>     1244 static void kill_me_maybe(struct callback_head *cb)
>     1245 {
>     ...
>     1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
>     1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
>     1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
>     1257                 sync_core();
>     1258                 return;
>     1259         }
>     ...
>     1267 }

No need for the line numbers.

> 4. The error process for B will end, and may nothing happened if
> kill-early is not set, The process B will re-excute instruction and get
> into mce again and then loop happens. And also the set_mce_nospec()
> here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
> mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").

That needs massaging too.

> For other cases which care the return value of memory_failure() should
> check why they want to process a memory error which have already been
> processed. This behavior seems reasonable.

This whole commit message needs sanitizing.

Also, looking at the next patch, you can merge this one into the next
because the next one is acting on -EHWPOISON so it all belongs together
in a single patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
