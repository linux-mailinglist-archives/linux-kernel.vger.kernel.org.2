Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7984351EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbhDASt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:49:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:38549 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240295AbhDASaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:30:01 -0400
IronPort-SDR: 46tFSyiTBFbTHqm+ajNzuWyDPv/0bczOl41VolkhQT0x2QUIi4Y8uwP4x2pjSsPbwHBEmJW5UG
 UDBLtlFboryg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179810992"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179810992"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 09:03:23 -0700
IronPort-SDR: 4QbDotXZHHyUF/mrZZU6rz0IbZ67UA7GraB1G+XBmuOpxgxG6yCnqIzxdEruyJ/dy5KQHEcu7x
 1keblEV6B3zA==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="439265765"
Received: from mooreale-mobl.amr.corp.intel.com (HELO [10.255.229.43]) ([10.255.229.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 09:03:22 -0700
Subject: Re: [PATCH v2] soundwire: qcom: wait for fifo space to be available
 before read/write
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e1bcc85d-b583-2c9a-18e5-634994cc2916@linux.intel.com>
Date:   Thu, 1 Apr 2021 09:36:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/21 4:00 AM, Srinivas Kandagatla wrote:
> If we write registers very fast we can endup in a situation where some
> of the writes will be dropped without any notice.
> 
> So wait for the fifo space to be available before reading/writing the
> soundwire registers.

Out of curiosity, do you actually need to do a check in the read case as 
well?

The commit message talks about writes getting dropped, is the opposite 
also a problem?

