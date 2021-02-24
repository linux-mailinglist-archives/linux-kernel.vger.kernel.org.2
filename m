Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD168323A42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhBXKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234856AbhBXKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614161435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJP+7xjpHI/L/CO5Uf055oueXseLV6cShrwJ7S+5kB8=;
        b=iRjGdvyU+kWKQudL+o2U1LKDMm6g2eA1b2j1Ijr56KBzb/+FcJXtTOkEIHIg/0R9XVkjjj
        cPt2rgVEDieDqTJ67Tv41LcTcucMGRrEbrVDMjPy8+iG43mg74X5XOpEXsWq3jXhWV6lzH
        Uj3MOP4oJq46iK5prpiJV9Dv76yhB5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-Wj9JxizGNyueDbUtdui9Yw-1; Wed, 24 Feb 2021 05:10:32 -0500
X-MC-Unique: Wj9JxizGNyueDbUtdui9Yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB25F1937FCC;
        Wed, 24 Feb 2021 10:10:30 +0000 (UTC)
Received: from [10.36.114.83] (ovpn-114-83.ams2.redhat.com [10.36.114.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF48460C4D;
        Wed, 24 Feb 2021 10:10:24 +0000 (UTC)
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
To:     Aili Yao <yaoaili@kingsoft.com>, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org, tony.luck@intel.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, inux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yangfeng1@kingsoft.com
References: <20210224151619.67c29731@alex-virtual-machine>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <97a2511e-2002-ec25-6902-8fe841922138@redhat.com>
Date:   Wed, 24 Feb 2021 11:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224151619.67c29731@alex-virtual-machine>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.02.21 08:16, Aili Yao wrote:
> When the page is already poisoned, another memory_failure() call in the
> same page now return 0, meaning OK. For nested memory mce handling, this
> behavior may lead real serious problem, Example:
> 
> 1.When LCME is enabled, and there are two processes A && B running on
> different core X && Y separately, which will access one same page, then
> the page corrupted when process A access it, a MCE will be rasied to
> core X and the error process is just underway.
> 
> 2.Then B access the page and trigger another MCE to core Y, it will also
> do error process, it will see TestSetPageHWPoison be true, and 0 is
> returned.
> 
> 3.The kill_me_maybe will check the return:
> 
> 1244 static void kill_me_maybe(struct callback_head *cb)
> 1245 {
> 
> 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
> p->mce_whole_page);
> 1257                 sync_core();
> 1258                 return;
> 1259         }
> 
> 1267 }
> 
> 4. The error process for B will end, and may nothing happened if
> kill-early is not set, We may let the wrong data go into effect.
> 
> For other cases which care the return value of memory_failure() should
> check why they want to process a memory error which have already been
> processed. This behavior seems reasonable.
> 
> In kill_me_maybe, log the fact about the memory may not recovered, and
> we will kill the related process.
>

Is -EBUSY then the right return value?

I'd expect if it's already poisoned that we would get something like 
EHWPOISON.

Does this affect existing user space interfaces (especially, via madvise?)?

-- 
Thanks,

David / dhildenb

