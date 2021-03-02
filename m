Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5713532A07A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381140AbhCBEVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347825AbhCBAM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614643861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4xOsDXnwNRrzScGg/FT4qUG8OQhdh13l32Skzvk+lyY=;
        b=CML77Uq7xVjIUkbA0fBOpnsy4KKTWTkNFGXhQm6yHKGoon3tnd82BwLRkoCLptndgAht1V
        ym1nxUPzpMwHNKYpUBADTT86Ox5H1g6IvEfwX4joVrhdfy1+jSizMS8SdmhOhZGWHgrieB
        MpiDqnf6yUmdA3B5IJ07fD524f0kzHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-fz-mU5_3NOm-0HMpz29v6A-1; Mon, 01 Mar 2021 19:10:59 -0500
X-MC-Unique: fz-mU5_3NOm-0HMpz29v6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF62F80196C;
        Tue,  2 Mar 2021 00:10:58 +0000 (UTC)
Received: from treble (ovpn-119-4.rdu2.redhat.com [10.10.119.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 579BC5C3E9;
        Tue,  2 Mar 2021 00:10:56 +0000 (UTC)
Date:   Mon, 1 Mar 2021 18:10:54 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Artem Savkov <asavkov@redhat.com>, linux-kernel@vger.kernel.org,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Upper bound mode for kernel timers
Message-ID: <20210302001054.4qgrvnkltvkgikzr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

As discussed on IRC:

We had a report of a regression in the TCP keepalive timer.  The user
had a 3600s keepalive timer for preventing firewall disconnects (on a
3650s interval).  They observed keepalive timers coming in up to four
minutes late, causing unexpected disconnects.

The regression was observed to have come from the timer wheel rewrite
from almost five years ago:

  500462a9de65 ("timers: Switch to a non-cascading wheel")

As you mentioned, with a HZ of 1000, the granularity for a one-hour
timer is four minutes, which matches the seen behavior.

To "fix" it, the user can just lower the timeout value by four minutes,
but that's a workaround, because the keepalive timer isn't working as
advertised.

One potential fix would be an "upper bound mode" in the timer, i.e. give
the user a way to specify that the given 'expires' value is an upper
bound rather than a lower bound.

As you graciously offered, if you or Anna-Maria can implement that new
interface, we (Artem or I) can write up a patch to use it for the
keepalive timer.

-- 
Josh

