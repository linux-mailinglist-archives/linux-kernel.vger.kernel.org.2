Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B0B383B98
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbhEQRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:50:27 -0400
Received: from ms.lwn.net ([45.79.88.28]:48018 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235250AbhEQRu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:50:26 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3614F2E7;
        Mon, 17 May 2021 17:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3614F2E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621273749; bh=iWmm4hnq2CtqA3pXgnL0gun99p0HjfnwoUQ5bnL5xUw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dh6l9slO5Rjlx2Alqras6Ho1QBga++8vMcOzhoQq+BQYowEF3ttjETzhETTjfdVmQ
         z0UxwlG29pu7+czVO5o40Airn26gLaKCDwcCOfHtUMPh75ZoQ30WvmKu8xB1X064tf
         MGTqEPO4GK0YVwV7Ril2VTX3kyaVRFgPD0wVVKMIbYSNnuGGFLEMpskVswlDQ0EhfX
         DW2E6tbY2VfINtDO4FIjpYs500ukh0XkVb4NXfcmHrLe9NjgkclljQuDiVfc2Cnekk
         eOiuU3zgf7sN8CqdSD9gEgURb6Q1V2Xr2PkaW6KFhhWuzu+cT9XePDAPhwrnNVMXsX
         X/2KK8OeVnODQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, willy@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4] scripts: kernel-doc: reduce repeated regex expressions
 into variables
In-Reply-To: <20210514144244.25341-1-yashsri421@gmail.com>
References: <87bl9ujy2r.fsf@meer.lwn.net>
 <20210514144244.25341-1-yashsri421@gmail.com>
Date:   Mon, 17 May 2021 11:49:08 -0600
Message-ID: <878s4d45ez.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Srivastava <yashsri421@gmail.com> writes:

> There are some regex expressions in the kernel-doc script, which are used
> repeatedly in the script.
>
> Reduce such expressions into variables, which can be used everywhere.
>
> A quick manual check found that no errors and warnings were added/removed
> in this process.
>
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> Changes in v4:
> - Fix htmldocs warning at function parsing, involving repeated $type2 identifiers capture
> - Re-tested against all files in kernel tree

Applied, thanks for stickint with this.

jon
