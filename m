Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57EA3F85CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbhHZKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234296AbhHZKt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:49:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A23B6108E;
        Thu, 26 Aug 2021 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629974921;
        bh=yxtJgotS++D52Z3Lag3uqPEOetyeM7aOaKowbkza2G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sE2n5HQyaQ/RQe0xEGBhZLKMvz06vA1j0eq+d0kWsv3EXfJjVbCVl68BF/vA0X6Nm
         TzhcSafr8w9Nu4NFYr5n72BAS2VoKXBJRso9skDpU+c2MQPZe9EgsRGqJIOkh7xAS1
         olY4jd6cprGTJguwVb6/VaJfcqdngiUUjOUTV+q0=
Date:   Thu, 26 Aug 2021 12:48:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 1/2] staging: r8188eu: Use usb_control_msg_recv/send()
 in usbctrl_vendorreq()
Message-ID: <YSdxhfNjxOcJwxFg@kroah.com>
References: <20210825035311.8910-1-fmdefrancesco@gmail.com>
 <20210825035311.8910-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825035311.8910-2-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 05:53:10AM +0200, Fabio M. De Francesco wrote:
> Replace usb_control_msg() with the new usb_control_msg_recv() and
> usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> Remove no more needed variables. Move out of an if-else block
> some code that it is no more dependent on status < 0. Remove
> redundant code depending on status > 0 or status == len.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v2->v3: Restore the test for success of usb_control_message_recv/send
> that was inadvertently removed. Issue reported by Pavel Skripkin.
> 
> v1->v2: According to suggestions by Christophe JAILLET 
> <christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
> to the new API. According to suggestions by Pavel Skripkin 
> <paskripkin@gmail.com>, remove an extra if-else that is no more needed, 
> since status can be 0 and < 0 and there is no 3rd state, like it was before.
> Many thanks to them and also to Phillip Potter <phil@philpotter.co.uk>
> who kindly offered his time for the purpose of testing v1.
> 
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
>  1 file changed, 17 insertions(+), 28 deletions(-)

This doesn't apply to my tree at all.  Please rebase and resend.

But first, are you sure you want to use these new functions here?  This
is a "common" function that is called from different places for
different things.  How about unwinding the callers of this function
first, to see if they really need all of the complexity in this function
at all, and if not, then call the real USB function in those locations
instead.

It's only used in this single file, so it shouldn't be that hard to
unwind (after seeing where those calls are made from, and if they even
need to be present at all.  Hint, look at the mess of where _write16 and
friends are set to realize that structure is not needed at all, right?
It's a long chain, the more you pull on it, the messier you realize it
is...)

thanks,

greg k-h
