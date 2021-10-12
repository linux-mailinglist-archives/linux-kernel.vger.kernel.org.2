Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D625A42A933
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJLQSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:18:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A89C061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:16:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id s64so47805573yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7BD6wccAPTIincdVGpFvmdfRHDmwKN+1690ABm9BSo=;
        b=JqLMGsZLZwo/26rWcaEEkpSVhFFH+OlC7Yh11GjQMJWOAoOEo/OS8FiYJ5PtD0RSgu
         bw2Oaz49oFivA3bMB30OQaVH0PdMQz/7iIH4kMs9baD9eYeXd9So5SfKEEYlUTfc2qcD
         HT3wOwyZgSR1V7t810RRtL1MXXX35IhRsm/EuWIwMK/mEJvehfsBPcASE5FwzWW3dvZ0
         Eujw94ZLfnXjnkcl/a6DwpOks65BXP0jcO9OZjvoujG2wstFXydhSxouo0Wu9jvUKwXg
         Vbpuu1oBONXEWtc/vqY0EwF07tAMyG+Ci2f3vBafl2B/0xBfTrbbWXItiFFqvhaxMb2E
         ChfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7BD6wccAPTIincdVGpFvmdfRHDmwKN+1690ABm9BSo=;
        b=HV7dBbTV1Y0GrsL9o+isYkbZavulqAgeM38rNltj8ITbJ8Kke/k0rC/ShG/RreMnNd
         uZNb6GuGHVxnOwwAlvNKkL78Z6BAZVMFWlP7RXmdcT8KDlkjOLf1UwOd5sIQXtFPCbSO
         eXfUgXm5nWLw+bix1cCCBOb4KAZFcmv/ob0eyySy6wUlm9abCT2Pt9Sre6JDv0bVjHQL
         SBbmlKJ67ZjHAxBr04i8DHZV3kPXQc7A0zCf+geAeJWGsb8KMtDxU6V6b4g0MSCfMByH
         MUvNRbQH7ugwXNOIeZtiWGtp7PZnl6FCRo2zliFwcjdoz5JkW9U+owRgrygoLvXbKQH6
         vqTQ==
X-Gm-Message-State: AOAM531VuYmi23RacFCVwJrYv08OXhUQFEy8u2UqAGq0sM+/tJleYgfy
        G01vPbPNwVdvcTA/DNmSfaXCrhJKid1j4avrJCQ77g==
X-Google-Smtp-Source: ABdhPJxDSDLnCeRzy63ns5goD4U+AUKCvcseSMV+6HMnU+P37cXoMGJA5SHu3pcghaRwcNAyK6MR7qNNOaWzyLCiEhg=
X-Received: by 2002:a25:5b04:: with SMTP id p4mr28429328ybb.34.1634055392729;
 Tue, 12 Oct 2021 09:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211012015244.693594-1-surenb@google.com> <YWVeHbWp3kqf7Hyj@kroah.com>
In-Reply-To: <YWVeHbWp3kqf7Hyj@kroah.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Oct 2021 09:16:21 -0700
Message-ID: <CAJuCfpHg9fs5XoyY26ZQbLuPHo0-HLoE8FPFF7CcTy1OLpSveQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] gup: document and work around "COW can break either
 way" issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, Shaohua Li <shli@fb.com>,
        Nadav Amit <namit@vmware.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, jack@suse.cz,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 3:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 11, 2021 at 06:52:44PM -0700, Suren Baghdasaryan wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> >
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> >
> > commit 17839856fd588f4ab6b789f482ed3ffd7c403e1f upstream.
>
> Both backports now queued up, thanks.

Thanks!

>
> greg k-h
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
