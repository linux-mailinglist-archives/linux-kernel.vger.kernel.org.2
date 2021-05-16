Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB85381C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 04:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhEPCkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 22:40:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2667 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhEPCkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 22:40:21 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FjRFl0ljszNxFf;
        Sun, 16 May 2021 10:35:39 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 16 May 2021 10:39:05 +0800
Received: from [10.174.179.215] (10.174.179.215) by
 dggema769-chm.china.huawei.com (10.1.198.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sun, 16 May 2021 10:39:05 +0800
Subject: Re: [PATCH -next] ASoC: soc-core: use DEVICE_ATTR_RO macro
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20210514081100.16196-1-yuehaibing@huawei.com>
 <20210514122442.GA6516@sirena.org.uk>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <bc0f78b7-6ced-dfbc-d3c4-e6675dc4957e@huawei.com>
Date:   Sun, 16 May 2021 10:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210514122442.GA6516@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/14 20:24, Mark Brown wrote:
> On Fri, May 14, 2021 at 04:11:00PM +0800, YueHaibing wrote:
> 
>> -static ssize_t pmdown_time_set(struct device *dev,
>> -			       struct device_attribute *attr,
>> -			       const char *buf, size_t count)
>> +static ssize_t pmdown_time_store(struct device *dev,
>> +				 struct device_attribute *attr,
>> +				 const char *buf, size_t count)
> 
> This unrelated formatting change should be in a separate patch.

This change pmdown_time_set() to pmdown_time_store(), which trigger
checkpatch warning.

> 
