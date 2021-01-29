Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF192308652
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhA2HSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhA2HSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:18:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4014C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nAnTETMHcfweHl7T4+bq1hybnR4BA4pB1t2JYrikVAk=; b=KS95H98dWPeHViBs1Z6WwzGCFO
        CTZBeyqLXhKw1cPWie38D9LoqDVH1DFrQ22pXi1yOwt5U3R8Qrgy7lIX+AjJ93EzMjFiZxsdH9Cgx
        rfP/mxCOo+v0Uq5lSknEiLvmdDtql2WKeEucP/PPodOXQKXxGIwAW2NXzjmVnSrFFvnqA3gwQ7fmz
        gG0AUjM9hVSsgPRB2FuSWekhC886QUDJyw7pJvJmD9neAg/IkCWox3q5jbx6mOQr5L8JXFYfGAycJ
        ru70Yq8twQsxnTiiZWppvpfnVQAKqYJer+htJiWBBZYsyHglvJ6UxZ0msCtKXnWV6Y6HKsFzr+K6f
        VGp/Q5TQ==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l5O1s-00014O-Fd; Fri, 29 Jan 2021 07:17:16 +0000
Subject: Re: [PATCH] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
To:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
References: <20210129060443.14864-1-scott.branden@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <90a4fb55-3ecc-cdcd-2884-1f65062d139c@infradead.org>
Date:   Thu, 28 Jan 2021 23:17:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210129060443.14864-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 10:04 PM, Scott Branden wrote:
> Correct compile issue if CONFIG_TTY is not set by
> only adding ttyVK devices if CONFIG_TTY is set.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/misc/bcm-vk/Makefile     |  4 ++--
>  drivers/misc/bcm-vk/bcm_vk_dev.c | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.
-- 
~Randy

