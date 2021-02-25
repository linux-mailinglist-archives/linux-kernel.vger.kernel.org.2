Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07348324F54
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhBYLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:40:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:55048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231895AbhBYLkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:40:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59D36AC6E;
        Thu, 25 Feb 2021 11:39:40 +0000 (UTC)
Date:   Thu, 25 Feb 2021 12:39:30 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Aili Yao <yaoaili@kingsoft.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210225113930.GA7227@localhost.localdomain>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux>
 <20210225114329.4e1a41c6@alex-virtual-machine>
 <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 11:28:18AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> Hi Aili,
> 
> I agree that this set_mce_nospec() is not expected to be called for
> "already hwpoisoned" page because in the reported case the error
> page is already contained and no need to resort changing cache mode.

Out of curiosity, what is the current behavour now?
Say we have an ongoing MCE which has marked the page as HWPoison but
memory_failure did not take any action on the page yet.
And then, we have another MCE, which ends up there.
set_mce_nospec might clear _PAGE_PRESENT bit.

Does that have any impact on the first MCE?

> It seems to me that memory_failure() does not return MF_XXX.  But yes,
> returning some positive value for the reported case could be a solution.

No, you are right. I somehow managed to confuse myself.
I see now that MF_XXX return codes are filtered out in page_action.

> We could use some negative value (error code) to report the reported case,
> then as you mentioned above, some callers need change to handle the
> new case, and the same is true if you use some positive value.
> My preference is -EHWPOISON, but other options are fine if justified well.

-EHWPOISON seems like a good fit.


-- 
Oscar Salvador
SUSE L3
