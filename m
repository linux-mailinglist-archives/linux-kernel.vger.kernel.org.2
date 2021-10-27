Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7596643CCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbhJ0Oxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242600AbhJ0OxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:53:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 828BC60F21;
        Wed, 27 Oct 2021 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635346259;
        bh=yK7f6M6Qv2Cckh4UdvwrCe10fvCOBiFbkBgX3izYCh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vWm5UW/n/DuQHvu/RtgnSPoxgfEIhfQembjyu/QMH58PmvWEEcn9snf5Tb8NYEd2E
         kJYs8Sr4GB2sGQjFMI/DS3OPfFTIq0EfPlHSAI8Pa5uKqBmJrVyPqRovJZXNJTRNjd
         2r2VIBVgL1JrO4GD4CZG02azemodtODo0CzWEerE=
Date:   Wed, 27 Oct 2021 16:50:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: Re: [GIT PULL] extcon next for 5.16
Message-ID: <YXlnUKcAvzuBeFBg@kroah.com>
References: <CAGTfZH3V=SwDL6Uy6BM++sTnUmvos4vBeJf8_nvso9L6viKPnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGTfZH3V=SwDL6Uy6BM++sTnUmvos4vBeJf8_nvso9L6viKPnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 06:00:44PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.16. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:
> 
> Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)
> 
> are available in the Git repository at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git
> tags/extcon-next-for-5.16

Note, in the future, can you keep this all on one line so I don't have
to cut/paste from two lines and put it together?

Anyway, pulled and pushed out, thanks.

greg k-h
