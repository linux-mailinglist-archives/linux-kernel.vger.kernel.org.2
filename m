Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E980B45F615
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 21:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKZUyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 15:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhKZUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 15:52:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF9C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 12:48:34 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v1so43470689edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pG4xlGmNMDFGr825O/R6uCl26bzbZQEprxIK7faKN9s=;
        b=Prc8NPT9XbWakzgu+3afC265bExR0XcARtyU6sNY1ExCWqDKxnkj4VBHatykhOILZ7
         FK0Lv7/uEKg68llA2ON8NtFhjO5dgu8tLVds31JaI+Qv9hevgPGr+e7b90nqb5ovvt9k
         fNuqoElXqScEDrzJRHNWXfiA96HAlu+RdUPfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pG4xlGmNMDFGr825O/R6uCl26bzbZQEprxIK7faKN9s=;
        b=mg7YZnVDGIuHo71Torm/RRaDgud9nDkI4v0xyTA1sl00ed51WtqBMdZzTuMxMLvUqc
         jMcz6FpHro+Lft/Db1LZQgy/+3dtZ4aFCSbINYOWpEYbp1b29s0Cjuj3rPmCb9X1nw2U
         7DZBBqC/tOS1omd3qGJeVIyS9JrRAz5vOOQ4xStpPwUgjw7lx4FvBjDvJ9eCQwqkGsLj
         8Ie+i5jy4qncIclKJ99Kts8zWOI5aY65FQXXCbFVZbW59vvI/5Dw6rmLhefAf5oVjMIW
         CBmfPTkSM9TdC92hZkxGpV6VPYZflj3xkmJFTIL02QRQjTJHzNZI3YspFgos27YXBcLX
         /xpw==
X-Gm-Message-State: AOAM533n2oFWwYOO5DofRr2j3fPG4FztSYrlc1w/BHC3a2RaV++YBJXS
        GAgFUnwyPc+Ef7dhOjOk9a48cu3S5itYgfY/
X-Google-Smtp-Source: ABdhPJyaj/W60n9ykE5R+nH4EiZAVl3G9Ec6G+l1REFg8LKp6cpcnmBMxlf4cetYuPL9TayeW0sphA==
X-Received: by 2002:a05:6402:12c1:: with SMTP id k1mr50688911edx.355.1637959712682;
        Fri, 26 Nov 2021 12:48:32 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id co10sm4516958edb.83.2021.11.26.12.48.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 12:48:31 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id t9so4124593wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 12:48:31 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr17098118wre.140.1637959711645;
 Fri, 26 Nov 2021 12:48:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637940049.git.dsterba@suse.com>
In-Reply-To: <cover.1637940049.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Nov 2021 12:48:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia6jNRQDm51wNf2X2cNGeN+5Uz3DWQ2bgnGyVRK4LRJA@mail.gmail.com>
Message-ID: <CAHk-=wia6jNRQDm51wNf2X2cNGeN+5Uz3DWQ2bgnGyVRK4LRJA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 5.16-rc3
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 7:42 AM David Sterba <dsterba@suse.com> wrote:
>
> one more fix to the lzo code, a missing put_page causing memory leaks
> when some error branches are taken.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.16-rc2-tag

Hmm.

pr-tracker-bot didn't react to this one, and it wasn't obvious why.

Until I started looking closer. You claim:

> for you to fetch changes up to 504d851ab360dc00e2163acef2e200ea69ac800a:
>
>   btrfs: fix the memory leak caused in lzo_compress_pages() (2021-11-26 14:32:40 +0100)

but in fact it's commit daf87e953527, not as the pull request claims
504d851ab360..

And no, it's not the tag either, that was d0a295f521e2.

The diffstat and the shortlog matched, so I had pulled it without
noticing. But something went wrong in there in the pull request.

               Linus
