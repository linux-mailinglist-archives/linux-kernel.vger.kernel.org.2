Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7315F4077D8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhIKNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:20:51 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:65488 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhIKNRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:17:42 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 56793741;
        Sat, 11 Sep 2021 15:16:19 +0200 (CEST)
Date:   Sat, 11 Sep 2021 15:16:19 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     jassisinghbrar@gmail.com, sven@svenpeter.dev, robh+dt@kernel.org,
        marcan@marcan.st, alyssa@rosenzweig.io,
        mohamed.mediouni@caramail.com, stan@corellium.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210907145501.69161-3-sven@svenpeter.dev> (message from Sven
        Peter on Tue, 7 Sep 2021 16:55:00 +0200)
Subject: Re: [PATCH 2/3] dt-bindings: mailbox: Add Apple mailbox bindings
References: <20210907145501.69161-1-sven@svenpeter.dev> <20210907145501.69161-3-sven@svenpeter.dev>
Message-ID: <5614518fc7343342@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sven Peter <sven@svenpeter.dev>
> Date: Tue,  7 Sep 2021 16:55:00 +0200
> 
> Apple mailbox controller are found on the M1 and are used for
> communication with various co-processors.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../bindings/mailbox/apple,mailbox.yaml       | 81 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
