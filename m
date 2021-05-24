Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC36638EE1B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhEXPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:45:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:16417 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232897AbhEXPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:41:20 -0400
IronPort-SDR: VMTJl6GSCVPXA6figqlrJfhvtWUd6mCUpqK01/9Jyk7kI/Lw2NUgqXMjHWYoGW2dUJDLxDm0sl
 NZ2XZFxlL9gQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="201983288"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="201983288"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 08:35:36 -0700
IronPort-SDR: 6JNNC3Pogyso/KGGAfNwiSQQxJuKMQaOAmms9AWVnpqpVGz3xbImhi0RuJZpX40sNJ/sJHpT+2
 Saxqy2AV7llw==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="614145671"
Received: from bwheeler-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.57.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 08:35:35 -0700
Subject: Re: [PATCH v5 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <e4dc31d5-d897-50fa-34e7-f5c033d5f5db@linux.intel.com>
 <20210524060221.519093-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <2592439.mvXUDI8C0e@kreacher>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b75f5418-e839-7946-93e1-a2b057673866@linux.intel.com>
Date:   Mon, 24 May 2021 08:35:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2592439.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/21 7:51 AM, Rafael J. Wysocki wrote:
> It would help if you CCed this tolinux-acpi@vger.kernel.org.

Sorry. Since it did not touch code in drivers/acpi, I missed to add it.

Shall I bump the version and resend it with proper CC?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
