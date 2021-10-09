Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A1D427721
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 06:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhJIE0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 00:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhJIE0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 00:26:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8868960FD7;
        Sat,  9 Oct 2021 04:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633753475;
        bh=ziwox/3IPHFZ71CM62L5TFAi8Z8VL2tm8zXgH6+KQZQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S1CFT7su1MlEsaYtzgDHbEI3QvBE+AnJXOzxJXdBBWwT03VLEGBuIlu6XUPP5m0fI
         MPkjiWwhJPDHLN9FuVefyA37GqDyR+d645D5Fzn4BUseX5KEgHxDbd97Stjp1Q5JRK
         BVG0CbRdLGUqlOkYY/Me9cpzwPcEbOb5yyF4wtWLdAPbyoYE65wpnpUrDnsBQISmXu
         HyLxtqpOZwG1awF+NRTy5kWHyctViP3gQlb9defCalbHNJTEhMCPfEaMfcOyoFD1yS
         WRGdlXcH7n/39eqkxaZg/wPxD8vjheqjZXMWKDtk/ewVZphI78GuQUbsX9q7dV8n8C
         XXrOuXQ5WogNA==
Subject: Re: [PATCH v2] f2fs: fix to use WHINT_MODE
To:     keosung.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanghuan@vivo.com" <tanghuan@vivo.com>,
        "changfengnan@vivo.com" <changfengnan@vivo.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>
References: <CGME20210930005939epcms2p7303bf6f96c824720f824989746491cba@epcms2p7>
 <20210930005939epcms2p7303bf6f96c824720f824989746491cba@epcms2p7>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a59baec0-02cf-28d6-17cd-3ff6dfdf0a01@kernel.org>
Date:   Sat, 9 Oct 2021 12:24:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930005939epcms2p7303bf6f96c824720f824989746491cba@epcms2p7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/30 8:59, Keoseong Park wrote:
> Since active_logs can be set to 2 or 4 or NR_CURSEG_PERSIST_TYPE(6),
> it cannot be set to NR_CURSEG_TYPE(8).
> That is, whint_mode is always off.
> 
> Therefore, the condition is changed from NR_CURSEG_TYPE to NR_CURSEG_PERSIST_TYPE.
> 

Fixes: d0b9e42ab615 (f2fs: introduce inmem curseg)

> Cc: Chao Yu <chao@kernel.org>
> Reported-by: Huan Tang <tanghuan@vivo.com>
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
