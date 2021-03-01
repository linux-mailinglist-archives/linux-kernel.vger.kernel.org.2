Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED74232A01C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575323AbhCBDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242715AbhCAW1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:27:49 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACEC061756;
        Mon,  1 Mar 2021 14:27:09 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0E7752B8;
        Mon,  1 Mar 2021 22:27:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0E7752B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614637629; bh=rSSHnGhzEii1/rrLqGEGh+jMY3cTA7tX064ieLAcReM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BCLK8l8mBa4gQl2fv8ggTv4uI+/XfCCIEno1aunjEvT2P89j7iK9en1AaDJYCJtCV
         ejjCEXlv2DiAiJ7hhwdIvZTyHO3Kf/aCs0hzo1kDbk+V9Ez+MgkcEob6/mv0TvOTOh
         ehtAOS/dMVhKP9nvKaJc1dD5FLd67giB1XQMybTuQ6/+UIRfeOQ9AYVUSgS8rjFD4Z
         xAzfrr0oDcYEyxktC0vZkHQsfKpTuYLlHILExhsM3xD1a71NG7xMlTenW5L++VNxro
         Ahk7m9OTjjSaHxeGAQSAf+EDDH29wEv8T0kMaeaIj+aXeaT6y/WrJaYwZmr270zNoc
         iJ7e8EpZZogxA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs: eventpoll: fix comments & kernel-doc notation
In-Reply-To: <20210210042526.23174-1-rdunlap@infradead.org>
References: <20210210042526.23174-1-rdunlap@infradead.org>
Date:   Mon, 01 Mar 2021 15:27:08 -0700
Message-ID: <87im6a1pdv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Use the documented kernel-doc format for function Return: descriptions.
> Begin constant values in kernel-doc comments with '%'.
>
> Remove kernel-doc "/**" from 2 functions that are not documented with
> kernel-doc notation.
>
> Fix typos, punctuation, & grammar.
>
> Also fix a few kernel-doc warnings:
>
> ../fs/eventpoll.c:1883: warning: Function parameter or member 'ep' not described in 'ep_loop_check_proc'
> ../fs/eventpoll.c:1883: warning: Excess function parameter 'priv' description in 'ep_loop_check_proc'
> ../fs/eventpoll.c:1932: warning: Function parameter or member 'ep' not described in 'ep_loop_check'
> ../fs/eventpoll.c:1932: warning: Excess function parameter 'from' description in 'ep_loop_check'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> ---
> Jon: Al says that he is OK with one of you merging this fs/
>      (only comments) patch.
>
>  fs/eventpoll.c |   52 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Both patches applied, thanks.

jon
