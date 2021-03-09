Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D7332EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhCITIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34458 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhCITIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:08:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 3E6AA5000B4DD;
        Tue,  9 Mar 2021 11:08:16 -0800 (PST)
Date:   Tue, 09 Mar 2021 11:08:12 -0800 (PST)
Message-Id: <20210309.110812.234617387417457658.davem@davemloft.net>
To:     glaubitz@physik.fu-berlin.de
Cc:     torvalds@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] SPARC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
References: <20210308.154619.729170517586257571.davem@davemloft.net>
        <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 09 Mar 2021 11:08:16 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 9 Mar 2021 01:19:05 +0100

> Hi Dave!
> 
> On 3/9/21 12:46 AM, David Miller wrote:
>> Just some more random bits from Al,  including a conversion over to generic exytables.
> 
> Is there a chance we could include this important fix by Rob Gardner for 5.12 as well?
> 
>> https://marc.info/?l=linux-sparc&m=161457847223456&w=2
> 
> It fixes a hard kernel crash under certain loads which we have seen in Debian quite frequently.

I'll ake sure that gets into my next pull req, thanks.
