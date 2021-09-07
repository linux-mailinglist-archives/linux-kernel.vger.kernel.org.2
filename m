Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF2A402E99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242482AbhIGS6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:58:25 -0400
Received: from rosenzweig.io ([138.197.143.207]:46204 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237636AbhIGS6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:58:23 -0400
Date:   Tue, 7 Sep 2021 14:56:46 -0400
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
Subject: Re: [PATCH 2/3] dt-bindings: mailbox: Add Apple mailbox bindings
Message-ID: <YTe17jGBobarePaK@sunset>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <20210907145501.69161-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907145501.69161-3-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +      - description:
> +          M3 mailboxes are an older variant with a slightly different MMIO
> +          interface still found on the M1.
> +        items:
> +          - const: apple,t8103-m3-mailbox

Would be nice to document an example of where an M3 mailbox is found.

> +  interrupts:
> +    minItems: 4
> +    items:
> +      - description: send fifo is empty interrupt
> +      - description: send fifo is not empty interrupt
> +      - description: receive fifo is empty interrupt
> +      - description: receive fifo is not empty interrupt
> +
> +  interrupt-names:
> +    minItems: 4
> +    items:
> +      - const: send-empty
> +      - const: send-not-empty
> +      - const: recv-empty
> +      - const: recv-not-empty

If the names became not-constant the asprintf thing goes away, not sure
that's better or worse.

> +  clocks:
> +    description:
> +      Reference to the clock gate phandle(s) if required for this mailbox.
> +      Optional since not all mailboxes are attached to a clock gate.

Do we do anything with the clocks at this point?
