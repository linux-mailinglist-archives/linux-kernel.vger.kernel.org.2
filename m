Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643CB368DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhDWHLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241136AbhDWHLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97D7C6144A;
        Fri, 23 Apr 2021 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619161835;
        bh=07uPf56UihuHP6h60A6xn8XZGobXrQnzIBtqs41xaHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+zLdASW653rPTYWWbEq5RzR4UDjL3O0nmqzFujAyyrxzzsVQdI82KIjwogosCCas
         IbIeWuCKT6N1uvPvc5U/hxIq0xImoD8C0MFTiF2XGFQ4cjnnxGrygqJAC3IRphnnOb
         M4/8JLAAWlX1H3RLwROhKy595ej0quXnQpzabxjo=
Date:   Fri, 23 Apr 2021 09:10:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
Message-ID: <YIJy6AnG6QBlkV/5@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-10-gregkh@linuxfoundation.org>
 <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:04:27AM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> > This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> 
> This looks like a good commit but should be done now in a different way
> - using pm_runtime_resume_and_get().  Therefore I am fine with revert
> and I can submit later better fix.

Great, thanks for letting me know, I can have someone work on the
"better fix" at the same time.

greg k-h
