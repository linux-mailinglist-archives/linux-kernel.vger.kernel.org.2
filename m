Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2A31EF80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhBRTPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhBRRym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:54:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E7364E2E;
        Thu, 18 Feb 2021 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613670839;
        bh=1Mckai72+Ezeyz93253E8fXqlylV55QI3DAGPILrLMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsiKVEXuQNa9/iKvBCU0cg82KvNz2O8DsIEUHXvdWZg5Ii/1g4iBxFOFYZiWxZksz
         j9cX884hxHbL2q2vpo4tm5WIDtc9tAB+aitMfwx6mTuvcQdNefqrLSzptJZIHvoHp8
         +/4w7K1E5X8BAuEsRU8uq0Q+vwf3Tl8qKRCtmh2E=
Date:   Thu, 18 Feb 2021 18:53:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC6ptKgsMh20tmu6@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
> As a company, we are most likely shooting ourselves in the foot by not
> having a point of coordination with the Linux Foundation and key people
> like you, Greg and other participants in the stable kernel.

What does the LF have to do with this?

We are here, on the mailing lists, working with everyone.  Just test the
-rc releases we make and let us know if they work or not for you, it's
not a lot of "coordination" needed at all.

Otherwise, if no one is saying that they are going to need these for 6
years and are willing to use it in their project (i.e. and test it),
there's no need for us to maintain it for that long, right?

thanks,

greg k-h
