Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DBD377477
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 00:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhEHW42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 18:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhEHW41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 18:56:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A7C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 15:55:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o16so16196700ljp.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kA/KDUDO096vq2rEKxFXAZivI52axFruzSdRkQyvoI=;
        b=PWRMIeUKO0nmSZhexye/3YzAUVpInwAh7XXlaTHnWhlKIAuWvggExHJgbfmaYh9nR0
         DRNpc5CAKtPEke/TFa5iaD4eYxQPerPxY17lVXLaNXY4SEls6TLdUjya9c5Rt62dxKkG
         IgPGuzEDzfaGsPkyXdCfqJY1xki5yy39Ae+Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kA/KDUDO096vq2rEKxFXAZivI52axFruzSdRkQyvoI=;
        b=Z5hIIdEUVdgSX6OLMbByD8jggFl6qhES5EXdQd8fQ4z0M1xEGwEmon3U1e85a4xPF3
         eVTO92T/4/9RHB0cEfa5/PNc//evvJH4+cCh0McpQwKUC+lNeE5+WJINtSQNnUfxCHKm
         yhgYAGdzLrN6ZeSdSebQfOOa1GOv5cgQJ21HJEEViFg1KebWYkESccnwOKrVBD1GODlE
         zYY6de/0KITqxIW36aYQYFMwwo1/vLEbzTKtsrguBHnyrKQlnNfGPHxamFQMEBob86p1
         SIybkUE0dROZiREnUctR1Dyga7IUSoODAn9kSLDMzh7ByI0XhiDGBqUkjny60gGcptYr
         9nWg==
X-Gm-Message-State: AOAM530Pq9MHug6M1kJHLgVbRoTr7a6P5ucSrC7i2SQ0M6DgCH1vaJvR
        JEYhqw30lNEj9h9XAqbVBN/lGUXkGwCTdcUDLrw=
X-Google-Smtp-Source: ABdhPJw/QnBu77yQyvyChjciHO0e5CqBXDG4M57shxr9saeQn1PrRbWjTHa9tyXni9gv/avXKie99A==
X-Received: by 2002:a2e:e11:: with SMTP id 17mr13746914ljo.90.1620514523763;
        Sat, 08 May 2021 15:55:23 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id c15sm1739409lfk.153.2021.05.08.15.55.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 15:55:23 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z9so17910436lfu.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 15:55:23 -0700 (PDT)
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr10896192lfr.201.1620514114222;
 Sat, 08 May 2021 15:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210508122530.1971-1-justin.he@arm.com> <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk> <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk> <CAHk-=wjgXvy9EoE1_8KpxE9P3J_a-NF7xRKaUzi9MPSCmYnq+Q@mail.gmail.com>
 <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
In-Reply-To: <YJcUvwo2pn0JEs27@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 15:48:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbaLFNU3448HhUX7AZB1xxqTg=A8PLbzazQxR_ukyJsw@mail.gmail.com>
Message-ID: <CAHk-=wgbaLFNU3448HhUX7AZB1xxqTg=A8PLbzazQxR_ukyJsw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] fs: introduce helper d_path_fast()
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

On Sat, May 8, 2021 at 3:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> static inline struct mount *real_mount(struct vfsmount *mnt)
> {
>         return container_of(mnt, struct mount, mnt);

Too subtle for me indeed.

           Linus
