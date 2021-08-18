Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D13F0E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 00:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhHRW2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Aug 2021 18:28:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:52412 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhHRW2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 18:28:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="280178010"
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="280178010"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 15:27:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,332,1620716400"; 
   d="scan'208";a="531873941"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2021 15:27:42 -0700
Received: from tjmaciei-mobl5.localnet (10.209.60.224) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 18 Aug 2021 23:27:38 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/26] x86/fpu/xstate: Use feature disable (XFD) to protect dynamic user state
Date:   Wed, 18 Aug 2021 15:27:35 -0700
Message-ID: <2658618.gP76fVu5Ab@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <C3EBA85C-8708-4BAD-BB78-C975250BEFFF@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com> <3399412.qF98CnctbS@tjmaciei-mobl5> <C3EBA85C-8708-4BAD-BB78-C975250BEFFF@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.209.60.224]
X-ClientProxiedBy: orsmsx605.amr.corp.intel.com (10.22.229.18) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 18 August 2021 14:12:06 PDT Bae, Chang Seok wrote:
> On Aug 18, 2021, at 14:04, Thiago Macieira <thiago.macieira@intel.com>
> wrote:
> > But it's not the only possible solution. A future kernel could decide to
> > leave some bits off and only enable upon request. That's how
> > macOS/Darwin does its AVX512 support.
> 
> 
> Even if XCR0 is ever switched, doesn’t XGETBV(0) return it for the
> *current*  task?

That's the point. If the kernel decides that feature bit 19 will be left off 
in XCR0, how shall userspace know the kernel supports the feature through the 
arch_prctl syscall you added?

Not that I am advising we adopt this strategy. We don't need more 
fragmentation on how we enable the features. But having this syscall gives us 
flexibility in case we do need it in the future.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



