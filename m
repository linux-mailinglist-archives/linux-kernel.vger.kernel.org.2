Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EF35C2D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbhDLJv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:26 -0400
Received: from smtp81.iad3a.emailsrvr.com ([173.203.187.81]:57771 "EHLO
        smtp81.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243120AbhDLJlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1618220463;
        bh=Ua6N2tbUCxSpcHBTulhre/77HwGvuvWxXpGJ7l1JK0s=;
        h=Subject:To:From:Date:From;
        b=EwyKCaMQ7nsqi8IM6thFgUadq0MOtx5aR/cGtnz7gy5EGf5znd6l8ELBoiI+hJS2g
         kIEPeOMbFi9fKpMQdxgb+NAYtcmszCNrntXmZOqmoeJ7z1ljpFrN7V/LNwpCf3c+xL
         CdbZkByEMLbgJ7420cnfFn3J356X/TynaqRM6RgU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp19.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6CEDE4FB0;
        Mon, 12 Apr 2021 05:41:02 -0400 (EDT)
Subject: Re: [PATCH] Staging: Remove line to fix checkpatch error
To:     tawahpeggy <tawahpeggy98@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210411204933.GA3524@peggy-Lenovo-V130-15IKB>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <25a33398-483e-931c-f023-61bac56c72ef@mev.co.uk>
Date:   Mon, 12 Apr 2021 10:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210411204933.GA3524@peggy-Lenovo-V130-15IKB>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 508ff95b-300f-4d57-ad4a-8069f2518623-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2021 21:49, tawahpeggy wrote:
> remove one empty line.CHECK: Please don't use multiple blank lines
> 
> Signed-off-by: tawahpeggy <tawahpeggy98@gmail.com>
> 
> ---
>   drivers/staging/comedi/comedi_pcmcia.mod.c | 1 -
>   1 file changed, 0 insertion(+), 1 deletion(-)
>   create mode 100644 drivers/staging/comedi/comedi_pcmcia.mod.c
> 
> diff --git a/drivers/staging/comedi/comedi_pcmcia.mod.c b/drivers/staging/comedi/comedi_pcmcia.mod.c
> index 0904b8765afs96..3984db1a39c8
> --- /dev/null
> +++ b/drivers/staging/comedi/comedi_pcmcia.mod.c

The .mod.c files are not really part of the Linux kernel source code. 
They are generated during the kernel build process.  There is no point 
checking them with checkpatch.pl.  If you are adding them to your git 
repository, then you are doing something wrong.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
