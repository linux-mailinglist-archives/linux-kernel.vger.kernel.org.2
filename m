Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8640B99F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhINVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhINVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:09:16 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9ECC061574;
        Tue, 14 Sep 2021 14:07:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1610B2CA;
        Tue, 14 Sep 2021 21:07:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1610B2CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631653679; bh=zhCzyOF3lYqBc1BvpA96ITkuEpoRG8iCvc+4y4xPfQ0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AAVsaxbzyQihf3w4oIMl14whE6GlJ3hvVaTVC+FyfUdw5NNnxAbOevuys/s+opr+S
         h7StVlVESBiRus5Q591hiGDJp9HVwtyim26JKgobMxdOt0oj/hQ1uVNhaXR7c2Qjf2
         3JJo6rWlGSKUhQtyntuovU/MNne7kIPNuq99EL1Xgxv8SLDjzE+jKVoxGymkaTLwa3
         iF1rtLjPVFezEx3/NixscIkxO2INGi7UpozUB6V6EAV9zksTz0LhHHFnDnBivV2cFf
         uu/w7xLw7kD1Ia5l+O8loiimwWDGi9tbQoEXOs674eSqmYiD+V7B1aMyMHPKB0kJe0
         XLvgMd0NaCdeA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Add TRAILING_SEMICOLON message
In-Reply-To: <20210904074201.13532-1-utkarshverma294@gmail.com>
References: <20210904074201.13532-1-utkarshverma294@gmail.com>
Date:   Tue, 14 Sep 2021 15:07:58 -0600
Message-ID: <87ilz2dfwx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utkarsh Verma <utkarshverma294@gmail.com> writes:

> Add a new message type TRAILING_SEMICOLON for the macro definitions
> that conclude with a semicolon.
>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied, thanks.

jon
