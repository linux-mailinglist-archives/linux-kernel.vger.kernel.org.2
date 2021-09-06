Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6240181A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhIFIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbhIFIhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:37:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B6C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 01:36:11 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:36:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630917370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z73r+uu0OsE+RCBpe04a4TiiNp0FgA3n2mTqKGIbPpU=;
        b=pK3Rxh9+8iUhc12flqeeQUuD5QSmefbtcBfenwr1t3ssQCAjzQfK9pnn39KZrZ82/yzgOg
        n4nGKqlCPNHm1EtY9AGZ9iBSW3bBkAcyR8M+M6RGpA36pnHQM6R/niEcC+y3S8Ryiw44xs
        xoUwp0w1LMtbpc0ePiQEe2eExfzcRTtBynEuY8OjV6rUlSaySYphWYOUWs8m0hSe0xGAkQ
        wWA+iPzqMDkygolOHKyYFQsjN5tu76nZc3W+a6fRP04VDu8mTeebDvJdEzyh5B5qAkEpsn
        y0Vz3gXfqiASpfgLEkquCEgv+GCjJ95c5sk5Jh7WGe5OBCJpsrBbYxzZM1TG2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630917370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z73r+uu0OsE+RCBpe04a4TiiNp0FgA3n2mTqKGIbPpU=;
        b=Mv2QugxS+fSlHL9g3NOqAkdl2vDepdMfhZgZKd1dhJ8Ehmd02j1r2ogn9Q4LedJC3QwNFi
        VTY/P+hK2VqfWUBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Gregor Beck <gregor.beck@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "williams@redhat.com" <williams@redhat.com>, zanussi@kernel.org
Subject: Re: 5.4.143-rt63 fscache_cookie_hash initialisation
Message-ID: <20210906083608.u6ghkljbdiz6js3c@linutronix.de>
References: <CAEvSrY+XS2+xYTDT=up6VwLer8STS1KmNbP43PjZ4Z=qKvL4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEvSrY+XS2+xYTDT=up6VwLer8STS1KmNbP43PjZ4Z=qKvL4-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-06 09:55:59 [+0200], Gregor Beck wrote:
Your proposed change is

|index 5508d92e3f8f..cba2a226897f 100644
|--- a/fs/fscache/cookie.c
|+++ b/fs/fscache/cookie.c
|@@ -963,6 +963,6 @@ void __init fscache_cookie_init(void)
| {
|        int i;
|
|-       for (i = 0; i < (1 << fscache_cookie_hash_shift) - 1; i++)
|+       for (i = 0; i < ARRAY_SIZE(fscache_cookie_hash); i++)
|                INIT_HLIST_BL_HEAD(&fscache_cookie_hash[i]);
| }
|

So that -1 at the end killed us.

fscache-initialize-cookie-hash-table-raw-spinlocks.patch was removed in
the v5.6-RT series so this should be applied to 5.4 and 4.19.

Sebastian
