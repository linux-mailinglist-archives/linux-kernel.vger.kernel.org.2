Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B457F3EDE10
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhHPTsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:48:03 -0400
Received: from out0.migadu.com ([94.23.1.103]:34505 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230420AbhHPTsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:48:02 -0400
Subject: Re: [PATCH v2 03/19] ARC: mm: move mmu/cache externs out to setup.h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629143249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYJm7DmTJym2Eu10SQxvpGktry/PBZKRLrfBx4S95Xk=;
        b=UndcR7Nihh6eUoLaRx1A3wJpWqQGyyuUc7+rNxBZ4S047wZKneJk8/UFj/rFdXH8zx1niP
        1/O+YgwDI2p0aGHF2UvNApPsHQblHLuGH+yAxuTyNiFBdALwXf4TUg8L3dg6nIS/ALPceu
        9TuoiigWHBJgEm/FqUZsZlidrDGH99E=
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210812233753.104217-1-vgupta@kernel.org>
 <20210812233753.104217-4-vgupta@kernel.org> <YRjd9FO37fVZyV5V@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vineet Gupta <vineet.gupta@linux.dev>
Message-ID: <c391bc0b-d8c8-7dc1-08af-4618e8532662@linux.dev>
Date:   Mon, 16 Aug 2021 12:47:25 -0700
MIME-Version: 1.0
In-Reply-To: <YRjd9FO37fVZyV5V@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: vineet.gupta@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/21 2:27 AM, Mike Rapoport wrote:
> Heh,
>
> "Don't pollute mmu.h and cache.h with some of ARC internal bootlog/setup
> related functions.
> move them aside to setup.h"
>
> is still not there :)

Oops my bad, indeed missed out on that one. Fixed now.

Thx,
-Vineet

