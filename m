Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A762735952A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhDIGJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhDIGJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B8C76113A;
        Fri,  9 Apr 2021 06:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617948541;
        bh=n/aP/TcQ/267gm09eQYkvPethiroHue0xczvg+6G3Zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rO5ecE1g04K9xDFy5L/LGdHimUdczHwrglWJODNv17qHP7X9suZDf3/uKV1/+gmW5
         xib9EmFsKorhPLw3Sxml7u2t5pHz1l2o8bciR3b+iFXHW6BQV6vH3IchB9a0RUj1UA
         azcAJI5rVqaIouGFZhqEJaWqWg2G26Yx4rBR1LYo=
Date:   Fri, 9 Apr 2021 08:08:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hang Lu <hangl@codeaurora.org>
Cc:     tkjos@google.com, tkjos@android.com, maco@android.com,
        arve@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] binder: tell userspace to dump current backtrace when
 detected oneway spamming
Message-ID: <YG/veiWKkaJtEZkq@kroah.com>
References: <CAHRSSEyTDZTWMrWe+H4awCOBrf+AZd-TEqi3gZONZxYYQSWB5Q@mail.gmail.com>
 <1617939657-14044-1-git-send-email-hangl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617939657-14044-1-git-send-email-hangl@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:40:57AM +0800, Hang Lu wrote:
> When async binder buffer got exhausted, some normal oneway transactions
> will also be discarded and may cause system or application failures. By
> that time, the binder debug information we dump may not be relevant to
> the root cause. And this issue is difficult to debug if without the
> backtrace of the thread sending spam.
> 
> This change will send BR_ONEWAY_SPAM_SUSPECT to userspace when oneway
> spamming is detected, request to dump current backtrace. Oneway spamming
> will be reported only once when exceeding the threshold (target process
> dips below 80% of its oneway space, and current process is responsible for
> either more than 50 transactions, or more than 50% of the oneway space).
> And the detection will restart when the async buffer has returned to a
> healthy state.
> 
> Signed-off-by: Hang Lu <hangl@codeaurora.org>
> ---
> v4: add missing BR_FROZEN_REPLY in binder_return_strings and change the size of binder_stats.br array

Should the BR_FROZEN_REPLY string be a separate patch as it's a fix for
the "binder frozen feature", not this new feature, right?  Or does this
patch require that change and the frozen patch did not?

thanks,

greg k-h
