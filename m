Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255B53E1C29
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbhHETJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:09:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:64685 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242274AbhHETJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:09:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="214215896"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="214215896"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 12:08:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="512904115"
Received: from dkdean-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.157.53])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 12:08:54 -0700
Subject: Re: [PATCH v1] driver: base: Add driver filter support
To:     Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20210804174322.2898409-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrqhYEL64CSLRTy@kroah.com>
 <f2b1d564-8174-f8e9-9fee-12e938c6d846@linux.intel.com>
 <YQuYCePPZEmVbkfc@kroah.com> <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
 <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
 <YQwpa+LAYt7YZ5dh@kroah.com>
 <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com>
 <CAPcyv4h26QmPhJKjtUB-VPc4TP95rBAer78OzkgXncg77tFWVw@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <179a8351-5541-a4f0-bbb2-5d4f398e2476@linux.intel.com>
Date:   Thu, 5 Aug 2021 12:08:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h26QmPhJKjtUB-VPc4TP95rBAer78OzkgXncg77tFWVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/21 12:01 PM, Dan Williams wrote:
> What's wrong with the generic authorized proposal? The core can
> default to deauthorizing devices on the platform bus, or any bus,
> unless on an allow list. It's a bit more work to uplevel the local
> "authorized" implementations from USB and Thunderbolt to the core, but
> it's functionally identical to the "filter" approach in terms of
> protection, i.e. avoiding probe of unnecessary unvetted drivers.

I have not yet read about the "authorized" model in USB and Thunderbolt.
So bear with me if my question is basic or obvious. In the case USB
authorized model, who maintains the allow list? kernel or userspace?

If we are clubbing it with the driver filter model, I think
allow list in kernel should take precedence. Agree?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
