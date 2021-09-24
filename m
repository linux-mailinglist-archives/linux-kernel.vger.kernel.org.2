Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD1B417548
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346435AbhIXNT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:19:57 -0400
Received: from foss.arm.com ([217.140.110.172]:48362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346306AbhIXNTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:19:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 626B3113E;
        Fri, 24 Sep 2021 06:17:31 -0700 (PDT)
Received: from [10.57.95.68] (unknown [10.57.95.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 980EC3F719;
        Fri, 24 Sep 2021 06:17:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] coresight: etm4x: Add ETM PID for Kryo-5XX
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
References: <1632477981-13632-1-git-send-email-quic_taozha@quicinc.com>
 <1632477981-13632-2-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <dfe21692-ff04-5c17-8bb3-369fc5ff504e@arm.com>
Date:   Fri, 24 Sep 2021 14:17:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1632477981-13632-2-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2021 11:06, Tao Zhang wrote:
> Add ETM PID for Kryo-5XX to the list of supported ETMs.
> Otherwise, Kryo-5XX ETMs will not be initialized successfully.
> e.g.
> This change can be verified on qrb5165-rb5 board. ETM4-ETM7 nodes
> will not be visible without this change.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>

I have queued this one.

Suzuki
