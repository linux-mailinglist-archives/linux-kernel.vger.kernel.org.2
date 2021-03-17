Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0333EDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCQKEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhCQKEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:04:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E35664EC4;
        Wed, 17 Mar 2021 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615975452;
        bh=1XL+32mEOdTpqfl52nzTXb2/wrMBJ6bVUmnvUwzo7g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jMh2QclmxyX43yIip9c+d9btxRNJ04bjjgjGsGeCXk6PXkVR0GHP83GB4C1eLjrO
         A561ivPUAmRVtTHlD3eIGHpzFEl1VQGTphoSp0/U3d80TMP0Ehkrr/CXCHc59nGzy8
         lmRy9xbKjTNWYXOLoxZHHqDbHmdbtklEKW5ESsdU=
Date:   Wed, 17 Mar 2021 11:04:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, lkft-triage@lists.linaro.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Yan <yanaijie@huawei.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: BUG: KFENCE: memory corruption in usb_get_device_descriptor
Message-ID: <YFHUGG6AWGt/C8C+@kroah.com>
References: <CA+G9fYsKBLOvvxOfB6AAzjarsABQiEUhGd4JB3FDq3q1OrFmOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsKBLOvvxOfB6AAzjarsABQiEUhGd4JB3FDq3q1OrFmOw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:28:40PM +0530, Naresh Kamboju wrote:
> While booting Linux mainline master 5.12.0-rc2 and 5.12.0-rc3 on arm64
> Hikey device the following KFENCE bug was found.
> 
> Recently, we have enabled CONFIG_KFENCE=y and started seeing this crash.
> kernel BUG log:

What USB traffic are you having here?

And has this ever not triggered?

thanks,

greg k-h
