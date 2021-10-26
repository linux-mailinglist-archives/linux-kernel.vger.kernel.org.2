Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBF543B006
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhJZKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhJZKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:33:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F122C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=jY+ZCL8Nr+lNKUZnMKzONCXhUQE14bxqJk87ik6rqUw=; b=KaJvgcir8yNar7MQzOg2KSEJDB
        g0Kj4e5vpUus+m749ihFhcYHZi3SvFLqMx+7cffN5I/64owawf6sTdKqO3I+Pm5Xw2bXAcGTN7jAN
        MyqCLwWj0l5+vGra/nK4Lv1lM3SvelsLaDWukQuoIkoSv+UVpBcFvfu6Rh+Y0LVsFADWHuQINtvjX
        jN7VDsk7U6bvIwkxTsZM4RDYp8h8ickeZLwLiWWobSqd306Lz5KjkWSxm3IyrRgtrrsCc+5T/KYsG
        lW3b39ulDP5BU0a1UYO788p+V6XrbrS+gCiZr13o8/9vycJ3KlKPINSdbypPtmqzLbmJa/3Tn7L38
        K5p+9BxQ==;
Received: from [212.102.57.91] (helo=u0c626add9cce5a.ant.amazon.com)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfJi1-00GmdF-G3; Tue, 26 Oct 2021 10:29:45 +0000
Message-ID: <a61be974ef65d00fd22b0216fc0d85c0c226f5e9.camel@infradead.org>
Subject: Re: drivers/char: suspected null-pointer dereference problem in
 handle_control_message
From:   Amit Shah <amit@infradead.org>
To:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "amit@kernel.org" <amit@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Oct 2021 12:29:31 +0200
In-Reply-To: <TYCP286MB11884B1010AF8C77F1BBDAF08A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB11884B1010AF8C77F1BBDAF08A849@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-26 at 06:17 +0000, YE Chengfeng wrote:
> Hi,
>  
> https://github.com/torvalds/linux/blob/master/drivers/char/virtio_console.c#L1657
>  
> Our experimental static analysis tool detects a suspected null-pointer-dereference problem. We manually check it, but It still could be false positive because we are not familiar with the code. We report this to you just in case.
>  
> We notice that in some branches of switch case at line #1582, the pointer port is null check. But null check is missing at line #1657 and line #1633. It seems like a suspected null-pointer dereference pointer. Would you like to spare some time to have a look at it?

For this NULL deref to happen, the host will have to send a port_name
command before a port_add command.  Worrying about that isn't
worthwhile.  If you'd like to add a generic `if (unlikely(!port))`
after line 1579 there, that'd be fine as a hint to the static analysis
tools, though, so just for that reason, it might be worthwhile.

		Amit

