Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7C4501BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhKOJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhKOJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:53:21 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74CAC061200;
        Mon, 15 Nov 2021 01:50:20 -0800 (PST)
Received: from localhost (unknown [151.82.209.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B7F71723;
        Mon, 15 Nov 2021 09:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B7F71723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636969819; bh=0oEmBIb8tog6brnSAATJ3G4wgAbmHoGDxkTOs9L3SNc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TQlNtaNrbawWPqV14lxhRz6lgaXlSYDmE8K8BvHnf9Oa5zyAKtxkEb7gPU3olWVZi
         44mVbKqeC4p+WEZJivS5kkObVgLYxvvUat/aeKgyVNqxJ88Ugwh83ThRAO+rmC1JcY
         kRyFVW5jCNwP5/8AwzGnTs8Mp2jR+VwPwX9u/S3DSBhYV9vjz6VyfF36YWAyU3XakO
         6+YZ66fA9GSjL9qUdyVWQFV49VD6MLwXLCu5+j+Q04WR78HZfEF4VpQiHPHdICr5rw
         rDrZBVjGs48VNMMOjACJdd5hqGpmPmzKmgrc0JG87upxRIQmS7/6jmFuWBHNTO9QJq
         QiCvYRzgl9zNQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: arm: marvell: Add some links to
 homepage / product infos
In-Reply-To: <20211008160105.24225-1-pali@kernel.org>
References: <20211008160105.24225-1-pali@kernel.org>
Date:   Mon, 15 Nov 2021 02:50:15 -0700
Message-ID: <871r3hn3xk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Webarchive contains some useful resources like product info or links to
> other documents.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 7 +++++++
>  1 file changed, 7 insertions(+)

I have applied this set, thanks.

jon
