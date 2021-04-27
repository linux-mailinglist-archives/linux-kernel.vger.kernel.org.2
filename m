Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9237C36C69E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhD0NCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235446AbhD0NCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:02:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B514761078;
        Tue, 27 Apr 2021 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619528485;
        bh=sKiJVqJdDA8khrlrCBEHKnnMwkutc3VNyQ1vNzwDdSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNe3sAV9hdM39rMM/W0pQPRGdh3/atDmX9ypzq//sam2NxwKvowIdcyL3aUEernRF
         dayvl3hHc+SnyWymBg3cdv2mfYwTZGu9lssI8Axzngq4imkEnf6bia5quvh9blW1Cv
         y7W4EsE4BNXver9BlIbmZrpTakpDi/pO/pliy/LA=
Date:   Tue, 27 Apr 2021 15:01:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        wang6495@umn.edu
Subject: Re: [PATCH 167/190] Revert "gdrom: fix a memory leak bug"
Message-ID: <YIgLIscB1I8MxkWP@kroah.com>
References: <20210421130105.1226686-168-gregkh@linuxfoundation.org>
 <23ffd3c5-0095-6a95-8c30-2b6f67377ce7@axentia.se>
 <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14bdfbee-b8b9-d8ac-de34-b6d852d1485b@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 08:20:30AM -0600, Jens Axboe wrote:
> On 4/22/21 3:29 PM, Peter Rosin wrote:
> >> This reverts commit 093c48213ee37c3c3ff1cf5ac1aa2a9d8bc66017.
> > 
> > The reverted patch looks fishy.
> > 
> > gc.cd_info is kzalloc:ed on probe. In case probe fails after this allocation, the
> > memory is kfree:d but the variable is NOT zeroed out.
> > 
> > AFAICT, the above leads to a double-free on exit by the added line.
> > 
> > I believe gd.cd_info should be kfree:d on remove instead.
> > 
> > However, might not gc.toc also be kfree:d twice for similar reasons?
> > 
> > I could easily be mistaken.
> 
> >From taking a quick look the other day, that's my conclusion too. I
> don't think the patch is correct, but I don't think the surrounding code
> is correct right now either.

Thanks for the review from both of you, I'll keep this commit in the
tree.

greg k-h
