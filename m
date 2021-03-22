Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CE03445A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhCVNYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:24:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50913 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhCVNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:23:31 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOKWZ-00010X-8A; Mon, 22 Mar 2021 13:23:15 +0000
Date:   Mon, 22 Mar 2021 14:23:14 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     vgupta@synopsys.com, akpm@linux-foundation.org,
        keescook@chromium.org, shorne@gmail.com, walken@google.com,
        viro@zeniv.linux.org.uk, jhubbard@nvidia.com,
        daniel.m.jordan@oracle.com, tsbogend@alpha.franken.de,
        peterx@redhat.com, axboe@kernel.dk,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] arcc/kernel/process: Few mundane typo fixes
Message-ID: <20210322132314.mtky3gx2oqqucoob@wittgenstein>
References: <20210322125155.3401540-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322125155.3401540-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:21:55PM +0530, Bhaskar Chowdhury wrote:
> s/defintion/definition/
> s/succeded/succeeded/
> s/commiting/committing/
> s/interrutps/interrupts/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---

Since you aim to be mirroring the path arc/kernel/process there's a typo
in the patch subject :)
s/arcc/arc/

otherwise

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
