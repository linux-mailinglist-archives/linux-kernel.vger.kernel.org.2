Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F84102F1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbhIRCTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 22:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbhIRCTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 22:19:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3685C061574;
        Fri, 17 Sep 2021 19:17:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m26so10874172pff.3;
        Fri, 17 Sep 2021 19:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+M5W20MLNCUU/ws1gQOcAKUs2D9KZt8ThmqSRDtUw6U=;
        b=FtC54o/WljSING2cVeiMmgKsv0YonzncFPZ7ipCuQS5d86mpa9e8rtwwBzOBebZ8Q2
         xZulJnGc5OJtYm02iOp3FqDZj2HuvTNNBYHCVwKvIDEqrhfrhm8SLF7B6fh7p9b+YJzK
         n927jKV53f4SDlH21+Ru1OSlpZYtwrxImLof3NsujtGiWFKJbG/WOnB9Jneemp+kUHQz
         YNx/B3wdVkDgIgKWMfOiJ8j4Jrx6IqWmmSChFkTAhyuuo3mfoUaAaTJzqdfVO7lmADJ7
         71EwXDBXqPj8lYqS7qtkB4vl88GMVVV/07DNtLvYYh+EsGTg2x28cCDMZgKxwU7IzoQB
         hSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+M5W20MLNCUU/ws1gQOcAKUs2D9KZt8ThmqSRDtUw6U=;
        b=n3EmH63RLMj0AcN+RrUeYehBG/EsqUvmzt3lhto2osMKOArtDkO4pcAVKo7Lbv/Hi8
         uv5Y3ZPtTJ0kMQlZG9xBHPqWSo70/cPWhpGP1g8ZL5GbwwMSDnTyAoMzArUZYLs0fn1m
         9Eu7MaI70Yl0H2Z0Kjy9bmTr3sO7Bao+5qqOtOdqjX+sByT3mJCT8Sfs0733Y+q6Eyfb
         noWX/Qj3kULWbL1RZDT7VlS5n/16erlzHy+EfFk0O7bmYhUQWhDUb/0jMQWLLmu0BbCE
         WcNd+qj38rhFJZfd9bhJlL/4bW+pA2HR+b8NnBle2H6USQwZBAvM2LhvvUKOF4OGjAGe
         x2EQ==
X-Gm-Message-State: AOAM531wXd6Ec7KasGk1YZzpnVMny2ssLEq8DmDAdvznM1UJmt3OqhI9
        EiEUyYsVKUChNZMObLFuaVyMsNrX3g4PYprqfA==
X-Google-Smtp-Source: ABdhPJxXSAvSWlF/7f0OzTk5MFdx2gRguc9muiaQroXRWm43FnQ9eahu0KIxXtmP6zY5/MfJg+PH8BaH6rFlfKhZf0E=
X-Received: by 2002:a63:36c4:: with SMTP id d187mr12566785pga.205.1631931457171;
 Fri, 17 Sep 2021 19:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsYQxQxGQwb3YS4obVWH3EODzqky5=nM3ADP7+13hBYgAA@mail.gmail.com>
 <20210913135459.GA120302@rowland.harvard.edu> <CACkBjsZcg0B=tF8cr54VqaJMVURD9R463epZqRQfesnoY=+L8g@mail.gmail.com>
 <20210918020245.GA69263@rowland.harvard.edu>
In-Reply-To: <20210918020245.GA69263@rowland.harvard.edu>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Sat, 18 Sep 2021 10:17:26 +0800
Message-ID: <CACkBjsZPjO96NzLjKR2N7bYzBJRN6sPuaDpK6cvmGqKTd=Byow@mail.gmail.com>
Subject: Re: INFO: task hung in hub_port_init
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        a.darwish@linutronix.de, johan@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oneukum@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> =E4=BA=8E2021=E5=B9=B49=E6=9C=8818=
=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:02=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Sat, Sep 18, 2021 at 09:56:52AM +0800, Hao Sun wrote:
> > Hi Alan,
> >
> > Alan Stern <stern@rowland.harvard.edu> =E4=BA=8E2021=E5=B9=B49=E6=9C=88=
13=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:55=E5=86=99=E9=81=93=EF=
=BC=9A
> > >
> > > On Mon, Sep 13, 2021 at 11:13:15AM +0800, Hao Sun wrote:
> > > > Hello,
> > > >
> > > > When using Healer to fuzz the Linux kernel, the following crash was=
 triggered.
> > > >
> > > > HEAD commit: ac08b1c68d1b Merge tag 'pci-v5.15-changes'
> > > > git tree: upstream
> > > > console output:
> > > > https://drive.google.com/file/d/1ZeDIMe-DoY3fB32j2p5ifgpq-Lc5N74I/v=
iew?usp=3Dsharing
> > > > kernel config: https://drive.google.com/file/d/1qrJUXD8ZIeAkg-xojzD=
pp04v9MtQ8RR6/view?usp=3Dsharing
> > > > Syzlang reproducer:
> > > > https://drive.google.com/file/d/1tZe8VmXfxoPqlNpzpGOd-e5WCSWgbkxB/v=
iew?usp=3Dsharing
> > > > Similar report:
> > > > https://groups.google.com/g/syzkaller-bugs/c/zX55CUzjBOY/m/uf91r0Xq=
AgAJ
> > > >
> > > > Sorry, I don't have a C reproducer for this crash but have a Syzlan=
g
> > > > reproducer. Also, hope the symbolized report can help.
> > > > Here are the instructions on how to execute Syzlang prog:
> > > > https://github.com/google/syzkaller/blob/master/docs/executing_syzk=
aller_programs.md
> > > >
> > > > If you fix this issue, please add the following tag to the commit:
> > > > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > >
> > > There's not much hope of finding the cause of a problem like this
> > > without seeing the kernel log.
> > >
> >
> > Healer found another Syzlang prog to reproduce this task hang:
> > https://paste.ubuntu.com/p/HCNYbKJYtx/
> >
> > Also here is a very simple script to execute the reproducer:
> > https://paste.ubuntu.com/p/ZTGmvFSP6d/
> >
> > The `syz-execprog` and `syz-executor` are needed, so please build
> > Syzkaller first before running the script.
> > Hope this can help to find the root cause of the problem.
>
> I don't have time to install and figure out how to use Healer and
> Syzkaller.  But if you run the reproducer and post the kernel log,
> I'll take a look at it.
>

Just executed the reproducer, here is the full log:
https://paste.ubuntu.com/p/x43SqQy8PX/

Hao
