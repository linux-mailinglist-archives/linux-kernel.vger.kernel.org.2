Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318E243CFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbhJ0Rnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231531AbhJ0Rng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:43:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16F6960EFF;
        Wed, 27 Oct 2021 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635356470;
        bh=7VSID2oeTV1/xGVowVgnfToa4LEkRNWlaK/p6kpz9/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXrrdH6KHgFqr5Klt6qMbV+SCQP6lZ9gLwlm5vaM1l1guExDw2cjml/uPMJFPaKDD
         y+7RffOCaOYi7hvBE1cKDM/TsRDbFMhB12ff87Aw3f2Etnlxac1HSxvw6m5PLmh/11
         gHnhBb8ercyB23LLtw29Xz83mQOBiCY6y8dYF6C4=
Date:   Wed, 27 Oct 2021 19:41:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL v2] Coresight changes for v5.16
Message-ID: <YXmPNNig91Pay9U5@kroah.com>
References: <20211026195545.3951306-1-mathieu.poirier@linaro.org>
 <YXj2trHe8XA0QtFO@kroah.com>
 <CANLsYkwcUbV-kX3yZt6K0rK9PBUpkW=fp2_Y5Bd3+fCgxZr4EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwcUbV-kX3yZt6K0rK9PBUpkW=fp2_Y5Bd3+fCgxZr4EA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:32:43AM -0600, Mathieu Poirier wrote:
> On Wed, 27 Oct 2021 at 00:50, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Oct 26, 2021 at 01:55:45PM -0600, Mathieu Poirier wrote:
> > > The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
> > >
> > >   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.16
> >
> > Better but I get the following errors when my scripts try to merge them.
> > Note, the linux-next scripts will give you the same complaint, so this
> > isn't a new thing:
> 
> Can you point me to the linux-next script you are referring to above?
> Usually when that happens I get an email but this time I didn't get
> anything.

Is this tree/branch in linux-next now?  If so, you should have gotten an
email.

My scripts were sent to the workflow mailing list a year or so ago, I
can dig them up if needed.

thanks,

greg k-h
