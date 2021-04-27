Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB81936C917
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhD0QQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237503AbhD0QMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:12:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0F10613E7;
        Tue, 27 Apr 2021 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619539888;
        bh=sWfj4/YD88XWP9TQDYozP4U5HS1T7QaBgPwNmFATYlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/h88WMzn2Ywa8/GnKK3jD2ZlBO2/j1LOTfWQgTjEPBBkT4eyKI/wwEltGRpRePzC
         vCM5/OsTz8kNQZxkdocoiwlmHts4u1jeeM9lMnhOEupaiEnSRYVO9QXfHwAvnd+SDR
         fUoD5mTKkuDUCstHbVcxug8Q8se//4XkI04Qqpds=
Date:   Tue, 27 Apr 2021 18:11:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
Message-ID: <YIg3rBvkLzgHkZr2@kroah.com>
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
 <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
 <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk>
 <YIgLIscB1I8MxkWP@kroah.com>
 <5a55e8d4-e9b6-1854-51bc-afacd3ca097c@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a55e8d4-e9b6-1854-51bc-afacd3ca097c@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:03:01PM +0200, Peter Rosin wrote:
> On 2021-04-27 15:01, Greg KH wrote:
> > On Fri, Apr 23, 2021 at 08:20:30AM -0600, Jens Axboe wrote:
> >> On 4/22/21 3:29 PM, Peter Rosin wrote:
> >>>> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.
> >>>
> >>> The reverted patch looks fishy.
> >>>
> >>> gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
> >>> memory is kfree:d but the variable is NOT zeroed out.
> >>>
> >>> AFAICT, the above leads to a double-free on exit by the added line.
> >>>
> >>> I believe gd.cd_info should be kfree:d on remove instead.
> >>>
> >>> However, might not gc.toc also be kfree:d twice for similar reasons?
> >>>
> >>> I could easily be mistaken.
> >>
> >> >From taking a quick look the other day, that's my conclusion too. I
> >> don't think the patch is correct, but I don't think the surrounding code
> >> is correct right now either.
> > 
> > Thanks for the review from both of you, I'll keep this commit in the
> > tree.
> Err, which commit is "this" and what tree are you keeping it in? I
> think you mean that you are keeping the revert in your tree with
> reverts, and not that you mean that we should keep the original
> commit in Linus' tree.

That is correct, I will be keeping this revert in my tree.

> In any case, I'd think that the original memory leak is somewhat
> better than the introduced double-free and therefore the revert
> should be done.

Will do that.

thanks,

greg k-h
