Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC93B330A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCHJTI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Mar 2021 04:19:08 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:53265 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229458AbhCHJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:18:37 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.69.177;
Received: from localhost (unverified [78.156.69.177]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 24038370-1500050 
        for multiple; Mon, 08 Mar 2021 09:18:20 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210308085952.8153-1-baijiaju1990@gmail.com>
References: <20210308085952.8153-1-baijiaju1990@gmail.com>
Subject: Re: [PATCH] gpu: drm: i915: fix error return code of igt_buddy_alloc_smoke()
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, lkml@SDF.ORG,
        matthew.auld@intel.com, rodrigo.vivi@intel.com
Date:   Mon, 08 Mar 2021 09:18:16 +0000
Message-ID: <161519509650.8241.14778072091965189208@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jia-Ju Bai (2021-03-08 08:59:52)
> When i915_random_order() returns NULL to order, no error return code of
> igt_buddy_alloc_smoke() is assigned.
> To fix this bug, err is assigned with -EINVAL in this case.

It would not be EINVAL since that is used for a reference failure, but
in this case the idea was to return 0 as no testing was done and the
ENOMEM was raised before testing began i.e. not an internal and
unexpected driver allocation failure.
-Chris
