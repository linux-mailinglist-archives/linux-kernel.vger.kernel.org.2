Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3042E31CB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBPOFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:05:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBPOFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:05:51 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lC0yT-0000mq-G8; Tue, 16 Feb 2021 14:05:09 +0000
Subject: NACK: [PATCH][next] tracing/tools: fix spelling mistake "functionph"
 -> "graph"
From:   Colin Ian King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210216140112.159926-1-colin.king@canonical.com>
Message-ID: <87d92a26-ae1c-e76b-76b1-315e4cf759fc@canonical.com>
Date:   Tue, 16 Feb 2021 14:05:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216140112.159926-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 14:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the -g help option, I believe
> it should be "graph". Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/tracing/latency/latency-collector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
> index 57b20802e71b..8d28234cd6fb 100644
> --- a/tools/tracing/latency/latency-collector.c
> +++ b/tools/tracing/latency/latency-collector.c
> @@ -1711,7 +1711,7 @@ static void show_usage(void)
>  "\t\t\tbeginning, end, and backtrace.\n\n"
>  
>  "-g, --graph\t\tEnable the display-graph option in trace_option. This\n"
> -"\t\t\toption causes ftrace to show the functionph of how\n"
> +"\t\t\toption causes ftrace to show the graph of how\n"
>  "\t\t\tfunctions are calling other functions.\n\n"
>  
>  "-c, --policy POL\tRun the program with scheduling policy POL. POL can be\n"
> 

Found another spelling mistake, sending a V2 soon.
