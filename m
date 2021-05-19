Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580AA3884DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbhESClT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhESClR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 22:41:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867DC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:39:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w33so8782272lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtmNJLU/dhQ9ELu/k2h5VHa5Rzw2bCS2zmPu0hLax+8=;
        b=BVvY6dfBpTLG0lCmqHmrDJcT+SrZNvl2aUJRRzUMfSXvRfy+O8EXPnnwQahXMdao6o
         ADK4xqT8fNsbM2m33sQnw4i2uQ0JMU5+vr1tAi+7ZAg8S9HHsObzS/enEivmT4rgIsLZ
         ILiKKP3sz7olT1g3KLaQqtWqIyrwYxRu/fSqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtmNJLU/dhQ9ELu/k2h5VHa5Rzw2bCS2zmPu0hLax+8=;
        b=RUk6lSZ8fmz+LAcq+mwpBIjyea3/xyjkqICaeLEhHpiy+tmcg/fS9VMMUBZ4qz7IhM
         P5sYNpBGRBXonE6n3TW/fg6bc6dDLrnhBwuVUU63qv869beF6Q5FpOc9nuY3FM3nYrFE
         iN1nbc7HxYGa2MSrWmar/Iw79xFTLbLyeSF/eIJ3KF0KUlQkl0MqIv0/bfYP4bKYiTxu
         A/mD7EyCnwTpCfEs+ul2wuWfmcJaKMZPOYeS272VXFeLyqb4tg3H1b5e3glSACSuYdn0
         9+n92HRMBRSXjkyA1bhmN9L3I1CFbQeF6o7c0+CU74HYcVm9560NGilsl5BDCXASw0Uh
         wbiQ==
X-Gm-Message-State: AOAM533zbwY5JICQ22eyZkezS1ydQIdIqVQGx1GX0CquUA4FvHbbjTHS
        NuqcJjpmVM1KCXzTl9roJW4h7SQnwXnVN2NY
X-Google-Smtp-Source: ABdhPJzDISnP/wQAPucKOXygKjB8e/QNJ03i1U4woeWasGxnzH+0zhU/TstWBEeXH3bakFKmRljWhA==
X-Received: by 2002:ac2:592c:: with SMTP id v12mr6383839lfi.632.1621391996463;
        Tue, 18 May 2021 19:39:56 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id q10sm2457614lfg.1.2021.05.18.19.39.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 19:39:55 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id w7so396613lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:39:54 -0700 (PDT)
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr6863723ljq.220.1621391994583;
 Tue, 18 May 2021 19:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
 <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
 <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk> <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
 <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
In-Reply-To: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 16:39:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=whJkHMtf4RYiE3PLTEo8fM_vU6BG43TNJLbHsGYPsSJfQ@mail.gmail.com>
Message-ID: <CAHk-=whJkHMtf4RYiE3PLTEo8fM_vU6BG43TNJLbHsGYPsSJfQ@mail.gmail.com>
Subject: Re: [PATCHSET] d_path cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 2:44 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Here's what I've got for carve-up of cleanups.

Thanks, these all look logical to me.

I only read through the individual patches, I didn't test or check the
end result, but it all looked like good sane cleanups.

              Linus
