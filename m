Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4AF401F46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbhIFRlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbhIFRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:41:54 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB90EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:40:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so9592940otf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGzDP1P9SV//47D/1bbDt2xJ8d6dN94V6Uu4MHonLGI=;
        b=dXQlueRL6yCC1LFm1O4+GsWqrR+kOWkG/f8PNuQDaHoLdUfzrTSsZz3WR3siWSF5oA
         IRCI/icPdjCL7akV7URsxiE/0yquIkgj0vSN3ktHWvDrEWh0dkUe8l+lnsNLVoXQkiXG
         kb8R8TmcIH/oW6hTYYmUrIjcJY/o8ZZR30VQygzo9NkceFnkMOl+DLjQHT6lItC77g74
         YUJsSW3DxMcfepfANzD9H8W/lRq6KYQJsEp+Z5KtXFX3Uwd39/TGCJfkvmJxdwTGQbO/
         I44RFj3of0utGIURwNZsN+NGymZIzTJLoS6P5/VEgSzbRaffutKNTbpLavTB8Q4uj5BC
         Ngsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGzDP1P9SV//47D/1bbDt2xJ8d6dN94V6Uu4MHonLGI=;
        b=c293DVFnMVavGaO19wUckSoatzS9UQzywDRFwGzath23M1rBQSHVBNLXNNIoCz2aI4
         vztq7wxLifV8cQSTP9E8nTEAMd6exsEKveJGJg38lcIXN6dfQ5Z8cnDy4HETmw7IxAah
         obx1gfTPGTWFUOwFfPTjo+ZxHgchwc37C0lLtYZlRi/06Y/iKEDutkOt3smSaG+1nO+N
         u4iKvRegN30pXGmUpURsJaXRuZbMdhzZZxHGguBJaK/XUUGOZluQHEgUxSHucVrlmz71
         k1z3DHkabumUKzzcGTYABgHIEXgozwGZ8kUhsjp+ZUgTZIn7XyDSXydibb487jxeBNoD
         9rMg==
X-Gm-Message-State: AOAM531sycBYnO3qNubZLPQquewAjURncpN+vZmWfUzfIOd6VAm81VoT
        lB3SSKAvdHob7vR5e3FrmOY2QN9N+Q/IVAriFHi/Y82VjTc=
X-Google-Smtp-Source: ABdhPJxXk8NGnRG2SjvFy0AvMFnXSEzj53HK6kZKZ3zdKO1ioFir7yFoE8Smana1chGOAcxs4SmWH4Zj3COImxKIgkI=
X-Received: by 2002:a05:6830:1bf1:: with SMTP id k17mr11577115otb.295.1630950048986;
 Mon, 06 Sep 2021 10:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bc92ac05cb4ead3e@google.com> <CAJfpeguqH3ukKeC9Rg66pUp_jWArn3rSBxkZozTVPmTnCf+d6g@mail.gmail.com>
 <CANpmjNM4pxRk0=B+RZzpbtvViV8zSJiamQeN_7mPn-NMxnYX=g@mail.gmail.com> <CAJfpegvzgVwN_4a-ghtHSf-SCV5SEwv4aeURvK_qDzMmU2nA4Q@mail.gmail.com>
In-Reply-To: <CAJfpegvzgVwN_4a-ghtHSf-SCV5SEwv4aeURvK_qDzMmU2nA4Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 6 Sep 2021 19:40:37 +0200
Message-ID: <CANpmjNM3swsJ6F4P5CrhSTFr3uYMsMTHCFCL9huzXJgWbADxwQ@mail.gmail.com>
Subject: Re: [syzbot] linux-next test error: KASAN: null-ptr-deref Read in fuse_conn_put
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+b304e8cb713be5f9d4e1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sept 2021 at 19:35, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 6 Sept 2021 at 18:59, Marco Elver <elver@google.com> wrote:
> >
> > On Mon, 6 Sept 2021 at 13:56, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > Thanks,
> > >
> > > Force pushed fixed commit 660585b56e63 ("fuse: wait for writepages in
> > > syncfs") to fuse.git#for-next.
> > >
> > > This is fixed as far as I'm concerned, not sure how to tell that to syzbot.
> >
> > Thanks -- we can let syzbot know:
> >
> > #syz fix: fuse: wait for writepages in syncfs
> >
> > (The syntax is just "#syz fix: <commit title>".)
>
> Yeah, but that patch has several versions, one of which is broken.
> Syzbot can't tell the difference just based on the title.

True, and a general problem with trying to track -next, where even
commit hashes might change. For -next, we can probably live with just
marking the problem fixed, meaning anyone checking the issue will see
a fix exists (and not invest time in trying to fix it).

If the problem persists, syzbot will just keep complaining. ;-)
