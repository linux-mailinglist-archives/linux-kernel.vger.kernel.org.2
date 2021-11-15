Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A654501C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhKOJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:57:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:53440 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhKOJ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:57:09 -0500
Received: from localhost (unknown [151.82.209.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2420B723;
        Mon, 15 Nov 2021 09:54:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2420B723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1636970050; bh=WkCQpNM829IFoODGXR5mweTH+GdBORupVvAx7iX2YLo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=U4DOOFennzPlkzCLmyk8jG524MRB2aYnYH4Tc257yobEb3fSlNfcPhDO04wjOuLQJ
         2RZkQ9Mho+DV+V3eCbEjcwNi9c9zAIRl6PpFjkBitbIhK+uFM9Strr2dLh0X2ghvXy
         RKnrveXMGxLTeuZRq5Apm/o7kKwi7ni75OyMt7m42BkL5n8NIRuYczWjqon4D5dmpF
         24XfSerehsLU079tiub5CSYHhwTgibpi/LblIv2b3fv/M4+knYehwLttLYSnP3PS+1
         zyrQEVA7sdPX3JLODhtrBxzjQPsE3pBi64z+CwUP/PVE4cyKkghLXKHchE4O+tmK13
         DcBrZDgGllSAw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Xinyong Wang <wang.xy.chn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc/zh_CN: fix a translation error in management-style
In-Reply-To: <20211110120213.134313-1-alexs@kernel.org>
References: <20211110120213.134313-1-alexs@kernel.org>
Date:   Mon, 15 Nov 2021 02:54:05 -0700
Message-ID: <87sfvxlp6q.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alexs@kernel.org writes:

> From: Alex Shi <alexs@kernel.org>
>
> 'The name of the game' means the most important part of an activity, so
> we should translate it by the meaning instead of the words.
>
> Suggested-by: Xinyong Wang <wang.xy.chn@gmail.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net> 
> Cc: linux-doc@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  Documentation/translations/zh_CN/process/management-style.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
