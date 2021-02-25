Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9470732556B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhBYS1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:27:19 -0500
Received: from ms.lwn.net ([45.79.88.28]:34608 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhBYS1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:27:17 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A79E76D6;
        Thu, 25 Feb 2021 18:26:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A79E76D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614277595; bh=bUQncvD/3vtCnEnGcjbOS2DrgvpDXQ2TxaxApV80onY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=by0elyzU8gYcl2P6kSwoeEDbjoIxP6ZNQSo5anORth5HqlRRpPldNwQPOaqvoJ9F4
         mwQ/Poq4hkSQ9GWvwivQrgyr6U6ucbEF4y8PatZMBNoc0LmYpK/YzoIBg/eG0UfHXv
         6N/uXWyqru5ch3xHQh7rjnJXxI4bXCAWZAN9xdj3nRWGy0byY/ANvXia0JVqVz7srQ
         kEa9xag4wNAgDOyOFdKqypUEFsBeV3b0FCm7d40ZVsYGkr2I0hy3Aqjf8dnwVURdpj
         WwqZhC0GWIUMxo2ySF/yxBFg94e2ulhNdky0iEOF0xmwHF2AbBx+S0iYACJsv2Ni29
         IOtu/uGkUucEw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: features: remove c6x references
In-Reply-To: <20210225142841.3385428-1-arnd@kernel.org>
References: <20210225142841.3385428-1-arnd@kernel.org>
Date:   Thu, 25 Feb 2021 11:26:35 -0700
Message-ID: <87tuq0c8bo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The references to arch/c6x are obsolete now that the architecture
> is gone. Remove them.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Both applied, thanks.

jon
