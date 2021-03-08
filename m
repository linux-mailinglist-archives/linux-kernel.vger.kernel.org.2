Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3A330A09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhCHJNL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Mar 2021 04:13:11 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:53061 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229637AbhCHJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:13:06 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.69.177;
Received: from localhost (unverified [78.156.69.177]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 24038287-1500050 
        for multiple; Mon, 08 Mar 2021 09:12:19 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210308090722.8392-1-baijiaju1990@gmail.com>
References: <20210308090722.8392-1-baijiaju1990@gmail.com>
Subject: Re: [PATCH] gpu: drm: i915: fix error return code of igt_threaded_blt()
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com
Date:   Mon, 08 Mar 2021 09:12:15 +0000
Message-ID: <161519473525.8241.4435549444995105395@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jia-Ju Bai (2021-03-08 09:07:22)
> When kcalloc() returns NULL to tsk or thread, no error code of 
> igt_threaded_blt() is returned.
> To fix this bug, -ENOMEM is returned as error code.

Because we decided to skip the test if it could not be run due to
insufficient memory, as opposed to an internal allocation failure from
the driver.
-Chris
