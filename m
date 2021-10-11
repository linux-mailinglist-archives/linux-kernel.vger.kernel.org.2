Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56312428718
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhJKHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhJKHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:04:18 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B25C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:02:19 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e63so2802649oif.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htZ8t8nOabNnJ9q7wmc+ZN1SdI8BO6B0ETLpwejMQJQ=;
        b=Y89I0etMroRJHu+6O29FtgB/nkTFwKlivNTsYmUcEb7L9c/KqcAOSbOvXXSyM+3Yun
         t6oT1PaoYH3UOpd5iTpLZXfn8HZJ58j49C9Oh6P9pjSmihFavSPS6jf3jZqAg6qtmce9
         4lgIv4K1sD67+bPMf+xC2d+EJIcO+WuBIj+b6EIvnseEKxlOsqIR3hznkYODSwlY6IJQ
         Dgel9DTXH4b6ClekkAHgV97a3QkWyqbc0YST0ggelL4S3JxoPm5e9oNbcPmuIgNZazaa
         XsBF4Kj1Rv83nPsTp2I76yVGDsie2fuuuo/cQ4G7UFsSqtADarGEofs+UzIaYPonG7ka
         3jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htZ8t8nOabNnJ9q7wmc+ZN1SdI8BO6B0ETLpwejMQJQ=;
        b=2PKyZvtGEF/+qMqVVx+eH95ZhhFAYiePPfa+dbd9zmBbiqcjM2EgKL09U7sPsBIcjT
         igvXABdJTpOhIc2TS9nAR8MdBcHMWtvAwFPGvU3E5khbvzCE7qVASokJsMRRvuLJLFH3
         OqgiNBZG61xiIEI6r+ZsVNE8YoLeJi9J5qOOBUWypDpD7gAbRLdsh/s7/9dqu2hk8uAa
         PmF0vlq7wF/aG3EXF/FyIHTnZtmwm3FSlpkXrgZZGoLI1kX9vUHAY6X2pZigTjm7cy4/
         fvToGTpITSdY7Wu92IYQjeQaIj3uJlQOEM57f8SupwR03brs9tS99azemGTNi+DcneyH
         XsRQ==
X-Gm-Message-State: AOAM533BzFyWTxxpz0QKsFAgctAbZqLT+FlpXLZb+8Kt1b2Y54WMFxnf
        IfX2cDqJ5MTsS0mMq3tihgwF/e0UKpwSA2Sat3zFuQ==
X-Google-Smtp-Source: ABdhPJxgOUUwpaH4L9dkeU8DWeSQmlFTIVya5t4BKNsCjXY+V1WKx7107AJh5oPHrZ0vDHDYWAkdK3gvJmz21JQwi20=
X-Received: by 2002:aca:f189:: with SMTP id p131mr25976776oih.128.1633935737899;
 Mon, 11 Oct 2021 00:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000baddc805cdf928c3@google.com> <YWKmBWfBS3oshQ/z@codewreck.org>
 <CACT4Y+bqD=EkkQB6hm+FVWVraDBChnRgqViLTqvmVrVM=1gH+w@mail.gmail.com> <YWPfl8FFI5uKX499@codewreck.org>
In-Reply-To: <YWPfl8FFI5uKX499@codewreck.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Oct 2021 09:02:06 +0200
Message-ID: <CACT4Y+Y9cSrctQ5gLaCy-13eEz4pxxn=h9wr2xXZTJ6+CUxTtA@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in p9pdu_readf
To:     asmadeus@codewreck.org
Cc:     syzbot <syzbot+06472778c97ed94af66d@syzkaller.appspotmail.com>,
        davem@davemloft.net, ericvh@gmail.com, glider@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 at 08:54, <asmadeus@codewreck.org> wrote:
>
> Thanks for the reply,
>
> Dmitry Vyukov wrote on Mon, Oct 11, 2021 at 07:56:05AM +0200:
> > > would be 'len' in p9pdu_vreadf, which has to be set as far as I can understand:
> > > > uint16_t len;
> > > >
> > > > errcode = p9pdu_readf(pdu, proto_version,
> > > >                                 "w", &len);
> > > > if (errcode)
> > > >         break;
> > > >
> > > > *sptr = kmalloc(len + 1, GFP_NOFS);
> > >
> > > with relevant part of p9pdu_readf being:
> > > > case 'w':{
> > > >                int16_t *val = va_arg(ap, int16_t *);
> > > >                __le16 le_val;
> > > >                if (pdu_read(pdu, &le_val, sizeof(le_val))) {
> > > >                        errcode = -EFAULT;
> > > >                        break;
> > > >                }
> > > >                *val = le16_to_cpu(le_val);
> > > >        }
> > > > ...
> > > > return errcode;
> > >
> > > e.g. either len or errcode should be set...
> > >
> > > But:
> > > > Local variable ----ecode@p9_check_errors created at:
> > > >  p9_check_errors+0x68/0xb90 net/9p/client.c:506
> > > >  p9_client_rpc+0xd90/0x1410 net/9p/client.c:801
> > >
> > > is something totally different, p9_client_rpc happens before the
> > > p9pdu_readf call in p9_client_stat, and ecode is local to
> > > p9_check_errors, I don't see how it could get that far.
> > >
> > > Note that inspecting p9_check_errors manually, there is a case where
> > > ecode is returned (indirectly through err = -ecode) without being
> > > initialized,
> >
> > Does this connect both stacks? So the uinit is ecode, is it used in
> > p9pdu_vreadf? If yes, then that's what KMSAN reported.
>
> Hm...
> Assuming that's the uninit, it'd have been propagated as the return
> value as req = p9_client_rpc; passed the IS_ERR(req) check as not an
> error, then passed to p9pdu_readf(&req->rc (later 'pdu')...)
> That would then try to read some undefined address in pdu_read() as
> memcpy(data, &pdu->sdata[pdu->offset], len)
> and returning another undefined value as
> sizeof(__le16) - min(pdu->size - pdu->offset, __le16)
>
> Here magic should happen that makes this neither a success (would set
> *val e.g. len in the kmalloc line that complains) or an error (would set
> errcode e.g. p9pdu_vreadf() would return before reaching that line)
>
> I guess with undefineds anything can happen and this is a valid link?
>
> I would have assumed kmsan checks would fail sooner but I don't see what
> else it could be.

KMSAN tracks propagation of uninits and reports only "uses".
Reporting sooner tends to produce lots of false positives because code
tends to operate/propagate/copy/add uninits, but then discard.


> > > so I will send a patch for that at least, but I have no
> > > idea if that is what has been reported and it should be trivial to
> > > reproduce so I do not see why syzbot does not have a reproducer -- it
> > > retries running the last program that triggered the error before sending
> > > the report, right?
> >
> > Yes.
>
> Ok, I guess there are conditions on the undefined value to reach this
> check down the road, even if the undefined return itself should be
> always reproducible.
>
> Either way Pavel Skripkin reached the same conclusion as me at roughly
> the same time so I'll just go with it.
>
> --
> Dominique
