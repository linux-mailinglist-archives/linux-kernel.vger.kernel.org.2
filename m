Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1F0325FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBZJTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:19:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2608 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhBZJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:17:17 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dn3mF1cY5z67qLq;
        Fri, 26 Feb 2021 17:10:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 10:16:24 +0100
Received: from [10.47.0.216] (10.47.0.216) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Feb
 2021 09:16:23 +0000
Subject: Re: perf test for daemon
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210219194619.1780437-1-acme@kernel.org>
 <e368e5d0-0005-0b67-aaeb-042eef9c24be@huawei.com> <YDf2wUG9JiXKEzL9@krava>
 <YDf8GYWlEhYqGkXv@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <283df638-2300-e723-f0dd-b0672170537f@huawei.com>
Date:   Fri, 26 Feb 2021 09:14:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YDf8GYWlEhYqGkXv@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.216]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2021 19:35, Jiri Olsa wrote:
> On Thu, Feb 25, 2021 at 08:13:07PM +0100, Jiri Olsa wrote:
>> On Thu, Feb 25, 2021 at 06:39:22PM +0000, John Garry wrote:
>>> Hi,
>>>
>>> I notice that "perf test" when run without root priviledges now hangs at the
>>> daemon test - is this expected behaviour? Can we skip and warn the user
>>> instead?
>>>
>>> I'm checking acme perf/core today.
>> ugh, I'll check.. looks like control fifo files are created with wrong permissions
> could you please try the fix below? it's passing with non-root user for me
> 
> thanks,
> jirka
> 

ok, it completes now. thanks

Tested-by: John Garry <john.garry@huawei.com>

> 
> ---
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 617feaf020f6..8f0ed2e59280 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -373,12 +373,12 @@ static int daemon_session__run(struct daemon_session *session,
>   	dup2(fd, 2);
>   	close(fd);
>   
> -	if (mkfifo(SESSION_CONTROL, O_RDWR) && errno != EEXIST) {
> +	if (mkfifo(SESSION_CONTROL, 0600) && errno != EEXIST) {
>   		perror("failed: create control fifo");
>   		return -1;
>   	}
>   
> -	if (mkfifo(SESSION_ACK, O_RDWR) && errno != EEXIST) {
> +	if (mkfifo(SESSION_ACK, 0600) && errno != EEXIST) {
>   		perror("failed: create ack fifo");
>   		return -1;
>   	}
> diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
> index e5b824dd08d9..5ad3ca8d681b 100755

