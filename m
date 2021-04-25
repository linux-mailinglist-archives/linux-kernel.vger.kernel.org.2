Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4D36A81B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhDYPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhDYPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 11:54:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E324EC061574;
        Sun, 25 Apr 2021 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=k2uf/iHXemagBorxPTaq/+K+RiEPjAIJeeEurCwCXSs=; b=Fb59g13r9rvX0/W9RfgWxWdGus
        W5jUjXYSVqYkdM61R0YnAinzmUO0almobzNADP6WQdYFtfEJDLkCeHbtRiiUwuNURCfuX2OjFytO4
        DyySt7iXgRn/RPOJomWJNM7i3LYVsxz0ZVABtoCD0r3I7OqtGCsLtFFPsEYqf7oDEBDiWRC4Vdb2P
        2QKnTba8ycEmLBLqWF0284w6JMDm64xkb3pi0GjvoCbA6VW8Uq/I2rnVdAnxetTW5lPhvRO3gl/rU
        /SFAIYXgb/d8z9VKd2QMlgqUmbebkToIK8yqga0BZ3L9VC41RAaqAUbviclMVNxB+ClkKDTkEwQ+l
        TdWQgFcA==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lah4l-004Rj5-Rv; Sun, 25 Apr 2021 15:53:42 +0000
Subject: Re: [PATCH v2] usb: cdns3: Corrected comment to align with kernel-doc
 comment
To:     Souptick Joarder <jrdr.linux@gmail.com>, peter.chen@kernel.org,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619338565-4574-1-git-send-email-jrdr.linux@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8cbc9ed6-4499-642c-3b49-53e80974f004@infradead.org>
Date:   Sun, 25 Apr 2021 08:53:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1619338565-4574-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/21 1:16 AM, Souptick Joarder wrote:
> Minor update in comment.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2:
> 	Updated change logs and address review comment.

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

>  drivers/usb/cdns3/cdns3-gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 9b1bd41..21f026c 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -484,7 +484,7 @@ static void __cdns3_descmiss_copy_data(struct usb_request *request,
>  }
>  
>  /**
> - * cdns3_wa2_descmiss_copy_data copy data from internal requests to
> + * cdns3_wa2_descmiss_copy_data - copy data from internal requests to
>   * request queued by class driver.
>   * @priv_ep: extended endpoint object
>   * @request: request object
> 


-- 
~Randy

