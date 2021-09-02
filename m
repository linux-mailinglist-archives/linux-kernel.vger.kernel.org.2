Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF53FF195
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbhIBQi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:38:27 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:42410 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346398AbhIBQiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:38:25 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 1B5E0821A0;
        Thu,  2 Sep 2021 19:37:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630600646;
        bh=/Vc4FLhSkksqr+H2ybhe9q6KfMyJY35ZtSabsZexfnQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A8PquZcBh9qeio7WXRBSlqcfJc+ZgPlDcXuoAeeCRUKm4ohAKjkrnIKT9gzv6b0ST
         r1OrtOBrDjf+JvQUG7IpmG66fcZ8kXsUvmSJfNXGI8oFaOzF7Y+YK+xme4wRnoumGH
         IU3T8yqt21omIpgk+Qk80hndR7ey9TtEZKveF44g=
Received: from [192.168.211.59] (192.168.211.59) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 2 Sep 2021 19:37:25 +0300
Subject: Re: [PATCH] fs/ntfs3: Change how module init/info messages are
 displayed
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>
References: <20210829144239.58213-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <8c05acf1-b6eb-09b0-e4ea-e9d3c6343545@paragon-software.com>
Date:   Thu, 2 Sep 2021 19:37:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829144239.58213-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.59]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.08.2021 17:42, Kari Argillander wrote:
> Usually in file system init() messages are only displayed in info level.
> Change level from notice to info, but keep CONFIG_NTFS3_64BIT_CLUSTER in
> notice level. Also this need even more attention so let's put big
> warning here so that nobody will not try accidentally use it.
> 
> There is also no good reason to display internal stuff like binary tree
> search. This is always on option which can only disabled for debugging
> purposes by developer. Also this message does not even check if
> developer has disabled it or not so it is useless info.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  fs/ntfs3/super.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 17ee715ab539..7895039cf673 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1430,21 +1430,14 @@ static int __init init_ntfs_fs(void)
>  {
>  	int err;
>  
> -	pr_notice("ntfs3: Index binary search\n");
> -	pr_notice("ntfs3: Hot fix free clusters\n");
> -	pr_notice("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
> +	pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
>  
> -#ifdef CONFIG_NTFS3_FS_POSIX_ACL
> -	pr_notice("ntfs3: Enabled Linux POSIX ACLs support\n");
> -#endif
> -#ifdef CONFIG_NTFS3_64BIT_CLUSTER
> -	pr_notice("ntfs3: Activated 64 bits per cluster\n");
> -#else
> -	pr_notice("ntfs3: Activated 32 bits per cluster\n");
> -#endif
> -#ifdef CONFIG_NTFS3_LZX_XPRESS
> -	pr_notice("ntfs3: Read-only lzx/xpress compression included\n");
> -#endif
> +	if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
> +		pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
> +	if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
> +		pr_notice("ntfs3: Warning: Activated 64 bits per cluster. Windows does not support this\n");
> +	if (IS_ENABLED(CONFIG_NTFS3_LZX_XPRESS))
> +		pr_info("ntfs3: Read-only LZX/Xpress compression included\n");
>  
>  	err = ntfs3_init_bitmap();
>  	if (err)
> @@ -1484,15 +1477,11 @@ static void __exit exit_ntfs_fs(void)
>  
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("ntfs3 read/write filesystem");
> -MODULE_INFO(behaviour, "Index binary search");
> -MODULE_INFO(behaviour, "Hot fix free clusters");
>  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
>  MODULE_INFO(behaviour, "Enabled Linux POSIX ACLs support");
>  #endif
>  #ifdef CONFIG_NTFS3_64BIT_CLUSTER
> -MODULE_INFO(cluster, "Activated 64 bits per cluster");
> -#else
> -MODULE_INFO(cluster, "Activated 32 bits per cluster");
> +MODULE_INFO(cluster, "Warning: Activated 64 bits per cluster. Windows does not support this");
>  #endif
>  #ifdef CONFIG_NTFS3_LZX_XPRESS
>  MODULE_INFO(compression, "Read-only lzx/xpress compression included");
> 

Applied, thanks!
