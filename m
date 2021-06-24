Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537D23B314C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhFXO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFXO3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:29:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA9516024A;
        Thu, 24 Jun 2021 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624544840;
        bh=/W7GGtFuHznE/k7ogBLCPm6Nks6yk9xFc5/56IqkYuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ew3Cd6sRv4GTber3Mwcl4FY/kn++KMhFdnWMjvGeRwF3Zg/e62KkqObHKHYxz3jxR
         GbQtjl67gpqsf4MDjWDK/iy8SjQ2a5p/14jNBAbei8L+eUEZtro02p2WdUl9va9u88
         +IEzNp43tUARi8d4yXhRqj/Wx47IAm638mAEwNQ0=
Date:   Thu, 24 Jun 2021 16:27:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v7 0/8] Move Hisilicon 6421v600 SPMI and USB drivers out
 of staging
Message-ID: <YNSWRlCjJ6WlrM/6@kroah.com>
References: <cover.1624542940.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1624542940.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:01:29PM +0200, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> Those are the remaining patches that are needed for the USB to work
> with Hikey970.
> 
> This series address the comments made on v5. Sorry for taking so long to
> return back on this. Got sidetracked by other unrelated stuff.

I took the first 2 patches in here.

thanks,

greg k-h
