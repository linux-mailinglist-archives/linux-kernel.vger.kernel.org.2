Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8FC35079E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhCaTuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbhCaTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:49:41 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267D3C061574;
        Wed, 31 Mar 2021 12:49:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CA7159A8;
        Wed, 31 Mar 2021 19:49:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CA7159A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617220180; bh=WGvCrSU61Xe816QF3o5rjlAlpM+o7DKv/z+vfTHEN00=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QLI8Oy1Lxp3fxWBv2mpmEbR1BnS+NU/ZFzeZpxEMVTsdWd2Q9956S0dFe0cX+MBXt
         xPVhG6YfCBPyjBBNd+Okz+2JVrQzyshzVrowf1YyR5aEI4KkQpwWmH5TbrKaUNtfUB
         coDfiYvuHSPOzKvwhIUU1I4N3z8ICcEorYJkdxVbhxDhB9AoZJ/xpJLVU6nBJkiWZU
         YbLiNmVPqalutadIkC4dln8QaDe8lblDmGPyD3Ti1/alGdqPR9nGW3gaV6Kn8HeW1D
         yvcpUo82VIQ6j4WXsqugJVzvcnkqZdWiGHhf+VK40rZnC1VfWLJKSz9zJcCFeTzYPG
         cg28b+yLdS0HA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark O'Donovan <shiftee@posteo.net>
Subject: Re: [PATCH] Documentation: Add leading slash to some paths
In-Reply-To: <20210328152837.73347-1-shiftee@posteo.net>
References: <20210328152837.73347-1-shiftee@posteo.net>
Date:   Wed, 31 Mar 2021 13:49:40 -0600
Message-ID: <87czvfksrv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark O'Donovan <shiftee@posteo.net> writes:

> Change multiple sys/xyz to /sys/xyz
>
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>  Documentation/admin-guide/mm/numaperf.rst |  2 +-
>  Documentation/fb/fbcon.rst                |  4 ++--
>  Documentation/hid/intel-ish-hid.rst       |  2 +-
>  Documentation/leds/leds-lm3556.rst        | 28 +++++++++++------------
>  4 files changed, 18 insertions(+), 18 deletions(-)

Makes sense ... applied, thanks.

jon
