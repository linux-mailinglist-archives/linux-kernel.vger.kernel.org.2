Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F93E11CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhHEKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:01:35 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:54101 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbhHEKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:01:34 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5E97222178;
        Thu,  5 Aug 2021 12:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1628157675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NGYQwVfxVHDz/GJP5VhlEpV2kLC+JAURoiNTdFYD0U=;
        b=j0GLLYEHjV9mmnzOhCJNLunL5n+2AKjGOsszlIeVirXoQimXjrd8myjG8+OVFnCLakRZHY
        Pew2sgK+eFe4bizwtTY5q+g+tRMSnqecimOfZywxhxhH+x4/tSRk2Watt2RIhA0rwErcE0
        5FLdX/eA+sl+6DmehYjnA1MVGPOtUgA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Aug 2021 12:01:15 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH v2 1/1] mfd: simple-mfd-i2c: Add support for registering
 devices via MFD cells
In-Reply-To: <20210805085611.864188-1-lee.jones@linaro.org>
References: <20210805085611.864188-1-lee.jones@linaro.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ce1b71f317bff2dbcbf558e989b76087@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-08-05 10:56, schrieb Lee Jones:
> More devices are cropping up requiring only Regmap initialisation and
> child registration functionality.  We currently only support that if
> all required devices are represented by their own Device Tree nodes
> complete with compatible strings.
> 
> However, not everyone is happy with adding empty nodes that provide no
> additional device information into the Device Tree.
> 
> Rather than have a plethora of mostly empty, function-less drivers in
> MFD, we'll support those simple cases in here instead via MFD cells.
> 
> Cc: Michael Walle <michael@walle.cc>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Alistair Francis <alistair23@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Tested-by: Michael Walle <michael@walle.cc>

-michael
