Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9960435F358
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350749AbhDNMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231849AbhDNMSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E2BA6105A;
        Wed, 14 Apr 2021 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618402695;
        bh=iM0+Dta8yMlWylk4cz0KlfODBJXgiJ9qnCkX9y5oV6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zY/OJh+TYGTHOs5juL0tx0Q7ekvRf4Ahdaj5nu4iur2apSW4grbN3ph6GoTkrQ4M+
         83/M5gIDW7M9q+cFb/rwVQm8kj2d8Y39aD4qa03w/7q+hGojA1uGCVxwnW53bpYw7y
         M9jJA2Xu8U+ejE2Y77JrtEWxkBMNpx0FNB9t5+b4=
Date:   Wed, 14 Apr 2021 14:18:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <YHbdhT8z11rd6okI@kroah.com>
References: <20210414115243.32716-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414115243.32716-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 01:52:43PM +0200, Fabio M. De Francesco wrote:
> Removed the led_blink_hdl() function (declaration and definition).
> Declared dummy_function() in include/rtw_mlme_ext.h and defined it in
> core/rtw_cmd.c. Changed the second parameter of GEN_MLME_EXT_HANDLER
> macro to make use of dummy_function().

No no no.

If you want to remove is function declaration and use, then do it
properly.

The code is crazy, I agree, but it should not be difficult to just
remove this correctly instead of papering over this mess.

Also note that no one actually calls this function if you look at the
logic here.  It might take some good knowledge of C to unwind this crud,
but once done, you should be able to "prove" it's not called and how to
remove it correctly.

And no, I'm not going to say how to do it, that's an exercise best left
for the reader.  But I will hint that this was done in the past, in
2014, in another driver in the tree with a codebase much like this one,
so it shouldn't be hard to find an example of it.  Only took me a few
minutes...

good luck!

greg k-h
