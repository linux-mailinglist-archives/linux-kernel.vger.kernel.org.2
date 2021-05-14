Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6007D380FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhENSac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhENSab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:30:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6694561442;
        Fri, 14 May 2021 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621016960;
        bh=7Rxzqbp9zx/CR6YJmm0t2HgR3O+2xjtDuDGUkpxonvU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tXUuvnKNYt6ogg+Zrg5ozgoGzCOEnODIzSMGsvm8iY+ju6dubP+7iYuQoEISYmJyn
         so4rLbvFvF/5S7fiQnO5jXfAtFmSDV4btsQfL5vGpLsSUsQMza1TIyntT3DDd1N/5s
         zVKDugctkRT3TgldWl5cJRC9A1RFq+WuXH3tvZPL7sKQ5a00c3MT5JQdbP+4EUPxg8
         CxodPO+WQE0Rgmys74B9XPUhDgsabASGCfTmcQPxynTUy1MzqHVwyUb4ljwenAOKhX
         +FKBPUI8+fFdTngYGFhdwwd3LsdPYYaQZ7RA7QiomlgpM7oe0tjsToYTzsi7ztsdhZ
         C6kBUHRko2P2w==
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     Arnd Bergmann <arnd@kernel.org>, Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210514140015.2944744-1-arnd@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <0ad11966-b286-395e-e9ca-e278de6ef872@kernel.org>
Date:   Fri, 14 May 2021 11:29:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514140015.2944744-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2021 7:00 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang points out that an initcall funciton should return an 'int':
> 
> kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
> late_initcall(kcsan_debugfs_init);
> ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
>   #define late_initcall(fn)               __define_initcall(fn, 7)
> 
> Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For the record, this requires CONFIG_LTO_CLANG to be visible.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   kernel/kcsan/debugfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index c1dd02f3be8b..e65de172ccf7 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -266,9 +266,10 @@ static const struct file_operations debugfs_ops =
>   	.release = single_release
>   };
>   
> -static void __init kcsan_debugfs_init(void)
> +static int __init kcsan_debugfs_init(void)
>   {
>   	debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
> +	return 0;
>   }
>   
>   late_initcall(kcsan_debugfs_init);
> 

