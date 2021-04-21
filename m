Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993C43670B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbhDUQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:57:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32898 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbhDUQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:56:53 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id A79C74D2493BF;
        Wed, 21 Apr 2021 09:56:19 -0700 (PDT)
Date:   Wed, 21 Apr 2021 09:56:15 -0700 (PDT)
Message-Id: <20210421.095615.459544163755192519.davem@davemloft.net>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/26] serial: sunsu: drop low-latency workaround
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210421095509.3024-24-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
        <20210421095509.3024-24-johan@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 21 Apr 2021 09:56:19 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>
Date: Wed, 21 Apr 2021 11:55:06 +0200

> The sunsu driver has been carrying a workaround for the infamous
> low_latency behaviour of tty_flip_buffer_push() by dropping and
> reacquiring the port lock in the interrupt handler since 2004.
> 
> Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
> tty_flip_buffer_push() always schedules a work item to push data to the
> line discipline and there's no need to keep any low_latency hacks around.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
