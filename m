Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C963D4FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhGYUFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 16:05:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:42034 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGYUFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 16:05:40 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 539FA2E6;
        Sun, 25 Jul 2021 20:46:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 539FA2E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627245970; bh=TuTMn4o7PhW7u5FWUGN7SYgYL59tBjTBrcZFeu3oH+Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X1Gie8v8uWddy4GjZEb+CqONP79Wj5/xYC8D7ebX7LGL8MXs4KBEDeEGGuMurjiKR
         4qQwsDnrRpZKkrxIu4PbsDBL2+E/2GEeeJ7ZQeAn1RY3xFQYTATvIpfkvv+58rW5Mb
         NUK2iu5PPY7XaCG29fyIHzkYIo7gl/iobP85PrKyFdXl+TqhvO53ZHfhvpontXKfU3
         B0Cynnq8q8xcsRnyj+03inf/xk/xtogVY1HWrDuruLFpc8D9+bXPY+hV4xVbEvUGZt
         idbO7TRpsik2DAXIZE6eqdqPNteRNUyBVFN6Qy4hPEai39vKpUaVf8VTqzn9QuSevC
         1BrJTNAl1WqeA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hannu Hartikainen <hannu@hrtk.in>, linux-doc@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Hannu Hartikainen <hannu@hrtk.in>
Subject: Re: [PATCH] docs: submitting-patches: clarify the role of LKML
In-Reply-To: <20210707133634.286840-1-hannu@hrtk.in>
References: <20210707133634.286840-1-hannu@hrtk.in>
Date:   Sun, 25 Jul 2021 14:46:09 -0600
Message-ID: <87sg02t94e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hannu Hartikainen <hannu@hrtk.in> writes:

> The documentation previously stated that LKML should be used as *last
> resort*. However, scripts/get_maintainer.pl always suggests it and in a
> discussion about changing that[0] it turned out that LKML should in fact
> receive all patches.
>
> Update documentation to make it clear that all patches should be sent to
> LKML by default, in addition to any subsystem-specific lists.
>
> [0]: https://lore.kernel.org/lkml/19a701a8d5837088aa7d8ba594c228c0e040e747.camel@perches.com/
>
> Signed-off-by: Hannu Hartikainen <hannu@hrtk.in>
> ---
>  Documentation/process/submitting-patches.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

jon
