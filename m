Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7334E7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhC3MvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:51:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhC3MvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:51:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617108670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcYp5JWxCIve1nzZ4kuXcxsj4TTT3BCiD20mecGy2cs=;
        b=avqnNzanjB/FHporaP0Ys9r8CfEBn7mA1J3eubKsJRT/gygdNYehX86b/8r5tovs7czFIh
        rdpytiovoIIgzJzeXQZ8X8M9RzvIK+hdbhSmPMcX18r3A/jkwAmU0wJM59+L5V1Cue+jPY
        p3IuZ3h/7/NRk/XkAnl0rhsbdLArs/E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6625EB2F5;
        Tue, 30 Mar 2021 12:51:10 +0000 (UTC)
Date:   Tue, 30 Mar 2021 14:51:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        john.ogness@linutronix.de
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] kernel/printk.c: Fixed mundane typos
Message-ID: <YGMevQvltf/LnJP1@alley>
References: <20210328043932.8310-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328043932.8310-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-03-28 10:09:32, Bhaskar Chowdhury wrote:
> 
> s/sempahore/semaphore/
> s/exacly/exactly/
> s/unregistred/unregistered/
> s/interation/iteration/
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

John,

it conflicts with the patchset removing printk safe buffers[1].
Would you prefer to queue this into the patchset?
Or should I push it into printk/linux.git, printk-rework and you would
base v2 on top of it?

Best Regards,
Petr
