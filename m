Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0019319C77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBLKQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhBLKP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:15:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC5D764E65;
        Fri, 12 Feb 2021 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613124917;
        bh=vb31PA1ua/ogWyOOsf013o489IVUxd0Oj1dcAEuyJkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sd8wKOK+K9h1/Nrjwc7F3GmA8zMbK6bMJcEPhUd0Q3tW7xTMD6S+vuU5vRkpNihhY
         /4gFQsEMNwqh2DR16rPbcTPg0qeqHwnch8tO2PtPGjLvAI5zpmwkuCID7juTGRqnRz
         56F8Ghv5KbyN4VnhmigK8grWvgF76lUY99Rjq4bs=
Date:   Fri, 12 Feb 2021 11:15:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH v2 3/3] misc/pvpanic: add license
Message-ID: <YCZVMk/moL8x+Vir@kroah.com>
References: <1613121426-15585-1-git-send-email-mihai.carabas@oracle.com>
 <1613121426-15585-4-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613121426-15585-4-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 11:17:06AM +0200, Mihai Carabas wrote:
> Add license to the newly created files in adding support for pvpanic PCI device
> driver.
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/pvpanic/Kconfig   | 7 +++++++
>  drivers/misc/pvpanic/Makefile  | 7 +++++++
>  drivers/misc/pvpanic/pci.c     | 7 +++++++
>  drivers/misc/pvpanic/pvpanic.h | 7 +++++++

Do not add this after-the-fact, add them when you create these files.

thanks,

greg k-h
