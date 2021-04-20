Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57236365F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhDTS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhDTS2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:28:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CE106052B;
        Tue, 20 Apr 2021 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618943271;
        bh=KKqI0CtdBHnooIUsDeB/ucsXCbS8kOelphJ+U2dDNfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMeUBUM/+jZCj2JdxtT/7Fdp9QL90Wfk11n0DYy8kF9zUtstSlzZN75u9JANQoyCf
         s2eYbxuLp8hFXHKeEoM9SMAAnGuNGH9IGy6e8ZQMGVfM0Efc5qkoAMRe7GbWk0CwiJ
         8fCgLcHp90AtT5MsUZU5H8POYsc9S/wk1n/xtaAbubyT3EOtVCmgRVaClPCRLP81pa
         IHbMn+pBSQ6ORV5tVGXFHbVlVtXUqXfWrWuayR1YfIXBO+af2Pg/2dgIIuqvX7ptY5
         to6xfFGwQSclnbqdu7mXMM+edDGlcydVnovqox9ILTBOjqX/IaaOadJbBCvu1jj0xX
         4ekaxTRy6V+og==
Date:   Tue, 20 Apr 2021 11:27:49 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-bounds memory access
Message-ID: <YH8dJQCJm7iqsC+a@google.com>
References: <20210322114730.71103-1-yuchao0@huawei.com>
 <CAFcO6XMak8GSRqQbZ3nPdGvV_eM6DL0+P0z1X2y0G9hkrccaCg@mail.gmail.com>
 <beff8953-d91a-c677-f50a-3aba27c15dde@huawei.com>
 <YH8SvK+OLSKAEYpJ@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH8SvK+OLSKAEYpJ@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/20, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Tue, Mar 23, 2021 at 02:43:29PM +0800, Chao Yu wrote:
> > Hi butt3rflyh4ck,
> > 
> > On 2021/3/23 13:48, butt3rflyh4ck wrote:
> > > Hi, I have tested the patch on 5.12.0-rc4+, it seems to fix the problem.
> > 
> > Thanks for helping to test this patch.
> 
> Was this patch applied? I do not see it in mainline (unless
> miss-checked).

Not yet. Queue for next merge window.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=b862676e371715456c9dade7990c8004996d0d9e

> 
> Regards,
> Salvatore
