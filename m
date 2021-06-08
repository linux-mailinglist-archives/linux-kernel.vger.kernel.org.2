Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B227139F786
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhFHNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhFHNTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:19:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC766100A;
        Tue,  8 Jun 2021 13:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623158271;
        bh=WzqOwX6T0PPSqN/wyATKV+t/eFQS0HeYKDWBkVcTJ2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=II00HFq28BhsWrL3vkBIBMA13i0nWKMfhytyCtJvNLF3N9KbzT96Dch8XvqejjGd6
         ywB3sqrUhkr6LzHx/ZJe6GXUYsIvpmZyvfw6KkTpDTQHJsYYjxNdvi1EFc5S3cqGm3
         1COzH1BW0Srci54ptxW9j6ql8TYPwPmud3s/6j/E=
Date:   Tue, 8 Jun 2021 15:17:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Ricky WU <ricky_wu@realtek.com>, arnd@arndb.de,
        Bjorn Helgaas <bhelgaas@google.com>, ulf.hansson@linaro.org,
        rui_feng@realsil.com.cn, vaibhavgupta40@gmail.com,
        yang.lee@linux.alibaba.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] misc: rtsx: separate aspm mode into MODE_REG and
 MODE_CFG
Message-ID: <YL9t/ZfRsIMSpXfm@kroah.com>
References: <20210607101634.4948-1-ricky_wu@realtek.com>
 <CABTNMG1yoYPgs0gr1bHsrxCmpNM8fUB+3S5E+HS7c9pPGiFxrQ@mail.gmail.com>
 <YL8xYRwKfA5EtSqT@kroah.com>
 <CABTNMG2HZD52DmQ8iqC1jqLf6v4QpqCyxOXgjMjzD7rySgGa7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG2HZD52DmQ8iqC1jqLf6v4QpqCyxOXgjMjzD7rySgGa7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:16:14PM +0800, Chris Chiu wrote:
> On Tue, Jun 8, 2021 at 4:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 08, 2021 at 11:43:03AM +0800, Chris Chiu wrote:
> > > On Mon, Jun 7, 2021 at 6:16 PM <ricky_wu@realtek.com> wrote:
> > > >
> > > > From: Ricky Wu <ricky_wu@realtek.com>
> > > >
> > > > aspm (Active State Power Management)
> > > > rtsx_comm_set_aspm: this function is for driver to make sure
> > > > not enter power saving when processing of init and card_detcct
> > > > ASPM_MODE_CFG: 8411 5209 5227 5229 5249 5250
> > > > Change back to use original way to control aspm
> > > > ASPM_MODE_REG: 5227A 524A 5250A 5260 5261 5228
> > > > Keep the new way to control aspm
> > > >
> > > > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > > > ---
> > > Reported-by: Chris Chiu <chris.chiu@canonical.com>
> >
> > Can you test this to verify it works?
> >
> > thanks,
> >
> > greg k-h
> 
> It's verified and confirmed by the user at comment #17 of
> https://bugs.launchpad.net/bugs/1929444.

That's not useful to put in a changelog text.  Please respond with a
real tag that I can use.

thanks,

greg k-h
