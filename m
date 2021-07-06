Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E413BC4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhGFCnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFCnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:43:41 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76723C061574;
        Mon,  5 Jul 2021 19:41:03 -0700 (PDT)
Subject: Re: [PATCH] block: nbd: fix order of cleaning up the queue and
 freeing the tagset
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625539261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3F9gcIMfbZAZugjl+Gc1dc/E0wEPvESxt0ZR11S8uhk=;
        b=HFf+xWY7B6EYQJc8kOMC5nz/SISJnttX8PNc6OLaDzVEF2cKHzRpwNK17mw6pDnnKITUUl
        G1Ew1Bozw2yvSHU+JMS9I6csi/0Vk7OFoPN5uKx1a0uwuir0Sb8ms3jURtahdkQ9jkRDQY
        9DgXZa42F1C1eajXyxfJCjwES0xrBcg=
To:     Wang Qing <wangqing@vivo.com>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <d32f0c7c-4cbc-d754-817b-1c3f58a3e776@linux.dev>
Date:   Tue, 6 Jul 2021 10:40:54 +0800
MIME-Version: 1.0
In-Reply-To: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/21 5:25 PM, Wang Qing wrote:
> Must release the queue before freeing the tagset.
>
> Fixes: 1c99502fae35 ("loop: use blk_mq_alloc_disk and blk_cleanup_disk")
> Reported-and-tested-by: syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com

Did syzbot actually test the change?

> Signed-off-by: Wang Qing <wangqing@vivo.com>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

I don't mind you sent it quickly, but pls remove my outdated mail account.

Guoqing
