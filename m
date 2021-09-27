Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA9419D75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhI0Rvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbhI0Rve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:51:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E9C06120F;
        Mon, 27 Sep 2021 10:44:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B7CD8867;
        Mon, 27 Sep 2021 17:43:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B7CD8867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1632764639; bh=ZtnzvOYoJU2QJS7oSLw7U3mGblXZ6NQEMSpDfwmTgqI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aoZAgmTTMm5lD1s5kPvg9Lg1IqmLwITC4VJ6dW660IVZWU3CXlhQURHSKNVC73jwU
         iTQQJjUeigqOdycqBTJCHQwIOrwW+joEr5X8kTPU+56Tip3KWRTFu+Cc3wAA/pT1hA
         rWr+4kT3hWxD1CEyxAuFJk5vW6dAN3WZsU2ejMPf9ht/VehZ6GCh4NEiNfu2GmsAsp
         5iOd3h5iutkzKQub0UREf38/PM587DMaf4j2KM4m7LhFcQhHlBtO5jdSONWwRhKKRe
         nICJYtxy5IxjcOt5zw/QqX/Aq1tdNCs95lyWOat9Ap8e0xrszhAVWE1IxtT5s3QLHZ
         7N5WiD8epPsnw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Utkarsh Verma <utkarshverma294@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Document some more message
 types
In-Reply-To: <20210925201746.15917-1-utkarshverma294@gmail.com>
References: <20210925201746.15917-1-utkarshverma294@gmail.com>
Date:   Mon, 27 Sep 2021 11:43:59 -0600
Message-ID: <875yulj4m8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utkarsh Verma <utkarshverma294@gmail.com> writes:

> Added and documented 3 new message types:
> - UNNECESSARY_INT
> - UNSPECIFIED_INT
> - UNNECESSARY_ELSE
>
> Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 47 ++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

So...when you send multiple patches with the same subject line that's
always a bad sign.  We really want a "git --oneline" listing to give a
good idea of what the patch does, and that depends on more descriptive
subject lines.

In this case, something like:

  docs: checkpatch: add UNNECESSARY/UNSPECIFIED_INT and UNNECESSARY_ELSE

I can fix up these two patches, but please try to keep this in mind for
future work.

(applying the patches now).

Thanks,

jon
