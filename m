Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB730E039
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBCQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhBCQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:54:14 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DBC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=tLhiWmnT/C8Kq00EIzAMsggn/BloqdNGprNcS8C0Zag=; b=B/KqVgnBuKSSgs884yojmP2THN
        4UYvffDwKvt7K7YQvzPLxI8FJ7V4JaVmkVSzXpJVfSqXjfpZeajCg+4vxQV2qoiA+T22X1zqnHGEx
        +rraTJhMTrLc16ObUHa3eY1Oa1U2ljTiyvDUM3DQ1BSEWx8FsEVnK9aWtZed/2fbsYZ7YpdsQOdMZ
        caFigqLug3KUTKOONImBXHdSxx083joEtPnWvexe4/YWwvjVOF0XMWb+wV+CGCQaWOwVPK5MdIknR
        +pW3eRTUrcQCm8Gkx7VkqebrB38CEVAXriA0pCSOuf2Y90guBkjuOFhFLD3WRMXSRIhTl8w28/nd4
        sUjkJJ4w==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7LPG-0004EM-14; Wed, 03 Feb 2021 16:53:30 +0000
Subject: Re: [PATCH] tools: bootconfig: Fix a spelling messge to message in
 echo statement
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20210203143425.19595-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e2c7733e-c080-08b6-7cf2-6882efc955e7@infradead.org>
Date:   Wed, 3 Feb 2021 08:53:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203143425.19595-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 6:34 AM, Bhaskar Chowdhury wrote:
> 
> s/messge/message/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/bootconfig/test-bootconfig.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index baed891d0ba4..08b14ff0070c 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -78,7 +78,7 @@ echo "File size check"
>  new_size=$(stat -c %s $INITRD)
>  xpass test $new_size -eq $initrd_size
> 
> -echo "No error messge while applying"
> +echo "No error message while applying"
>  dd if=/dev/zero of=$INITRD bs=4096 count=1
>  printf " \0\0\0 \0\0\0" >> $INITRD
>  $BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
> --
> 2.26.2
> 


-- 
~Randy

