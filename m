Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA6430471
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbhJPTTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:19:04 -0400
Received: from rosenzweig.io ([138.197.143.207]:47016 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232336AbhJPTTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:19:02 -0400
Received: by rosenzweig.io (Postfix, from userid 1000)
        id DA8B341012; Sat, 16 Oct 2021 19:16:53 +0000 (UTC)
Date:   Sat, 16 Oct 2021 19:16:53 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mailbox: apple: Add driver for Apple mailboxes
Message-ID: <YWslJRVQLraWE+Mu@rosenzweig.io>
References: <20210916154911.3168-1-sven@svenpeter.dev>
 <20210916154911.3168-3-sven@svenpeter.dev>
 <CABb+yY2XxpQa-QqsVnzVsYb+msSiOiELE1R5UFjE02Diwww2Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY2XxpQa-QqsVnzVsYb+msSiOiELE1R5UFjE02Diwww2Ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +struct apple_mbox_msg {
> > +       u64 msg0;
> > +       u32 msg1;
> > +};
> > +
> Aren't msg0/1 the Tx and Rx channels? If so you may want to separate
> them out as such. But of course, I don't know the h/w details so I may
> be wrong.

AIUI -- It's a 96-bit message (msg0 is general purpose, msg1 is used for
dispatch). This goes for both RX and TX.
