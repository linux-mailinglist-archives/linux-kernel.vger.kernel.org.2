Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E6E3F8A32
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbhHZOhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:37:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbhHZOho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:37:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD08822235;
        Thu, 26 Aug 2021 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629988615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AJYi8p48Mp7c2LVCCbbs7wQvg9zHNiToSE4X8bydgEo=;
        b=c5oNUgjCTZvPBtu/VYNVNHRoCyXWQE25wn9JKR3rEk72OLcWdhBBCIaE5V02e63f2fbcwa
        LMJoI4VZhYdTzoBmtUnTEYou6L56if3zXxcYnYv8pTMf55zMHcOpT/EDwJS6akNBEeNayV
        LPepd/PtGZRD6JBv9FXmYNAojRpfTEg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 47CA0A3B8D;
        Thu, 26 Aug 2021 14:36:55 +0000 (UTC)
Date:   Thu, 26 Aug 2021 16:36:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] kernel/watchdog: change prototype of
 watchdog_nmi_enable()
Message-ID: <YSenB+Rr/4OV8EHQ@alley>
References: <20210824031435.9664-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824031435.9664-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-24 11:14:35, Pingfan Liu wrote:
> The only caller does not handle the return value of
> watchdog_nmi_enable(). If there is an error, it seems to be reported by
> arch specific code.
> 
> Hence changing watchdog_nmi_enable() return value from int to void.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
