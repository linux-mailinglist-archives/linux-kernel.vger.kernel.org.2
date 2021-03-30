Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6922034ECD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhC3Png (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:43:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:27968 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232329AbhC3PnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:43:06 -0400
IronPort-SDR: Dmvo+4c49aUOqFiCN3HpsSVKoLMPtK8szbYydYV6VaiO+a9wUCRIqd/1mj7Nw8tnfc+vYkLy6s
 SY5GLJvSxFCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="188531630"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="188531630"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 08:43:05 -0700
IronPort-SDR: LXRpHwKsdvxf9y/OfKTI7OsBQlAi1WChA9XmFTDca6XG5aS/2pjN1YnCcF7+teqPX5S9PCJHNp
 E7zrR5D0yI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="445197940"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2021 08:43:04 -0700
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
To:     David Laight <David.Laight@ACULAB.COM>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
References: <1617114785-22211-1-git-send-email-richard.gong@linux.intel.com>
 <1617114785-22211-2-git-send-email-richard.gong@linux.intel.com>
 <26176a0062114b9faa7c2c64c8ea3e64@AcuMS.aculab.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <16c40de5-b405-92b6-d08f-e395b9774e7e@linux.intel.com>
Date:   Tue, 30 Mar 2021 11:02:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <26176a0062114b9faa7c2c64c8ea3e64@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

On 3/30/21 9:19 AM, David Laight wrote:
> From: richard.gong@linux.intel.com
>> Sent: 30 March 2021 15:33
>>
>> Extend Intel service layer driver to get the firmware version running at
>> FPGA device. Therefore FPGA manager driver, one of Intel service layer
>> driver's client, can decide whether to handle the newly added bitstream
>> authentication function based on the retrieved firmware version.
> 
> Using the version number to detect features is just plain wrong.
> 
> You should use something like a bitmap of supported features.

Firmware, which runs at EL3, returns the version to Intel service layer 
driver in a 64-bit value at the register. Intel service layer driver 
runs at EL1.

Regards,
Richard

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
