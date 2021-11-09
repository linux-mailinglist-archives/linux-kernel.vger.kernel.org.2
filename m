Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6444A531
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242415AbhKIDNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:13:09 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41791 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235901AbhKIDNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:13:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UviXRY0_1636427418;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UviXRY0_1636427418)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Nov 2021 11:10:20 +0800
Date:   Tue, 9 Nov 2021 11:10:18 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org, yh@oppo.com, guanyuwei@oppo.com,
        guoweichao@oppo.com
Subject: Re: [PATCH 1/2] erofs: add sysfs interface
Message-ID: <YYnmmla6xh5Y4d30@B-P7TQMD6M-0146.local>
References: <20211109025445.12427-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109025445.12427-1-huangjianan@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan,

On Tue, Nov 09, 2021 at 10:54:44AM +0800, Huang Jianan via Linux-erofs wrote:

You might need to add a "From:" tag here, otherwise, the author will
show "Huang Jianan via Linux-erofs" due to your mailing server...

> Add sysfs interface to configure erofs related parameters in the
> future.

s/in the future/Later/

> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  fs/erofs/Makefile   |   2 +-
>  fs/erofs/internal.h |  10 ++
>  fs/erofs/super.c    |  12 +++
>  fs/erofs/sysfs.c    | 239 ++++++++++++++++++++++++++++++++++++++++++++

At a quick glance, we might need to add sysfs API documentation
as well:
Documentation/ABI/testing/sysfs-fs-erofs

Thanks,
Gao Xiang

