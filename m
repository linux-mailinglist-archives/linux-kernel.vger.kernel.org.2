Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972A840A321
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbhINCNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhINCNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:13:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538EEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:12:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j12so20773465ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTZ+eFGbCDolHBudnZBl3uwTbCyuUnDDlNjR7YoJlN8=;
        b=a8etmcMmxUvXlsF8SSWc/UbOYHx7MrB6jf8XzEcL+zzyCDw6Kat7Q5QwvXdHdsuFVl
         tZyCY2YvkPFPJTWsENvKQB8encBX0h2+ti3zl4D14UnnVtEr1ME5aaiD3w/D1plemf+X
         MJaYSKqDIGmy52Iro7ivbir9UMYjn+0QhvsAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTZ+eFGbCDolHBudnZBl3uwTbCyuUnDDlNjR7YoJlN8=;
        b=ATNqkwtqW8ki7Agihp/U9gUN5wcvepM2PLhMfPMcN76ePFgz0/19HRgh3sXT6N4SZc
         V2PDacPPHAiBbiMbEYlMhOEbXS/xBvO6ftNK9c5OVQ+No8IjswGpT0XkqH8ocQTjMiRu
         5JZiBEuO0ZwzG6/+gtypTLeKVoK4AH0iiQIrTXepUzahiHlDWPsoLqvQU4FBrSHGyHCe
         h2wAihS5IJk+813/i9U/CoRliC1ga4EEvc1LMVuhMteOqez6MDoFGLIo6ln9zqH4buY1
         oxSIH7U26ROK60Qj0ezUp0PyzNQOy4gjN+sr1nakFdFAxLIVzYb/0vjDpjQaff4dJCfX
         kifg==
X-Gm-Message-State: AOAM531Wy2hDwSpxggnbRMNKtm05/Oys03YPFD+1iGPHOT0wq+l7dBzZ
        DjyMwqOoosO8ghCDu5lKFNqL0NLhOdzAVpegv+8=
X-Google-Smtp-Source: ABdhPJxj1J1ifbe/1aGpMd1zj3132qiByBHpcvtnnR2HqMvgvhrB6gSbiXZHGridtOWPGCRIU8H7XQ==
X-Received: by 2002:a2e:a48d:: with SMTP id h13mr13450633lji.36.1631585549298;
        Mon, 13 Sep 2021 19:12:29 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b22sm982419lfv.286.2021.09.13.19.12.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 19:12:28 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y28so1027721lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:12:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3984:: with SMTP id j4mr1498523lfu.280.1631585548512;
 Mon, 13 Sep 2021 19:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210914100853.3f502bc9@canb.auug.org.au> <CAHk-=whOv-LZKxBqQr8yzmhi7sN4zoFG7t8ALNx+2XFhXjGTpA@mail.gmail.com>
 <CAHk-=whGuEkYmQcJx8WfZ7MFhbKGJDcA6NUZWtrnM6Y6xFqATw@mail.gmail.com>
 <20210914105359.5c651d55@canb.auug.org.au> <CAHk-=whyWUdJDeOBN1hRWYSkQkvzYiQ5RbSW5rJjExgnbSNX9Q@mail.gmail.com>
 <20210914120818.4a102b46@canb.auug.org.au>
In-Reply-To: <20210914120818.4a102b46@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 19:12:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieb251-L9D-v3BeF-Cna8r5kLz2MeyXDS3mrNUmXNYrg@mail.gmail.com>
Message-ID: <CAHk-=wieb251-L9D-v3BeF-Cna8r5kLz2MeyXDS3mrNUmXNYrg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 7:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> That patch works for me - for the ppc64_defconfig build at least.

Yeah, I just tested the allmodconfig case too, although I suspect it's
essentially the same wrt the boot *.S files, so it probably doesn't
matter.

I'd like to have Michael or somebody who can actually run some tests
on the end result ack that patch (or - even better - come up with
something cleaner) before committing it.

Because yeah, the build failure is annoying and I apologize, but I'd
rather have the build fail overnight than commit something that builds
but then is subtle buggy for some reason.

But if I don't get any other comments by the time I'm up again
tomorrow, I'll just commit it as "fixes the build".

                  Linus
