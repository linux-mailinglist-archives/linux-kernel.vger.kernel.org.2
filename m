Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEB3349D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCJV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhCJV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:27:07 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADBDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:27:07 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id d5so16987610iln.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6D5z3mafEzY8yrWw6TNKSwod1RWWNCgjnlei0AA4Yg=;
        b=sqQvvFfF9Rv0VE0JwuclYzO/9N0bN+joIEu77n22nsqkxRelcawXlykkuDoGb4K9wa
         z/ajL4jkgypagouVW5k65wZIDFdSiwXmrXS9zddpZyOxURu7qhkO/IOFyJWULxkV3roM
         9WAZIGHSplakE0vgu+Nhl2dZWx2L1jS6TlQrAH6tD6uBorrz40sHEoAEN6PAJxVi4FS2
         SBmMpf/c5cEB2bCNUpBJypDC7u24baxee4WBz5NzyctAEJq3PEEq+nG84MeYqbVg3Ns+
         Nc585bsochmyJvVAJlH3YJFaLhvsPKsonYRoCgnQC4aqACNosnsc/OIDgBpM67Tk46Lr
         bX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6D5z3mafEzY8yrWw6TNKSwod1RWWNCgjnlei0AA4Yg=;
        b=mt6e3qevR/9F2ayrXXDPPwrOhnn64z8lOu7pkjGRhkDHnmExTi/TPHCyTkqblngZrW
         hxoSK5avkdPFFOYi95krskPgge3XRLRZ3eTxRUzrRYj8fVp7hVO/jMiVT0ywRLSZvxbp
         MuWKV6uC6z6+xnr2sB9ERpcoTzX3NGUVkWgcUrzaZhizWHBIN3Jb2OF6K7lB6gg2XwXv
         Ydq1zZmSAKJXJJ3wt54rImllUO0DHJ6mMMP7PDJz2WCXGoedgglss7MuO1mCIm/3w0tC
         3uCFBme7y1Bo1B5e5uQ7j7NKR305i03VmaBrCCxK+EiiwL0WBTcFcU6SmnIHEWWHmXVs
         CFVA==
X-Gm-Message-State: AOAM532W9blB772DpUnxXTfA8XHJ5+v1w4vTEkt0q+w3eA7retHbdbM/
        fkfoBtaVNBx9blTywXJpSbT7EeSI9W8nx/J5ZCfuQA==
X-Google-Smtp-Source: ABdhPJyPVwTTHE1TsFxNCU6mx29jBLudL6jpgWl9CE4iX0JZiitRwaeTOniNdwI68K66urDGyjaWVnzufYaYGVgMp18=
X-Received: by 2002:a92:d6d2:: with SMTP id z18mr4402514ilp.30.1615411626484;
 Wed, 10 Mar 2021 13:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20210310004511.51996-1-peterx@redhat.com>
In-Reply-To: <20210310004511.51996-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 10 Mar 2021 13:26:29 -0800
Message-ID: <CAJHvVcj0JUtV8VFAa_CftEN7-ohNLhcnfpmM-zny2aVvc0a2ug@mail.gmail.com>
Subject: Re: [PATCH 0/5] userfaultfd/selftests: A few cleanups
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These look like good cleanups to me! I reviewed all of the patches,
and tried out the resulting selftest program, it seems to work
correctly. So, for what it's worth:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>


On Tue, Mar 9, 2021 at 4:45 PM Peter Xu <peterx@redhat.com> wrote:
>
> Based on v5.12-rc2-mmots-2021-03-08-21-54.
>
> I wanted to cleanup userfaultfd.c fault handling for a long time. If it's not
> cleaned, when the new code grows the file it'll also grow the size that needs
> to be cleaned...  This is my attempt to cleanup the userfaultfd selftest on
> fault handling, to use an err() macro instead of either fprintf() or perror()
> then another exit() call.
>
> The huge cleanup is done in the last patch.  The first 4 patches are some other
> standalone cleanups for the same file, so I put them together.
>
> Please review, thanks.
>
> Peter Xu (5):
>   userfaultfd/selftests: Use user mode only
>   userfaultfd/selftests: Remove the time() check on delayed uffd
>   userfaultfd/selftests: Dropping VERIFY check in locking_thread
>   userfaultfd/selftests: Only dump counts if mode enabled
>   userfaultfd/selftests: Unify error handling
>
>  tools/testing/selftests/vm/userfaultfd.c | 742 +++++++----------------
>  1 file changed, 235 insertions(+), 507 deletions(-)
>
> --
> 2.26.2
>
>
