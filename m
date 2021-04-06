Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED586355D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245666AbhDFUun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbhDFUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:50:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6ADC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 13:50:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f29so8821196pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45gywtFS7vFeJG2FHCl1wMYRQ5pWycXZasjRBGHBHf0=;
        b=DQUn8uT6mNsJry3m0l32a87qkver2AwRJ5w5tVFOLqqzJ4M3VwThuukE+Jdxl32/Va
         KapCQ25lXeJ88uZbko+guP9pgKtlWC/jCbWfS1Q3VV7CZNIX98BXHTf+T+6R78G9nLIs
         TA+jL0InTal86IrphFcPZA9dIV2QkmxnGsbRzUnurOBtyjYRRuTBgmorLHEoVizI7tYi
         Z5Azzkej/ufDyx1HQMEqGv5xUO5evgS9vILku1EONx5AzPHSpJOdZqanA+UTIk9obKOM
         nV7pXGBOWUZQGsC7XFaUtmxbSyW5Qf6MuHrdJ8O3zG/Tmyr6l1gccgQUqwA3WncPM8XL
         N0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45gywtFS7vFeJG2FHCl1wMYRQ5pWycXZasjRBGHBHf0=;
        b=i7hKV6jXbXFvZ+4SqAnrcEt0sA1EmwYxWDfd/2+Xo3JjZMQHxk72Uqcy6RD1d59rIr
         jXeJvGDTXxzHiOEPcSEJQO6IKtvX/6ac0BPLyqt5q4POXE9U2YcJPSB9nRhaLKvBkFQK
         prcAmNYySqh9ZlLKs929U2eR0wVuJVpR+m53/cy+vhN7d/xA1etavoqbX7GWt+sE0SAy
         0nG83dQzMeRAJb6F0496pv2GtQ9lEOetrzX+GQNS3feokGiLadOvr0AInQ8gVZB2fGRj
         TjJdwzmAUCCRypivNdY9NKZXv3xdvux2RIXat+idZrpK3xzXTrcpP9w3GRk1LNSd0/3i
         4QXQ==
X-Gm-Message-State: AOAM533RykOE8I08Ui01y6xKsHP6d4LMFNo2RfzX2mFDQO/DWveipVX3
        GWrap5mfAjT5Dw9soEdn5yicLhloeb8LUVw/T2g2MA==
X-Google-Smtp-Source: ABdhPJy/QPOsCWYwjuBu6gg6eN7ce56618HZFTHEDxI8l0kKlNlQ3CKqwg9qjVReonlXkogTUCUmud4eu3ooOT/97nI=
X-Received: by 2002:a63:570e:: with SMTP id l14mr26828pgb.159.1617742232557;
 Tue, 06 Apr 2021 13:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210406172901.1729216-1-dlatypov@google.com>
In-Reply-To: <20210406172901.1729216-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 6 Apr 2021 13:50:21 -0700
Message-ID: <CAFd5g472E_Q-CoM2ONNONP_oeGZe0HGpNdqVhyRkKhP74b7h7A@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix -Wunused-function warning for __kunit_fail_current_test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 10:29 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> When CONFIG_KUNIT is not enabled, __kunit_fail_current_test() an empty
> static function.
>
> But GCC complains about unused static functions, *unless* they're static inline.
> So add inline to make GCC happy.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Fixes: 359a376081d4 ("kunit: support failure from dynamic analysis tools")

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
