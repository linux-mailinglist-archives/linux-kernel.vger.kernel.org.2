Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB93DAA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhG2RuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhG2RuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:50:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E52086069E;
        Thu, 29 Jul 2021 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627581001;
        bh=Y9OGgBXFU2G/7mHocyKVDlKZlE2rzm/VfDZ+H+zhGPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N4/xLEXF9qxW7yGhZphmX4slJQYzCm4alCBco+rxJ/9yJDk/fKsR0tD3NeVRg8Mxg
         APi3yiAyQ38dHH4OS2LBz8dVxjP0uZQsRCdPx7QJ2KKmaIpqDf6/Ad7hJSG3490XsF
         L/50HxUSWY9x5HW+i/PQcmA3Ck5zjZwAKhe92/7c=
Date:   Thu, 29 Jul 2021 10:50:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     <andriy.shevchenko@linux.intel.com>, <yury.norov@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <dave.hansen@intel.com>, <linux@rasmusvillemoes.dk>,
        <rafael@kernel.org>, <rdunlap@infradead.org>,
        <agordeev@linux.ibm.com>, <sbrivio@redhat.com>,
        <jianpeng.ma@intel.com>, <valentin.schneider@arm.com>,
        <peterz@infradead.org>, <bristot@redhat.com>,
        <guodong.xu@linaro.org>, <tangchengchang@huawei.com>,
        <prime.zeng@hisilicon.com>, <yangyicong@huawei.com>,
        <tim.c.chen@linux.intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v8 0/5] use bin_attribute to break the size limitation
 of cpumap ABI
Message-Id: <20210729105000.857e7225f0a73d6af98db116@linux-foundation.org>
In-Reply-To: <20210729054208.1800-1-song.bao.hua@hisilicon.com>
References: <20210729054208.1800-1-song.bao.hua@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 17:42:03 +1200 Barry Song <song.bao.hua@hisilicon.com> wrote:

>  drivers/base/node.c     |  51 +++++++++-----
>  drivers/base/topology.c | 115 ++++++++++++++++--------------
>  include/linux/bitmap.h  |   2 +
>  include/linux/cpumask.h |  63 +++++++++++++++++
>  lib/bitmap.c            |  96 +++++++++++++++++++++++++
>  lib/test_bitmap.c       | 150 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 407 insertions(+), 70 deletions(-)

I'm assuming this is more a gregkh thing than an akpm thing?
