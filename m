Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA73FD8FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbhIALtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:49:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhIALtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:49:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C18752252B;
        Wed,  1 Sep 2021 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630496917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r86Qp0j14moY0c9BdKYGjByM22DynjsO0TI01C7umvY=;
        b=NFWHX/B1vAc6YABOInFrmYNw2eInR+iBHZ+VH/hfhirp+xm7GjTBx/NISkb2ooa2uSjh5a
        s4EIzX3Xs6dUu450J/riTS1Hb9Xv+U/PQEWkJec2MNxo/R37OjfBzKsagx6AGE0WpAZBO2
        J8oI1aFhUvJgVpjnF/WFpRQ2p63RmUs=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5ABE6A3B9F;
        Wed,  1 Sep 2021 11:48:37 +0000 (UTC)
Date:   Wed, 1 Sep 2021 13:48:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     James Wang <jnwang@linux.alibaba.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
Message-ID: <YS9okbiLzBflOBsl@alley>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
 <YS2fZ1sknFYKtJFi@google.com>
 <YS3k5TRf5oLLEdKu@alley>
 <YS3stL0cTn5ZQSNx@google.com>
 <fc18d17a-b185-7a1e-2135-ec83f3f8c70f@linux.alibaba.com>
 <YS490P27YM6UlB2z@alley>
 <e66f501a-0ba9-77f1-b5a2-9a759f8e00d6@linux.alibaba.com>
 <YS5CPGm4JENsFIem@alley>
 <e670c6c0-dd24-bb26-a78f-e8cac10970eb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e670c6c0-dd24-bb26-a78f-e8cac10970eb@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-09-01 09:52:54, James Wang wrote:
> 
> 在 2021/8/31 PM10:52, Petr Mladek 写道:
> > On Tue 2021-08-31 22:38:42, James Wang wrote:
> > > 在 2021/8/31 PM10:33, Petr Mladek 写道:
> > > > On Tue 2021-08-31 21:45:05, James Wang wrote:
> > > > > 在 2021/8/31 PM4:47, Sergey Senozhatsky 写道:
> > > > > > And may I ask, just in case, if James can revert a revert of Petr's commit:
> > > > > > 
> > > > > >           revert a91bd6223ecd46addc71ee6fcd432206d39365d2
> > > > > > 
> > > > > > boot with wrong console argument and see if the kernel reboots without
> > > > > > any problems.
> > > > > After test, revert Petr's commit can work; reboot without any problem;
> > > > Interesting, it looks like the panic() is really caused by missing
> > > > stdout, stdin, and stderr, for the init process.
> > > > 
> > > > Unfortunately, the fix is not easy, as described in the commit
> > > > a91bd6223ecd46addc71e ("Revert "init/console: Use ttynull as
> > > > a fallback when there is no console").
> > > OK. But I suppose you could find a quick workaround to mitigate this issue.
> > You could either remove the invalid console=ttyUSB0,115200
> > parameter. As a result, tty0 will become the default console and
> > it will be used by the init process.
> 
> No，I just want to use a "invalid" console parameter for "boot up", because
> It could help me "drop" kernel/systemd log, keep the kernel logo on the
> screen;

This looks like a hack. And it works just by chance. It is neither
documented nor supported.

The official way to hide kernel messages is using "quiet" or
"loglevel=1" kernel parameters.

If you really do not want the console then I suggest to use the
ttynull driver mentioned in the previous mail.

Best Regards,
Petr
