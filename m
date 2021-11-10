Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9644BF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhKJLDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:03:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40264 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhKJLD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:03:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A1401FD33;
        Wed, 10 Nov 2021 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636542041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GvcKRFtx8w8rSIP+kSHTZMfrUiewhvh/8GYOSosoL0=;
        b=29iiLnJF45EG6ifRVcbtBcV1Qvcf2QyBNHHUVMwTH6Pyl9bYIIjMzK8TWO5Zx/R48dK50V
        1NAb5wPqQRbjRhXnXFOjPdK1tOXyqZJsk/1opDykZU0MGsiD7Xktvy4TFo/70P93/RR+NP
        2Z4tKfnEByLryNop79+KUm/GFxM/lrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636542041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4GvcKRFtx8w8rSIP+kSHTZMfrUiewhvh/8GYOSosoL0=;
        b=aqMx0Qb8j1jvkvXN1o7ThICiuDNeeKrziuQ7/GJjpXdHPpJey1AWzITcPiHTZ3XWLuqdZD
        jf1ameD35YGwPwCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6FAB7A3B87;
        Wed, 10 Nov 2021 11:00:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3C2261E1649; Wed, 10 Nov 2021 12:00:38 +0100 (CET)
Date:   Wed, 10 Nov 2021 12:00:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: shut up pointer cast warning
Message-ID: <20211110110038.GA4048@quack2.suse.cz>
References: <20211109123621.52474-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109123621.52474-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-11-21 13:36:08, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On 32-bit architectures, the workaround of storing the directory position
> in the private_data pointer causes a warning, as loff_t does not fit in
> a pointer:
> 
> fs/udf/dir.c: In function 'udf_readdir':
> fs/udf/dir.c:78:25: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    78 |         if (ctx->pos != (uintptr_t)file->private_data) {
>       |                         ^
> fs/udf/dir.c:211:30: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   211 |         file->private_data = (void *)(uintptr_t)ctx->pos;
>       |                              ^
> 
> An extra cast to uintptr_t shuts up the warning. This is of course
> still broken if the position is ever beyond the first 2^32 bytes (4GB).
> 
> I have not found a clear information on whether directories this
> large are allowed on UDF, but it seems unlikely.
> 
> Fixes: 39a464de961f ("udf: Fix crash after seekdir")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd but the problem was actually (mostly theoretical) problem on
32-bita archs and furthermore I've realized it didn't completely fix the
original problem either. Yesterday I've pushed a different fix to
linux-next. So the warning should disappear.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
