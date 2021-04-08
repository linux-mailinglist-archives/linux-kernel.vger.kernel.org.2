Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56891357F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhDHJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:33:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:39344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhDHJdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:33:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617874422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jeg9xG562CxRJLeyVpY5toJr618E3J/dpt9KJqMeLQM=;
        b=eNAKt+L0eB+a+u6zrn5M68e7Dv5RRCkSfD1wsWtWfyx1+RAr0UEK7zw0G47kZm5ZSYW9rX
        xJj9RXhXKkMy/Rtos3NeFT+KE1SnGe0G/u4wo9MbZIU1MtUBKZ9hR+YgMJAkrTzE28L/Ed
        jMbXEUzPjglBR441NnH2M1Sa93BaxPE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 100BCB00E;
        Thu,  8 Apr 2021 09:33:42 +0000 (UTC)
Message-ID: <a14fcaffd6e26081c07bcfa36a81ded38dcf88b2.camel@suse.com>
Subject: Re: [PATCH 1/2] USB:ehci:Add a whitelist for EHCI controllers
From:   Oliver Neukum <oneukum@suse.com>
To:     Longfang Liu <liulongfang@huawei.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com, stern@rowland.harvard.edu,
        liudongdong3@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kong.kongxinwei@hisilicon.com, yisen.zhuang@huawei.com
Date:   Thu, 08 Apr 2021 11:33:30 +0200
In-Reply-To: <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
References: <1617873073-37371-1-git-send-email-liulongfang@huawei.com>
         <1617873073-37371-2-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 08.04.2021, 17:11 +0800 schrieb Longfang Liu:
> Some types of EHCI controllers do not have SBRN registers.
> By comparing the white list, the operation of reading the SBRN
> registers is skipped.
> 
> Subsequent EHCI controller types without SBRN registers can be
> directly added to the white list.

Hi,

shouldn't this set a flag for a missing functionality?

	Regards
		Oliver


