Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69802331B99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhCIAVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhCIAVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:21:16 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:21:12 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5062131A;
        Tue,  9 Mar 2021 00:21:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5062131A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615249272; bh=InMkmI9paP+8jJ22XBL8NtI/vyyreFrYdmisaZeCtho=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bL/Cj0OSPYmimuAv5gOx0Sv/RT2fTdOW1CdP/kO/xM+psv/aUuTPxItusXmO3MqhX
         mbBOQU9fZTcwr3LHpxG2Tlf4ds1x4GrIvhPwts4eqlNVI5TR5bPqkSeOI47MjsR0Ye
         0Nc+ZGhG7P2uN/gcAIVM8akj+Ldl0UNOBHr7pNfKTnSFOnD/iV4wh1Fhg5C+KvfF6K
         7nZ7luPkq+3eXf1xxRwIDpq12gZ0WHvfWXXP6cOjngQIWUAGFajlzr5oMasyKLiyjV
         yk5Z5QY8vABC5qroAwr8eCpTg2/iIKtcCFTQLEzjeWycDoV8u3DxEGLmGjotCz1C7U
         /+YfAOvrgw26w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH v2] docs: filesystem: Update smaps vm flag list to latest
In-Reply-To: <20210302000646.432358-1-peterx@redhat.com>
References: <20210302000646.432358-1-peterx@redhat.com>
Date:   Mon, 08 Mar 2021 17:21:11 -0700
Message-ID: <87k0qh41oo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> We've missed a few documentation when adding new VM_* flags.  Add the missing
> pieces so they'll be in sync now.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - rebase
> ---
>  Documentation/filesystems/proc.rst | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

jon
