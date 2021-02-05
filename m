Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A53310750
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhBEJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhBEJCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:02:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47C5F64FB7;
        Fri,  5 Feb 2021 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612515715;
        bh=Mcqzu6fMcx8quc9YblmBNqOcxfIfuRAUgvRTdeue+0g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=E/hGQ48H288v2XGveFxfFJKBnXladwFDdkybtunSyRMD5k5IXOPTQBUXFovYIljZ1
         l6wZZR5WlJTFAc99Lu+uz1uQugi+0DmwHRWRJIgOiJjcfXvKlrNafYE1EYTStpjL79
         tZI2wearpqnW4X9DEwl1MreUyKM+VMLcCXWTBkQFjLXmviPp4Gd4fmZDKnSiGumjFr
         mNKwjXWiytRNaUfKT/c7BrufTQ5mS7A9c0VxETEZgyaBHy5JiZlJEF2dkTpTpEiod9
         ETvoLWMsQmrHnOllW2BNJOxSvReNeeUcquH8tiFTiDsZ/xJQCqpsGiC4GfCjVACcIh
         fBLK8S77BdykA==
Date:   Fri, 5 Feb 2021 10:01:52 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kurt Garloff <kurt@garloff.de>
cc:     Jens Axboe <axboe@kernel.dk>, efremov@linux.com,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Floppy patch for 5.12
In-Reply-To: <925c6067-f317-70d1-231d-9d97c517212b@garloff.de>
Message-ID: <nycvar.YFH.7.76.2102051000460.28696@cbobk.fhfr.pm>
References: <45f555f4-b694-ca8e-c088-f34dea9fc7c7@linux.com> <ba300e13-dc16-af15-a386-0c5348e0f919@kernel.dk> <925c6067-f317-70d1-231d-9d97c517212b@garloff.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021, Kurt Garloff wrote:

> >> The following changes since commit 0d7389718c32ad6bb8bee7895c91e2418b6b26aa:
> >>
> >>   Merge tag 'nvme-5.21-2020-02-02' of git://git.infradead.org/nvme into for-5.12/drivers (2021-02-02 07:11:47 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.12
> > Pulled, thanks.
> 
> Great, thanks!
> 
> Next is -stable then ... so all those cloud images using floppy to 
> inject metadata work again, despite current libblkid. (Fortunately, most 
> use cdrom these days.)

-stable we can do only after the commit lands in Linus' tree.

Once that happens, I believe we can just as the version we have in 
openSUSE 15.2 kernel for now as-is:

	https://github.com/openSUSE/kernel-source/commit/ab10a7db5f5b721bf2145e6eab9358a751dd0e5b

-- 
Jiri Kosina
SUSE Labs

