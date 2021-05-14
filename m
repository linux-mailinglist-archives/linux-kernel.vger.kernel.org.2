Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A32380246
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 05:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhENDKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 23:10:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2655 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhENDKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 23:10:10 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FhD1B2RZNzQn56;
        Fri, 14 May 2021 11:05:34 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 11:08:58 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 11:08:58 +0800
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_-next=5d_staging=3a_comedi=3a_Remove_unuse?=
 =?UTF-8?B?ZCB2YXJpYWJsZSDigJhtaW5fZnVsbF9zY2FsZeKAmQ==?=
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <abbotti@mev.co.uk>,
        <hsweeten@visionengravers.com>, <grandmaster@al2klimov.de>,
        <john.wanghui@huawei.com>
References: <20210513133458.27766-1-cuibixuan@huawei.com>
 <YJ0czj6EOwW/l4sq@kroah.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <79e80cb6-5721-1256-fa3c-fa76502d7dc3@huawei.com>
Date:   Fri, 14 May 2021 11:08:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YJ0czj6EOwW/l4sq@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/13 20:34, Greg KH wrote:
> If it really is not used, then remove it, don't paper over a compiler
> warning for no good reason please.
> 
> Fix this properly.
I will send a new patches.

Thanks
Bixuan Cui
