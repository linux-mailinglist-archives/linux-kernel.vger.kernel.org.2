Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F13DCA59
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhHAGc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHAGcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:32:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5CBC06175F;
        Sat, 31 Jul 2021 23:32:18 -0700 (PDT)
Date:   Sun, 1 Aug 2021 08:32:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627799536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKD7nkFpjh4QjLdhSDSWcxFixT+I42XTbACFbBDZI0I=;
        b=Hiqp0lrSVc92ZgzC9hG0j34Dj4YsGDcc9QQAaJWm5FrUbTbVpHfgqzVruNRwsVxVjxhEZK
        xpHLL+D8Zv72T+zVTiT9TchD/zMwzhy6HWK5pftzWEd9VfUwgfXar3h2/8c10ztKW623Nw
        F+f94anga6L8YAFiHwxq/KOGnE3i1bTD6+7MKG6cHENzQ/k+uBGMEMM6TFF/HCylRphoXK
        XfsLB2TBFxswwCGYSKFYzqI5knG4RYK532nHsBcENYWqH/s2+3fqYnXSJu8VYJFtqbgwRg
        Xa4zd2ihjEJDIOR8AmrmtoOs8VTjtVbGIUT/BFZTbYzSYhisD5v3n8ovXDjdNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627799536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKD7nkFpjh4QjLdhSDSWcxFixT+I42XTbACFbBDZI0I=;
        b=mzGzd8pBWT/y+7+sRq4XRUl6Rdpv1brvVTE3aT76SiPihS9Fg2EAAM7oQ1TAjFhr6uTRsz
        xc+VXJu5HDLxiyCg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 01/17] libtracefs: Added new API tracefs_sql()
Message-ID: <YQY/72DgV7nBRQqw@lx-t490>
References: <20210730221824.595597-1-rostedt@goodmis.org>
 <20210730221824.595597-2-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730221824.595597-2-rostedt@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021, Steven Rostedt wrote:
>
> Currently it only supports simple SQL of the type:
>
>   SELECT start.common_pid AS pid, end.common_timestamp.usecs AS usecs
>     FROM sched_waking AS start on sched_switch AS end
                                 ^
                                 JOIN
>     ON start.pid = end.next_pid
>
