Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44A93D10F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbhGUNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:35:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54488 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhGUNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:35:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0D7992034D;
        Wed, 21 Jul 2021 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626876942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+3Om8wtKbQs5DWdHyNMcqhVeu7z3hdWmrVAZAm+4rA=;
        b=AnBjhrAjZNAF+Bizn0W/an9wQif2YV3D4CEh6h6Nor4zkHQatSG3VYOv7MaXEoQXCYYyyw
        HGSDy6PbE+XZGYyoKWCe8m9bJUDZAk6GKu4sCmvklnyULsF7flXjJVqNaXEvOny1dw/h/9
        D0uwobJ7UqpM3s/tGE2pi0BfqFaHNOk=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE740A3B84;
        Wed, 21 Jul 2021 14:15:41 +0000 (UTC)
Date:   Wed, 21 Jul 2021 16:15:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/2] printk: Remove console_silent()
Message-ID: <20210721141541.6lsnadugnsviwipr@pathway.suse.cz>
References: <20210713011511.215808-1-dima@arista.com>
 <20210713011511.215808-2-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713011511.215808-2-dima@arista.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-07-13 02:15:10, Dmitry Safonov wrote:
> It' unused since removal of mn10300:
> commit 739d875dd698 ("mn10300: Remove the architecture")
> x86 stopped using it in v2.6.12 (see history git):
> commit 7574828b3dbb ("[PATCH] x86_64: add nmi button support")
> 
> Let's clean it up from the header.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

I thought about this several times but never made a patch ;-)

Best Regards,
Petr
