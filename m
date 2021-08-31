Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4E3FC41B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbhHaIIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240107AbhHaIIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:08:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34B64603E7;
        Tue, 31 Aug 2021 08:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630397266;
        bh=z7P55UZRnlAxsdqAANQXJIQgoIdMDN7PXKO0gr+rm5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2vdWeLhaBBq6sEVc+B7bSwAyRp14UvYy8+aptxG9qQeEaexhWxicYWqcobw7kMX+
         bj0yqnoB6ECi5yqLdEP7Baz+WzV1Km2pbmFaC7VO5BuDwp7A4Dk43tqqUZ8O/MA8Bd
         MaO2Ny3od4cBnW1L+hq5uJC840+68lG07ujDXV6FvuvVkGPwqwYB1ojYsy1H/w2tNi
         r1kmMKP2oKeDKs9ZSlmY/q3Mr+Po4nbanzvWf7+QKOrHLfZjsFI7bhtJRQpiwLkQMT
         RJ6vcg94nwwM8sSKTGyinTt0ISTQwKiAk95Gn0CBOZ0ivYMstet2jArn/uQffncUCZ
         CwF87DBWP/nZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mKyny-0007AS-8H; Tue, 31 Aug 2021 10:07:39 +0200
Date:   Tue, 31 Aug 2021 10:07:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from
 IDR to XArray
Message-ID: <YS3jSsGSs0yAw/Ba@hovoldconsulting.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <YSyg/Db1So0LDGR+@hovoldconsulting.com>
 <2879439.WEJLM9RBEh@localhost.localdomain>
 <YSzGkNfG6HOayiXi@hovoldconsulting.com>
 <YSzMB80NOkNvdjy1@casper.infradead.org>
 <YSzQAd0Rg5CF/eLe@hovoldconsulting.com>
 <f7a25eb1-20f4-5031-a156-9e5dc019ad28@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a25eb1-20f4-5031-a156-9e5dc019ad28@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 08:20:25AM -0500, Alex Elder wrote:

> I have been offering review feedback on this patch for three reasons:
> 
> - First, because I think the intended change does no real harm to the
>   Greybus code, and in a small way actually simplifies it.

You leave out that we've already seen three versions of the patch that
broke things in various ways and that there was still work to be done
with respect to the commit message and verifying the locking. That's all
real costs that someone needs to bear.

> - Because I wanted to encourage Fabio's efforts to be part of the
>   Linux contributor community.

Helping new contributers that for example have run into a bug or need
some assistance adding a new feature that they themselves have use for
is one thing.

I'm not so sure we're helping either newcomers or Linux long term by
inventing work for an already strained community however.

[ This is more of a general comment and of course in no way a critique
  against Fabio or a claim that the XArray conversions are pointless. ]

> - Because I suspected that Matthew's long-term intention was to
>   replace IDR/IDA use with XArray, so this would represent an early
>   conversion.

That could be a valid motivation for the change indeed (since the
efficiency arguments are irrelevant in this case), but I could not find
any indications that there has been an agreement to deprecate the
current interfaces.

Last time around I think there was even push-back to convert IDR/IDA to
use XArray internally instead (but I may misremember).

> The Greybus code is generally good, but that doesn't mean it can't
> evolve.  It gets very little patch traffic, so I don't consider small
> changes like this "useless churn."  The Greybus code is held up as an
> example of Linux kernel code that can be safely modified, and I think
> it's actively promoted as a possible source of new developer tasks
> (e.g. for Outreachy).

Since most people can't really test their changes to Greybus perhaps it
isn't the best example of code that can be safely modified. But yeah,
parts of it are still in staging and, yes, staging has been promoted as
place were some churn is accepted.
 
Johan
