Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D639345868
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCWHPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCWHPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:15:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4519D619B7;
        Tue, 23 Mar 2021 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616483718;
        bh=uAPbzk95kSq16AeDhtxSa1NumC0IZEQq+Bq+BdyOWyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lq78N9EtTz83y9Ml5YmKo0/RFY3MaMXUVWiwCwzCnh4Kbqu7y2QCysdyO7FeQ1jGF
         XvB3Wdd0FkTlTxYaTfB8+SACnnGuxW+MQlDQd+ptvZG9NSuPhywa2FntK6yyf8oWLN
         hGUtDQtjy7NONqeYzxm4RkAjYc6T00QOXpmp7uO0=
Date:   Tue, 23 Mar 2021 08:14:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] w1: ds2438: fixed a coding style issues
Message-ID: <YFmVa8PGbu8ehXRg@kroah.com>
References: <20210323024209.nhf7dgrdooca363g@LuizSampaio-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323024209.nhf7dgrdooca363g@LuizSampaio-PC.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:42:09PM -0300, Luiz Sampaio wrote:
> Fixed coding style issues.
> 
> Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> ---
>  drivers/w1/slaves/w1_ds2438.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
