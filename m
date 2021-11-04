Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0728F444E25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 06:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKDFUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 01:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhKDFUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 01:20:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE6C06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 22:18:04 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 1so7576018ljv.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1i2ArK/DuUH+8zzvoUDR5kWhCGaxJs+6ozvmTXq3KK8=;
        b=UHIbzIzQ1BtxF5gJfTpEOGoz5NyoOTK6Ll+Tu1A5W4GCmzV2IKgvn53W9V0mG2Uap5
         PoDvCYiy4SsEZkkADAiH4AwUgZ2J3tv8y09mTPK3nk4gRy4yreS9YE8RcGXNs6h44LGZ
         jKvtMxAoE0x3RBpBKTj+1v17lGc4Drx8Oc8v0gVSjiYM+x6EuE/4IEKNPCcog6eeyDHe
         cv/5PEZ8ERI8lOiPS/waDl1su7Rmy3LVo3vLz5l39vot+RwJneQ6saFjzl6zTSHQrr4a
         dsD/3BVbAE5nk8fKATtycJODmWyHcLmGz8qZUkjrq0EsjT7eZMNHG3MBCFnitxvIinoL
         xjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1i2ArK/DuUH+8zzvoUDR5kWhCGaxJs+6ozvmTXq3KK8=;
        b=V9qnyuZdrOYmeNrWLk+3iMULHx3+2UV/U7evksssQpU0FyOZSSwF8BW+E5ceTY8Kut
         kVTs5UDBZxGCw6OcqDDsFhnxyeNTNAy9U05EEUzVS5v47bAAFz8GxnzkxXJM/gAjCz9u
         dCBz6n1hcORRsJceiVGI7q2S6dCmXe5KqBJTIoGSB8Oxc3B7TGMrT1A9cxSxy96weQ0K
         0L4X7qoeX8BAPqciS3WohxqKzwrjFd5TM9piC/KbOKC2oGU0U3EypmS7Vwm2VedG5L83
         dr4NXipBjXyzcWfY4SGw0mEl4bgwaI1zvzbOnNvgjAOAC7yCqUnpJPosa0I8vTuj+D0G
         fMHg==
X-Gm-Message-State: AOAM532o3q7lZA5T7tprfdI2x+3Zi9Gu+mhmmZ9JnumTO5Ftxr0YamEM
        TEZa7EH8QgLDwO+S3VSouhPivrRM1jKty14Aa76hlg==
X-Google-Smtp-Source: ABdhPJzQZSoC4A3NWrvzR7sdaoKUiV/q5Xy3qUQi0/b+nqASUfy2A97b28r0pC9HLcxKCyMSUDkX8eI3sOT/96BONDc=
X-Received: by 2002:a2e:bf06:: with SMTP id c6mr50574945ljr.405.1636003082804;
 Wed, 03 Nov 2021 22:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211103205911.1253463-1-vipinsh@google.com> <20211103205911.1253463-3-vipinsh@google.com>
 <YYMZPKPkk5dVJ6nZ@google.com>
In-Reply-To: <YYMZPKPkk5dVJ6nZ@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 3 Nov 2021 22:17:26 -0700
Message-ID: <CAHVum0eFwgM-Pj6xHt0gkFCf1OZGjYD7K0xttswbAaGMo6zpJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] KVM: Move INVPCID type check from vmx and svm to
 the common kvm_handle_invpcid()
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 4:20 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Nov 03, 2021, Vipin Sharma wrote:
> > Handle #GP on INVPCID due to an invalid type in the common switch
> > statement instead of relying on the callers (VMX and SVM) to manually
> > validate the type.
> >
> > Unlike INVVPID and INVEPT, INVPCID is not explicitly documented to check
> > the type before reading the operand from memory, so deferring the
> > type validity check until after that point is architecturally allowed.
> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
>
> For future reference, a R-b that comes with qualifiers can be carried so long as
> the issues raised by the reviewer are addressed.  Obviously it can be somewhat
> subjective, but common sense usually goes a long ways, and most reviewers won't
> be too grumpy about mistakes so long as you had good intentions and remedy any
> mistakes.  And if you're in doubt, you can always add a blurb in the cover letter
> or ignored part of the patch to explicitly confirm that it was ok to add the tag,
> e.g. "Sean, I added your Reviewed-by in patch 02 after fixing the changelog, let
> me know if that's not what you intended".
>
> Thanks!
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>

I was not sure if I can add R-b as it was only for the code and not
changelog. Good to know that I can ask such things in the cover letter
or the ignored part of the patch.

Thanks
Vipin
