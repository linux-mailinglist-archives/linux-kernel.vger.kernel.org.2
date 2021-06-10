Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439513A3773
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 00:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFJW70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 18:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhFJW7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 18:59:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E79A6613E1;
        Thu, 10 Jun 2021 22:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623365849;
        bh=2qdiKDsyqPFhDYPrvVgVTKvPw/sEvqf7zh726VLz6oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4QOnH+iB2+HQX/xjqiXTm6GkBuwf0HXl0tubPc4tqIchX5M/JPj+0aXJc4H1dRc6
         iHWYY3W8LfE5UR7maDeWIoS6+BDG9TL7DGJJg6qkreFBER7x77XoctmWwnojk2UFTn
         CWszSxnOAGk9zOy+uPvvMeBKFVAwEhMD0Bmf3K7ZGcRSSN2XGBZ2lBo68IqOYOGt5N
         aJWUBo+VrJ+mMlsxJ1pGQviVSJ7lgBZJORUm/c+fp+1rm+Z4Zf0oNPPW9fNKeplWxP
         OlDA9s+Uw9M/4C3csHao6xW3id36sDPefwShQ0sD4KNpbO1xMCcc1pXBa7RxF8EQN3
         HTXjdy0o2gCeg==
Date:   Thu, 10 Jun 2021 15:57:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce f2fs_casefold_name slab
 cache
Message-ID: <YMKY11PC5y/EfZYf@gmail.com>
References: <20210608000022.5509-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608000022.5509-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 08:00:22AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Add a slab cache: "f2fs_casefold_name" for memory allocation
> of casefold name.

Commit message should say "f2fs_casefolded_name", not "f2fs_casefold_name".

> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - change slab cache name to "f2fs_casefolded_name"
> - add a "f2fs_" prefix for slab cache variable name
>  fs/f2fs/dir.c      | 17 +++++++++++------
>  fs/f2fs/recovery.c |  6 +++++-
>  fs/f2fs/super.c    | 24 ++++++++++++++++++++++++

Otherwise this looks good.

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
