Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0836A8C2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 20:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhDYSIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 14:08:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhDYSIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:08:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E820AB061;
        Sun, 25 Apr 2021 18:07:36 +0000 (UTC)
Date:   Sun, 25 Apr 2021 11:07:29 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de
Subject: Re: [PATCH 0/1] ipc/util.{c,h}: Use binary search for max_idx
Message-ID: <20210425180729.7ew42ab5ygstbwm4@offworld>
References: <20210425075208.11777-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210425075208.11777-1-manfred@colorfullife.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021, Manfred Spraul wrote:

>2nd version of the patch:
>@Andrew: Could you add the patch to your mm tree, as candidate for
>linux-next?
>
>Note:
>I have tried to remove the ids->max_idx cache entirely. Unfortunately,
>this causes a significant slow-down of semstat(,,IPC_STAT):
>   * no object allocated, no ipcmni_extended: +50%
>   * no object allocated, with ipcmni_extended: +80%
>   * 30 objects allocated, with large gaps, no ipcmni_extended:
>           +350%
>Thus I haven't removed ids->max_id.

Right, IPC_STAT is the main usecase for max_id. But I'm not sure why
you were looking to remove it in the first place - or was it just to
avoid this patch altogether?

Thanks,
Davidlohr
