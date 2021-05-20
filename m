Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9921838B20E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242538AbhETOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240620AbhETOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:41:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20BE0ABC2;
        Thu, 20 May 2021 14:39:44 +0000 (UTC)
Date:   Thu, 20 May 2021 16:39:43 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jon Mediero <jmdr@disroot.org>
cc:     Jessica Yu <jeyu@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: correctly exit module_kallsyms_on_each_symbol
 when fn() != 0
In-Reply-To: <20210520122326.18563-1-jmdr@disroot.org>
Message-ID: <alpine.LSU.2.21.2105201639330.1498@pobox.suse.cz>
References: <20210520122326.18563-1-jmdr@disroot.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021, Jon Mediero wrote:

> Commit 013c1667cf78 ("kallsyms: refactor
> {,module_}kallsyms_on_each_symbol") replaced the return inside the
> nested loop with a break, changing the semantics of the function: the
> break only exits the innermost loop, so the code continues iterating the
> symbols of the next module instead of exiting.
> 
> Fixes: 013c1667cf78 ("kallsyms: refactor {,module_}kallsyms_on_each_symbol")
> Signed-off-by: Jon Mediero <jmdr@disroot.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
