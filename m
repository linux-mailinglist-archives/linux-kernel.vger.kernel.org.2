Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78744162CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhIWQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:14:26 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:47028 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231518AbhIWQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:14:25 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id D132F8232E;
        Thu, 23 Sep 2021 19:12:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632413572;
        bh=vRdKG05gnFQuVqKHvc+k3WvT4wAdI0k7moN34fawWr4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Viw9CUlXJRojXEftTFp6cWD8CxulPFF5FBMuAyLMgFq9/G0U5Xr8gjYYWAT8TfObc
         +9FQlM2f/ShBkMC+ObjvFVf0aSS9ihcNdC45oegI0j6guV2c7xTpXM+vran7uaiOsd
         Z1KsA4p4o1Tcu1GNmAPkTb6mb56VhpGH+zBqz6YQ=
Received: from [192.168.211.73] (192.168.211.73) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 23 Sep 2021 19:12:52 +0300
Message-ID: <a3dad3d1-6216-c289-d0fe-ffb36950481c@paragon-software.com>
Date:   Thu, 23 Sep 2021 19:12:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] fs/ntfs3: Remove deprecated mount options nls
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20210921171901.49176-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210921171901.49176-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.73]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.09.2021 20:19, Kari Argillander wrote:
> Some discussion has been spoken that this deprecated mount options
> should be removed before 5.15 lands. This driver is not never seen day
> light so it was decided that nls mount option has to be removed. We have
> always possibility to add this if needed.
> 
> One possible need is example if current ntfs driver will be taken out of
> kernel and ntfs3 needs to support mount options what it has.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> Patch is compile and checkpatch tested.
> 
> v2:
> 	-Do not delete {}
> ---
>  fs/ntfs3/super.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 6a535b144ff9..800897777eb0 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -246,10 +246,6 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
>  	fsparam_flag_no("prealloc",		Opt_prealloc),
>  	fsparam_flag_no("acsrules",		Opt_noacsrules),
>  	fsparam_string("iocharset",		Opt_iocharset),
> -
> -	__fsparam(fs_param_is_string,
> -		  "nls", Opt_iocharset,
> -		  fs_param_deprecated, NULL),
>  	{}
>  };
>  
> 
> base-commit: 6354467245ff8dd04b54e39790f2ee4d21d5419e
> 

Applied, thanks!
