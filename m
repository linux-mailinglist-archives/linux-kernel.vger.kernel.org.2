Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3569230DEA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhBCPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234590AbhBCPor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:44:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46D7564E0A;
        Wed,  3 Feb 2021 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612367046;
        bh=Wx3uhEVr4dAabl5Vw/AVDqFVSRVLFPvfx+P67v5LI3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLdzUFB8dOPaD1ydu1lZfsTR126sjcY83eFBXPA1QH7gJOpwedsAOQKjtZF1d5Qrj
         qDFYiB8gnQJGD5dp9X0Osjl9eo/Nj2+9ycdFIrNo9sJEx/gMkvbBgFwtAOdVrUgzVE
         0zFh+yvzHZFCur+9QAQfN6wznkvZ5yOxR1MVFHS4=
Date:   Wed, 3 Feb 2021 16:44:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com, bobo.shaobowang@huawei.com
Subject: Re: [PATCH 1/2] misc/pvpanic: split-up generic and platform
 dependent code
Message-ID: <YBrExCSbFu/SCcpW@kroah.com>
References: <1612363439-26656-1-git-send-email-mihai.carabas@oracle.com>
 <1612363439-26656-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612363439-26656-2-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:43:58PM +0200, Mihai Carabas wrote:
> Split-up generic and platform dependent code in order to introduce pvpanic pci
> device driver later.

What is "later"?

And did you just create a new driver/module in this change?  Why?
And how did you test?  This new module looks to probably taint the
kernel, correct?

How about doing this at the very least, 2 patches, one to move to the
new directory, and the second to split into two modules.  And of course,
please TEST THIS!

thanks,

greg k-h
