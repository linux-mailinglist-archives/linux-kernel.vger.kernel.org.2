Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB6E3D5A14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhGZM3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:29:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:58238 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhGZM3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:29:31 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 88769221;
        Mon, 26 Jul 2021 13:09:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 88769221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627304999; bh=YZy8cXLHkI0qJXaQSj8Qj3Db4h+IONtrKMhuPakS2Hc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XYsYCuba71EUWtWxaby68szrqy91oYNBppFKxEjBByWV6QMxtztD72btP7+78YIQh
         FwXQExObNDcxLTzguqxEz+u1BhgsHKUCqTP6xRuGKhDCEKO9GnOTTb92cHLaqc3mGk
         Nlk+JAh/lAvrkYTbZ7AUWi20qh//6Z6UcWrG2aEfmZhyXnJcW8RiuPNJ3XLqKYJIID
         kcK+uLvr4WCMTjnIFAfowI/ev3xkvNGDwzhgYwgppO62HqtO3vPMEVI/VhoHKFdl9v
         lckYow7LT8KFM9OKhcnl2s+pUNAhQqd8RLLQaX3ekWemXPDaDn9XlK/Gv6ZC7+deVD
         EMbQoKT9KJh5w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     cgel.zte@gmail.com, siyanteng@loongson.cn, sterlingteng@gmail.com
Cc:     alexs@kernel.org, yang.yang29@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3] docs/zh_CN: Add zh_CN/accounting/psi.rst
In-Reply-To: <20210726030909.508645-1-yang.yang29@zte.com.cn>
References: <20210726030909.508645-1-yang.yang29@zte.com.cn>
Date:   Mon, 26 Jul 2021 07:09:59 -0600
Message-ID: <87fsw1te54.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:

> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Add translation zh_CN/accounting/psi.rst and zh_CN/accounting/index.rst.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Reviewed-by: Jonathan Corbet <corbet@lwn.net>

I have not reviewed this patch or offered that tag, why have you put it
there?  Never add a Reviewed-by that has not been explicitly given by
the reviewer.

jon

