Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129044501A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhKOJwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:52:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:53438 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230405AbhKOJvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:51:38 -0500
Received: from localhost (unknown [151.82.209.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B7ABE845;
        Mon, 15 Nov 2021 09:48:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B7ABE845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636969704; bh=nvxcqwbMIaHIovfgqQD9sYW8j7wUwBH460Gw8oZIciA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BUUG8RM+0aOhgKVsMhQjlZaCUdGkuCU7g4QdrT1O1RadArcXEg42ncziN40IHmNET
         uAtbXaegrkzKud0J55thgLVAJm079FKgLS71OMqy4hStm4R7cT3NO8Uo9xsRN1nXoD
         Tqu2qd74DPDe9V1iX7kRwzSiZj7Ha7nSpeGgukmf3mrVw/v+fNRbCK4+5Aunps9TTb
         Y5fAFVcpb+NoWzp06HbLM1UNBFPxKyH8YfpqcvCqbq7hMuNuiq6bbe4SdM7gRNBD5N
         g8jDOoo+rC851P8m3PLU/57GGodxHTPrBtz98W21KIuExDPMEjQ3JKDiYyt0c6KHv0
         3+2ACVUvBUytg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Update Sphinx requirements
In-Reply-To: <2c704ddd-2da2-138b-4928-890e92b66f9f@gmail.com>
References: <2c704ddd-2da2-138b-4928-890e92b66f9f@gmail.com>
Date:   Mon, 15 Nov 2021 02:48:19 -0700
Message-ID: <875ystn40s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Subject: [PATCH] docs: Update Sphinx requirements
>
> Commit f546ff0c0c07 ("Move our minimum Sphinx version to 1.7") raised
> the minimum version to 1.7.
>
> For pdfdocs, sphinx_pre_install says:
>
>     note: If you want pdf, you need at least Sphinx 2.4.4.
>
> , and current requirements.txt installs Sphinx 2.4.4.
>
> Update Sphinx versions mentioned in docs and remove a note on earlier
> Sphinx versions.

It may be time to consider raising the minimum sphinx version
overall...  meanwhile, though, I've applied this, thanks.

jon
