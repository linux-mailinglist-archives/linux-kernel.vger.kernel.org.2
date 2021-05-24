Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10AD38E6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhEXMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhEXMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:51:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16DAB613AD;
        Mon, 24 May 2021 12:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621860617;
        bh=BK3GxEVGm3i/tXdMBD56HqOEOzlxjKGyVXbAR3B48x8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6TKBvsZXNM95GX2FxmO9b9Nlv4fdMtQb09bYVrmsJih76aCAG1Z/cWYmEOFJhvHJ
         QKAtLot7CKWnJu+Yy46M7YgXrAQo+Xd+4d5bM5oZfQmSGbQVISB2I6TjoNsw5Dafnz
         0JLAOxg0Y2fCvNY8lwK47+B8j3g1Ys/CM9ODTkks=
Date:   Mon, 24 May 2021 14:50:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org
Subject: Re: [PATCH stable-5.10,5.11,5.12] x86/boot/compressed/64: Check SEV
 encryption in the 32-bit boot-path
Message-ID: <YKuhBmTVUYMvLhXE@kroah.com>
References: <20210508032224.039CF613ED@mail.kernel.org>
 <YJZnYDty7Siyo68k@kroah.com>
 <YKOnVYLRxk9CUzTc@suse.de>
 <YKOnot8C4RKrWtXm@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOnot8C4RKrWtXm@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 01:40:18PM +0200, Joerg Roedel wrote:
> On Tue, May 18, 2021 at 01:39:02PM +0200, Joerg Roedel wrote:
> > [ Upstream commit fef81c86262879d4b1176ef51a834c15b805ebb9 ]
> > 
> > Check whether the hypervisor reported the correct C-bit when running
> > as an SEV guest. Using a wrong C-bit position could be used to leak
> > sensitive data from the guest to the hypervisor.
> > 
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Link: https://lkml.kernel.org/r/20210312123824.306-8-joro@8bytes.org
> > ---
> >  arch/x86/boot/compressed/head_64.S | 85 ++++++++++++++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> 
> This is compile-tested now for 5.10, 5.11 and 5.12. With 5.12 I also did
> a boot-test using the 32-bit boot-path and verified it still works as
> expected.

Now queued up, thanks.

greg k-h
