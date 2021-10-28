Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603DB43DC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhJ1IE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:04:26 -0400
Received: from s2.neomailbox.net ([5.148.176.60]:16156 "EHLO s2.neomailbox.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhJ1IEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:04:05 -0400
X-Greylist: delayed 1598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Oct 2021 04:04:05 EDT
Subject: Re: [PATCH net-next] batman-adv: Fix the wrong definition
To:     Yajun Deng <yajun.deng@linux.dev>, mareklindner@neomailbox.ch,
        sw@simonwunderlich.de, sven@narfation.org
Cc:     b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211028072306.1351-1-yajun.deng@linux.dev>
From:   Antonio Quartulli <a@unstable.cc>
Message-ID: <da6fa493-0911-ca3f-16c0-380bc35d8317@unstable.cc>
Date:   Thu, 28 Oct 2021 09:35:28 +0200
MIME-Version: 1.0
In-Reply-To: <20211028072306.1351-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/10/2021 09:23, Yajun Deng wrote:
> There are three variables that are required at most,
> no need to define four variables.
> 
> Fixes: 0fa4c30d710d ("batman-adv: Make sysfs support optional")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

NAK.

kobject_uevent_env() does not know how many items are stored in the
array and thus requires it to be NULL terminated.

Please check the following for reference:

https://elixir.bootlin.com/linux/v5.15-rc6/source/lib/kobject_uevent.c#L548

OTOH I guess we could still use '{}' for the initialization.

Regards,

-- 
Antonio Quartulli
