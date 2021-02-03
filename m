Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36630E728
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 00:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhBCXTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 18:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbhBCXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 18:19:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414C3C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 15:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=C6a5mWnA1v0rdG4t+9qcVSQ/M7AZq464m+nT2YCvVzM=; b=UKALTyFZ5psxeLsFS38xxVHVMC
        xlByLGBvTgFdHaxYqaEQVvBem9a1RXN0mTKr8eE6q6wI3D8PrBPWfNEXrP//Q4Jv+vmRmt7uJf47M
        VEUhZ7PI2/I/UA2FxhW2F8niPl92arxkbJzODDax0ZkniLEnnTQzEHKxGU46sR3ZfG5Bp051FTzlV
        uORxgy17nZQ6mzRRPIWDHsC5EjbtAq5D2h+wa9/LPDMvHFXf4zNpnxU29HPj6buHJmXxnH0g5kM2m
        7PEFjibfKF5qZr/6tgQMYP7eFozItlmDsNzvcNvOHbL3TPu8avrya3VqLteGrFBqrrtxHujnnbrYc
        AY0AxK+w==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7RPi-00078S-Mt; Wed, 03 Feb 2021 23:18:23 +0000
Subject: Re: [PATCH v4] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210203223826.21674-1-scott.branden@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ac337905-9bf0-32c6-f98c-5912de1d6655@infradead.org>
Date:   Wed, 3 Feb 2021 15:18:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203223826.21674-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 2:38 PM, Scott Branden wrote:
> Correct compile issue if CONFIG_TTY is not set by
> only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> 
> ---
> Changes since v3:
> - Kconfig cleanups below as per Greg's comments
> - changed if BCM_VK to depends on BCM_VK
> - removed default y in CONFIG_BCM_VK_TTY
> - expanded decription of CONFIG_BCM_VK_TTY
> Changes since v2:
> - add CONFIG_BCM_VK_TTY
> - add function and stub for bcm_vk_tty_set_irq_enabled
> Changes since v1:
> - add function stubs rather than compiling out code
> ---
>  drivers/misc/bcm-vk/Kconfig      | 12 +++++++++
>  drivers/misc/bcm-vk/Makefile     |  4 +--
>  drivers/misc/bcm-vk/bcm_vk.h     | 42 +++++++++++++++++++++++++++++---
>  drivers/misc/bcm-vk/bcm_vk_dev.c |  5 ++--
>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 +++++
>  5 files changed, 61 insertions(+), 8 deletions(-)


-- 
~Randy

