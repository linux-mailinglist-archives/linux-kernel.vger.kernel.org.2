Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55B3229DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhBWL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:56:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:37578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232535AbhBWLyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:54:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614081206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6W7PNQXZkzlJiJw4AQM+zeoswTcFjNQjucw6QSRTvs0=;
        b=hISPFEVRxYkpx0nVLn/tXB+qvijXdxoyrRAYKgRc5kJFfUAyvXRLFPidQVzyVZj/S9A009
        ZOEI9TDdwkla9v4VW3qIeqQTGAyJkXu4inVEO3uDuTyCGcSjCjo6Qx2blY58Ekc5L+vxlh
        FS/eZD/tru0JKFeEVs6lJYX179ICpiE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9666FAE57;
        Tue, 23 Feb 2021 11:53:26 +0000 (UTC)
Date:   Tue, 23 Feb 2021 12:53:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 13/14] printk: kmsg_dump: use
 kmsg_dump_rewind
Message-ID: <YDTstn2FTyGiQDGM@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218081817.28849-14-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-02-18 09:18:16, John Ogness wrote:
> kmsg_dump() is open coding the kmsg_dump_rewind(). Call
> kmsg_dump_rewind() instead.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
