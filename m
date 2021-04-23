Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3179369B55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhDWUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:33:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59056 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:33:37 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 8E61D4D25A19E;
        Fri, 23 Apr 2021 13:33:00 -0700 (PDT)
Date:   Fri, 23 Apr 2021 13:33:00 -0700 (PDT)
Message-Id: <20210423.133300.1671385649231876076.davem@davemloft.net>
To:     shreya.ajithchb@gmail.com
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH]sbus:char:bbc_i2c:Replaced header file asm/io.h with
 linux/io.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210423065558.d5gy3zpxus6gsyc2@shreya-VirtualBox>
References: <20210423065558.d5gy3zpxus6gsyc2@shreya-VirtualBox>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 23 Apr 2021 13:33:00 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreya Ajith <shreya.ajithchb@gmail.com>
Date: Fri, 23 Apr 2021 12:25:58 +0530

> Replaced header file asm/io.h with linux/io.h
> 
> Signed-off-by:Shreya Ajith <shreya.ajithchb@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
