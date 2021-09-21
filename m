Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C5A413555
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhIUObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233153AbhIUObD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0130860F9E;
        Tue, 21 Sep 2021 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632234575;
        bh=+q0nyoy14NpCMbCk22ZohNdkmTGzVKRFk54BDAGZFB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSLdu4vjepDKelCtaa09WRuFRfIGN2pZ/txaQk76P59Pgn4Zin1syuBCs+NuecGGw
         RII0uRfWRCoC+RphppaN+seywlqzmIsiad8+Hrt5RP6zfQyOH648gYFlLcoHp6DP7y
         2BQJZy4paAiISaETaPgnjROxcuKiY0KUoCy8teJw=
Date:   Tue, 21 Sep 2021 16:29:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Petr Nechaev <petr.nechaev@cogentembedded.com>
Subject: Re: [PATCH v2] usb: gadget: storage: add support for media larger
 than 2T
Message-ID: <YUnsSxUERYj/oXTO@kroah.com>
References: <20210914151329.GD155245@rowland.harvard.edu>
 <20210914200917.24767-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914200917.24767-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:09:17PM +0300, Nikita Yushchenko wrote:
> This adds support for READ_CAPACITY(16), READ(16) and WRITE(16)
> commands, and fixes READ_CAPACITY command to return 0xffffffff if
> media size does not fit in 32 bits.
> 
> This makes f_mass_storage to export a 16T disk array correctly.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 87 ++++++++++++++++++--
>  1 file changed, 80 insertions(+), 7 deletions(-)
> 

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
