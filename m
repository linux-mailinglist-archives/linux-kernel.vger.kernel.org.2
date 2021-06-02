Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBC3986B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhFBKk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFBKk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:40:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1BBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oqCJhYD+APXhLiRbdzUFdNItab0UJDYn8NBVU6Y8mtY=; b=yc/d8gMsUVyNDNHXZbmPcX+AY
        VoqgRmhfPjp7x2ZRyO2iyAj0VGFYPhe8VmMMNw57lvFGZ/ojWHModK+R0Hxn87WTmWXbrLK28yJw1
        FgjQsL8jc7W6TB/Q0ECoVsRgTZfMpRhA5JBVM8vjVyddtn5nqjW1v7nILdJ8rKyB5mcSRr6sXT/nt
        yJseil1dqavyTZe+s2YMdQ5/CvEEN1kdoJb1yba+wOiTF8SzBtgu3EjMpAAgFjgeAnb86yQytzlXk
        2S6vr8j/FpFWOyMSWCkn4y2Lc+5SM8hVn4Y5F618NurWqenwiTGtyA9EZny6MUdi6KJ6PISdLTGML
        fCYVFp4PA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44614)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1loOHI-000112-5v; Wed, 02 Jun 2021 11:39:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1loOHH-00013e-Fc; Wed, 02 Jun 2021 11:39:11 +0100
Date:   Wed, 2 Jun 2021 11:39:11 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
Subject: Re: [PATCH v2 3/7] ARM: mm: Cleanup access_error()
Message-ID: <20210602103911.GG30436@shell.armlinux.org.uk>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602070246.83990-4-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 02, 2021 at 03:02:42PM +0800, Kefeng Wang wrote:
> Now the write fault check in do_page_fault() and access_error() twice,
> we can cleanup access_error(), and make the fault check and vma flags set
> into do_page_fault() directly, then pass the vma flags to __do_page_fault.
> 
> No functional change.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Looks fine to me. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
