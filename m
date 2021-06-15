Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8963A743F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFOCqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:46:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10058 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhFOCqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:46:20 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3ryT4CpTzZf0C;
        Tue, 15 Jun 2021 09:56:17 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:59:11 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:59:11 +0800
Subject: Re: [PATCH -next] tracing: Remove set but not used variable 'ret'
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210527091032.3878436-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <4ab45eeb-ad26-03e8-f2c5-2dc4582a2946@huawei.com>
Date:   Tue, 15 Jun 2021 09:59:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210527091032.3878436-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2021/5/27 17:10, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> kernel/trace/trace_events_hist.c: In function 'unregister_field_var_hists':
> kernel/trace/trace_events_hist.c:5228:6: warning:
>   variable ‘ret’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   kernel/trace/trace_events_hist.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c1abd63f1d6c..af4da32f7eab 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5225,13 +5225,12 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
>   	struct trace_event_file *file;
>   	unsigned int i;
>   	char *cmd;
> -	int ret;
>   
>   	for (i = 0; i < hist_data->n_field_var_hists; i++) {
>   		file = hist_data->field_var_hists[i]->hist_data->event_file;
>   		cmd = hist_data->field_var_hists[i]->cmd;
> -		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
> -					      "!hist", "hist", cmd);
> +		event_hist_trigger_func(&trigger_hist_cmd, file,
> +					"!hist", "hist", cmd);
>   	}
>   }
>   
