Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036233B3E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFYIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhFYIJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:09:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 650EA61425;
        Fri, 25 Jun 2021 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624608448;
        bh=3U9dOh8ubJIZg7LPE4ibu71lztZPpneG4VY8XUeQMJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NecY4QLc6B1Iy1Wn0nDs+hgKCfA11BmN3lJ9UndAuFph4V3CxfXgv9bNevvKbpEhL
         QZnZm+rwc2daJFC6U+4YlxDUBufuRCTZrFc3D2uKjcT6s7O9TLGP4upUN3PqsmiEB4
         JINWJt7rhwJymccYInvr130+hYknFGYWh7OT+CPw=
Date:   Fri, 25 Jun 2021 10:07:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 00/12] Move Hisilicon 6421v600 SPMI and USB drivers
 out of staging
Message-ID: <YNWOvn67Gl2v3Cco@kroah.com>
References: <cover.1624606660.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624606660.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:45:52AM +0200, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> Thanks for merging patches 1 and 2 from the v7 series!
> 
> Those are the remaining patches that are needed for the USB to work
> with Hikey970.
> 
> I guess patches 1 and 2 on this series are also OK, as they were acked
> by the PHY and SPMI maintainers.
> 
> As suggested on your last review, I broke the MFD staging patches 
> into one logical change per patch.
> 
> Except for the split, the only change from v7 was at the copyright: 
> I'm using 20xx-2021 instead of 20xx- to indicate that the copyrights
> extend to the present. I also changed the HiSilicon name to better
> reflect the name of the company.

The copyright change is still not correct.  I recommend you take a look
at this:
	https://www.linuxfoundation.org/blog/copyright-notices-in-open-source-software-projects/
and:
	https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/
	(the copyright chapter)
for specifics as to what to, and not to do with regards to copyright
notices.

I'm sure your employer also has some information about what to do with
regards to this as well.

I've taken patches 1-3, 5-9 now.

thanks,

greg k-h
