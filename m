Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28893334289
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhCJQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233253AbhCJQJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:09:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEF5A64EB3;
        Wed, 10 Mar 2021 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615392588;
        bh=C0BjbrFILuIdm0gH2fNV9//MEdJhoKcilycTcDKfmbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjia/KwGtGVsc5+U5PJVzo53iU86uG11+oNUqtAO+nzOwqe3eAPRQYzhU1xLUxg8n
         xcm5V2EB5hJySA1uZDTt5CnLd7f3gp2p0JTGdnjh6qIf7pUssFdZ97kVktvfev6xHV
         i/fNZ4XzxydTLWo5jsN0M4re0k+x/KsQNjMgafOo=
Date:   Wed, 10 Mar 2021 17:09:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH v4] add support for pci in the pvpanic driver
Message-ID: <YEjvStU2WyI80W+I@kroah.com>
References: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
 <d35f5afd-6067-313e-ac1f-0d1b23fcb531@oracle.com>
 <YEjvDnK4E0anCrqO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEjvDnK4E0anCrqO@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:08:46PM +0100, Greg KH wrote:
> On Sun, Feb 28, 2021 at 08:39:29PM +0200, Mihai Carabas wrote:
> > Hello,
> > 
> > Any feedback on this last series?
> 
> Other than the "this breaks the build according to the kernel test
> robot"?
> 
> I think that needs to be fixed before we can do anything here...

Ok, it didn't break the build, it added a warning, which is still not
allowed, as you know.

thanks,

greg k-h
