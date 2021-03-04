Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525FE32CD4F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhCDHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbhCDHEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:04:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F409464E89;
        Thu,  4 Mar 2021 07:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614841450;
        bh=zcZ7ryqu2fi79peiiKc8nYlLpBjaL3LlyRxfmtN1TNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=un36DXnslJnEIXAgUPkwmMs1OmsNLVgTH/FKoxQRLzkVGhQ7MgSq4E3jS5Mt60GNg
         9baBsFk4A0v7qlvukgDxWmOVmnqWhMSHSB1nU2svHvVVLUvLJeCQzoetG0DWrcB7pv
         7P86e6RbBclTZjNCTNUsPBAZ+zJP2sR/9ya2o8v0=
Date:   Thu, 4 Mar 2021 08:04:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Wang <li.wang@windriver.com>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] vt: keyboard, fix uninitialized variables warning
Message-ID: <YECGZwEZItRNAQGh@kroah.com>
References: <2973260e-2405-5a70-f9bd-398d3d45346e@windriver.com>
 <1614827448-1594-1-git-send-email-li.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614827448-1594-1-git-send-email-li.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:10:48AM +0800, Li Wang wrote:
> drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
> drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   return ret;
>          ^~~
> drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   kfree(kbs);
>   ^~~~~~~~~~

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
