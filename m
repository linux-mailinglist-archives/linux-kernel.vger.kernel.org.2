Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A33EF00E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhHQQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhHQQSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 862CA60F41;
        Tue, 17 Aug 2021 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629217090;
        bh=ToObd4N8m5x+wDCUcl4zRBsahziVAryjORiouHydmso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUQDrInwCe28eU/M/Sq9fYeXf0VvUwYghqpc/WPhXZcpEZE0HNzwyC9gv7KKrIQvK
         MZdqzFe6DUgmf4aXwecEf1wltWOOno4JA4KubWh0vjQXmdu9OeYE3427Y0dfC2A2/0
         2IlJkJ4mD7f7nBwSEAFMs6kpjpI/xnviG9EuEnEA=
Date:   Tue, 17 Aug 2021 18:18:07 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Daniel Steger <dsteger@xilinx.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: sysfs: do not remove files if group is null
Message-ID: <YRvhP3qchzjAPsdA@kroah.com>
References: <20210809204228.2987376-1-daniel.steger@xilinx.com>
 <BY5PR02MB68170E18D6B5C79BB0AC9083C1FE9@BY5PR02MB6817.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB68170E18D6B5C79BB0AC9083C1FE9@BY5PR02MB6817.namprd02.prod.outlook.com>
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

On Tue, Aug 17, 2021 at 04:13:48PM +0000, Daniel Steger wrote:
> Hi Greg, Rafael, 
> 
> Have you had a chance to review this patch?

What patch?

> 
> Thank You,
> Daniel
> 
> -----Original Message-----
> From: Daniel Steger <daniel.steger@xilinx.com> 
> Sent: Monday, August 9, 2021 1:42 PM
> To: gregkh@linuxfoundation.org; rafael@kernel.org
> Cc: linux-kernel@vger.kernel.org; Daniel Steger <dsteger@xilinx.com>
> Subject: [PATCH] fs: sysfs: do not remove files if group is null

What is the message id of this, I do not see it on my side at all.

> 
> The current implementation allows the remove_files() API to be called without checking if the grp->name is null. Ensure that the group name is valid prior to removing files.

At the least, wrap your lines at 72 columns, we can't take this as-is...

thanks,

greg k-h
