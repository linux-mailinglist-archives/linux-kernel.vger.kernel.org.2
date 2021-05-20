Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CFF38B2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbhETPNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232020AbhETPNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:13:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE24600D1;
        Thu, 20 May 2021 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621523509;
        bh=eFI5rpQJhU6aKiz7M8+Q4aUTrQg2nZYVDF4zrydbhhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/B4dHHhjeBn8turYwFunjFQ9HFK+qY2IH/3HqY4hb8q9WMtZwprLoDysMYgcZUtS
         y6xZN2b0knJu6n9S9zUFRd986f66pngXR2TFF2mYYQWNy719xFTCkv2CF6EDdFhFE3
         rhzzYPLkrUs7AbwCLzko3IftEvrdeHkmWShLKk3M=
Date:   Thu, 20 May 2021 17:11:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linuxarm@openeuler.org
Subject: Re: [PATCH 0/9] tty: hvc_console: Fix some coding style issues
Message-ID: <YKZ8M8j5/bUJxLq5@kroah.com>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 02:37:04PM +0800, Xiaofei Tan wrote:
> Fix some issues reported by checkpatch.pl. All of them are
> coding style issues, no function changes.
> 
> Xiaofei Tan (9):
>   tty: hvc_console: Fix spaces required around that '='
>   tty: hvc_console: Fix "foo * bar" should be "foo *bar"
>   tty: hvc_console: Remove trailing whitespace
>   tty: hvc_console: Fix issues of code indent should use tabs
>   tty: hvc_console: Delete spaces prohibited around open parenthesis '('
>     and ')'
>   tty: hvc_console: Fix coding style issues of block comments
>   tty: hvc_console: Add a blank line after declarations
>   tty: hvc_console: Remove the repeated words 'no' and 'from'
>   tty: hvc_console: Move open brace { on the previous line
> 
>  drivers/tty/hvc/hvc_console.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)

Do you use this driver?  If so, great, I'm sure there are other "real"
issues in it that need some work.  But as Johan points out, doing
drive-by checkpatch cleanups on random files that you do not use, isn't
the best thing to do.

If you just want to do this type of work, please do so in
drivers/staging/ as it is most welcome there if you wish to get involved
in kernel work to get experience before doing "real" stuff.

thanks,
g
reg k-h
