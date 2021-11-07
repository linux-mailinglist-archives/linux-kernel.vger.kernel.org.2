Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9CF4475F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhKGUyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:55 -0500
Received: from cc-smtpout1.netcologne.de ([89.1.8.211]:47288 "EHLO
        cc-smtpout1.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhKGUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:41 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Nov 2021 15:54:41 EST
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
        by cc-smtpout1.netcologne.de (Postfix) with ESMTP id DAD8812685;
        Sun,  7 Nov 2021 21:43:50 +0100 (CET)
Received: from nas2.garloff.de (xdsl-78-35-62-253.nc.de [78.35.62.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA id A813A11D9B;
        Sun,  7 Nov 2021 21:43:49 +0100 (CET)
Received: from [192.168.155.202] (unknown [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id 26633B3B131A;
        Sun,  7 Nov 2021 21:43:49 +0100 (CET)
Message-ID: <70f44842-ed3a-fc80-786e-0e6278cb7f19@garloff.de>
Date:   Sun, 7 Nov 2021 21:43:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     e1000-devel@lists.sourceforge.net
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Kurt Garloff <kurt@garloff.de>
Subject: igb in 5.15: autosuspend hangs netlink
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-NetCologne-Spam: L
X-Rspamd-Queue-Id: A813A11D9B
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have several NICs enslaved to a bridge.

Enabling powermanagement (setting the pcie device power/control to auto) for
an intel I211 Gigabit Network device hangs the Linux kernel's netlink interface.
Commands like `ip addr show` no longer work but just hang.
Note: There's nothing connected to the i211, so I assume it goes to sleep indeed.
There's no recovery -- trying to echo "on" to the power/control does not recover
the netlink interface -- I have not found a better recovery than rebooting yet.

This problem did not exist in 5.10.y kernels, it does exist in 5.15.[01].
The device is powered by the igb driver.

Let me know if this problem is not known yet and you need more information.

Best,

-- 
Kurt Garloff <kurt@garloff.de>
Cologne, Germany

