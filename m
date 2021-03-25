Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF6349C47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhCYWav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhCYWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:30:33 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6CFC06174A;
        Thu, 25 Mar 2021 15:30:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5B2F36A2;
        Thu, 25 Mar 2021 22:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5B2F36A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616711433; bh=1qlmKLPTjs0PRb7TDA0clS4F1PUPTP6FjOnMXk0X1ss=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=POxXQ1DgCcjBE8SKpdMzx64zYvmovEJ03iURTYhsEfkqXjRuA1o5QSXtie89fFWLS
         PUyJPOji/zRQW2OaJLXZ8z7tblR+lx8tIANJSqZxv70Dr1euWs+K7dt89mnCjinrZ8
         E0UfwCItlQTxHYa7bpS7AJhvrXXDeJ8pyA0WV2o1xfOwZZIm1lnCoLHLEmaUQ8bRgg
         7EBRWE2o01ZsZKz6rd30fLmCubi1NHjAJe3s6h6e4O8+1ph1XRUhKu657vR/mbrDm1
         XYW+GidLUvJ2OOJRbdBttghzU8wnDQgutAKyUBtzsSRiPELi/KZCEigGQlEURs/8VS
         os2v04yzzsPHg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: better handle '::' sequences
In-Reply-To: <20210325221437.GA1719932@casper.infradead.org>
References: <20210325184615.08526aed@coco.lan>
 <2cf44cf1fa42588632735d4fbc8e84304bdc235f.1616696051.git.mchehab+huawei@kernel.org>
 <87tuozyslu.fsf@meer.lwn.net>
 <20210325191435.GZ1719932@casper.infradead.org>
 <87a6qrx7wf.fsf@meer.lwn.net>
 <20210325221437.GA1719932@casper.infradead.org>
Date:   Thu, 25 Mar 2021 16:30:32 -0600
Message-ID: <87wntux3w7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> The rust code is alredy coming though ...
>
> rust/kernel/buffer.rs:/// A pre-allocated buffer that implements [`core::fmt::Write`].
>
> so now we have three formats.  Markdown and RST are _very_ similar, but
> not identical [1].  Oh, and even better we now have three distinct tools --
> kerneldoc, rustdoc and sphinx.  Have the rust people reached out to you
> about integrating the various docs?

I have talked with them a bit, yes, but without any clear conclusions at
this point.  The Rust world has its own way of doing things with regard
to documentation, and I don't want to tell them they can't use it in the
kernel context.  So I think there's going to be a certain amount of
groping around for the best solution.

We did come to the mutual agreement that teaching kernel-doc to parse
Rust code as well was not an ideal solution.  Probably there will be
some sort of tool to translate between rustdoc and our sphinx setup.
Beyond that, we'll see how it goes.

jon
