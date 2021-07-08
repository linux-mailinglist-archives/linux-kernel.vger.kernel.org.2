Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28B3C1942
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGHSjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:39:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56156 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGHSjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:39:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625769387; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=CaCFZHGTqeI0frAdNEP44m6CAB9Mlr4tcLRQxgjQMC0=; b=m3HUMQj1xxyma1swyAt7aiu0O286JGjG/LeOix7WDS+s1HT4CIa9MRS+MraGANZMa7z5iEjT
 Ns7amQFFVqwoT2JECxHLPUBuD1F35uAvNZm//PKkJHa3Uo9HUGqQaq0EmTVGyTd1c2fx6zmu
 lkjs4055zPfVLS3uSd4TfMwKqJ8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60e74589ec0b18a7451dfa54 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Jul 2021 18:35:53
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9806C43143; Thu,  8 Jul 2021 18:35:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44C17C433F1;
        Thu,  8 Jul 2021 18:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44C17C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        "'Christoph Hellwig'" <hch@lst.de>
Cc:     "'Manning, Sid'" <sidneym@quicinc.com>,
        "'Nathan Chancellor'" <nathan@kernel.org>,
        "'Sid Manning'" <sidneym@codeaurora.org>,
        "'Arnd Bergmann'" <arnd@arndb.de>, <linux-hexagon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org> <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com> <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de> <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com> <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain> <20210707141054.GA24828@lst.de> <1ee8fc44-3e8c-91c0-7909-a636757dbda4@kernel.org> <20210708052751.GA18789@lst.de> <CAKwvOd=iRLQPum8-jaCG90TPyxDptNB31yRHMEWgSMxjv=KuHA@mail.gmail.com>
In-Reply-To: <CAKwvOd=iRLQPum8-jaCG90TPyxDptNB31yRHMEWgSMxjv=KuHA@mail.gmail.com>
Subject: RE: how can we test the hexagon port in mainline
Date:   Thu, 8 Jul 2021 13:35:49 -0500
Message-ID: <0a6801d77428$13c88060$3b598120$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJHxj6Ga6VuoE3mNrk9EKW2w3HC7gG6K8dnAg2GTicC7yoGzAOeQQE6AcpiXAwBQV0IVQJh9CDkAd1aUgECtDKCjQHeCRXAqactp4A=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Thursday, July 8, 2021 12:54 PM
> To: Christoph Hellwig <hch@lst.de>
> Cc: Nathan Chancellor <nathan@kernel.org>; Brian Cain
> <bcain@codeaurora.org>; Sid Manning <sidneym@codeaurora.org>; Arnd
> Bergmann <arnd@arndb.de>; linux-hexagon@vger.kernel.org; linux-
> kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> Subject: Re: how can we test the hexagon port in mainline
>=20
> On Wed, Jul 7, 2021 at 10:27 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jul 07, 2021 at 10:42:27AM -0700, Nathan Chancellor wrote:
> > >> hch@brick:~/work/linux$ make -j4 ARCH=3Dhexagon
> > >> CROSS_COMPILE=3Dhexagon-unknown-linux-musl LLVM=3D1 LLVM_IAS=3D1
> defconfig all
> > >> HOSTCC  scripts/basic/fixdep
> > >> clang: error while loading shared libraries: libtinfo.so.5: =
cannot open
> shared object file: No such file or directory
> > >
> > > Hmmm, is that with libtinfo5 installed (or whatever the =
ncurses-compat
> > > equivalent is on your distribution installed)? I had that problem =
on Debian
> > > until I insta
> >
> > I did install libtinfo5, which just gets me to the next error:
> >
> > hch@brick:~/work/linux$ export PATH=3D/opt/clang+llvm-12.0.0-cross-
> hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/:$PATH
> > hch@brick:~/work/linux$ make -j4 ARCH=3Dhexagon
> CROSS_COMPILE=3Dhexagon-unknown-linux-musl LLVM=3D1 LLVM_IAS=3D1 =
defconfig
> all
> >   HOSTCC  scripts/basic/fixdep
> > clang: error while loading shared libraries: libc++.so.1: cannot =
open shared
> object file: No such file or directory
>=20
> ^ Nathan did mention earlier in the thread that he "had to install
> libtinfo5 and libc++1-7 on Debian Buster." Emphasis on the _and
> libc++_ part.
>=20
> I'm not sure if that binary distribution came with a libc++.so.1; if
> so, that path needs to be specified via LD_LIBRARY_PATH so that the
> runtime loader can find it.  Perhaps rpath wasn't set when the clang
> binary was built.

The only libc++ builds in this distribution are the target hexagon ones. =
 I did not include a host x86_64 libc++.so library, but it does seem =
like it would be more convenient if we did.

Nathan suggested disabling the terminfo dependency, I will include that =
change for the next release that we produce.  Also, the upcoming =
clang-13 release from releases.llvm.org should contain all the necessary =
fixes (discussed recently) to build kernel code for hexagon.

> We're looking into statically linked images of clang to prevent these
> kinds of games.

Statically linking against libc++/libc++abi at least seems like a good =
idea.  Let me know if we can help.

-Brian

