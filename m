Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5342534F4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhC3XE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:04:58 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:55323 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhC3XEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:04:43 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 3332540;
        Tue, 30 Mar 2021 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1617145481;
        bh=a0pxJKLp4kwSgBuAXaf6gCUL1ZiGuvYKdYven1w2R5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvJHkNLSqelGFK0pxm2kZDqUvh6POA51LGFafc7kenK/M3WXW5hDZaBowcPiRfmZN
         Bge/3CZ5uQlTQogNlqHSMlcoK1Yy6WUZydzlzzGopWeIHlctYxJbBqdt9xQoxZaytM
         iJjNSMsIbl3q8ol+JFkh98RodvOxVrXNfTLY3zJI=
Date:   Tue, 30 Mar 2021 18:04:38 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: update for
 aspeed,sirq-active-high
Message-ID: <YGOuhjD19SmjmQou@hatter.bewilderbeest.net>
References: <20210330002338.335-1-zev@bewilderbeest.net>
 <20210330002338.335-3-zev@bewilderbeest.net>
 <20210330223902.GA837825@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210330223902.GA837825@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 05:39:02PM CDT, Rob Herring wrote:
>On Mon, Mar 29, 2021 at 07:23:37PM -0500, Zev Weiss wrote:
>> Update DT bindings documentation for the new incarnation of the
>> aspeed,sirq-polarity-sense property.
>
>Why?
>
>This isn't a compatible change.
>

Ah, sorry -- that was a misunderstanding on my end.  I'll resend a 
compatible v2 shortly.


Zev

