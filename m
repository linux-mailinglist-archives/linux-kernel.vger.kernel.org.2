Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC63C6108
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhGLQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:42870 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234569AbhGLQ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:00 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9E96836E;
        Mon, 12 Jul 2021 16:56:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9E96836E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626108971; bh=aNm9NX0hfUyaIkr9HuU7I5L73M9duZwZgsBGvD4Cdnk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=od8ajVH6X5NNGtPgI7wf8C4KUzTpnArTUGsiq/oj5RyJgUICtPk4IncJDYBKhU6cz
         71T9ucCL4Wp5g2IGzKtUXqv/fv8Dzh23h1nx5tNtCcm4hymnLQEdEWLq+9Pb5/UJFE
         YrByVr2jv/AhEU5vbnZjpwU4NV1n91pEB03rK5Iwo/p5/8O351IK2ncdeLcsHPmOKP
         4TJ74vZV1inmZmEvii2cGlwowq4uMK0Co2ci1TKsWcEzwXtmInHyVhqUboFkDMC31y
         0ToVjR0KLgXy69x4cGPSqcDaA/2IQicvD/xQ6MzUS3NWhjrCTRHQBSuA/v1fIByJBQ
         iDxodHs9p20Mw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add few missing models and
 documentation files
In-Reply-To: <20210625215437.2156-1-pali@kernel.org>
References: <20210625215437.2156-1-pali@kernel.org>
Date:   Mon, 12 Jul 2021 10:56:11 -0600
Message-ID: <87zgurpj2s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied, thanks.

jon
