Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B977E38E7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhEXNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 09:44:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:36583 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232932AbhEXNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 09:44:24 -0400
IronPort-SDR: skukgycBTupGEc/oqveYzsuQjtyyBVqsSWjo4uhgzphwilXB26cMfjraIx5jwE5QWgAWWZP5j4
 grPDO0wOnWLA==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="223091312"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="223091312"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 06:42:55 -0700
IronPort-SDR: xj6m4cZ3QJ+FiRUX9g95RzhYM4oMQdGx4xwaLc+q6WdoduiqsiRCXzpZBtJSGLOBCFOhzhNnHG
 horj1olH75RA==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="614111067"
Received: from bwheeler-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.57.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 06:42:55 -0700
Subject: Re: [PATCH v5 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <e4dc31d5-d897-50fa-34e7-f5c033d5f5db@linux.intel.com>
 <20210524060221.519093-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <4295dab3-7675-9146-ac6e-244704ecfcca@nextfour.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0a663bde-c301-d326-2b19-ca52719a5855@linux.intel.com>
Date:   Mon, 24 May 2021 06:42:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4295dab3-7675-9146-ac6e-244704ecfcca@nextfour.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/21 11:40 PM, Mika Penttilä wrote:
> 
> So this isn't supporting suspend/resume if AP cannot started again?

Yes. You are correct. It can be used only once per AP. Please find the
spec reference below.

/*
  * According to the ACPI specification r6.4, sec 5.2.12.19, the
  * mailbox-based wakeup mechanism cannot be used more than once
  * for the same CPU, so skip sending wake commands to already
  * awake CPU.
  */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
