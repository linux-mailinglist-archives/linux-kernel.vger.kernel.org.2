Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E0350767
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhCaTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbhCaTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:32:10 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC5CC061574;
        Wed, 31 Mar 2021 12:32:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 335FA9A8;
        Wed, 31 Mar 2021 19:32:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 335FA9A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617219130; bh=hZwGuOo7xBljtRcLVGar1Uk5RDsxdyJQt5UiAYHN+jc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=E7ufQWAca4gTgjOdNkDbwdFZsU25mdw2tplB6ctexMcpjFECDHkl1uj1asFkfJKU3
         FkOuM5VUFbxiYj/qttGYof7zZJCFaIgqbHW1bPmTjd7lxgqNlvTw+iGBZPWSCISx9v
         9pI2Qqy9Y2QdlMJA9dEJQ8nRrhNnwQ8NLclSBVvC3geZBz+9cnAC2Vnf0MBJwehQA4
         tjDzwKUOmgEeisYHK0jaNMQYIRKAuUbKXb0NLmMvZ0p6TkwgUPm+3M2+A5bpj/8vYO
         //zZZKmzljHy5HqES9WWjgE627obg0Ek79rboZLNSGrDseW7+Q9AGKktpVG4tQcL2Z
         r5sj8cQXv0I4w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: add warning for comment not
 following kernel-doc syntax
In-Reply-To: <a35096d5-99e7-6b69-c959-1136d511a0ff@gmail.com>
References: <20210329092945.13152-1-yashsri421@gmail.com>
 <87czvit65m.fsf@meer.lwn.net>
 <a35096d5-99e7-6b69-c959-1136d511a0ff@gmail.com>
Date:   Wed, 31 Mar 2021 13:32:09 -0600
Message-ID: <87mtujktl2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> On 29/3/21 7:26 pm, Jonathan Corbet wrote:
>> Aditya Srivastava <yashsri421@gmail.com> writes:
>> 
>>> Currently, kernel-doc start parsing the comment as a kernel-doc comment if
>>> it starts with '/**', but does not take into account if the content inside
>>> the comment too, adheres with the expected format.
>>> This results in unexpected and unclear warnings for the user.
>>>
>>> E.g., running scripts/kernel-doc -none mm/memcontrol.c emits:
>>> "mm/memcontrol.c:961: warning: expecting prototype for do not fallback to current(). Prototype was for get_mem_cgroup_from_current() instead"
>>>
>>> Here kernel-doc parses the corresponding comment as a kernel-doc comment
>>> and expects prototype for it in the next lines, and as a result causing
>>> this warning.
>>>
>>> Provide a clearer warning message to the users regarding the same, if the
>>> content inside the comment does not follow the kernel-doc expected format.
>>>
>>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>>> ---
>>>  scripts/kernel-doc | 17 +++++++++++++----
>>>  1 file changed, 13 insertions(+), 4 deletions(-)
>> 
>> This is definitely a capability we want, but I really don't think that
>> we can turn it on by default - for now.  Experience shows that if you
>> create a blizzard of warnings, nobody sees any of them.  How many
>> warnings does this add to a full docs build?
>> 
>
> Hi Jonathan, here's the diff I have created for the warnings before
> and after the changes:
> https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/kernel_doc_comment_syntax.txt
>
> Around ~1320 new warnings of this type are added to the kernel tree,
> and around ~1580 warnings are removed.

So I finally got around to looking at this again...  How did you
generate that file?

I tried applying the patch and doing a normal full htmldocs build and
got all of four warnings:

  ./include/linux/seqlock.h:829: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
  ./fs/jbd2/journal.c:1391: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   *  journal_t * jbd2_journal_init_dev() - creates and initialises a journal structure
  ./fs/jbd2/journal.c:1422: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   *  journal_t * jbd2_journal_init_inode () - creates a journal which maps to a inode.
  ./include/linux/dcache.h:309: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
   *      dget, dget_dlock -      get a reference to a dentry

Two observations:

 - This is not an awful lot of warnings - not the blizzard I had
   feared.  At this level, I think we can just merge the patch and
   then, hopefully, fix those cases.

 - All of the warned-about places are *attempts* to write real kerneldoc
   comments, they just got the syntax wrong in one way or another.  It's
   probably not worth the effort to try to detect this case - the
   warning is enough to draw attention to the comment in question.

Thanks,

jon
