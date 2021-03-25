Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65B7349B61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhCYVE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:04:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:52272 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhCYVEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:04:01 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B9C0D6A2;
        Thu, 25 Mar 2021 21:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B9C0D6A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616706240; bh=iGv+gy+JQHLdwSA/W99xdBIG7NrXqMxzGHgpi0V8xoI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=C2xRhDozwuE/9W4G+Ys47QGMv+I4fWco5t/ATvwMaMp4ix+LysEWb+VLxr+jQ7lMv
         f9QiKith1pPeLUTKEiZDcAszuJV11zNlxQtrDXSMfA7JPW3m44yjjb3xpdjZdTz9VC
         6sTaZcPb/yOVcNi556/Z60567clHenopFODJDolSaGdR+9v17HmLmST339GkCb8wG3
         U/luDihWgnJ05H4nyv+3zpLBylgglsljr0OxoOsSWBnTPEZ19wXr1JTSv8GMvZwW9m
         PR5G/J6IghVOv46bZY77djDJFGNH8s6c7D7v1wE7Z0evThFHYLMUcaWxFclyER8R/7
         EW3RkOa5dxU2Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
In-Reply-To: <20210325191435.GZ1719932@casper.infradead.org>
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net>
 <20210325191435.GZ1719932@casper.infradead.org>
Date:   Thu, 25 Mar 2021 15:04:00 -0600
Message-ID: <87a6qrx7wf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Mar 25, 2021 at 12:51:25PM -0600, Jonathan Corbet wrote:
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>>=20
>> > Right now, if one of the following headers end with a '::', the
>> > kernel-doc script will do the wrong thing:
>> >
>> > 	description|context|returns?|notes?|examples?
>> >
>> > The real issue is with examples, as people could try to write
>> > something like:
>> >
>> > 	example::
>> >
>> > 		/* Some C code */
>> >
>> > and this won't be properly evaluated. So, improve the regex
>> > to not catch '\w+::' regex for the above identifiers.
>> >
>> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> > ---
>> >  scripts/kernel-doc | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> Ah....wouldn't it be nice if kerneldoc comments had just been RST from
>> the beginning?  I don't think we're fixing that at this point, though,
>> so this makes sense; applied.
>
> Well ...
>
> If somebody wants to write a new tool (*) that extracts documentation
> written in a different format, I think that could be done.  Because the
> hard part of writing documentation is getting the person who knows the
> code to get everything that's in their brain into words, not really
> the formatting.
>
> If somebody did want to write such a tool, I think we'd also want a
> tool that turns the existing kernel-doc into the new format, because
> maintaining two function-doc formats would be awful.

Yeah, the thing is that, as long as we're documenting code with
something other than RST, we *do* have two formats, and they interact
with each other in surprising and unwelcome ways.

I don't really see a fix, though.  Even if we come up with the Perfect
New Format=E2=84=A2, I don't want to be the one trying to push through the
patches changing tens of thousands of kerneldoc comments over...

jon
