Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9843E0928
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbhHDUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:09:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:37662 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhHDUJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:09:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="194279472"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="194279472"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 13:09:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="512214214"
Received: from bguvendi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.99.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 13:09:09 -0700
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <56f15095-f1aa-88bc-9335-e0147bdcc573@linux.intel.com>
Date:   Wed, 4 Aug 2021 13:09:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/21 12:50 PM, Andi Kleen wrote:
> 
>> And what's wrong with the current method of removing drivers from
>> devices that you do not want them to be bound to?  We offer that support
>> for all busses now that want to do it, what driver types are you needing
>> to "control" here that does not take advantage of the existing
>> infrastructure that we currently have for this type of thing?
> 
> I'm not sure what mechanism you're referring to here, but in general don't want the drivers to 
> initialize at all because they might get exploited in any code that they execute.The intention is to 
> disable all drivers except for a small allow list, because it's not practical to harden all 25M 
> lines of Linux code.

Yes, we are not trying to remove the drivers via sysfs. If driver
filter is enabled, "allowed" sysfs file is used to view the driver
filter status (allowed/denied). And a write to that file changes
the allowed/denied status of the driver. It has nothing to do
with bind/unbind operations.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
