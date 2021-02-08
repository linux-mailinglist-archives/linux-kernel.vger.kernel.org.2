Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA59312A43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 06:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBHFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 00:50:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21467 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229503AbhBHFu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 00:50:27 -0500
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800"; 
   d="scan'208";a="104316295"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 13:49:40 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B970C4CE6F74;
        Mon,  8 Feb 2021 13:49:37 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 13:49:40 +0800
Subject: Re: [PATCH] dax: fix default return code of range_parse()
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
To:     <linux-nvdimm@lists.01.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com>
Message-ID: <49788459-f42d-5173-c77a-f0a33558a58e@cn.fujitsu.com>
Date:   Mon, 8 Feb 2021 13:49:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: B970C4CE6F74.AAECC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2021/1/26 上午10:13, Shiyang Ruan wrote:
> The return value of range_parse() indicates the size when it is
> positive.  The error code should be negative.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>   drivers/dax/bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 737b207c9e30..3003558c1a8b 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1038,7 +1038,7 @@ static ssize_t range_parse(const char *opt, size_t len, struct range *range)
>   {
>   	unsigned long long addr = 0;
>   	char *start, *end, *str;
> -	ssize_t rc = EINVAL;
> +	ssize_t rc = -EINVAL;
>   
>   	str = kstrdup(opt, GFP_KERNEL);
>   	if (!str)
> 


