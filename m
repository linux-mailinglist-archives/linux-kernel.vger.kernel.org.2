Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79A3349886
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCYRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhCYRo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:44:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C912C06174A;
        Thu, 25 Mar 2021 10:44:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 03542381;
        Thu, 25 Mar 2021 17:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 03542381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1616694299; bh=UmX4fxnLTsCNtAx7oSZYP5/ZUbxnYjDlfu+ot5Zo33I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Aei4qbS/b8S5NTMhvOi7FMO4OVVsbbV+43glmO77UyXHQjPM9vTIITkt7J4+oLm1M
         qNPjvfhPHApU66Bj7W5Cbwt8NF3bbY86TkCsuPS1I8g0Y/yMtPPGStJ2Qp0C1GjvF6
         S2AJB8MtsYN+1+FaO3Zqy3RaYDVyWxKzn3xOtFxiR620PN7wVNtNrxOpneYAeNWJmZ
         8cQpt2ZteYzHvid11zzyPb1MKiVxKeVETSj/QY+QRjle49kCY9GOqpR6ClnSPhfKua
         O/Yl/tQgkmPv0wtkfBth3vuljGZLbPyhjiFODdix7l8TqVtom8DOifyT9H78Dxnh3D
         FTnp5dUF49jQw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] docs/kokr: make sections on bug reporting match practice
In-Reply-To: <20210308075701.23411-1-sj38.park@gmail.com>
References: <20210308075701.23411-1-sj38.park@gmail.com>
Date:   Thu, 25 Mar 2021 11:44:58 -0600
Message-ID: <871rc32kmd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj38.park@gmail.com> writes:

> From: SeongJae Park <sjpark@amazon.de>
>
> Translate this commit to Korean:
>
>     cf6d6fc27936 ("docs: process/howto.rst: make sections on bug reporting match practice")
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/translations/ko_KR/howto.rst | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied, thanks, sorry for the delay.

jon
