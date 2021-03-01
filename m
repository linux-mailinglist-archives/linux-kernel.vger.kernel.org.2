Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015EA327D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbhCALfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:35:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39974 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhCALdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:33:54 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lGgnM-0001QG-CE; Mon, 01 Mar 2021 11:33:00 +0000
Date:   Mon, 1 Mar 2021 12:32:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Cedeno <thomascedeno@google.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Michel Lespinasse <walken@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Return -EFAULT if copy_to_user() fails
Message-ID: <20210301113259.wpqmjutdhw6thzku@wittgenstein>
References: <1614598093-1188-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1614598093-1188-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 07:28:11PM +0800, Wang Qing wrote:
> The copy_to_user() function returns the number of bytes remaining to be
> copied, but we want to return -EFAULT if the copy doesn't complete.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Hey Wang,

Thanks for the patch. It looks like override_release() is called in
three places and all three places return -EFAULT correctly. They simply
treat any as EFAULT. So not sure this change buys us anything.

Christian
