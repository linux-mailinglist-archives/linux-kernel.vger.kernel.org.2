Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C802236BADE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhDZU4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhDZU4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:56:03 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E32C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:55:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 4so30454416lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsvd/Qinp/p9KJ8WGTP8ln6jTc3txvxZQ3RZQL+RCH4=;
        b=Mh6fPNjdra5N9zpGupgnZ3bI/RC5dvEZ3srZKHfmekX5dRYuOORb4UfOFcALxnlyQd
         6aAaups4I/YbFe+8howGXUcciIhZfN2kkU/5WUuVH9hjTf0Q0IZvKrYaxGnVJoMP5oem
         SL4I9MhJjUWCPb64VYzex6iw8haAk4vgPW0/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsvd/Qinp/p9KJ8WGTP8ln6jTc3txvxZQ3RZQL+RCH4=;
        b=glu6kuUCT6pUmbbCv/CxdiHbAcK7ORuIA+Ke8w31SS6szmRXptAHRfIM6u/9iGnv+a
         vxrrQsHBybRlnftvICXIve5RxRWGEm4BNHHP9hTHf2tdGy+ufyWl/fRr0V+fLKl36aZ4
         9Z/28RsLn5eSjyqW6sIwqSTwX+gnZE64N+AtddyukU0DFh/6mBDZ2Mdr4657J2uOOR03
         NaUwOPYxfhvFhntSbGqJQzfco13QfeOwSugvaFXpoeB80dSLzAKIU0ibDbSyAwp5558/
         FOq66zWWS8fqaO4hVyQ92JZdxyKH+KXZOTgj4Xs9lCaPD/p9ihzF4FaA9JMZRMB3kdzF
         +SrA==
X-Gm-Message-State: AOAM533qyxGlM1wOBlhvCJ9Ox4D20aSDgTXZI6d9McxPkj9Fz5kb57Tj
        ZUgryk2XtDEunkc0q9pRj4464OsBwlm1ss9x
X-Google-Smtp-Source: ABdhPJzO6UMGEMKlKm6kTagqrO6KGrKOsqsWYSkN0o/8mqsoWWC9HK+gWB7Mt9FfYyg0l9W+yrz8JA==
X-Received: by 2002:a05:6512:21cc:: with SMTP id d12mr13767228lft.512.1619470519777;
        Mon, 26 Apr 2021 13:55:19 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v8sm121072ljn.17.2021.04.26.13.55.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 13:55:19 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id y4so50125812lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:55:19 -0700 (PDT)
X-Received: by 2002:a05:6512:3147:: with SMTP id s7mr13714445lfi.41.1619470518895;
 Mon, 26 Apr 2021 13:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619466460.git.dsterba@suse.com>
In-Reply-To: <cover.1619466460.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Apr 2021 13:55:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1KRvb=hie1VUTGo1D_ckD+Suo0-M2Nh5Kek1Wu=2Ppw@mail.gmail.com>
Message-ID: <CAHk-=wj1KRvb=hie1VUTGo1D_ckD+Suo0-M2Nh5Kek1Wu=2Ppw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.13
To:     David Sterba <dsterba@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've pulled this, but:

On Mon, Apr 26, 2021 at 1:01 PM David Sterba <dsterba@suse.com> wrote:
>
> Matthew Wilcox (Oracle) (1):
>       btrfs: add and use readahead_batch_length

This one is buggy, or at least questionable.

Yes, yes, the function looks trivial. That doesn't make it right:

  static inline loff_t readahead_batch_length(struct readahead_control *rac)
  {
          return rac->_batch_count * PAGE_SIZE;
  }

the above does not get the types right, and silently does different
typecasting than the code clearly intends from the return type of the
function.

It may not matter much in practice, but it's still wrong.

               Linus
