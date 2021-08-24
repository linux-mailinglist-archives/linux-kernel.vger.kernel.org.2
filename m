Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95CE3F6BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhHXW73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhHXW72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:59:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F64C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:58:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me10so19209988ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f10+9KbmQ1w02G7q+vYSGq4zSlnvBUYSA0JIwEQJN9s=;
        b=DoP7KssKpIp9XCkUTxSi/zJLenqik0tcmDAHiauRUoCkNW9AhrTA3DICkRxjXiq0Gq
         dRYBDkL5Sym1M6q0snsRd390sVMfXGrjN4fhrFCdghsp6nJrY87LvE04TTqy7NIbkhJH
         Bd3tOpoDw8/4jKEFu2fgyGRtZdjv/oeTtLYgDgmlKzPlQFWzlbTUj6H2AOJ8Fjru+1qF
         Gr2t0qpDr/877oJTSPkPeomwi2Tu/pIfVMAtkvGrNQU4PRdHQ+/nyWnNwWM2pKyt0Bcb
         jxFyls6YkCRdmA2MdEVtUerQbZwTFVThTly3iQS2e16Hpazi8Rd4GvD36CQqHkS9pdJp
         q9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f10+9KbmQ1w02G7q+vYSGq4zSlnvBUYSA0JIwEQJN9s=;
        b=Gf8LJDNPkbG1cL6DUUo/ZXqUEN06OHiAKpa3ZZb7qUrvWYXZKBRQTnXQfnPM067TWA
         80NpwrAd9zAU2v9XzfSytm0GJMeapBbt/oVvi0aIjXPhuMZSVDvhjdLbS1MTNzqvKq4k
         sgQrAbJAeiYYP8hnlL91JxGq4jEPj5DJBUtgtmn5b7pOvyhCOnJsKuGSIXA1HWMowukX
         a3pk+YTIMATOSnFMlARGjPYlu8BvcSAWHcFts+bADbQc34BtoCive5RQl4bnBH0Q8DX9
         iY/vqwXRHEl5JLceSssuldEQRi1ee6vn9D0o7vY3jPk1YAGrkrteMmNYJb7xX/4eek+7
         MG/A==
X-Gm-Message-State: AOAM533zPO4X9rXj4nUL0MvgVXiv8TyjoZjIXteKtmyQjpZsOovR9w3q
        tMictRX43NEosmMWqfmVPruI26YdEU+vSLAQMnM3
X-Google-Smtp-Source: ABdhPJxphheJHK+XVxQzW59S2SSw9xvK1dsGezokUCC9HbcvtIAjkZDCpr7mjhHvBb36Y3tNY9r86bzMjjZUkqHPwKI=
X-Received: by 2002:a17:907:a04d:: with SMTP id gz13mr10091350ejc.91.1629845922271;
 Tue, 24 Aug 2021 15:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <caba6f2509ce8eedb6c904e9b0e13ca676bd7d61.1629770243.git.rgb@redhat.com>
In-Reply-To: <caba6f2509ce8eedb6c904e9b0e13ca676bd7d61.1629770243.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Aug 2021 18:58:31 -0400
Message-ID: <CAHC9VhSXJZs=f6u8m3P3PcA3PJPUMGei+vBZzLe1fvzRo90iHw@mail.gmail.com>
Subject: Re: [ghak-trim PATCH v1] audit: move put_tree() to avoid trim_trees
 refcount underflow and UAF
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seiji Nishikawa <snishika@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 10:05 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> AUDIT_TRIM is expected to be idempotent, but multiple executions resulted in a
> refcount underflow and use-after-free.
>
> git bisect fingered commit fb041bb7c0a918b95c6889fc965cdc4a75b4c0ca (2019-11)
>         ("locking/refcount: Consolidate implementations of refcount_t")
> but this patch with its more thorough checking that wasn't in the x86 assembly
> code merely exposed a previously existing tree refcount imbalance in the case
> of tree trimming code that was refactored with prune_one() to remove a tree
> introduced in commit 8432c70062978d9a57bde6715496d585ec520c3e (2018-11)
>         ("audit: Simplify locking around untag_chunk()")
>
> Move the put_tree() to cover only the prune_one() case.
>
> Passes audit-testsuite and 3 passes of "auditctl -t" with at least one
> directory watch.
>
> Fixes: 8432c7006297 ("audit: Simplify locking around untag_chunk()")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Seiji Nishikawa <snishika@redhat.com>
> ---
>  kernel/audit_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

First a quick comment about the commit description, when referencing
specific commits in the description please use the same format that
you used in the "Fixes:" tag; it makes the description easier to read.
No need to resend, I fixed it when I merged your patch, but something
to keep in mind for the future.

As for the patch itself, thanks for finding this and sending a fix.
Normally this is something I would send up to Linus at the end of the
week during the -rcX phase, but since we are currently at -rc7 I'm
going to simply add the -stable marking and merge it into audit/next
to get pushed up to Linus early next week, assuming we see v5.14
released this Sunday.  If for some reason we see a v5.14-rc8 next week
I'll adjust things and send it to Linus as a -stable patch.

-- 
paul moore
www.paul-moore.com
