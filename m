Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB29410A88
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 09:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhISHff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhISHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 03:35:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362E2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 00:34:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g8so47736657edt.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iBBrx3hpzJ7Ut9GBAInkoQ1AD0xMM6a14IRutCs7oY=;
        b=IAHR68j90/ljUBRKZWmRxgOJVhLH/Kg7xL/KF9YE3wBuqbXmkV70CyDSbd7JCIMmlD
         Nbp4EOOziBgOuKrJTuCM2QyBFREG8f5LtUn45lSLJzF/D+y5i/jAIMZ2mcY1y9jo4i9X
         zZ1zDOcA5NUV5bGaW5bJJRc90qxlpJbcrumJZf1u1g4KwarlFEaWfNRTAe/PCnVg9X0q
         uOoIibc6Tv0QLQM+Z6Fa71MT2ucf5wOrtS5vt0P7ptA/ifKZ2481A9nFSnxLthsHTqsG
         6U708fguty30YmJKKtzB6mj2ai8mROshdpai5tC8kPCs6MsqQwlBJBALWMnKqKn+admE
         QyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iBBrx3hpzJ7Ut9GBAInkoQ1AD0xMM6a14IRutCs7oY=;
        b=dqsHSRkSoma+ybwPXOJahooaXknGPbHGwQeyydJeespQA4P/qP1zmZxjeZFaE9Z9SF
         gMZtlG9pTvpDnOmn2bZMQ6LjGPAlGD00vU/QSjHMnwUIHCOxBhU5d11AOiWz3zk96/wt
         hga5HQ66yhy7FXfqo8WaDiFlIA+Hy7I+Esy4d5c7BkhNlmtSLgAqzvCkLNKJ5+3wCRw/
         ZuYqOLOcK3bq3a++ohMEgqhe/QkOVC/8M0zST/GOUJQZNHplI9YdWlP415TizIU8BO6m
         t1ILmpjExd+mz99XsUeg2JFCFoVqAkRNTGOK01HH0Wg6cqnN06JK/9CL4EEb6QVSm+2/
         oyeA==
X-Gm-Message-State: AOAM532sbo+u+oBWK+0gG1a4J+4sBRHijDUkL2RR7OF3y4xpwETDxNBe
        p3EUuBuzOmAIN6IMK7SqHHVox/OYPZm9BQPU08c=
X-Google-Smtp-Source: ABdhPJxBs6ByeOam+SiblI1uePg+FT0wYE9zFKlX6rMJPfpNOLyqOhuZjy/S23p3n84rA5CZ0kHPVt5umAWKaer63uA=
X-Received: by 2002:a50:dacf:: with SMTP id s15mr10806187edj.385.1632036843648;
 Sun, 19 Sep 2021 00:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210916222705.13554-1-tklauser@distanz.ch> <aa4bc59c44b345ae814c61f6593a7178@hisilicon.com>
 <YUPQ6F8M822fLzpx@yury-ThinkPad> <20210917084526.uzpish2owb24szng@distanz.ch>
In-Reply-To: <20210917084526.uzpish2owb24szng@distanz.ch>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 19 Sep 2021 19:33:52 +1200
Message-ID: <CAGsJ_4wftev=z1tf7fzVKS5wRPneWSOimSxG+E0qy2CGuRykKQ@mail.gmail.com>
Subject: Re: [PATCH] cpumask: Omit terminating null byte in cpumap_print_{list,bitmask}_to_buf
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Yury Norov <yury.norov@gmail.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 1:27 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> On 2021-09-17 at 01:19:04 +0200, Yury Norov <yury.norov@gmail.com> wrote:
> > [CC Greg KH <gregkh@linuxfoundation.org>]
> >
> > On Thu, Sep 16, 2021 at 10:53:39PM +0000, Song Bao Hua (Barry Song) wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Tobias Klauser [mailto:tklauser@distanz.ch]
> > > > Sent: Friday, September 17, 2021 10:27 AM
> > > > To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jonathan Cameron
> > > > <jonathan.cameron@huawei.com>; tiantao (H) <tiantao6@hisilicon.com>; Song Bao
> > > > Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>; Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com>; Yury Norov <yury.norov@gmail.com>; Peter
> > > > Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.org
> > > > Subject: [PATCH] cpumask: Omit terminating null byte in
> > > > cpumap_print_{list,bitmask}_to_buf
> > > >
> > > > The changes in the patch series [1] introduced a terminating null byte
> > > > when reading from cpulist or cpumap sysfs files, for example:
> > > >
> > > >   $ xxd /sys/devices/system/node/node0/cpulist
> > > >   00000000: 302d 310a 00                             0-1..
> > > >
> > > > Before this change, the output looked as follows:
> > > >
> > > >   $ xxd /sys/devices/system/node/node0/cpulist
> > > >   00000000: 302d 310a                                0-1.
> > >
> > > If we don't use xxd, I don't see any actual harm of this NULL byte
> > > by cat, lscpu, numactl etc. this doesn't break them at all.
> >
> > Barry, Tobias' script that uses xxd is userspace. Linux kernel never breaks
> > userspace.
>
> FWIW, the example using xxd was just to illustrate the issue in a
> concise way for the commit message. This is breaking other userspace
> programs as well. Originally, I discovered this because Kubernetes'
> kubelet was crashing on a bpf-next kernel. See [1] and following
> comments for more information:
>
> [1] https://github.com/cilium/cilium/pull/17394#issuecomment-920902042
>

cat, lscpu, numactl tools were tested. the above was not in the test cases.
Anyway, if some apps depend on the last character, this patch makes
sense. we need this one. sorry for missing the test case.

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

Greg, can you please help merge this one into 5.15?

> > > if we only want to make sure the output is exactly same with before
> > > for every single character, this patch is right.
> >
> > We don't want to make the output exactly the same. The "0,1" would
> > also work for the example above. But garbage characters following \0
> > is a bug that should be fixed.
>
> I think we also want to avoid the \0 itself, which is what this patch
> does and is in line with previous behavior. It also looks like all other
> sysfs files in that subtree expose the same content format (i.e. \n is
> the last character, not \0).
>
> Thanks,
> Tobias

Thanks
barry
