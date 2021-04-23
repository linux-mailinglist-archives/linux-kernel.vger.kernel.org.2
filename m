Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5313691A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 13:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbhDWL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 07:58:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53326 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242260AbhDWL6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:58:06 -0400
Received: from zn.tnic (p200300ec2f0cb100de1b78f3b91faa58.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:b100:de1b:78f3:b91f:aa58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B5301EC0118;
        Fri, 23 Apr 2021 13:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619179049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hl4owIygIiuL+Uo1VjLb8yx5rvDHEvzCcFzwABb5PYo=;
        b=cGIDsJufxJejr6m5pU81tTIT5Zyyt/2m8sYjxfkATzMh/3QXpk/K/n8xkzuQocNbCoqnl9
        6d8orgS8F0w3utnveodjRJL4h4MBQ6mAb3318hEQ3HyHAWpVgMjvVvq8hjFsTAlSkRFQjT
        tzlIChMkDT5sk7sIhm7GSvd/E9pb8js=
Date:   Fri, 23 Apr 2021 13:57:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Message-ID: <20210423115725.GB18085@zn.tnic>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <20210421005728.1994268-4-nao.horiguchi@gmail.com>
 <20210422170213.GE7021@zn.tnic>
 <20210423021833.GB68967@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210423021833.GB68967@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 02:18:34AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> I don't know exactly.  MCE subsystem seems to have code extracting linear
> address, so I wonder that that could be used as a hint to memory_failure()
> to find the proper virtual address.

See "Table 15-3. Address Mode in IA32_MCi_MISC[8:6]" in the SDM -
apparently it can report all kinds of address types, depending on the hw
incarnation or MCA bank type or whatnot. Tony knows :)

> The situation in question is caused by action required MCE, so
> we know which process we should send SIGBUS to. So if we choose
> to send SIGBUS to all, no innocent bystanders would be affected.
> But when the process have multiple virtual addresses associated
> with the error physical address, the process receives multiple
> SIGBUSs and all but one have wrong value in si_addr in siginfo_t,
> so that's confusing.

Is that scenario real or hypothetical?

Because I'd expect that if we send it a SIGBUS and we poison that page,
then all the VAs mapping it will have to handle the situation that that
page has been poisoned and pulled from under them.

So from a hw perspective, there won't be any more accesses to the faulty
physical page.

In a perfect world, that is...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
