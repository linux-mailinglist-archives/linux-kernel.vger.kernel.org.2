Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B53456088
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhKRQgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhKRQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:35:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4ODP4AJfHtSXvVUKQfuE4b3KJMz8jYDJg/J3gU4Dsg=; b=0/LMVuOhzY788oJNrGZymIH1oe
        o5i1ejl1e1EiGYZBXume9hQGsY29lqr8TRIOvsdfQ3HJkqM4dsOxR+22EBqNWsrZwhWoVkmMjOaZp
        yTwQul81XVz4hMu9kPEhUKzY2M0i02d1OVyXnh7glDxc6jwv6OItY95t0xTi6EGwSa92d+kdnRxWw
        vsIMYptwCY9ZEEEo5vzOo1yKeU7TlDTvimSHF89PNozmjZdYs1vsIk4zhc9WZ9rCb67HYQI2xWiDW
        totRsMkl7N14yFaNdSab1VFng9LcCjhWAwrLANuuGrihMTKsShxIbWZapdcIGMP8zNGUSB9VQn65r
        /kz4TlnA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnkLH-008MJz-AW; Thu, 18 Nov 2021 16:32:55 +0000
Date:   Thu, 18 Nov 2021 08:32:55 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH mcgrof-next] hung_task:
 sysctl_hung_task_all_cpu_backtrace can be static
Message-ID: <YZaANzEZ4n/RKDyQ@bombadil.infradead.org>
References: <202111181439.tykxEC3r-lkp@intel.com>
 <20211118062040.GA67066@d1b1ea5158cd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118062040.GA67066@d1b1ea5158cd>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:20:40PM +0800, kernel test robot wrote:
> kernel/hung_task.c:66:28: warning: symbol 'sysctl_hung_task_all_cpu_backtrace' was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: kernel test robot <lkp@intel.com>

I'll roll this fix into my series, thanks!

  Luis
