Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44EA40DC69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbhIPOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:09:15 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:54216 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238088AbhIPOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:09:06 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 580181F89;
        Thu, 16 Sep 2021 17:07:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631801264;
        bh=JJnlxypnVRgMT5SLAXWcsf8aaPGV2nStrpNiAr0sGkU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=YLBmdcL1dV24tFVR8JXIbtc6mbkPoHVMFPDYbAI4GBVaLSa7gmqb00QkRFXEL7mzE
         2Aj5dyfjnOXjbdTu4x9AIWFqejjPp5U0tya9En65upGnVTzq0LHilla4E/WG9kGTK6
         ewmFbJ68JIsecIMDpxJl9MwTybp+vhCD5/13Lg7U=
Received: from [192.168.211.100] (192.168.211.100) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 16 Sep 2021 17:07:43 +0300
Message-ID: <dc3fab5b-c70e-bf8c-eabf-7da1ca24830c@paragon-software.com>
Date:   Thu, 16 Sep 2021 17:07:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/4] fs/ntfs3: Fix various styling issues
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>
References: <20210907083441.3212-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210907083441.3212-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.100]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.09.2021 11:34, Kari Argillander wrote:
> Fix various checkpatch warnings. There will still be some but they
> will be addressed in different patch sets.
> 
> v2:
> 	- Remove + sign completly in 1/4 (Thanks Joe)
> 	- I dropped one patch as it addressed else were [1]. (Thanks Joe)
> 	- Drop newline in 3/4
> 
> [1]: lore.kernel.org/ntfs3/20210902154050.5075-1-kari.argillander@gmail.com
> 
> Kari Argillander (4):
>   fs/ntfs3: Remove '+' before constant in ni_insert_resident()
>   fs/ntfs3: Place Comparisons constant right side of the test
>   fs/ntfs3: Remove braces from single statment block
>   fs/ntfs3: Remove tabs before spaces from comment
> 
>  fs/ntfs3/frecord.c | 7 +++----
>  fs/ntfs3/lznt.c    | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> 
> base-commit: d3624466b56dd5b1886c1dff500525b544c19c83
> 

Hi, Kari, Joe!
Applied, thanks!
