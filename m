Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6534007AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 23:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350079AbhICV6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbhICV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:58:49 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B9CC061575;
        Fri,  3 Sep 2021 14:57:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C2D69734;
        Fri,  3 Sep 2021 21:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2D69734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1630706268; bh=0ztR2PG58bionl4htPOnZ6zEyz1G9LrFqWLzfCqwD/s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NZfFHTrXboAKes3S4DXV9qNAGuGzHChc7P4QQ32ONj3Ns6rPIO8APXnUdbZGXpcye
         DY/TzQtAFRVekgi4ieNgKQK1WnC2ugh73N3DuqwxDbToPwlYYr7WzZVIKaUJxNOash
         SMb/DIisJImpVPGqHjxvbood6DSZiDKeUvR5VA0eMJRq/sfKGTztwv/yYSa9pl2QgK
         yeY4xS5ER7Yh9qswM4+Kv0HnlYwdW0U7k6EazEdgYy97Jp862wTnhqYNMsEE+IrR4F
         4tC1WQ5JND0vrdQLzGNE5rVP5zO3zvhywGBA1hs00Th67s0THq++J/bVhaeUKiEUFh
         AOjAihDGoHqvg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, linux-doc@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH] docs: kernel-hacking: Remove inappropriate text
In-Reply-To: <20210903151826.6300-1-alyssa@rosenzweig.io>
References: <20210903151826.6300-1-alyssa@rosenzweig.io>
Date:   Fri, 03 Sep 2021 15:57:48 -0600
Message-ID: <877dfxxqxv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alyssa Rosenzweig <alyssa@rosenzweig.io> writes:

> Remove inappropriate sexual (and ableist) text from the locking
> documentation, aligning it with the kernel code-of-conduct. As the text
> was unrelated to locking, this change streamlines the document and
> improves readability.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
>  Documentation/kernel-hacking/locking.rst | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

That text dates all the way back to pre-2.4 kernels...there goes a bit
of history.  It's history that we can do without at this point, though;
patch applied, thanks.

jon
