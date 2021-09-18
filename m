Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3736D4102D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 03:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbhIRB63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 21:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhIRB60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 21:58:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA182C061574;
        Fri, 17 Sep 2021 18:57:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r2so11287687pgl.10;
        Fri, 17 Sep 2021 18:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DLTPW/hfQBEBoxi8tw2Sw1p9mg4aUgf8URr4JiL3FCk=;
        b=Eymdlr9G0tSoHCXjKX4Nxga3jl3j7W27x1JiBCsAZkviBzZZhOQkLrElNdaKtSO2tK
         QOUh3q4L8o/2jSU8HjoNVPSSMU/87cvWUGNwdeYVYVkXFx+lgLEdUHYpBgR1USgt5Nru
         3NZTVENNMwx1FnYoFWAMTD45rtNZcENcdatQjdZeqiscYM49rA+rofP41PZayz3R4RUf
         gn8/Yts2MC8ek9tiUAmw5kXTN1qhIpyMPaS09eb+eOyX3PgdV69L5BxxEzHHs7p92lLn
         DRSXrB91q9Sn3Oxt5VowniUPCC/hN1rOhbNAj5lBbXynQxDyeiPBDx6bsPb2AJa5ksep
         DbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DLTPW/hfQBEBoxi8tw2Sw1p9mg4aUgf8URr4JiL3FCk=;
        b=JN45bbOMErIBy5ZM/snEhBklLOHEmdoEskt1a3UvqLqbiqofnXrnW+NFrfFLlLFwA9
         MdtD62HYJ/v/S2D6BcXqGPVor92dXFj88I8S/buqkvCEcFn6DAkfW6dd7v1Uz23D4UDt
         /mrVH80Ywdz7bHp4Srfb39MXr649QwDW3vD8Qeww0c4RFFkOJcdhakmXt4kULCJCOE06
         5srLDQ8eM0z8I+eI46/x2T/99/enwJW9XGs3wbIquydMlv/xzXq2bjBGbFrWJnOjZVZk
         Cmfug2sx4+BpnPEQ4ZFaexwwG6jOruWAB3CPl2Fi6VsJX/7ZW7O5GnUxb/A3yZLWtjIz
         7sEg==
X-Gm-Message-State: AOAM533EkORUOI7BvuJ3KUF+baUwjeDvz2yli0gO51ipVHVE4DyZ8x0M
        l/ZPHbc0/CeNiKK1KbhnEUzbFe1ygJJ3nTswGQ==
X-Google-Smtp-Source: ABdhPJyKZhG5q9XAq1VBNVECcq2ZYnbwAIQtVeJY8Yg36bqqS6wuC1AN1QkkOctwsHvtQ8bwPcBSDXyNNXpQV9xc7oY=
X-Received: by 2002:a65:6389:: with SMTP id h9mr12469451pgv.83.1631930223073;
 Fri, 17 Sep 2021 18:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsYQxQxGQwb3YS4obVWH3EODzqky5=nM3ADP7+13hBYgAA@mail.gmail.com>
 <20210913135459.GA120302@rowland.harvard.edu>
In-Reply-To: <20210913135459.GA120302@rowland.harvard.edu>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Sat, 18 Sep 2021 09:56:52 +0800
Message-ID: <CACkBjsZcg0B=tF8cr54VqaJMVURD9R463epZqRQfesnoY=+L8g@mail.gmail.com>
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

Hi Alan,

Alan Stern <stern@rowland.harvard.edu> =E4=BA=8E2021=E5=B9=B49=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:55=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Mon, Sep 13, 2021 at 11:13:15AM +0800, Hao Sun wrote:
> > Hello,
> >
> > When using Healer to fuzz the Linux kernel, the following crash was tri=
ggered.
> >
> > HEAD commit: ac08b1c68d1b Merge tag 'pci-v5.15-changes'
> > git tree: upstream
> > console output:
> > https://drive.google.com/file/d/1ZeDIMe-DoY3fB32j2p5ifgpq-Lc5N74I/view?=
usp=3Dsharing
> > kernel config: https://drive.google.com/file/d/1qrJUXD8ZIeAkg-xojzDpp04=
v9MtQ8RR6/view?usp=3Dsharing
> > Syzlang reproducer:
> > https://drive.google.com/file/d/1tZe8VmXfxoPqlNpzpGOd-e5WCSWgbkxB/view?=
usp=3Dsharing
> > Similar report:
> > https://groups.google.com/g/syzkaller-bugs/c/zX55CUzjBOY/m/uf91r0XqAgAJ
> >
> > Sorry, I don't have a C reproducer for this crash but have a Syzlang
> > reproducer. Also, hope the symbolized report can help.
> > Here are the instructions on how to execute Syzlang prog:
> > https://github.com/google/syzkaller/blob/master/docs/executing_syzkalle=
r_programs.md
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> There's not much hope of finding the cause of a problem like this
> without seeing the kernel log.
>

Healer found another Syzlang prog to reproduce this task hang:
https://paste.ubuntu.com/p/HCNYbKJYtx/

Also here is a very simple script to execute the reproducer:
https://paste.ubuntu.com/p/ZTGmvFSP6d/

The `syz-execprog` and `syz-executor` are needed, so please build
Syzkaller first before running the script.
Hope this can help to find the root cause of the problem.

Regards
Hao
