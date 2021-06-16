Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4133A93A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhFPHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:19:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231665AbhFPHTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:19:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EC3F613B9;
        Wed, 16 Jun 2021 07:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623827860;
        bh=vzNbASvPNyWJbR89YyZgUGO1Mle5ZgzHENB8vDFYWxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXoWR3AdteVbCYG/Xj9z0at1MxpssAcSBg4mXCOKRKN80M+QfcnufYc0z6sW7T4su
         fL1kZfdbJXxDDdIFSvvZ4DukM+/A1B+waS8gQ0axAU/AKq2+xZ9z0B15psgdpc3Lyq
         xyHs7Bbq7RFBFR4CK7LpeaaIe2gOI154rsc7bSUc=
Date:   Wed, 16 Jun 2021 09:17:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] mcb: Use DEFINE_RES_MEM() to simplify code
Message-ID: <YMmlkmnEWetYVXdg@kroah.com>
References: <20210616015509.672-1-thunder.leizhen@huawei.com>
 <20210616015509.672-2-thunder.leizhen@huawei.com>
 <YMmdAQtPN7QRfcNO@kroah.com>
 <8bd6946b-b3f5-35c7-2cbe-51f4c4841d20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd6946b-b3f5-35c7-2cbe-51f4c4841d20@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 02:57:14PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/6/16 14:41, Greg Kroah-Hartman wrote:
> > On Wed, Jun 16, 2021 at 09:55:09AM +0800, Zhen Lei wrote:
> >> Use DEFINE_RES_MEM() to save a couple of lines of code, which makes the
> >> code a bit shorter and easier to read. The start address does not need to
> >> appear twice.
> >>
> >> By the way, the value of '.end' should be "start + size - 1". So the
> >> previous writing should have omitted subtracted 1.
> > 
> > Does that mean the current code is wrong and this is a bugfix?  If so,
> > what commit id does this fix?
> 
> OK, I'll add Fixes.
> 
> However, some people think that only functional fixes need to add "Fixes".

If this is not a "fix" then that is fine, I can take it as-is, it just
was not obvious.

greg k-h
