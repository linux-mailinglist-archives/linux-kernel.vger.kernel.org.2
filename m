Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2100A30E17F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhBCRxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:53:33 -0500
Received: from mleia.com ([178.79.152.223]:50576 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231436AbhBCRxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:53:31 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 40EEE430E9B;
        Wed,  3 Feb 2021 17:52:49 +0000 (UTC)
Subject: Re: [PATCH] pwm: lpc18xx-sct: remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>, thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1612320605-6430-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <525dd757-ac62-cc71-3af1-af9bdbedc26b@mleia.com>
Date:   Wed, 3 Feb 2021 19:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612320605-6430-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20210203_175249_287758_6D93AC96 
X-CRM114-Status: UNSURE (   4.90  )
X-CRM114-Notice: Please train this message. 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 4:50 AM, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/pwm/pwm-lpc18xx-sct.c:292:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
