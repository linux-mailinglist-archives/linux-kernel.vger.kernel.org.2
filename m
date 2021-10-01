Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF85241EF0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353844AbhJAODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353676AbhJAOD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:03:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B12761439;
        Fri,  1 Oct 2021 14:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633096904;
        bh=SDqkA1t6ExmdnMf7WcVRgGzkvaLQwDzGwEbjE1CRlUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROv78rcm0iEa8tNW4dqzx64rt4P6dbZWLZeoindCkhhxtt19LqbuHP9gjL2/SW2Oz
         P94gxYtpIhanHPSS2EZw8UFKtHoB0sQoYowgjlI17bk6lanwWCtyzosXgzjIQYHT9k
         53hvXeikK5a1x3pEQvft4Tf1b1tNtWyxwa4eFzEY=
Date:   Fri, 1 Oct 2021 16:01:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, linux-kernel@vger.kernel.org,
        Fei Li <fei1.li@intel.com>
Subject: Re: [PATCH v1 1/1] virt: acrn: Drop internal kernel type from ABI
Message-ID: <YVcUxXJeduv1OHrz@kroah.com>
References: <20211001135644.1884-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001135644.1884-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 04:56:44PM +0300, Andy Shevchenko wrote:
> guid_t is internal type of the kernel which is mistakenly had been exposed
> to the user space. Replace it with raw buffers.

Wait, why is it a mistake to expose it to userspace?  What does this
conflict with?  Is it a namespace issue?  Or something else?

thanks,

greg k-h
