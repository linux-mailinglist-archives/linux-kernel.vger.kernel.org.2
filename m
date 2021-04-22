Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20036858E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbhDVRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:10:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F8C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:09:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y4so33108359lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h95AgVCanHu12dn3zoUEpFIcw5KfHCuizquP4MnVNqg=;
        b=fixtjA3UBcVQHNqWWgY4qX0wbRH5p3DyUwfPTt6l3x0WuXsyvmVDdsSg8MRSHQaexl
         FCwbTiiKeRgKySUlwTrLQ1hPk9LvLCWZG8q+0EXSQBiq3fgYhw8OtWSVn9pBfWKNOdWL
         LVjdzwb462+SdktnG6vMMmVezVOs54IuS7+GxFeOZAlhgGXkVopAPwa6lid5qH8kVP9a
         NdjU2SGDHC2nv1rOyBHjEND8BQpPuuThLU8/hE7pKgBuMC/zaUJTy4tOHMUbveyPXnSr
         rWYvhC8YL/yuxmS8ZNscGZj3xLhqP3sL4pJkJA3ig/JRLWxfJ58C8GhfX52Jl4aaOMeF
         mIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h95AgVCanHu12dn3zoUEpFIcw5KfHCuizquP4MnVNqg=;
        b=IR1hosVnLBLTFq53ww06Mt5Ueti+2Tv7/JoXJ4iZVPxHXN/1KaKbyOTZ7MmFhDK2kK
         PBIpLrXiPDrs/y86tT4HQ/R+eCqXGtnjMX6jsQSUoa0RpaCVWGRB8cWA7vPCOmVT+NWd
         27dcTVT2BcrQV4E8/Z9m4L1Ia3Z2mRyBtCXuGOOC/s5fPux/NU9nrVBYN2f9f5pzw2xg
         1PjrqYhmdrPwkTFMV7MwY1gFOqbUPA5EBi+Jb3Wo329SjlZoQ6uFOn2X032iJs6ToYY4
         xUcf213HQhFX0U1mnAuEuOQxznquiGpRFgz2LxOSSwOd1tr2JsYTxL6ulhVmgjj1DhoF
         f9gQ==
X-Gm-Message-State: AOAM532ubU5fYMHlVm7EN2/oOc4oWzeqxNyuT5iKyqEFgUCQ/F4SG+Y1
        SjWvp16kiPDazEIBqarGbIJtxp0EoZvuCiRhWZ2V+A==
X-Google-Smtp-Source: ABdhPJzSZyTEFgmh0FIZQYJ8ZkMxIoKaf6ErQRqkUiuDAKb9iJcaDqNkIBwT6uBHgF2hYV6GXbmvVCgsU72nlEvPgBw=
X-Received: by 2002:a05:6512:314c:: with SMTP id s12mr3185329lfi.53.1619111396278;
 Thu, 22 Apr 2021 10:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210422155355.471c7751@canb.auug.org.au> <124cf94f-e7f5-d6f3-7e7a-2685e1e7517f@redhat.com>
 <CAHVum0eQX8+HCJ3F-G9nzSVMy4V8Cg58LtY=jGPRJ77E-MN1fQ@mail.gmail.com> <e6256bd5-ca11-13c1-c950-c4761edbcf4d@redhat.com>
In-Reply-To: <e6256bd5-ca11-13c1-c950-c4761edbcf4d@redhat.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 22 Apr 2021 10:09:18 -0700
Message-ID: <CAHVum0cVMd-SxmjKAJyJXO7SR68GKXQ7WTqyqWVfq1MMVd+oLQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the cgroup tree with the kvm tree
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Tejun Heo <tj@kernel.org>,
        KVM <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 12:47 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> You can check the current state of the merge in the queue branch of the
> KVM tree.  This is what I plan to merge if Tejun agrees.  That would be
> helpful indeed!

Merge looks fine from my patch perspective. However, one thing is missing:

In sev_guest_init() after sev_asid_free() call we should also write
set sev->es_false = false.

Without this the main intent of Sean's patch will be missing in the merge.

I can send you the patch but just wanted to know if that will be right because
originally it is Sean's fix and I am not sure how to give him credit
in my patch.
May be Reported-By?

Thanks
Vipin
