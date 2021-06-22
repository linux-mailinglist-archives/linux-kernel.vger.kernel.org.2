Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788113B0CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhFVSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhFVSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:34:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF4C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:32:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q23so21037152ljh.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0pmw5StORP1KUcP15TdiklSXjxFImoIRcmx4+WJzKc=;
        b=NP4S1TsIF9h2rPtpSgvjlnlXPEzV1Eg6DWYa5iK2q6AtxYQkNIkoYmNrE9B5XO/S4e
         HF1VEmrSrJFoleJ4FjX+FsvMVqxeW7ygtwWfM8q4P8/YZWbLfBROiuS/kumnsSNRhqqv
         IWq+2Kwg/HRFdIwqvLmKhyArAFRW+GJQTx+1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0pmw5StORP1KUcP15TdiklSXjxFImoIRcmx4+WJzKc=;
        b=jjNfUDtBow2wQenh5+5nsFBvNyFr9P8uysXQJjY0kTYrgbKdeTzNz8nhQF3U1TXqaL
         bKd9yBWK1LYNf+2kFhzZkrCAcNTV6G+mxIf8Y1UM6LPkkbyz/ki7VJieDWq8yKk9HwRs
         JFFWFm6Df90rbv+R2UCf8Any0LvuYqYozIRa1elpZMA7Wk+AhhRAf3PY2KhuEC/+qZSJ
         9kg6Bl6bLBSFJT6y7NUc6KGdQqI3SNS3TqrQbXxFJW0132RWgUmS1Sb8FWJfinPr/iKk
         81mFPMnZyUQ/Hw8Sph7JXc8Bou3QmAypmbawk/XHKQIZpvuHYplI9rst1udizJlvp2ys
         3cUA==
X-Gm-Message-State: AOAM533gPS3atgm3hFyBKNLz+HQjDYxVmGGJrdyhZUXWL1C9CLcJyYWU
        B3+NL2xG934yQ4PlhzeubJySamR5bJ5DbRbrvl0=
X-Google-Smtp-Source: ABdhPJxjtGvaqbGgZLszu2dRoUW/B8SS0/QVhmVzXYxYtmrKG8bgBpgoruNav4xNa39cevL7dek0lA==
X-Received: by 2002:a05:651c:1541:: with SMTP id y1mr4450464ljp.475.1624386737663;
        Tue, 22 Jun 2021 11:32:17 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d19sm1241769lfv.187.2021.06.22.11.32.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id h15so18956709lfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr3809268lfc.201.1624386736181;
 Tue, 22 Jun 2021 11:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh=YxjEtTpYyhgypKmPJQ8eVLJ4qowmwbnG1bOU06_4Bg@mail.gmail.com>
 <3221175.1624375240@warthog.procyon.org.uk> <YNIBb5WPrk8nnKKn@zeniv-ca.linux.org.uk>
 <YNIDdgn0m8d2a0P3@zeniv-ca.linux.org.uk> <YNIdJaKrNj5GoT7w@casper.infradead.org>
 <3231150.1624384533@warthog.procyon.org.uk> <YNImEkqizzuStW72@casper.infradead.org>
 <CAHk-=wicC9ZTNNH1E-oHebcT3+r4Q4Wf1tXBindXrCdotj20Gg@mail.gmail.com> <3233312.1624386204@warthog.procyon.org.uk>
In-Reply-To: <3233312.1624386204@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Jun 2021 11:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgA4_TkMqOw9GwW7aNe3jBU_yBKZkNWTicz=BKap_=siw@mail.gmail.com>
Message-ID: <CAHk-=wgA4_TkMqOw9GwW7aNe3jBU_yBKZkNWTicz=BKap_=siw@mail.gmail.com>
Subject: Re: Do we need to unrevert "fs: do not prefault sys_write() user
 buffer pages"?
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, "Ted Ts'o" <tytso@mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:23 AM David Howells <dhowells@redhat.com> wrote:
>
> Probably the most obvious way would be to set a flag in task_struct saying
> what you're doing and have the point that would otherwise wait for the page to
> become unlocked skip to the fault fixup code if the page is locked after
> ->readahead() has been invoked and the flag is set, then use get_user() in
> iov_iter_fault_in_readable().

Yeah, the existing user access exception handling code _almost_
handles it, except for one thing: you'd need to have some way to
distinguish between "prefetch successful" and "fault failed".

And yeah, I guess it could be a flag in task_struct, but at that point
my gag reflex starts acting up.

               Linus
