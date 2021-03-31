Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47334FEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhCaK7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235165AbhCaK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617188342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6L2AUqo5nz2UoERmv8ppYznSIQciq71zeLTZsRCRB0=;
        b=H+C2645TlHrCxc0nyPOvpZzOgmhGq8HRKTzcegY0e/Wuz2UHLrv0WZwpLv/H8cp88cq+RH
        JalkyHJcENQkvxtpzbmtWp56nEiJrcRDiq3SWRA4W8e0koDkTf9k9YhJsBjqLC5QnfBbjH
        lvxVDKkrFQDURFtOkjWdapTdQasiTWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-hWliKZPRN5OCmyKvlfuoNw-1; Wed, 31 Mar 2021 06:58:58 -0400
X-MC-Unique: hWliKZPRN5OCmyKvlfuoNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E61F107ACCD;
        Wed, 31 Mar 2021 10:58:56 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5253F6F135;
        Wed, 31 Mar 2021 10:58:51 +0000 (UTC)
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
To:     Aili Yao <yaoaili@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKCDloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux> <20210225114329.4e1a41c6@alex-virtual-machine>
 <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
 <20210225113930.GA7227@localhost.localdomain>
 <20210331185637.76f863e2@alex-virtual-machine>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <0d6f0f9c-f644-1246-0530-e39656a207ca@redhat.com>
Date:   Wed, 31 Mar 2021 12:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331185637.76f863e2@alex-virtual-machine>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 12:56, Aili Yao wrote:
> On Thu, 25 Feb 2021 12:39:30 +0100
> Oscar Salvador <osalvador@suse.de> wrote:
> 
>> On Thu, Feb 25, 2021 at 11:28:18AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> Hi Aili,
>>>
>>> I agree that this set_mce_nospec() is not expected to be called for
>>> "already hwpoisoned" page because in the reported case the error
>>> page is already contained and no need to resort changing cache mode.
>>
>> Out of curiosity, what is the current behavour now?
>> Say we have an ongoing MCE which has marked the page as HWPoison but
>> memory_failure did not take any action on the page yet.
>> And then, we have another MCE, which ends up there.
>> set_mce_nospec might clear _PAGE_PRESENT bit.
>>
>> Does that have any impact on the first MCE?
>>
>>> It seems to me that memory_failure() does not return MF_XXX.  But yes,
>>> returning some positive value for the reported case could be a solution.
>>
>> No, you are right. I somehow managed to confuse myself.
>> I see now that MF_XXX return codes are filtered out in page_action.
>>
>>> We could use some negative value (error code) to report the reported case,
>>> then as you mentioned above, some callers need change to handle the
>>> new case, and the same is true if you use some positive value.
>>> My preference is -EHWPOISON, but other options are fine if justified well.
>>
>> -EHWPOISON seems like a good fit.
>>
> 
> Hi Oscar, david:
> 
> Long away fron this topic, but i noticed today I made a stupid mistake that EHWPOISON is already
> been declared, so we should better return EHWPOISON for this case.
> 
> Really sorry for this!
> 
> As the patch is still under review, I will post a new version for this, if I change this, may I add
> your review tag here please?

Just resend as v2. We will review and post our RBs there.


-- 
Thanks,

David / dhildenb

