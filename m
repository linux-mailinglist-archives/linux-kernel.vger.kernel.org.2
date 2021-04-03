Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5E35340D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhDCMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 08:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhDCMns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 08:43:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41331C0613E6;
        Sat,  3 Apr 2021 05:43:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h8so3630032plt.7;
        Sat, 03 Apr 2021 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l9J7Rrtr5vX5sTUcC2BnLF28M3UYe4/pHrGKjFh6MSM=;
        b=rAvyolEtINNdsn5rcy3zoxvT4KgaWso521j7kK32Tou5ahiOGCzNYoJ/C4JX+3MyMz
         RuO8HtjcUj6jQbZ0zPkrFOvwSHYK7c4sFBj0SALgClqXcSnkc625rREamCwz8icGWz8B
         HdRZDnhHJ1gD6QFeGH17t+PXvSbMnVkJ5S6a6avakA5oVvrCmjXiEr2t0l6gzarNTf/v
         lkqakN/ko91X4kdjY+DifBrSEwT74Hfi4Br6zngZ55TRS5PfVtAqWtouvQxlQqqOL/5g
         01ZPIjSK4reAESN0t6s8FrUTYvIqqBhBflJQC3U9LL8HOYkMbRBHGVhY1VUJXYBe3J0R
         T19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9J7Rrtr5vX5sTUcC2BnLF28M3UYe4/pHrGKjFh6MSM=;
        b=ATuJcP3S8Wp1GbjYNlaIWb3AYfymkVZYyftKGwFlFJFYd5hGWmku4YYQkUd9exV4s5
         kz/E07hxYU5EiT3mpCRL9HLF0iG43Utb45bB+jWsqUPzRCUCLhTsChfVDX8HH4NpjiAj
         un0/xgUUWTViquRM1ijIOJeKnZi4sSP59fLjeJYjn9YIJq9kTHT0on9XjMuxlr2HdwFh
         fMhVg7cyFhJ/KYhjSkEvOqpKYDZih1i3LNhf58QKCRO0esTLNKr6Rbn8QQ6x9grjyJ1a
         jeHZz71CXPh13l/MtdupSPg8bNRic1s9aQ3HP1R7qBMWQgG5oeNeAJg10l40KN7NgSju
         XNfQ==
X-Gm-Message-State: AOAM532/UwnKnMA/Db6o82cA3BwxBrs+e9OL0t6K9YOZP+vE7s5aGOoY
        dr6Yfae8kahoRv94nTBa+VdROIVORqjZWQ==
X-Google-Smtp-Source: ABdhPJw9MyAP3c9lzuu0qApDj+cYYiZVnB1RR6reKtnceMO8i0UaIlAmY2rHQmXQ9cZHZD59gERA2Q==
X-Received: by 2002:a17:90a:1b0e:: with SMTP id q14mr17620107pjq.41.1617453824146;
        Sat, 03 Apr 2021 05:43:44 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:150c:a6c7:d4:6d35? ([2405:201:600d:a089:150c:a6c7:d4:6d35])
        by smtp.gmail.com with ESMTPSA id g4sm11158310pgu.46.2021.04.03.05.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 05:43:43 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
Subject: Re: [PATCH] scripts: kernel-doc: add warning for comment not
 following kernel-doc syntax
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210329092945.13152-1-yashsri421@gmail.com>
 <87czvit65m.fsf@meer.lwn.net>
 <a35096d5-99e7-6b69-c959-1136d511a0ff@gmail.com>
 <87mtujktl2.fsf@meer.lwn.net>
Message-ID: <0b5cedae-d89e-e558-906d-846ed01f27ca@gmail.com>
Date:   Sat, 3 Apr 2021 18:13:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87mtujktl2.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 1:02 am, Jonathan Corbet wrote:
> Aditya Srivastava <yashsri421@gmail.com> writes:
>
>> On 29/3/21 7:26 pm, Jonathan Corbet wrote:
>>> Aditya Srivastava <yashsri421@gmail.com> writes:
>>>
>>>> Currently, kernel-doc start parsing the comment as a kernel-doc comment if
>>>> it starts with '/**', but does not take into account if the content inside
>>>> the comment too, adheres with the expected format.
>>>> This results in unexpected and unclear warnings for the user.
>>>>
>>>> E.g., running scripts/kernel-doc -none mm/memcontrol.c emits:
>>>> "mm/memcontrol.c:961: warning: expecting prototype for do not fallback to current(). Prototype was for get_mem_cgroup_from_current() instead"
>>>>
>>>> Here kernel-doc parses the corresponding comment as a kernel-doc comment
>>>> and expects prototype for it in the next lines, and as a result causing
>>>> this warning.
>>>>
>>>> Provide a clearer warning message to the users regarding the same, if the
>>>> content inside the comment does not follow the kernel-doc expected format.
>>>>
>>>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>>>> ---
>>>>  scripts/kernel-doc | 17 +++++++++++++----
>>>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>> This is definitely a capability we want, but I really don't think that
>>> we can turn it on by default - for now.  Experience shows that if you
>>> create a blizzard of warnings, nobody sees any of them.  How many
>>> warnings does this add to a full docs build?
>>>
>>
>> Hi Jonathan, here's the diff I have created for the warnings before
>> and after the changes:
>> https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/kernel_doc_comment_syntax.txt
>>
>> Around ~1320 new warnings of this type are added to the kernel tree,
>> and around ~1580 warnings are removed.
>
> So I finally got around to looking at this again...  How did you
> generate that file?
>

I ran scripts/kernel-doc -none on all the files in the kernel tree
before and after appying the changes, and then generated their diff to
find the warnings removed and added.

> I tried applying the patch and doing a normal full htmldocs build and
> got all of four warnings:
>
>   ./include/linux/seqlock.h:829: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>    * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
>   ./fs/jbd2/journal.c:1391: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>    *  journal_t * jbd2_journal_init_dev() - creates and initialises a journal structure
>   ./fs/jbd2/journal.c:1422: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>    *  journal_t * jbd2_journal_init_inode () - creates a journal which maps to a inode.
>   ./include/linux/dcache.h:309: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>    *      dget, dget_dlock -      get a reference to a dentry
>

I think there should be more warnings. For e.g., running kernel-doc
-none ./drivers/usb/mtu3/mtu3.h gives these warnings:

./drivers/usb/mtu3/mtu3.h:75: warning: This comment starts with '/**',
but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst
./drivers/usb/mtu3/mtu3.h:86: warning: This comment starts with '/**',
but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst
./drivers/usb/mtu3/mtu3.h:143: warning: This comment starts with
'/**', but isn't a kernel-doc comment. Refer
Documentation/doc-guide/kernel-doc.rst

> Two observations:
>
>  - This is not an awful lot of warnings - not the blizzard I had
>    feared.  At this level, I think we can just merge the patch and
>    then, hopefully, fix those cases.
>
>  - All of the warned-about places are *attempts* to write real kerneldoc
>    comments, they just got the syntax wrong in one way or another.  It's
>    probably not worth the effort to try to detect this case - the
>    warning is enough to draw attention to the comment in question.
>

I agree. Above are some of the cases which are not getting detected by
this patch.
This may be so as I am only allowing the function syntax as mentioned
in the rst file, i.e., "^\s*\*\s*([\w\s]+?)(\(\))?\s*([-:].*)?$" or
("* foo(\(\))? - description")

I probably need to check for pointers as well and other similar case(s).
Maybe I should design a separate check for functions than assigning
$decl_type = 'function' in the first check.

What do you think?

Thanks
Aditya
