Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F277B3F61B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhHXPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:33:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbhHXPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:33:52 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F02F8220C9;
        Tue, 24 Aug 2021 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629819186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtMO6pzq1JxxjsPovKorB/0Mr6odPB8iyF/tAHb2O5M=;
        b=IIKkR9oi+sDLUoi8Cbwd2wI7rALgdkP+TQN2nl4RAB88YcuxIN6wQkjzAYGPsbUgVlosI8
        aPkpbKoeKB/lHKPxz6B7ehi99PMLrioD/TqmvGH4rW1oVnPcuw8E4b7LtMPhyPALDCU3KA
        FE+srbfjvTo+IW0FoUPASJ5YrG7G+Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629819186;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtMO6pzq1JxxjsPovKorB/0Mr6odPB8iyF/tAHb2O5M=;
        b=5xjh/5eeT1SnMVaho6nTZ0WDMI/QOPo/mL0AnVHeT9v9RxgDkfv4D1Fwqzm68T0OQ9voUl
        tjaxmcAbiBaqU1DQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B9AE713A60;
        Tue, 24 Aug 2021 15:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 7NkGLDIRJWHZTwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 15:33:06 +0000
Message-ID: <09af2c88-35ce-41ff-c172-64766b156d80@suse.cz>
Date:   Tue, 24 Aug 2021 17:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210811011056.770351-1-almasrymina@google.com>
 <9f76b103-ba81-d4e3-1071-89009fb585a5@oracle.com>
 <CAHS8izOkTPYUn5aLYtma=YTAm6yYYraL7AqXjjC4hiqLXXSB-g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm, hugepages: add mremap() support for hugepage
 backed vma
In-Reply-To: <CAHS8izOkTPYUn5aLYtma=YTAm6yYYraL7AqXjjC4hiqLXXSB-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 01:35, Mina Almasry wrote:
> On Fri, Aug 13, 2021 at 4:40 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Adding Michal, Vlastimil and Kirill as adding this type of support
>> was discussed in this thread:
>> https://lore.kernel.org/linux-mm/3ba05809-63a2-2969-e54f-fd0202fe336b@gmx.de/
>>
> 
> Ack. I haven't gone through that thread but if there are any concerns
> with what I whipped up here, do let me know.

Looks like there were mostly concerns with vma's growing and you're not handling
that, so that's fine?

>> On 8/10/21 6:10 PM, Mina Almasry wrote:
>> > Support mremap() for hugepage backed vma segment by simply repositioning
>> > page table entries. The page table entries are repositioned to the new
>> > virtual address on mremap().
>> >
>> > Hugetlb mremap() support is of course generic; my motivating use case
>> > is a library (hugepage_text), which reloads the ELF text of executables
>> > in hugepages. This significantly increases the execution performance of
>> > said executables.

I think this scenario has been motivation for FS support of THP, but AFAIK we're
not there yet. Also IIRC Google had some library that did what you describe, but
using THP's instead of hugetlbfs - might be simpler as there are no reservations
involved.

But nothing against improving mremap() support wrt hugetlbfs.

> I'll yield to whatever you decide here because I reckon you have much
> more experience and better judgement here. But my thoughts:
> 
> 'Sane' usage of mremap() is something like:
> 1. mmap() a hugetlbfs vma.
> 2. Pass the vma received from step (1) to mremap() to remap it to a
> different location.
> 
> I don't know if there is another usage pattern I need to worry about
> but given the above, old_addr and old_len will be hugepage aligned
> already since they are values returned by the previous mmap() call
> which aligns them, no? So, I think aligning old_addr and old_len to
> the hugepage boundary is fine.
> 
> With this support we don't allow mremap() expansion. In my use case
> old_len==new_len acutally. I think it's fine to also align new_len to
> the hugepage boundary
> 
> I already have this code that errors out if the lengths are not aligned:
> 
> if (old_len & ~huge_page_mask(h) || new_len & ~huge_page_mask(h))
>     goto out;
> 
> I think aligning new_addr breaks my use case though. In my use case
> new_addr is the start of the text segment in the ELF executable, and I
> don't think that's guaranteed to be anything but page aligned.

Hm, I have a vague (possibly wrong) recollection that Andrea mentioned he always
planned text to be in THPs so he made sure ELF text sections are aligned as
such. I guess there's a way to declare alignment in ELF and it depends on
whether your distro's linker is set up to ask for hugepage-sized one?

> Aligning new_addr seems like it would break my use case. If you insist
> though I'm happy aligning new_addr in the upstream kernel and not
> doing that in our kernel, but if I'm not particularly happy with the
> hugepage alignment I'd say it is likely future users of hugetlb
> mremap() also won't like the hugepage alignement, but I yield to you
> here.
