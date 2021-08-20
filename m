Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365243F34B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhHTTlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhHTTlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:41:06 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:40:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A140A12801DB;
        Fri, 20 Aug 2021 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629488427;
        bh=m7pwO1nE5aq19db0pqFBeoLj6CeJBhN9nsxzrjprEGM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=MmqJ3XZXEfMCJlAKFh2eI/5ZYNGKBfgORnXhNp0Zz7I8QwbNLAPGdES1xy51LhjVO
         rQScnkEoKTaMQc34aIco0fRK5nIv5TfrSq8gvxUWmL5KtI/8U5OI1KJ5HGcbYmbU5B
         oab87nnJpijZ65kA7FHDIJKwwQieIIrNJmAuR/dI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jN7dzCKAsSvP; Fri, 20 Aug 2021 12:40:27 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3077212801B4;
        Fri, 20 Aug 2021 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629488427;
        bh=m7pwO1nE5aq19db0pqFBeoLj6CeJBhN9nsxzrjprEGM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=MmqJ3XZXEfMCJlAKFh2eI/5ZYNGKBfgORnXhNp0Zz7I8QwbNLAPGdES1xy51LhjVO
         rQScnkEoKTaMQc34aIco0fRK5nIv5TfrSq8gvxUWmL5KtI/8U5OI1KJ5HGcbYmbU5B
         oab87nnJpijZ65kA7FHDIJKwwQieIIrNJmAuR/dI=
Message-ID: <68d2b3afd9a7ee27cdb7ec9ff7eb45342ce23c12.camel@HansenPartnership.com>
Subject: Re: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jordy Zomer <jordy@pwning.systems>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Date:   Fri, 20 Aug 2021 12:40:26 -0700
In-Reply-To: <209705133.1285234.1629477520318@privateemail.com>
References: <20210820043339.2151352-1-jordy@pwning.systems>
         <0874a50b61cfaf7c817cab7344c49c1641c1fd10.camel@HansenPartnership.com>
         <202108200904.81ED4AA52@keescook>
         <209705133.1285234.1629477520318@privateemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-20 at 12:38 -0400, Jordy Zomer wrote:
> Hi There!
> 
> Because this is a global variable, it appears to be exploitable.
> Either we generate a sufficient number of processes to achieve this
> counter, or you increase the open file limit with ulimit or sysctl.
> Unless the kernel has a hard restriction on the number of potential
> file descriptors that I'm not aware of.

There's no direct global counter for file descriptors, no; however,
there is an indirect limit: the number of processes per user which is
now defaulting to around 65535, so even a fork bomb opening the max
number of fds won't get you a wrap.

> In any case, it's probably a good idea to patch this to make it
> explicitly secure. If you discover a hard-limit in the kernel for
> open file descriptors, please let me know. I'm genuinely interested
> :D!

I didn't disagree it might be a useful think to update ... I just
didn't think it was currently exploitable.

James


