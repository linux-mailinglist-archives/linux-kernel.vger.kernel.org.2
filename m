Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1D3D0EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbhGUMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:02:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58456 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhGUMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:02:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5603B224F6;
        Wed, 21 Jul 2021 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626871400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGdnMjLwINujnz/L5thSgsnoCsraP3fxSj7mEBMY+OE=;
        b=cbm9l81/iwGYnn/eo6PG0O8t9L+KinXbx42JJnBBIg+9kCICBVqb2OBvUda3dlHT0/j/aq
        X3ULSQn2EBa7ZzXETwnCgbZ9gdat1gGMW/3kKVNVgD/lsqR8PFtloN5yJDjpR/KSf7/Lse
        IP69UJYmPEcyQUX1Y8hwcZvU0Pl2dls=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 16609A3B81;
        Wed, 21 Jul 2021 12:43:20 +0000 (UTC)
Date:   Wed, 21 Jul 2021 14:43:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 6/6] printk: syslog: close window between wait
 and read
Message-ID: <20210721124319.hy5rrn6p2i2r2qya@pathway.suse.cz>
References: <20210715193359.25946-1-john.ogness@linutronix.de>
 <20210715193359.25946-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715193359.25946-7-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-07-15 21:39:59, John Ogness wrote:
> Syslog's SYSLOG_ACTION_READ is supposed to block until the next
> syslog record can be read, and then it should read that record.
> However, because @syslog_lock is not held between waking up and
> reading the record, another reader could read the record first,
> thus causing SYSLOG_ACTION_READ to return with a value of 0, never
> having read _anything_.
> 
> By holding @syslog_lock between waking up and reading, it can be
> guaranteed that SYSLOG_ACTION_READ blocks until it successfully
> reads a syslog record (or a real error occurs).
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
