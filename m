Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8D3E9FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhHLHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:53:53 -0400
Received: from muru.com ([72.249.23.125]:42550 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhHLHxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:53:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DC1B880E2;
        Thu, 12 Aug 2021 07:53:47 +0000 (UTC)
Date:   Thu, 12 Aug 2021 10:53:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] soc: Keystone driver update for v5.15
Message-ID: <YRTTdcg+lj1/vH0L@atomide.com>
References: <0A637A41-2353-4900-962C-DBE50BBDE75A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0A637A41-2353-4900-962C-DBE50BBDE75A@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@oracle.com> [210810 23:47]:
> Tony Lindgren (1):
>       soc: ti: Remove pm_runtime_irq_safe() usage for smartreflex

Thanks for picking this one up, I also just sent a pull request for it,
my pull request can now be just ignored as that's a single commit
in it.

Regards,

Tony
