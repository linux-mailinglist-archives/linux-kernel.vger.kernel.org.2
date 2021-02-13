Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF431ACAD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 16:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBMPpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 10:45:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229714AbhBMPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 10:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613231055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQi/EANdHWWU+K4S2hS9kqKruFURuTm780fwscRNIrs=;
        b=iS376KUFoqEK/1oFtw+EOl/vVUBbho6q7Rj4qSCQ7aIrcmqeyCPiafwDz4QteztqYyNk/+
        2UM3Bm4KAvegpN0q5Sq6PRAxQnC0zoNpoF0ydVUl02nwFmkLdgGqivckAZ7/t5UxETmR3W
        H2ahWpAUarrTIb/dn0YQS0uE0JzwVug=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-pjz9TYICPsOTt3H_EXE84g-1; Sat, 13 Feb 2021 10:44:13 -0500
X-MC-Unique: pjz9TYICPsOTt3H_EXE84g-1
Received: by mail-qt1-f197.google.com with SMTP id k90so2332967qte.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 07:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YQi/EANdHWWU+K4S2hS9kqKruFURuTm780fwscRNIrs=;
        b=IGSpP7ccjobBKtPX/kCbNQSafF9EkaezDYvZBH+Kx81l1VF6IuQL4sB/JLc1uaVj77
         PZRe94QkZyMMG482wv00tjIVnbOw5OZUEcrVuKwd3ZBqjKwLlxOqYrP2l6Fk08Tp8JiX
         XF/CFuD3Jcxjq3CVaiqpg3XtSqsDY5ko05oyZvESmf4+Y8qwQSvptwWdu8PzL8r27Zgq
         iaemOHqojtRXmM4ZmBcA/4gHpm9DVDajLYWyU0J4MYmiEWfCnOJZ12UBM/nFRqO7AhBY
         KkxO1UdXn+ACoDXRf4OWWb3Q0UC/w5Xyubf8/joKTXEN/lSJWkrCG2O7d/26ID3FKiEb
         EO+w==
X-Gm-Message-State: AOAM533yMK4foDZdMPFiv1Vbj0943SLIN5TyeXdCccQl/LkDUEx/RiCe
        AH6AyZCvs+tCLjXcXu7npFPJmN2HDkosPgV6GGjhs68jA+xLa9H5kGmwJ2/7ogLj8UohBlxug3I
        8mBd/ExDa6bjXdQ/D+bzStxAg
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr7551378qkj.260.1613231052745;
        Sat, 13 Feb 2021 07:44:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7v+qM/tIcMmVl4Bc1iAXA7r88M/vfv1VkG7OMyRdrIIEV1A5BK6WWjqRQyk4g3LdRadBIsw==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr7551361qkj.260.1613231052497;
        Sat, 13 Feb 2021 07:44:12 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v5sm8510673qkg.47.2021.02.13.07.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 07:44:12 -0800 (PST)
Subject: Re: [PATCHv5 1/7] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <1612909233-13867-2-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bc43e8ab-b8df-fd2f-31e4-02cdc48cadff@redhat.com>
Date:   Sat, 13 Feb 2021 07:44:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612909233-13867-2-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/21 2:20 PM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.
>
> Fixes: 36847f9e3e56 ("firmware: stratix10-svc: correct reconfig flag and timeout values")
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v5: new add, add the missing standalone patch
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index a93d859..f843c6a 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -56,7 +56,7 @@
>   * COMMAND_RECONFIG_FLAG_PARTIAL:
>   * Set to FPGA configuration type (full or partial).
>   */
> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0

Is this the stand alone fix split from v3's patch 1 ?

https://lore.kernel.org/linux-fpga/YBFW50LPP%2FyEbvEW@kroah.com/

Tom

>  
>  /**
>   * Timeout settings for service clients:

