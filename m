Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E430D901
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhBCLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhBCLls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:41:48 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF00C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:41:07 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW09w67K6z9vGH; Wed,  3 Feb 2021 22:40:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     ajd@linux.ibm.com, arnd@arndb.de, fbarrat@linux.ibm.com,
        gregkh@linuxfoundation.org
In-Reply-To: <20201224132446.31286-1-zhengyongjun3@huawei.com>
References: <20201224132446.31286-1-zhengyongjun3@huawei.com>
Subject: Re: [PATCH v2 -next] misc: ocxl: use DEFINE_MUTEX() for mutex lock
Message-Id: <161235199985.1516112.15428721712671016806.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:51 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Dec 2020 21:24:46 +0800, Zheng Yongjun wrote:
> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().

Applied to powerpc/next.

[1/1] ocxl: use DEFINE_MUTEX() for mutex lock
      https://git.kernel.org/powerpc/c/52f6b0a90bcf573ba8a33e97544c7b6f292376a4

cheers
