Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465D13D918B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhG1PKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:10:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44577 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235618AbhG1PIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:08:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627484924; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=3wwq0AErdGICOZ9un5uPRzTUaZOh9Woef+N1yP+Q6P8=; b=i8utI76rDKa7v2SssMXcnzQyF10jpV6VTWcxq2Xyk1e4KgMtupbIcROf/Gjykh+3FiBEyBUH
 d+tk4xBPiClaPry+EazlzU7qIVWYka7p2j0VGG/bV6pS55FXklMlW0jwZIsIUgvM803/vLKn
 Jk4PV453I9zrF5cXKwIir4FdwOw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 610172f196a66e66b2ac446c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Jul 2021 15:08:33
 GMT
Sender: bcain=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88174C4338A; Wed, 28 Jul 2021 15:08:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from BCAIN (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bcain)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 74E43C433D3;
        Wed, 28 Jul 2021 15:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74E43C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bcain@codeaurora.org
Reply-To: <bcain@codeaurora.org>
From:   "Brian Cain" <bcain@codeaurora.org>
To:     "'Nathan Chancellor'" <nathan@kernel.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
Cc:     "'Nick Desaulniers'" <ndesaulniers@google.com>,
        <linux-hexagon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>,
        "'Manning, Sid'" <sidneym@quicinc.com>
References: <20210708233849.3140194-1-nathan@kernel.org> <YQCiZSj1gfnF5x/d@Ryzen-9-3900X.localdomain>
In-Reply-To: <YQCiZSj1gfnF5x/d@Ryzen-9-3900X.localdomain>
Subject: RE: [PATCH] Hexagon: Export raw I/O routines for modules
Date:   Wed, 28 Jul 2021 10:08:31 -0500
Message-ID: <03be01d783c2$6e684420$4b38cc60$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQFUlYLPOGQsXIMzH6S1xuiFiwykdgGu9yYgrFDh67A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
...
> On Thu, Jul 08, 2021 at 04:38:50PM -0700, Nathan Chancellor wrote:
...
> > Export these symbols so that modules can use them without any errors.
> >
> > Fixes: 013bf24c3829 ("Hexagon: Provide basic implementation and/or stubs
> for I/O routines.")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >
> > It would be nice if this could get into 5.14 at some point so that we
> > can build ARCH=hexagon allmodconfig in our CI.
> >
> >  arch/hexagon/lib/io.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/hexagon/lib/io.c b/arch/hexagon/lib/io.c
> > index d35d69d6588c..55f75392857b 100644
> > --- a/arch/hexagon/lib/io.c
> > +++ b/arch/hexagon/lib/io.c
> > @@ -27,6 +27,7 @@ void __raw_readsw(const void __iomem *addr, void
> *data, int len)
> >  		*dst++ = *src;
> >
> >  }
> > +EXPORT_SYMBOL(__raw_readsw);
> >
> >  /*
> >   * __raw_writesw - read words a short at a time
> > @@ -47,6 +48,7 @@ void __raw_writesw(void __iomem *addr, const void
> *data, int len)
> >
> >
> >  }
> > +EXPORT_SYMBOL(__raw_writesw);
> >
> >  /*  Pretty sure len is pre-adjusted for the length of the access
already */
> >  void __raw_readsl(const void __iomem *addr, void *data, int len)
> > @@ -62,6 +64,7 @@ void __raw_readsl(const void __iomem *addr, void
> *data, int len)
> >
> >
> >  }
> > +EXPORT_SYMBOL(__raw_readsl);
> >
> >  void __raw_writesl(void __iomem *addr, const void *data, int len)
> >  {
> > @@ -76,3 +79,4 @@ void __raw_writesl(void __iomem *addr, const void
> *data, int len)
> >
> >
> >  }
> > +EXPORT_SYMBOL(__raw_writesl);
> >
> > base-commit: f55966571d5eb2876a11e48e798b4592fa1ffbb7
> > --
> > 2.32.0.93.g670b81a890
> 
> Ping? Brian, if you do not want to carry this, can you give an ack so
> that Andrew can?

Acked-by: Brian Cain <bcain@codeaurora.org>

