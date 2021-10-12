Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DA42AD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhJLUKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhJLUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:10:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2DFC061745;
        Tue, 12 Oct 2021 13:08:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A3F02A08;
        Tue, 12 Oct 2021 20:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A3F02A08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1634069294; bh=xBvPBSgq/jALR+fUU1/6u75c/wa341hjobtQpxOJqt8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PMfsYchxyn5dDMDtzNr4WXKfliwYt/4lmDamCInzjTvhZbz1Bk3MHfG8ufppfqpwG
         +rlWRfiPHPzc1CzV3y5tBrSS45MoH/ENRANkwpfQa9F8e5wA6Nn4Xacg4+H+AqkaZj
         0A4gpuak3zgB1UJU0vYcK2OcyIb+0cUnUN2p/hBUBHen8ZDuzZCf+9VBvIpasDOtbs
         iEsW7qMoc+T5QWUbEMI9CruM9Chs5UOhAGes/F5aNdDTdZyCQ1Rd5o6QE7C2ZcH5fm
         G6nAgsE5VSgaR7FshcINvJOlFkKt7wVEDLryQitaIN+lcgXm8iUWSdN/5P3yKDsr6m
         7/QE8fi9NDBOQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: UML: user_mode_linux_howto_v2 edits
In-Reply-To: <20211010064827.3405-1-rdunlap@infradead.org>
References: <20211010064827.3405-1-rdunlap@infradead.org>
Date:   Tue, 12 Oct 2021 14:08:14 -0600
Message-ID: <871r4quhu9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Fix various typos, command syntax, punctuation, capitalization,
> and whitespace.
>
> Fixes: 04301bf5b072 ("docs: replace the old User Mode Linux HowTo with a new one")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: linux-um@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/virt/uml/user_mode_linux_howto_v2.rst |  119 +++++-----
>  1 file changed, 62 insertions(+), 57 deletions(-)

Applied, thanks.

jon
