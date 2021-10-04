Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05BF42082E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhJDJ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:26:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45384 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJDJ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:26:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C4A63220E5;
        Mon,  4 Oct 2021 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633339474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kE6QqohlNijf2mZObcz+VaBZl/vt0O2YpBYiHRynMyo=;
        b=UR+LZTchcxLLIkIUHxgvdvZKTttRjC5PS54jEDdsq/S/YsgFvkDGoX1X0BthIcPenz0rsd
        s/FP1jqYPlLHlN4UAhp3XBQBuz1hl9kU7fXIdin7vQniL84acv5upJ3tG1UwDRAGEdbSnv
        fJUbG3ITabrGXaZ+PPGv5R1Nr6wRHbs=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9862A3B88;
        Mon,  4 Oct 2021 09:24:34 +0000 (UTC)
Date:   Mon, 4 Oct 2021 11:24:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH printk v1] printk: use gnu_printf format attribute for
 printk_sprint()
Message-ID: <YVrIUsTl8SSpfyDZ@alley>
References: <20210927142203.124730-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927142203.124730-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-09-27 16:28:03, John Ogness wrote:
> Fix the following W=1 kernel build warning:
> 
> kernel/printk/printk.c: In function 'printk_sprint':
> kernel/printk/printk.c:1913:9: warning: function 'printk_sprint' might be
> a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The patch has been committed into printk/linux.git, branch for-5.16.

Best Regards,
Petr
