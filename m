Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953E3B8730
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhF3Ql6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3Ql4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:41:56 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E30C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 09:39:25 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id l68so2031560vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8gMFR1A10s93xV07w9I9Oq+Pgqfmx7L44pDnudkZFA=;
        b=kyINrnqN2yjb2P6g6motDjhmZsGqJFUV3IeXvsT7i1IZv9rl3FDzFerFczudKUnTLs
         uZLcP1C65vjNKvonSs4UjrXkYYBnEnCHWSVPJuiP2vR8P5y+NLHtYaERFSOtEWtk74Ze
         SbDW4XfLi9TdDzBzdsLTUkoGhvQRYK9I7PSAW4BiigaMDgslROT9hC9KowrYSOCw3+lY
         HJZtwu65cWkso/DawhwSKPtmod79eqNFswuWWfHLJ46T4nz64rt/Fppa6gYtYHBkLVp1
         yNF5C/Xh5Lw7Byw3bHggwttC8ojcsdIQC0pTpuIqlyL7jRc4JdjfDRRi8jNrjPNWSetj
         j2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8gMFR1A10s93xV07w9I9Oq+Pgqfmx7L44pDnudkZFA=;
        b=UibPlzpr47+0Ukw1sYiwHuHBVN5g30q7XyKwLxe9gvxXICpX+k+uLcyAYvY/OZmrOU
         B1xEe3sXXaokt3y5WxIqRE1ionSB4FPrHBtIqexmxfdxCflwxiq+WB4LQ6wBfzUxN/k2
         lKdrmdipTKHM+f9oNHBON8AldGTDbhU01VDLWqp+JeKhCK84ZAaYC0NSGmSVOVQTpT2/
         DM4vYWpfVSDApFypNQJGIy/L6GLjK2nfc3XV7ObB++nAkfV0ufsCZMhVWWBRThbCbw8w
         YcJsdAGkYw7+jxPq2nb8uAxApQnDhRaF1NhJGg6h9GyF9wKcDIvowygaEL/YqPMRLzZq
         E1jQ==
X-Gm-Message-State: AOAM531L4qtd5wgyV+HrXg1JMAYLIsx43nGfWhMgn30PVXqRf8BTSgK3
        cCx67eM9ls8jrHZdsB4Do86oplCud+momnDR5ag=
X-Google-Smtp-Source: ABdhPJzdJ9VKed8h0Ud9H9jMmx7kuO1jz6IclgxpnhqcaKwsaFOT7+ldUbWkxYm/Rywd3jPV4hOBPuL/wHosCPb526Q=
X-Received: by 2002:a05:6102:732:: with SMTP id u18mr31616335vsg.14.1625071165063;
 Wed, 30 Jun 2021 09:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210626034016.170306-1-jim.cromie@gmail.com> <20210626034016.170306-2-jim.cromie@gmail.com>
 <075e07c40b99f93123051ef8833612bc88a55120.camel@perches.com>
 <CAJfuBxxzBevMJYSWq5feO20S4h_T-+EZoifOTYJ1NB4B+J1hqQ@mail.gmail.com>
 <CAJfuBxywc=oc00F7b=dJU9y_vgrncCUYzvLNgM5VaMsuOiDAyg@mail.gmail.com>
 <5d28704b131e375347f266b10fc54891ba2a4fc4.camel@perches.com>
 <CAJfuBxyQ8OX8+A64SQPG4pXYKBDhyab7_-Dcc_C2_t-4oG9xng@mail.gmail.com> <cabb80f84ee0c11aaa548e8ebc87da72883c5a21.camel@perches.com>
In-Reply-To: <cabb80f84ee0c11aaa548e8ebc87da72883c5a21.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Wed, 30 Jun 2021 10:38:57 -0600
Message-ID: <CAJfuBxzBuGv95bOF1Pt-5KC+ToH5JXWHySG+72cViGbYXuBR=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpatch: skip spacing tests on linker scripts
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 2:01 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-06-29 at 13:50 -0600, jim.cromie@gmail.com wrote:
> > this does 3 different things
> >
> > - non-capturing matches  -  these add no functionality,
>
> true, it's nominally a bit faster through.
>
> > - moves the skip-remaining-tests check after SPDX
> >    that feels like a legal Q: should it be on all files ?
> >    moving it does seem proper though.
>
> to me too.
>
> > - adds the skip linker-script
> >   since i went ahead and added it 3 times to see errs/warns
> >   I didnt consider your precise placement,
> >   how does it do with 18/8 errs/warnings on ref-test ?
>
> $ ./scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --strict --terse

cool options.
<Aside>
some oddities are hidden there;
Im seeing the err/warn counts change along with use of those options.
not a big deal, but it is mildly surprising
forex:
$ scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --terse
...
total: 18 errors, 7 warnings, 1164 lines checked
$ scripts/checkpatch.pl -f include/asm-generic/vmlinux.lds.h --terse --strict
...
total: 9 errors, 7 warnings, 95 checks, 1164 lines checked


> include/asm-generic/vmlinux.lds.h:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> include/asm-generic/vmlinux.lds.h:43: WARNING: please, no space before tabs
> include/asm-generic/vmlinux.lds.h:101: CHECK: line length of 106 exceeds 100 columns
> include/asm-generic/vmlinux.lds.h:390: WARNING: please, no space before tabs
> include/asm-generic/vmlinux.lds.h:546: ERROR: code indent should use tabs where possible
> total: 1 errors, 3 warnings, 1 checks, 1184 lines checked
>

2nd one is I think pedantic comment formatting, but on the whole, fair
complaints.
and I see your insertion spot is right between my 2 picks.
works for me.

just to note, this is about a generalization of

commit 263afd39c06f5939ef943e0d535380d4b8e56484
Author: Chris Down <chris@chrisdown.name>
Date:   Thu Feb 25 17:22:04 2021 -0800

    checkpatch: don't warn about colon termination in linker scripts
