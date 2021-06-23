Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26773B1D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFWPR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:17:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12337 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhFWPRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:17:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624461337; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=4vNjqSMYlYk5DogUqQXzNNYTENq480OkTALLBteEOqA=; b=GOIGknUX99sJ9JKf4cICYAxsEOb8GBoXDZYL20Pj69zhcMBMGI5B29aFivTOIWuX7O2Ay7CA
 T9qVZZ0BcyO6YlP8ZwiL1ZoxGDStC9ZpFRSa8CsuwwScGbQ1baIrPxTA3UTmPE+ByUmNKJtI
 DU7IS6UsMcHfekkgzCJ3VaKUDF4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d3500901dd9a943124aa5e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 15:15:21
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91056C43460; Wed, 23 Jun 2021 15:15:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        PDS_BAD_THREAD_QP_64,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32E2CC433D3;
        Wed, 23 Jun 2021 15:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32E2CC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Arnd Bergmann'" <arnd@arndb.de>
Cc:     "'Christoph Hellwig'" <hch@lst.de>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Sid Manning'" <sidneym@codeaurora.org>,
        "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org> <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
Subject: RE: how can we test the hexagon port in mainline
Date:   Wed, 23 Jun 2021 10:15:19 -0500
Message-ID: <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJHxj6Ga6VuoE3mNrk9EKW2w3HC7gG6K8dnAg2GTieqIrkNAA==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Sent: Wednesday, June 23, 2021 9:54 AM
> To: Brian Cain <bcain@codeaurora.org>
> Cc: Christoph Hellwig <hch@lst.de>; Linus Torvalds <torvalds@linux-
> foundation.org>; Sid Manning <sidneym@codeaurora.org>; open
> list:QUALCOMM HEXAGON... <linux-hexagon@vger.kernel.org>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: how can we test the hexagon port in mainline
>=20
> On Wed, Jun 23, 2021 at 4:39 PM Brian Cain <bcain@codeaurora.org> =
wrote:
> >
> > > -----Original Message-----
> > > From: Christoph Hellwig <hch@lst.de>
> > ...
> > >
> > > Hi all,
> > >
> > > the oldest supported gcc version in mainline is gcc 4.9.  But the =
only
> > > hexagon crosscompiler I can find is the one Arnds website points =
to here:
> > >
> > > https://mirrors.edge.kernel.org/pub/tools/crosstool/
> > >
> > > which is a non-upstream gcc 4.6.1 port.  How are we supposed to =
even
> > > build test hexagon code?
> >
> > We have provided a clang-12-based toolchain here:
> >
> > https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-
> 12/clang+llv
> > m-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz
>=20
> How close is this to the mainline clang builds from =
https://apt.llvm.org/?

This is built from llvm-project 12.0.0 but also contains userspace =
toolchain features like musl and qemu-linux-user for hexagon.  I suppose =
for the purposes of kernel builds they're equivalent.

> The last time we talked, there were still a couple of bugs that =
prevented
> me from building an unmodified kernel with an unmodified clang =
toolchain,
> but I think you planned to address those. Are any changes left that =
did
> not make it into the 12.0 release?

I think those were identified building with clang 12.0.0 or post-12.0.0, =
so I don't think they'll be addressed.  Let me review and follow up on =
the status of those items.  I recall one workaround was to use the =
integrated assembler to avoid one of the toolchain bugs.

> > Could we update https://mirrors.edge.kernel.org/pub/tools/crosstool/ =
to
> > point here?
>=20
> I'm happy to edit the index page on
> https://mirrors.edge.kernel.org/pub/tools/crosstool,
> but could you provide a stable URL that will keep pointing to the =
latest
> version
> in the future so I don't have to update it for each new build?

I don't know how to do that with the mechanisms we have so far.  But I =
will see about getting one created and then hopefully you could use =
that.

-Brian

