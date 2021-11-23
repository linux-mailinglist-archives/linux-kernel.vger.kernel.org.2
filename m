Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE53645A6C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhKWPuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:50:40 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:59496 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232147AbhKWPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:50:39 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 48C861D6E;
        Tue, 23 Nov 2021 18:47:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1637682449;
        bh=QOqRFVptfs1cQfkqyxylbZmta/oLcPwVd88JVhuyUZw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=T6IzT5hl833cFx+WVTuAXGSLcSJ22gsRQOsVx3toCHCmdz2tXqCRgZiFgIjmDpeX/
         3Cwe0IAhXQSW4jCmd1e0pzk0IB2FGFecg15R0+o/mda36Xn3TOMngAP2fEQAqeVxVg
         xybmAuWwDLQlmUJ3XmRMo0FRaPsHFQk5n0m6gM8w=
Received: from [192.168.211.16] (192.168.211.16) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Nov 2021 18:47:28 +0300
Message-ID: <8fe8f1fd-b6ca-a8be-b899-b93d855e7748@paragon-software.com>
Date:   Tue, 23 Nov 2021 18:47:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] fs/ntfs3: Fix some memory leaks in an error handling path
 of 'log_replay()'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <a2244abd11dc5f5ee8a0dcec97da33b75923facb.1636616693.git.christophe.jaillet@wanadoo.fr>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <a2244abd11dc5f5ee8a0dcec97da33b75923facb.1636616693.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.16]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.11.2021 10:45, Christophe JAILLET wrote:
> All error handling paths lead to 'out' where many resources are freed.
> 
> Do it as well here instead of a direct return, otherwise 'log', 'ra' and
> 'log->one_page_buf' (at least) will leak.
> 
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  fs/ntfs3/fslog.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 06492f088d60..915f42cf07bc 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -4085,8 +4085,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>  		if (client == LFS_NO_CLIENT_LE) {
>  			/* Insert "NTFS" client LogFile. */
>  			client = ra->client_idx[0];
> -			if (client == LFS_NO_CLIENT_LE)
> -				return -EINVAL;
> +			if (client == LFS_NO_CLIENT_LE) {
> +				err = -EINVAL;
> +				goto out;
> +			}
>  
>  			t16 = le16_to_cpu(client);
>  			cr = ca + t16;
> 


Thanks for patch, applied!
