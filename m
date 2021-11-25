Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC845DA33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353561AbhKYMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:41:25 -0500
Received: from foss.arm.com ([217.140.110.172]:50316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354607AbhKYMjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:39:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C5F81042;
        Thu, 25 Nov 2021 04:36:13 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 026263F66F;
        Thu, 25 Nov 2021 04:36:11 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] firmware: arm_scmi: optee: Fix missing mutex_init()
Date:   Thu, 25 Nov 2021 12:36:09 +0000
Message-Id: <163784366410.133584.3099760910961513705.b4-ty@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123083620.2366860-1-weiyongjun1@huawei.com>
References: <20211123083620.2366860-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 08:36:20 +0000, Wei Yongjun wrote:
> The driver allocates the mutex but not initialize it.
> Use mutex_init() on it to initialize it correctly.
> 
> 

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: optee: Fix missing mutex_init()
      https://git.kernel.org/sudeep.holla/c/61bc76be36

--
Regards,
Sudeep

