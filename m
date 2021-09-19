Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA3410B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhISMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:03:41 -0400
Received: from rosenzweig.io ([138.197.143.207]:46618 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235729AbhISMDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:03:34 -0400
Date:   Sun, 19 Sep 2021 07:47:28 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Apple Mailbox Controller support
Message-ID: <YUcjUFv5AKky1Zb9@sunset>
References: <20210916154911.3168-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154911.3168-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've dropped v1 from my tree and cherry-picked "mailbox: apple: Add
driver for Apple mailboxes". NVMe and DCP both still work, so this is

	Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Thanks!

On Thu , Sep 16, 2021 at 05:49:09PM +0200, Sven Peter wrote:
> Hi,
> 
> This is the second version of my series which adds support for the mailbox
> controllers found on the Apple M1.
> 
> v1: https://lore.kernel.org/lkml/20210907145501.69161-1-sven@svenpeter.dev/
> 
> Thanks to Jassi, Mark and Alyssa for the initial review. I've addressed
> your comments with the following changes:
> 
>  - switched to txdone_irq instead of introducing a new mode
>  - switched to a threaded interrupt handler for receiving messages
>  - added co-processor examples to the device tree binding 
>  - reformatted the register defines and clarified multiple comments
> 
> Best,
> 
> Sven
> 
> Sven Peter (2):
>   dt-bindings: mailbox: Add Apple mailbox bindings
>   mailbox: apple: Add driver for Apple mailboxes
> 
>  .../bindings/mailbox/apple,mailbox.yaml       |  84 ++++
>  MAINTAINERS                                   |   3 +
>  drivers/mailbox/Kconfig                       |  12 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/apple-mailbox.c               | 431 ++++++++++++++++++
>  include/linux/apple-mailbox.h                 |  18 +
>  6 files changed, 550 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  create mode 100644 drivers/mailbox/apple-mailbox.c
>  create mode 100644 include/linux/apple-mailbox.h
> 
> -- 
> 2.25.1
> 
