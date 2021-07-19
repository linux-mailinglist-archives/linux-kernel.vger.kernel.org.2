Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC623CCE10
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhGSGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 02:47:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11444 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhGSGrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:47:06 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GSsg01NwzzcbDy;
        Mon, 19 Jul 2021 14:40:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:44:05 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 14:44:05 +0800
Subject: Re: [PATCH 1/1] firmware: fix use-after-free in _request_firmware()
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210713024942.2881-1-thunder.leizhen@huawei.com>
 <20210716195628.a2pz73hdudrsf7vu@garbanzo>
 <20210716195855.i5pfpz2xsu3ql44b@garbanzo>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4ca0d8c3-a089-82f9-4a30-dad4e529b8b9@huawei.com>
Date:   Mon, 19 Jul 2021 14:44:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210716195855.i5pfpz2xsu3ql44b@garbanzo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/17 3:58, Luis Chamberlain wrote:
> On Fri, Jul 16, 2021 at 12:56:32PM -0700, Luis Chamberlain wrote:
>> Can you resend a v2 patch describing how ...
> 
> While at it, can you also change the subject of the patch
> to be more specific and clear, perhaps something like:
> 
> firmware: fix theoretical UAF race with firmware cache and resume

This title looks much better than mine. Thanks

> 
>   Luis
> .
> 
