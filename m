Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9D459E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhKWIju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230176AbhKWIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:39:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D1036023E;
        Tue, 23 Nov 2021 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637656600;
        bh=8IUk2wsIqhHjOKYTSkovqz/gy4LMPoLmcGPb/RWtyL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=pE1jnYGRnAoPijL3RZ2jXz1jQkUDvNlFpaPfiLer0TvyDtU045PYqWux5WRFke57+
         qVRQ5sSfp2OmZS1w9El4RyvEYlNCUoH9XSJe6D6CQgMxekeH8jxb0vr//5cl+GHrWN
         ihlpVbD+xxUnVVKD7JA4T6qZZfEHcWS5hTi3DU5PqIQV65L8bPX9l1m/xLmZ8pwgnO
         fKkHBNh8rGdKOsA0od3w+Fjn4L9M7gLclG5v3Ji0cIYZFZvNXGjiQjZfjQvl3nEX+M
         Tvlcn12z8FK0uRTK79ttLwrrtKgPUnuMsYnV41tvhAPNzMcERc4tIIRxm9xbqNNuDV
         OHtxAG2PK9wpw==
From:   SeongJae Park <sj@kernel.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     akpm@linux-foundation.org, SeongJae Park <sj@kernel.org>,
        Jonathan.Cameron@huawei.com, amit@kernel.org,
        benh@kernel.crashing.org, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, foersleo@amazon.de,
        gthelen@google.com, markubo@amazon.de, rientjes@google.com,
        shakeelb@google.com, shuah@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] Introduce DAMON-based Proactive Reclamation
Date:   Tue, 23 Nov 2021 08:36:36 +0000
Message-Id: <20211123083636.5603-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <11868371.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksandr,

On Sun, 21 Nov 2021 23:32:12 +0100 Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> Hello.
> 
> On úterý 19. října 2021 17:07:16 CET SeongJae Park wrote:
> > In short, DAMON_RECLAIM with 50ms/s time quota and regions prioritization on
> > v5.15-rc5 Linux kernel with ZRAM swap device achieves 38.58% memory saving
> > with only 1.94% runtime overhead.  For this, DAMON_RECLAIM consumes only
> > 4.97% of single CPU time.
> 
> While it really consumes little CPU time, is it fine for `kdamond.0` to be in a 
> D (uninterruptible sleep) state all the time while active, pushing loadavg 
> over 1.0?

Good point, this could confuse some users using loadavg.  I will send a fix for
this soon.


Thanks,
SJ

> 
> Thanks.
> 
> -- 
> Oleksandr Natalenko (post-factum)
> 
