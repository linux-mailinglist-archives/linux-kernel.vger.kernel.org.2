Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85B4353E98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhDEJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 05:07:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15544 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbhDEJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 05:04:09 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FDPld31d2zPnpm;
        Mon,  5 Apr 2021 17:01:17 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 5 Apr 2021
 17:03:57 +0800
Subject: Re: [PATCH 02/10] tty/sysrq: Fix issues of code indent should use
 tabs
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
References: <1617593662-25900-1-git-send-email-tanxiaofei@huawei.com>
 <1617593662-25900-3-git-send-email-tanxiaofei@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <594fa168-3664-531a-cb13-42a4adfaa250@huawei.com>
Date:   Mon, 5 Apr 2021 17:03:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1617593662-25900-3-git-send-email-tanxiaofei@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/5 11:34, Xiaofei Tan wrote:
> Fix issues of code indent should use tabs, reported by checkpatch.pl.
>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/tty/sysrq.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 0372ed7..1ece100 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -548,22 +548,22 @@ static int sysrq_key_table_key2index(int key)
>   */
>  static const struct sysrq_key_op *__sysrq_get_key_op(int key)
>  {
> -        const struct sysrq_key_op *op_p = NULL;
> -        int i;
> +	const struct sysrq_key_op *op_p = NULL;
> +	int i;
>
>  	i = sysrq_key_table_key2index(key);
>  	if (i != -1)
> -	        op_p = sysrq_key_table[i];
> +		op_p = sysrq_key_table[i];
>
> -        return op_p;
> +		return op_p;

Wow, one redundant tab here.

>  }
>
>  static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
>  {
> -        int i = sysrq_key_table_key2index(key);
> +	int i = sysrq_key_table_key2index(key);
>
> -        if (i != -1)
> -                sysrq_key_table[i] = op_p;
> +	if (i != -1)
> +		sysrq_key_table[i] = op_p;
>  }
>
>  void __handle_sysrq(int key, bool check_mask)
> @@ -587,8 +587,8 @@ void __handle_sysrq(int key, bool check_mask)
>  	orig_log_level = console_loglevel;
>  	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
>
> -        op_p = __sysrq_get_key_op(key);
> -        if (op_p) {
> +	op_p = __sysrq_get_key_op(key);
> +	if (op_p) {
>  		/*
>  		 * Should we check for enabled operations (/proc/sysrq-trigger
>  		 * should not) and is the invoked operation enabled?
> @@ -637,13 +637,13 @@ static int sysrq_reset_downtime_ms;
>
>  /* Simple translation table for the SysRq keys */
>  static const unsigned char sysrq_xlate[KEY_CNT] =
> -        "\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
> -        "qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
> -        "dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
> -        "bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
> -        "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
> -        "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
> -        "\r\000/";                                      /* 0x60 - 0x6f */
> +	"\000\0331234567890-=\177\t"                    /* 0x00 - 0x0f */
> +	"qwertyuiop[]\r\000as"                          /* 0x10 - 0x1f */
> +	"dfghjkl;'`\000\\zxcv"                          /* 0x20 - 0x2f */
> +	"bnm,./\000*\000 \000\201\202\203\204\205"      /* 0x30 - 0x3f */
> +	"\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
> +	"230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
> +	"\r\000/";                                      /* 0x60 - 0x6f */
>
>  struct sysrq_state {
>  	struct input_handle handle;
> @@ -1108,7 +1108,7 @@ int sysrq_toggle_support(int enable_mask)
>  EXPORT_SYMBOL_GPL(sysrq_toggle_support);
>
>  static int __sysrq_swap_key_ops(int key, const struct sysrq_key_op *insert_op_p,
> -                                const struct sysrq_key_op *remove_op_p)
> +				const struct sysrq_key_op *remove_op_p)
>  {
>  	int retval;
>
>

