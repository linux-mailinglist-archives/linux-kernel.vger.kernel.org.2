Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823163EF6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 02:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhHRA3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 20:29:23 -0400
Received: from mx.cjr.nz ([51.158.111.142]:21324 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234302AbhHRA3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 20:29:22 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id B14107FF6C;
        Wed, 18 Aug 2021 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1629246526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYTI8eHnDRDCuYc0EGEyTDS9vWJeBebzaFZ1mBVnpqY=;
        b=xNEqtCdNo1Bd1VWZ/z76niW2n6KK3nCMJn5Fm85WH/4+CKIoq/P8l9ZdFpVYnC8IL0TXYd
        ykoUecU2BuAcbcK67sNJDOp6MCi5Yo4jC7K8SQxW6ZKxtrgWOSdrY/eDD9nD5/WxY3T5Ey
        8rhteKBABaNAqecGtYHiYnKxO05MYx/1BivgfstsSYxcn7dRZ+VZf5O7deyzQnd7rhIhMP
        Zp91ff3F14rrQ684DPL1P7jwBzZ2uWpBIBBOyCzSKFOATOlVKGOA5dIXLkCvs2n/SNc56X
        QA64M8ytvh/1Qe1ONobUGi8H4A/l28GLROWnvMZpicbq+KOPYg3RJhw8OOHnsg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Len Baker <len.baker@gmx.com>, Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@kernel.org>,
        Suresh Jayaraman <sjayaraman@suse.de>
Cc:     Len Baker <len.baker@gmx.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] CIFS: Fix a potencially linear read overflow
In-Reply-To: <20210817102709.15046-1-len.baker@gmx.com>
References: <20210817102709.15046-1-len.baker@gmx.com>
Date:   Tue, 17 Aug 2021 21:28:40 -0300
Message-ID: <87im03h9zb.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Baker <len.baker@gmx.com> writes:

> strlcpy() reads the entire source buffer first. This read may exceed the
> destination size limit. This is both inefficient and can lead to linear
> read overflows if a source string is not NUL-terminated.
>
> Also, the strnlen() call does not avoid the read overflow in the strlcpy
> function when a not NUL-terminated string is passed.
>
> So, replace this block by a call to kstrndup() that avoids this type of
> overflow and does the same.
>
> Fixes: 066ce6899484d ("cifs: rename cifs_strlcpy_to_host and make it use new functions")
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  fs/cifs/cifs_unicode.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
