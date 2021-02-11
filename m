Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECB318D08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhBKOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232051AbhBKNw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:52:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 607B364E87;
        Thu, 11 Feb 2021 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613051534;
        bh=mx/ir5owcxGhvKP8aEP+Z9CweTjM4sRvImnbrqzIaKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qII+HWhi8xgJ5IlTlO56BXxBwssvfap7hnge/KofbknZ8sD853Wf6dt42Kh5qcB+m
         2fnvunOTGfX2pp/dTMOmkTGu2jqDCWmRgLOkmARhed8XpRn5PFpR6SlbOPocZXl/83
         5tN0jKTpT7SpM1Yd+zEHYM4941nTSYiVB0BjjGK8=
Date:   Thu, 11 Feb 2021 14:52:12 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Amey Narkhede' <ameynarkhede03@gmail.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] staging: gdm724x: Fix DMA from stack
Message-ID: <YCU2jAameAtJ28+G@kroah.com>
References: <20210211053819.34858-1-ameynarkhede03@gmail.com>
 <500e7317567548b48604ed9972062da2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500e7317567548b48604ed9972062da2@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 01:28:41PM +0000, David Laight wrote:
> > Stack allocated buffers cannot be used for DMA
> > on all architectures so allocate hci_packet buffer
> > using kmalloc.
> 
> I wonder if the usb stack ought/could support a short bounce
> buffer within the memory is already has to allocate?

No.
