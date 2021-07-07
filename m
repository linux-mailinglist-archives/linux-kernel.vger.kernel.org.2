Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A233BF11C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhGGU7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhGGU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:59:37 -0400
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:56:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 3B2284D0F688B;
        Wed,  7 Jul 2021 13:56:55 -0700 (PDT)
Date:   Wed, 07 Jul 2021 13:56:51 -0700 (PDT)
Message-Id: <20210707.135651.420878063579280953.davem@davemloft.net>
To:     mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@lists.infradead.org,
        mingo@kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: sparc: fix arch_cmpxchg64_local()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210707083032.567-1-mark.rutland@arm.com>
References: <20210707083032.567-1-mark.rutland@arm.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 07 Jul 2021 13:56:55 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>
Date: Wed,  7 Jul 2021 09:30:32 +0100

> Peter, David, could one of you please apply this? It's an urgent fix for
> fallout from the ARCH_ATOMIC conversion, and it'd be good to fix before -rc1.

Peter please take this as I am backlogged.

Thank you.
