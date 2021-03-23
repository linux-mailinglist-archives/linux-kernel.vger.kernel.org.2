Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8B345A39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCWJAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:00:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52130 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCWJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:00:10 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOctI-0005pI-7e; Tue, 23 Mar 2021 08:59:56 +0000
Date:   Tue, 23 Mar 2021 09:59:55 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     akpm@linux-foundation.org, thomascedeno@google.com,
        daniel.m.jordan@oracle.com, tglx@linutronix.de,
        Nicolas.Viennot@twosigma.com, walken@google.com,
        viro@zeniv.linux.org.uk, krisman@collabora.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] kernel/sys.c: Fix a typo
Message-ID: <20210323085955.shlga46qv2kgoh5b@wittgenstein>
References: <20210323011909.311567-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323011909.311567-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 06:49:09AM +0530, Bhaskar Chowdhury wrote:
> 
> s/concurent/concurrent/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---

Looks good,
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
