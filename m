Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E7F45869A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 22:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhKUVkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 16:40:33 -0500
Received: from mailscanner01.zoner.fi ([84.34.166.10]:50396 "EHLO
        mailscanner01.zoner.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKUVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 16:40:30 -0500
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
        by mailscanner01.zoner.fi (Postfix) with ESMTPS id 08D6F4136C;
        Sun, 21 Nov 2021 23:37:23 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
        by www25.zoner.fi with esmtp (Exim 4.94.2)
        (envelope-from <lasse.collin@tukaani.org>)
        id 1mouWY-0003es-Sj; Sun, 21 Nov 2021 23:37:22 +0200
Date:   Sun, 21 Nov 2021 23:37:22 +0200
From:   Lasse Collin <lasse.collin@tukaani.org>
To:     Jubin Zhong <zhongjubin@huawei.com>
Cc:     <akpm@linux-foundation.org>, <wangfangpeng1@huawei.com>,
        <liaohua4@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kbuild: Enable armthumb BCJ filter for Thumb-2
 kernel
Message-ID: <20211121233722.708131a8@kaneli>
In-Reply-To: <1637379771-39449-1-git-send-email-zhongjubin@huawei.com>
References: <1637379771-39449-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-20 Jubin Zhong wrote:
> xz_wrap.sh use $SRCARCH to detect the BCJ filter. However, assigning
> arm BCJ filter to Thumb-2 kernel is not optimal. In my case, about 5%
> decrease of image size is observed with armthumb BCJ filter:
> 
> Test results:
>   hardware:      QEMU emulator version 3.1.0
>   config:        vexpress_defconfig with THUMB2_KERNEL & KERNEL_XZ on
>   arm BCJ:       4029808
>   armthumb BCJ:  3827280
> 
> Choose armthumb BCJ filter for Thumb-2 kernel to make smaller images.
> 
> Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>

I still didn't test it but it looks good to me.

Acked-by: Lasse Collin <lasse.collin@tukaani.org>

-- 
Lasse Collin
