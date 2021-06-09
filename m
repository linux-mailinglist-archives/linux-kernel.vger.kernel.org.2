Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3103A0B45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhFIE3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:29:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:3083 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhFIE3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:29:43 -0400
IronPort-SDR: ggVz6ONT0wxMqoSJFz1LIHZ8Q42QZ2ShUwES1UFzNj5qn3Fp36QwpDLFxNxbgkqaZD/6LXHDH5
 OO4Hw75oBe5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192108947"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="192108947"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:27:49 -0700
IronPort-SDR: HeCT/nqKrfuPjAXu1ylWArnlL11/p3d4W1Mpk4F9c7ii3IHEscWqrq749+a4ZB7i78+bc7B+g6
 nsmkqNOmc+Bw==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="551854385"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:27:49 -0700
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com>
 <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <ffedf1d2-e5ec-e0e3-8e83-edd186231029@linux.intel.com>
Date:   Tue, 8 Jun 2021 21:27:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


here is no resume path.

> Host is free to go into S3 independent of any guest state.

Actually my understanding is that none of the systems which support TDX 
support S3. S3 has been deprecated for a long time.


>   A hostile
> host is free to do just enough cache management so that it can resume
> from S3 while arranging for TDX guest dirty data to be lost. Does a
> TDX guest go fatal if the cache loses power?

That would be a machine check, and yes it would be fatal.

-Andi

