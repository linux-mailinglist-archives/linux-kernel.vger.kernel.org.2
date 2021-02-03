Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033FD30DD59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhBCO4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhBCO4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:56:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5288064E31;
        Wed,  3 Feb 2021 14:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612364151;
        bh=/YQHXdK30RtJnKSHxMPzXp6Zz8Ewq5VJj2HSrkbsMwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVlSEw1ZhU5KyNb3vow2AD2PXnPAPf589crMMC9AHLH2M8LatlHzB5ODN/c2tReoV
         JWd3sefo58icw+J4OP7DdQNvz5Vi5EBn3PsoI4bU2H02j07Xd254gqJkEvik987dij
         khzV9sezDoH4RDc7ilETWsz+ThDRrB56Lj4D1lJI=
Date:   Wed, 3 Feb 2021 15:55:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: Re: [PATCH v3] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
Message-ID: <YBq5dCWRxOeQxmVf@kroah.com>
References: <20210131233049.5500-1-scott.branden@broadcom.com>
 <YBexqH9KZEMs2fq0@kroah.com>
 <30098c21-f0aa-55f3-8e1f-c7bb8ae8be0e@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30098c21-f0aa-55f3-8e1f-c7bb8ae8be0e@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:13:55AM -0800, Scott Branden wrote:
> Hi Greg,,
> 
> I need a few clarifications before sending (hopefully) final revisions to the patch.
> 
> On 2021-01-31 11:45 p.m., Greg Kroah-Hartman wrote:
> > On Sun, Jan 31, 2021 at 03:30:49PM -0800, Scott Branden wrote:
> >> Correct compile issue if CONFIG_TTY is not set by
> >> only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
> >>
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> >>
> >> ---
> >> Changes since v2:
> >> - add CONFIG_BCM_VK_TTY
> >> - add function and stub for bcm_vk_tty_set_irq_enabled
> >> Changes since v1:
> >> - add function stubs rather than compiling out code
> >> ---
> >>  drivers/misc/bcm-vk/Kconfig      | 16 ++++++++++++
> >>  drivers/misc/bcm-vk/Makefile     |  4 +--
> >>  drivers/misc/bcm-vk/bcm_vk.h     | 42 +++++++++++++++++++++++++++++---
> >>  drivers/misc/bcm-vk/bcm_vk_dev.c |  5 ++--
> >>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 +++++
> >>  5 files changed, 65 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
> >> index 052f6f28b540..16ce98c964b8 100644
> >> --- a/drivers/misc/bcm-vk/Kconfig
> >> +++ b/drivers/misc/bcm-vk/Kconfig
> >> @@ -15,3 +15,19 @@ config BCM_VK
> >>  	  accelerators via /dev/bcm-vk.N devices.
> >>  
> >>  	  If unsure, say N.
> >> +
> >> +if BCM_VK
> > No need for this, just put it on the depends line, right?
> If you prefer I can but it on the depends on line.

If you do, it will help in that the default value might be inherited
from there.  I think, maybe, can't remember, try it out!

> But, I actually prefer the if syntax in this case as it more clearly shows
> BCM_VK_TTY is a suboption of BCM_VK.
> 
> Please let me know which method is "right"?

Either is fine, depends seems like the cleaner thing.


> >> +
> >> +config BCM_VK_TTY
> >> +	bool "Enable ttyVK"
> > Better config help text to explain what this is?
> I'll change it to the following?
> 
> "Enable tty's on VK devices"

"Enable tty ports on a Broadcom VK Accelerator device" is better, right?

> >> +	depends on TTY
> >> +	default y
> > Default y is only there if your system can not boot without it, please
> > remove it.
> I can remove if really needed but I'd like to learn more about such convention.
> Is there a document I can learn from describing such?

Again, if your machine can not boot without it, it should be 'y',
otherwise the default is n and don't list it.

> We actually want a full featured driver by default.  Otherwise we'll end up asking people to enable this
> feature and recompile the driver to get missing features such as this.

No one does that, they all use distro kernels who will enable this on
their own.

And even if they do, if they built their own kernel with your driver,
and enabled that option, then they can enable this one, there's nothing
"special" about your tiny driver here compared to the many thousands of
other ones in the tree :)

> >> +	help
> >> +	  Select this option to enable ttyVK support to allow console
> >> +	  access to VK cards from host.
> > Again, more help text, what is a "VK"?
> VK is already described in BCM_VK.  Why would I need to add the same information again to a suboption?

Context is everything, why not be verbose so that people know what is
happening.

> Perhaps you would like "config BCM_VK" changed to "menuconfig BCM_VK"

No, that's overkill for a single sub-option, right?

thanks,

greg k-h
