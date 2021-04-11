Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A203A35B39A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhDKLnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:43:04 -0400
Received: from mail.ispras.ru ([83.149.199.84]:43918 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235095AbhDKLnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:43:03 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id BCED440D3BFF;
        Sun, 11 Apr 2021 11:42:45 +0000 (UTC)
Date:   Sun, 11 Apr 2021 14:42:45 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Joe Perches <joe@perches.com>
cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
In-Reply-To: <6fbc8d6b885771ad4e69fc6789d07fd2b66f01d5.camel@perches.com>
Message-ID: <alpine.LNX.2.20.13.2104111441230.11104@monopod.intra.ispras.ru>
References: <20210410211152.1938-1-amonakov@ispras.ru> <6fbc8d6b885771ad4e69fc6789d07fd2b66f01d5.camel@perches.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021, Joe Perches wrote:

> (cc'ing the printk maintainers)
> 
[snip]
> 
> This shouldn't be necessary.
> If this is true then a lot of output logging code broke.

See also my response to Paul at
https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru/

Alexander
