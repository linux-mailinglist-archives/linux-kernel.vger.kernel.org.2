Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B42234E654
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhC3LcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:32:08 -0400
Received: from foss.arm.com ([217.140.110.172]:58170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhC3Lbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:31:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8B731B;
        Tue, 30 Mar 2021 04:31:50 -0700 (PDT)
Received: from [10.57.57.107] (unknown [10.57.57.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C40E3F694;
        Tue, 30 Mar 2021 04:31:48 -0700 (PDT)
Subject: Re: [PATCH v6 00/10] libperf and arm64 userspace counter access
 support
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com
References: <20210311000837.3630499-1-robh@kernel.org>
From:   Zachary Leaf <zachary.leaf@arm.com>
Message-ID: <163a5329-2ff6-1dad-bb4f-1a9cad2c5685@arm.com>
Date:   Tue, 30 Mar 2021 12:31:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210311000837.3630499-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 00:08, Rob Herring wrote:
> Changes in v6:
>   ...

Thanks Rob.

I haven't tested the libperf patches but the rest of the patches are
working well here for userspace access, based on my (fairly limited)
testing on N1-SDP.

Tested-by: Zach Leaf <Zachary.Leaf@arm.com>
