Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67503410B70
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhISMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:03:47 -0400
Received: from rosenzweig.io ([138.197.143.207]:46640 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231921AbhISMDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:03:35 -0400
Date:   Sun, 19 Sep 2021 07:51:17 -0400
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
Subject: Re: [PATCH v2 2/2] mailbox: apple: Add driver for Apple mailboxes
Message-ID: <YUckNbQwfD4X2PA7@sunset>
References: <20210916154911.3168-1-sven@svenpeter.dev>
 <20210916154911.3168-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154911.3168-3-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define APPLE_ASC_MBOX_CONTROL_FULL  BIT(16)
> +#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
...
> +#define APPLE_M3_MBOX_CONTROL_FULL  BIT(16)
> +#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)

It might make sense to combine these to just

> +#define APPLE_MBOX_CONTROL_FULL  BIT(16)
> +#define APPLE_MBOX_CONTROL_EMPTY BIT(17)

..unless we have a reason to think the status bits otherwise differ.

Regardless of that minor nit, this is

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
