Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D286359568
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhDIGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhDIGZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:25:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C408061008;
        Fri,  9 Apr 2021 06:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617949538;
        bh=aMZ/RRpwkxlu+X3FtH/ITw5IzYuoujr6SmEmX8XSFPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wKEREXJkzqhNzKVAtGcX6dg/5/ZNidgfeBLByJwLXa/3RqgM/wHkcO+skf71o9mVS
         CVoqylaBrJcnfxLnBbILDgomgrE7oA4YRBetc0V3x6H3ynOFNycKErKMTMzp02nFvW
         wqAeUx7VVSXFHRt7x7elHPdBQWhOxqMx9U1Fvnvg=
Date:   Fri, 9 Apr 2021 08:25:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hang Lu <hangl@codeaurora.org>
Cc:     tkjos@google.com, tkjos@android.com, maco@android.com,
        arve@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] binder: tell userspace to dump current backtrace when
 detected oneway spamming
Message-ID: <YG/zX7ofY3RpkqUg@kroah.com>
References: <CAHRSSEyTDZTWMrWe+H4awCOBrf+AZd-TEqi3gZONZxYYQSWB5Q@mail.gmail.com>
 <1617939657-14044-1-git-send-email-hangl@codeaurora.org>
 <YG/veiWKkaJtEZkq@kroah.com>
 <17cf5552-8fec-3aca-a671-f5fbc9344c95@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17cf5552-8fec-3aca-a671-f5fbc9344c95@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:21:58PM +0800, Hang Lu wrote:
> On 4/9/2021 2:08 PM, Greg KH wrote:
> > On Fri, Apr 09, 2021 at 11:40:57AM +0800, Hang Lu wrote:
> >> When async binder buffer got exhausted, some normal oneway transactions
> >> will also be discarded and may cause system or application failures. By
> >> that time, the binder debug information we dump may not be relevant to
> >> the root cause. And this issue is difficult to debug if without the
> >> backtrace of the thread sending spam.
> >>
> >> This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when oneway
> >> spamming is detected, request to dump current backtrace. Oneway spamming
> >> will be reported only once when exceeding the threshold (target process
> >> dips below 80% of its oneway space, and current process is responsible for
> >> either more than 50 transactions, or more than 50% of the oneway space).
> >> And the detection will restart when the async buffer has returned to a
> >> healthy state.
> >>
> >> Signed-off-by: Hang Lu <hangl@codeaurora.org>
> >> ---
> >> v4: add missing BR_FROZEN_REPLY in binder_return_strings and change the size of binder_stats.br array
> > 
> > Should the BR_FROZEN_REPLY string be a separate patch as it's a fix for
> > the "binder frozen feature", not this new feature, right?  Or does this
> > patch require that change and the frozen patch did not?
> 
> Yes, BR_FROZEN_REPLY string is a fix and seems should to be separated from this new feature. But I'm still wondering how to submit these 2 separate patches as they edit the same place(maybe merge conflict). Do you know which of the following two commit methods is more suitable? Thanks!
> 
> 1. char-misc-next HEAD --> BR_FROZEN_REPLY fix patch --> new feature patch

Yes, do it this way, a 2 patch series is fine.

thanks,

greg k-h
