Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597A43D1E49
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhGVFvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhGVFvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:51:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A6F7610F7;
        Thu, 22 Jul 2021 06:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626935540;
        bh=xxnnpD2PwXkyo2e+LojgObBUsyfdTvMxMPvA3nCfGJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVNh8VGVtrtCuVqKc+T+PYCawCVYe1M0oZffKdpis8KRx55EknwttMCGR5kRElv2z
         dhrll7fePpBRTe8sBZIVkSjRxINnEZqqcvkeAWq3vcRIaAny5KLHqCn7ZnNdm2iOdE
         r1SdbftAN9RUIKQ7QzelDiUbi9HdgxBq5kQ+OPho=
Date:   Thu, 22 Jul 2021 08:32:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <19210240158@fudan.edu.cn>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: Re: [PATCH] kernfs: Convert from atomic_t to refcount_t on
 kernfs_node->count
Message-ID: <YPkQ8M9CLqeBvN2W@kroah.com>
References: <60f8506d.1c69fb81.d8d4d.3bceSMTPIN_ADDED_BROKEN@mx.google.com>
 <YPkHAX1YdmxZtW49@kroah.com>
 <350c2c44.5a22.17acce3c8f4.Coremail.19210240158@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <350c2c44.5a22.17acce3c8f4.Coremail.19210240158@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 02:25:18PM +0800, Xiyu Yang wrote:
> Hi Greg,
> 
> I'm not sure why failed... I send it again now.
> 
> I consider it as a reference count due to its related operations and
> the developer's comments, such as "put a reference count on a
> kernfs_node" around the kernfs_put(). 

I'm sorry, but I have no context for this statement, what are you
referring to?

Always properly quote the email you are responding to, so we know what
is happening.  Remember, we deal with thousands of emails a week...

thanks,

greg k-h
