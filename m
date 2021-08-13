Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693203EBD24
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhHMUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233890AbhHMUNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E4206109E;
        Fri, 13 Aug 2021 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628885601;
        bh=qRcPNTd9RoFr3cz8v/gEfh/oPxPRHM5L0Xr5MkrLL8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pXHMupA17Sw/rVuGvTTZOdCbyo9ODx7u80UKQyOSUQBl9ajZzp8NB7BbdMOnFh8N1
         qdfriGiquhuVlxjticU0E1Pj1UfEjU5tYTLF4XZP/nzRsLS3J0Zy+dsJGWlfJoukV1
         /DKY142ehjPUpE5AKzorAxZlBNPYJRRyUWM7sVOA=
Date:   Fri, 13 Aug 2021 13:13:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     liuhailong <liuhailong@oppo.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add kernel_misc_reclaimable in show_free_areas
Message-Id: <20210813131320.b9474cb095cf815df1de337b@linux-foundation.org>
In-Reply-To: <20210813104725.4562-1-liuhailong@oppo.com>
References: <20210813104725.4562-1-liuhailong@oppo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 18:47:25 +0800 liuhailong <liuhailong@oppo.com> wrote:

> print NR_KERNEL_MISC_RECLAIMABLE stat from show_free_areas
> to check whether shrinker work correctly and current mem usage.

What inspired this change?  Are you observing problems with
misc_reclaimable memory accumulation?
