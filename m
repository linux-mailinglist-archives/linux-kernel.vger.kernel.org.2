Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5FC3993F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhFBTxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhFBTxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:53:14 -0400
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A50C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 12:51:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 8331E4D2522DF;
        Wed,  2 Jun 2021 12:51:27 -0700 (PDT)
Date:   Wed, 02 Jun 2021 12:51:17 -0700 (PDT)
Message-Id: <20210602.125117.1391130087317485842.davem@davemloft.net>
To:     thunder.leizhen@huawei.com
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sparc64: vcc: use DEVICE_ATTR_*() macro
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210602014839.10587-1-thunder.leizhen@huawei.com>
References: <20210602014839.10587-1-thunder.leizhen@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 02 Jun 2021 12:51:27 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Wed, 2 Jun 2021 09:48:39 +0800

> Use DEVICE_ATTR_*() macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
