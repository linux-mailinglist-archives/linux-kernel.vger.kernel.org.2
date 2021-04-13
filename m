Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9280535DDDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbhDMLhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 07:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238148AbhDMLhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BE6161244;
        Tue, 13 Apr 2021 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618313831;
        bh=HPs/cyVTjjgPMGZKDl4psfL7z6Thd81yUjkA+JoeUAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwlgYfesHJz2OcRmhIhj2KOtkf0Ym+DTZZnAM9yp0y7312niBbhbil3fdiwQMB5IY
         w0Kxt23pa7YHuTMobnL93UzuRAWlzAmKw5vFGiEmblEVvy2QCtWyjah33C4PcUvpSw
         x3Bdgj44qp34ADUSfU6c3w02Vu/iO97QahSPf/HM=
Date:   Tue, 13 Apr 2021 13:37:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v5 0/3] staging: rtl8192e: Cleanup patchset for style
 issues in rtl819x_HTProc.c
Message-ID: <YHWCZALi323oaGA5@kroah.com>
References: <cover.1618283232.git.mitaliborkar810@gmail.com>
 <YHVN0JRWqNDJYF3T@kroah.com>
 <YHV2LyXrJjVnMsyT@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHV2LyXrJjVnMsyT@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 04:15:03PM +0530, Mitali Borkar wrote:
> On Tue, Apr 13, 2021 at 09:52:48AM +0200, Greg KH wrote:
> > On Tue, Apr 13, 2021 at 08:55:03AM +0530, Mitali Borkar wrote:
> > > Changes from v4:-
> > > [PATCH v4 1/3]:- No changes.
> > > [PATCH v4 2/3]:- No changes.
> > > [PATCH V4 3/3]:- Removed casts and parentheses.
> > 
> > This series does not apply cleanly, please rebase and resend.
> >
> Resend as v6? Does not apply cleanly as in? Were mails not threaded
> properly?

Yes, send a v6, after rebasing on my tree and the staging-testing branch
and resend.

They were threaded properly, it looks like others have made changes to
the same files that you were, which is quite common when doing small
cleanup changes like this.

thanks,

greg k-h
