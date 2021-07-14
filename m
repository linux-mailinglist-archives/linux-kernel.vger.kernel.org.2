Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931433C80F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhGNJHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:07:45 -0400
Received: from foss.arm.com ([217.140.110.172]:60120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238113AbhGNJHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:07:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F02A31B;
        Wed, 14 Jul 2021 02:04:53 -0700 (PDT)
Received: from bogus (unknown [10.57.79.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563143F774;
        Wed, 14 Jul 2021 02:04:52 -0700 (PDT)
Date:   Wed, 14 Jul 2021 10:03:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     james.morse@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, bobo.shaobowang@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
Message-ID: <20210714090353.6ncnqof74hwbx2gf@bogus>
References: <1626226375-58730-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626226375-58730-1-git-send-email-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 09:32:55AM +0800, Xiongfeng Wang wrote:
> On ARM64, when PPTT(Processor Properties Topology Table) is not
> implemented in ACPI boot, we will goto 'free_ci' with the following
> print:
>   Unable to detect cache hierarchy for CPU 0
>
> But some other codes may still use 'num_leaves' to iterate through the
> 'info_list', such as get_cpu_cacheinfo_id(). If 'info_list' is NULL , it
> would crash. So clear 'num_leaves' in free_cache_attributes().
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
