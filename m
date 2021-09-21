Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FE0413797
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhIUQdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:33:07 -0400
Received: from foss.arm.com ([217.140.110.172]:36256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhIUQdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:33:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232C0113E;
        Tue, 21 Sep 2021 09:31:37 -0700 (PDT)
Received: from [10.57.95.67] (unknown [10.57.95.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50F653F718;
        Tue, 21 Sep 2021 09:31:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add Coresight support for RB5 board
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
References: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <07bba970-2315-4284-cd3e-d69a3028a406@arm.com>
Date:   Tue, 21 Sep 2021 17:31:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1631515214-13653-1-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao

On 13/09/2021 07:40, Tao Zhang wrote:
> This series adds Coresight support for SM8250 Soc on RB5 board.
> It is composed of two elements.
> a) Add ETM PID for Kryo-5XX.
> b) Add coresight support to DTS for RB5.
> 
> This series applies to coresight/next
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 

Please could you mention what has changed since the previous version
in the cover letter ?

Kind regards
Suzuki

> Tao Zhang (2):
>    coresight: etm4x: Add ETM PID for Kryo-5XX
>    arm64: dts: qcom: sm8250: Add Coresight support
> 
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      | 442 +++++++++++++++++-
>   .../coresight/coresight-etm4x-core.c          |   1 +
>   2 files changed, 439 insertions(+), 4 deletions(-)
> 

