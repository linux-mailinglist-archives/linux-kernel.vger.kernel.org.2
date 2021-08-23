Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB53F531A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhHWV6q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 17:58:46 -0400
Received: from foss.arm.com ([217.140.110.172]:57436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232898AbhHWV6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:58:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E99BD1042;
        Mon, 23 Aug 2021 14:58:00 -0700 (PDT)
Received: from [127.0.0.1] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ABFA3F766;
        Mon, 23 Aug 2021 14:58:00 -0700 (PDT)
Date:   Mon, 23 Aug 2021 22:57:56 +0100
From:   Steven Price <steven.price@arm.com>
To:     dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa@collabora.com>
CC:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3] drm/panfrost: Use u64 for size in lock_region
User-Agent: K-9 Mail for Android
In-Reply-To: <YSQO7exgqnk0ZLJT@maud>
References: <20210820213117.13050-1-alyssa.rosenzweig@collabora.com> <20210820213117.13050-3-alyssa.rosenzweig@collabora.com> <71392001-a5a9-fee2-79a5-91df55ba3081@arm.com> <YSQO7exgqnk0ZLJT@maud>
Message-ID: <77CFD756-7F02-4CBA-9E58-3EDA2167620E@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2021 22:11:09 BST, Alyssa Rosenzweig <alyssa@collabora.com> wrote:
>> > Mali virtual addresses are 48-bit. Use a u64 instead of size_t to ensure
>> > we can express the "lock everything" condition as ~0ULL without relying
>> > on platform-specific behaviour.
>> 
>> 'platform-specific behaviour' makes it sound like this is something to
>> do with a particular board. This is 32bit/64bit - it's going to be
>> broken on 32bit: large lock regions are not going to work.
>
>Oh, my. I used the term as a weasel word since the spec is loose on how
>big a size_t actually is. But if this is causing actual breakage on
>armv7 we're in trouble. I'll add a Cc stable tag on v2, unless the Fixes
>implies that?

The usual practice is to put CC: stable in the commit message or the fixes tag (no need to actually CC the stable email address). So just Fixes: should work

>Thanks for pointing this out.

It's not actually quite so bad as it could be as >4GB regions are unlikely (especially on 32bit), but the GPU does of course support such a thing.

Thanks,
Steve
