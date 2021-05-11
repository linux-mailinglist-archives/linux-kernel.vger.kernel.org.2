Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EAD379D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhEKDRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 23:17:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2764 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEKDRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:17:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfNKP69qJzmg6H;
        Tue, 11 May 2021 11:13:13 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 May
 2021 11:16:29 +0800
Subject: Re: [f2fs-dev] [PATCH 27/53] docs: filesystems: f2fs.rst: avoid using
 UTF-8 chars
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <c320db751bc326efbd1d619c0f8007d9965a32ab.1620641727.git.mchehab+huawei@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5454cb69-1193-83e2-754d-7d8807ad12e5@huawei.com>
Date:   Tue, 11 May 2021 11:16:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c320db751bc326efbd1d619c0f8007d9965a32ab.1620641727.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 18:26, Mauro Carvalho Chehab wrote:
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+2013 ('–'): EN DASH
> 	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
> 	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
