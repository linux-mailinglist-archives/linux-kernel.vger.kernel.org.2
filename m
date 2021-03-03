Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F732BBC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446998AbhCCMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1842564AbhCCIHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:07:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD33864EE4;
        Wed,  3 Mar 2021 07:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614756935;
        bh=svV7Egsy0fp0iNrHlIC+P1raaOYWY3P/kyHNIUiTxRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eu3Qp6yUYrM5ciwLfuoaghR06BoNA5CxQp9bsmp595rz2+y2mnt5JglrilPZl7DMD
         l0aSMv4Xg2747D5p1gMbuWrZeoA4yksN8rI47etz9wxHfDj6U8SdpD6a1CsyAA/MdN
         rerJghrTVt8fvLAzJ0l93+NltXmBn5zi4xkNhzMI=
Date:   Wed, 3 Mar 2021 08:35:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.12-rc2
Message-ID: <YD88RHuFQzC1dfs2@kroah.com>
References: <20210302205405.GA648@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302205405.GA648@CORE.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:54:05PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> This pull request contains some fixes of the habanalabs driver for
> 5.12-rc2.
> Nothing too scary, more details are in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:
> 
>   Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-03-02
> 
> for you to fetch changes up to bbcbfc85556ed9b2a15955eb6f9b5b732e6b1795:
> 
>   habanalabs: fix debugfs address translation (2021-03-02 15:07:09 +0200)
> 
> ----------------------------------------------------------------
> This tag contains the following fixes for 5.12-rc2:
> 
> - Call put_pid() when the user releases the control device.
> - Disable file operations after a PCI device is removed.
> - Fix address translation when displaying the memory mappings
>   through our debugFS.
> - Remove unused dentry pointer for debugFS files.

You applied this patch, but did not sign off on it, which results in the
following errors when pulling your branch:

Commit 9a7e471f376d ("drivers: habanalabs: remove unused dentry pointer for debugfs files")
	committer Signed-off-by missing
	author email:    gregkh@linuxfoundation.org
	committer email: ogabbay@kernel.org
	Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h
