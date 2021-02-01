Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D793A30A04E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBACQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhBACQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:16:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A498C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=QGcjppTN2Wzjw2RWxSNHHSSECmYgRKFWpAn4s71PM7Q=; b=KHlBcGl0S7vqgMrMK/BZ9fKs78
        oRY8p6l/9RqPsqdjQP+ryPtLdugzKGVi+1//f1Fy/kkHw3I3Cm7dzbhUtF97Y1W2+YB6Gkx4KUqvI
        nxjvYff2+sxqHPVewTbRWNXnTd6RsRa27y/1DA+J+4I1JQ5SbS9ETF947murOzcNbLr0UO53S+cEu
        BcYiCInBqouZGXa+496tC/Xuxo/cIKY0zYJbs/YmKdivcFpFZfDgh0nq0D5k5IEsBHiiypoQ1ZqkK
        xQ+xJ7/edt3G+HTStpmBK+ULFQWLGvcu2fGgogPzkenVCYqsKRP1/edgTe8IxcLb5Bzv6B6yjKJ9K
        qKEhPiJg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6Okx-0005wf-49; Mon, 01 Feb 2021 02:15:59 +0000
Subject: Re: [PATCH v3] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210131233049.5500-1-scott.branden@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cd57b586-9dad-f135-a344-0788826906dc@infradead.org>
Date:   Sun, 31 Jan 2021 18:15:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210131233049.5500-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/21 3:30 PM, Scott Branden wrote:
> Correct compile issue if CONFIG_TTY is not set by
> only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> ---
> Changes since v2:
> - add CONFIG_BCM_VK_TTY
> - add function and stub for bcm_vk_tty_set_irq_enabled
> Changes since v1:
> - add function stubs rather than compiling out code
> ---
>  drivers/misc/bcm-vk/Kconfig      | 16 ++++++++++++
>  drivers/misc/bcm-vk/Makefile     |  4 +--
>  drivers/misc/bcm-vk/bcm_vk.h     | 42 +++++++++++++++++++++++++++++---
>  drivers/misc/bcm-vk/bcm_vk_dev.c |  5 ++--
>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 +++++
>  5 files changed, 65 insertions(+), 8 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.


-- 
~Randy

