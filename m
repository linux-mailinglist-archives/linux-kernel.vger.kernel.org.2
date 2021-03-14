Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEFA33A39A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhCNIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 04:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhCNIfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 04:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5923264EBE;
        Sun, 14 Mar 2021 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615710931;
        bh=3WtodJc3soLmQ9CqzHPdNBhJrEKF+Kgty8caa746n4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLygglqo6bNd1UptwpYzp71gwsCEzci5o2/8NO0DmFclo7T0xe8ZDMzM4aRkyPzKK
         yKKUs0ySN/hwS1MKxAcNXWLH9HW1PxgFnd+AKAg/Icn6TqQUbUD1K4YvIUcLtEB8YT
         CROUH3EhtuSAwt93ViOTYIqmxiqCyIxQyS+ilHYQ=
Date:   Sun, 14 Mar 2021 09:35:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Selvakumar E <selvakumar16197@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb: fixed precedence issue
Message-ID: <YE3KzgnHyxdpMGZv@kroah.com>
References: <20210313173247.8676-1-selvakumar16197@gmail.com>
 <YE28Uzs6ZhHopk8J@kroah.com>
 <CAD=cR88u5o58NaL=z6NtMc2=N-hesKkFC8tkP3PJ4fu1Oaf-ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=cR88u5o58NaL=z6NtMc2=N-hesKkFC8tkP3PJ4fu1Oaf-ZQ@mail.gmail.com>
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

On Sun, Mar 14, 2021 at 01:34:23PM +0530, Selvakumar E wrote:
> Hi Greg
>             I changed the line because of the checkpatch.pl warned for
> precedence issue.

But I fail to see how this:

> > > +#define CVMX_USBCXREG1((reg), bid) \

Does anything here at all.

What am I missing?

thanks,

greg k-h
