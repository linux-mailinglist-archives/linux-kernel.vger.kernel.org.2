Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82334F8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhCaGXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233785AbhCaGW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:22:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B93ED619AA;
        Wed, 31 Mar 2021 06:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617171778;
        bh=bioy7mMpVRXL5zbDwj85CU2GZc5oLjGym23mmEaYQlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RR7HnAJgIhKO6uDunX6AcgNJ4CBnEUq2dDvHJ4XMXULJpuY/9iG3NhYlLeEXaYH+e
         +l/7DkJGALmV+BwXevHHtRZ/Xs/jEDqCAHgCnA0bRMrvueWWPyJrW0dvPUwDZD5dzI
         /5A+hwkdO4PAyw1vUZO4CqeX9C8qOf5Aem0NbhTc=
Date:   Wed, 31 Mar 2021 08:22:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deborah Brouwer <deborahbrouwer3563@gmail.com>
Cc:     ross.schm.dev@gmail.com, marcocesati@gmail.com,
        fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        phil@philpotter.co.uk, amarjargal16@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments
Message-ID: <YGQVP/llNYUX9egx@kroah.com>
References: <20210331053841.GA6091@djbComp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331053841.GA6091@djbComp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:38:43PM -0700, Deborah Brouwer wrote:
> Remove empty comment and fix checkpatch warnings:
> WARNING: Block comments use * on subsequent lines
> WARNING: Possible repeated word: 'very'
> 
> Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 61 +++++++++++------------
>  1 file changed, 28 insertions(+), 33 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
