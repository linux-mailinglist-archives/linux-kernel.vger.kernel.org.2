Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C807B36EBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhD2OAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:00:22 -0400
Received: from vps.thesusis.net ([34.202.238.73]:37074 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233862AbhD2OAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:00:20 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Apr 2021 10:00:20 EDT
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id AD44A2EC64;
        Thu, 29 Apr 2021 09:52:10 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F20wM5zUlzsp; Thu, 29 Apr 2021 09:52:10 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 753582EC66; Thu, 29 Apr 2021 09:52:10 -0400 (EDT)
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     msekleta@redhat.com, Peter Rajnoha <prajnoha@redhat.com>
Subject: Re: [PATCH 1/2] kobject: return error code if writing /sys/.../uevent
 fails
In-Reply-To: <20181205112745.12276-2-prajnoha@redhat.com>
Date:   Thu, 29 Apr 2021 09:40:08 -0400
Message-ID: <878s515hbp.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just an FYI, I've been tracking down a bug that was causing the debian
bullseye installer to immediately crash and reboot the xen domU and
bisected it to this commit.  It appears that the Xen Virtual Keyboard
driver ( and at least one other, probably more ) were always broken and
failed to trigger the udev event, but this was never noticed.  When this
patch returned the error code, it caused the d-i init scripts triggering
coldplug events to fail, which caused init to bail out, causing a kernel
panic.

In the future, when fixing error returns like this, could you please add
a big fat printk so that hopefully things that always should have failed
but didn't and now do can get noticed and fixed more quickly.

https://bugzilla.kernel.org/show_bug.cgi?id=207695
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=983357

