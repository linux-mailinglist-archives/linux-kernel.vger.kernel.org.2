Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C894309038
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhA2WmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbhA2Wl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:41:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40710C061756
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=aAYh3DP2zUjQJpT017dM88kX0zMM6n0co2EoHcZKDkE=; b=iB/D4YZabpcr/vEeQT0kZDHmDu
        jrh+Ns4evZ6+mhr5VKjDlIZEGffecW08Q4ntrkFNm5mfWHwPTjI2j3A6gbtt8Elj6v/As1BnhumSW
        NkcUJhjU4sziN3ibf/cY1VVxoXLSHdSjK9YnqA+wgQe4YXYvBjRVrWgVg7S+R1xv+cju0xft2PWk4
        8XZP+gfBaJzD8xGt10uQOLJWmYQLsnDSrXPnzVZLYls+WGuOVmm5ZqEaISn8LElm/OVsAr3PHmVlt
        qPX/Dg7qK0rPQRy7TY0BrbzMV+Q7RIhyIUOufQwyUd1QoWR5MxhY+VhwMDZdywNe43mPSLWUYu76U
        /PPusSSg==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5cRz-0004WG-JB; Fri, 29 Jan 2021 22:41:11 +0000
Subject: Re: [PATCH v2] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210129220627.22641-1-scott.branden@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f47f2cc-dcea-0734-6d58-fb38d120eed3@infradead.org>
Date:   Fri, 29 Jan 2021 14:41:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210129220627.22641-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 2:06 PM, Scott Branden wrote:
> Correct compile issue if CONFIG_TTY is not set by
> only adding ttyVK devices if CONFIG_TTY is set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> 
> ---
> Changes since v1:
> Add function stubs rather than compiling out code
> ---
>  drivers/misc/bcm-vk/Makefile     |  4 ++--
>  drivers/misc/bcm-vk/bcm_vk.h     | 35 +++++++++++++++++++++++++++++---
>  drivers/misc/bcm-vk/bcm_vk_dev.c |  3 +--
>  drivers/misc/bcm-vk/bcm_vk_tty.c |  6 ++++++
>  4 files changed, 41 insertions(+), 7 deletions(-)

Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


-- 
~Randy

