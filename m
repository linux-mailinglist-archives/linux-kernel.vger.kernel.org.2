Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59A53C16A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhGHP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhGHP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C656161607;
        Thu,  8 Jul 2021 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625759642;
        bh=v8x9Y1LFn397E4RLSsmhaYisK4hXaBItCKmaYE2nS+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCVWy7FRlMlhuufwP4E30YPUOr0NoJAH37e9WUCvsz/VIHruAZfBqYThUJ7Tgxo9e
         EqJsEXW+Iz4SzGWJUKae8PepgLg/lP14zPj8PBhHIJRZlwS7GG+yf5R61RWKsRw1Ax
         VEqsR5mj8UcSE9oPsLbgica2qfXt+zNk6/1i8F6A=
Date:   Thu, 8 Jul 2021 17:53:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] driver core: Make probe_type of driver accessible via
 sysfs
Message-ID: <YOcfl0DcPAy9wohy@kroah.com>
References: <20210708122010.262510-1-haowenchao@huawei.com>
 <YObvYiPxQC7lk3NT@kroah.com>
 <d2a5f7f3-f68f-9420-b7ee-43102adf514f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a5f7f3-f68f-9420-b7ee-43102adf514f@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jul 08, 2021 at 08:49:31PM +0800, Wenchao Hao wrote:
> In some scenarios, you need to know whether the probe() callback in struct
> driver which triggered by device_add() or driver_register() is called
> synchronous or not, and modify this mode according to user requirements.

Who needs to know this?  What can you modify that will change anything?
What will you do to change it that will solve a problem that just fixing
the driver would not solve instead?

And what are these magic numbers that probe_type is?  If they are
exported to userspace, shouldn't they be a string instead?

> While kernel now does not open an interface for users to query or
> modify, so I add this interface.

You need to really document this in the changelog text, and in the abi
documentation, otherwise we have no idea what this for.

thanks,

greg k-h
