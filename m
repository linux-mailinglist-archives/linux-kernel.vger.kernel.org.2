Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EACC41C2BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbhI2Kbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:31:35 -0400
Received: from foss.arm.com ([217.140.110.172]:57684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240310AbhI2Kbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:31:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04C80D6E;
        Wed, 29 Sep 2021 03:29:54 -0700 (PDT)
Received: from [10.57.95.68] (unknown [10.57.95.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16E283F70D;
        Wed, 29 Sep 2021 03:29:51 -0700 (PDT)
Subject: Re: [PATCH] coresight: etm4x: avoid build failure with unrolled loops
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Arnd Bergmann <arnd@kernel.org>
References: <1632652550-26048-1-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <48162555-2a67-60bc-ea4b-8720e7b98a22@arm.com>
Date:   Wed, 29 Sep 2021 11:29:50 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1632652550-26048-1-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao

On 26/09/2021 11:35, Tao Zhang wrote:
> clang-12 fails to build the etm4x driver with -fsanitize=array-bounds,
> where it decides to unroll certain loops in a way that result in a
> C variable getting put into an inline assembly.
> 
> Search this build failure and find this is a known issue and there
> has been a mail thread discussing it.
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210429145752.3218324-1-arnd@kernel.org/
> According to the modification suggestions of this mail thread,
> coresight infrastucture has already provided another API that
> can replace the function that caused the error.
> 
> Used here "csdev_access_read32" to replace the original API
> "etm4x_relaxed_read32".
> 
> This patch applies to coresight/next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>


Thanks for picking up the patch. Please could you convert all the other
variable indexed register access too ? That would save us spinning up
patches for fixing those individual cases whenever the compiler decides
to change its behavior.

Suzuki
