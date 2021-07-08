Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B73BFA1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGHMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhGHMbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:31:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66C0661450;
        Thu,  8 Jul 2021 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625747303;
        bh=rjj/1ngXwpg9hzNLAgSxlfUR07I5G2q+ZBm7VtzPLF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0nzAjLeUCzPNfNafKaSb9o5GjwGih3LvftztkTQQE8m6K7qDoMF2kTv9YdrB8/jV
         +ovaYl8iv5tcBILeNBxyX58rX0HKZrw/W7WmUhkgE9dzcRMhvaEAkKnmku1aMoReNp
         Fju83XD2+krqU2nZqCSow6wNm290bOmMYSxCOTfw=
Date:   Thu, 8 Jul 2021 14:28:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wenchao Hao <haowenchao@huawei.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linfeilong@huawei.com,
        Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [PATCH] driver core: Make probe_type of driver accessible via
 sysfs
Message-ID: <YObvYiPxQC7lk3NT@kroah.com>
References: <20210708122010.262510-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708122010.262510-1-haowenchao@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 08:20:10PM +0800, Wenchao Hao wrote:
> Like drivers_autoprobe of bus, make probe_type of driver
> accessible via sysfs, so we can get and set a driver's probe_type
> happily.

Why is this needed?  Who will use it?  And where is the
Documentation/ABI/ file update for this new sysfs file which is required
for all sysfs files?

thanks,

greg k-h
