Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC844334282
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhCJQI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhCJQIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:08:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A39864F4C;
        Wed, 10 Mar 2021 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615392528;
        bh=+jeM5mTF0DWL/FFvXq5PQzjSG6jE96CmIpkZ2rxyrDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/AozybfyhVfCTT6ZzdtslXkas+V4mi9DEqe49ZuDUs1nT3nMQIBN5LEmbyq4sajr
         09+56Z9bl+RljCi0vHkTOu0VpN35lRaIb49/OBJDRf8EvQGIChwIX/QU5i+60Ect3t
         MnBLZCtHfDOaV5w8U6K+EyTjQBE3obHvvC8rCmm0=
Date:   Wed, 10 Mar 2021 17:08:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, rdunlap@infradead.org,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH v4] add support for pci in the pvpanic driver
Message-ID: <YEjvDnK4E0anCrqO@kroah.com>
References: <1613245447-21495-1-git-send-email-mihai.carabas@oracle.com>
 <d35f5afd-6067-313e-ac1f-0d1b23fcb531@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35f5afd-6067-313e-ac1f-0d1b23fcb531@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 08:39:29PM +0200, Mihai Carabas wrote:
> Hello,
> 
> Any feedback on this last series?

Other than the "this breaks the build according to the kernel test
robot"?

I think that needs to be fixed before we can do anything here...

thnaks,

greg k-h
