Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727623AD622
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhFRXvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhFRXvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:51:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A68EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:49:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624060172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PtTo24AhDPIH9qt+rhf64KdODBLy4eXQI/xHF5KzK4w=;
        b=ucngxJVeFa2algjCcMptiBxBESUirb6TfP/IT4DnCDdvqnf4TSn83Hf88RQxKmlsxSsOHe
        UsHFGcZRSKs86toG307HG13Q7G3y2Em5wyovDkHJ9R+VAZ2DVRSUVQM+NdOQQ9g6w1GbXz
        sW/kqODfQDacZU7mEng+RpY/2v1OwXk88c3c50coTAf0UsqJRGj6PYiQIJUUZZrdml+f7N
        g7fQwjmsUoFWWIob6TDg6VJHYYlwuKc1b47yFnG3AwNIpsVI71YXICtpmncMB20bVWDfXp
        Z9G6o0i0+SRg6Qer3psZ0CSV9fjorzqWn6ZIvEsZTVPXzFcqV+PaNiolovvzvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624060172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PtTo24AhDPIH9qt+rhf64KdODBLy4eXQI/xHF5KzK4w=;
        b=DYuYou+1tqoB2T90IoEW/NBCXIDA+H55dZ6W6iEP1Cs5Wb+7+TURJ1SbUYxwJ3V5yMNXou
        SheEICLnSD+uS6Bg==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch V3 61/66] x86/fpu/signal: Sanitize the xstate check on sigframe
In-Reply-To: <e166f71b-bd83-04b1-27d7-cea59ebe81fb@citrix.com>
References: <20210618141823.161158090@linutronix.de> <20210618143451.325530702@linutronix.de> <e166f71b-bd83-04b1-27d7-cea59ebe81fb@citrix.com>
Date:   Sat, 19 Jun 2021 01:49:31 +0200
Message-ID: <87h7huensk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Fri, Jun 18 2021 at 22:02, Andrew Cooper wrote:
> On 18/06/2021 15:19, Thomas Gleixner wrote:
>> -static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32;
>> +static struct _fpx_sw_bytes fx_sw_reserved, fx_sw_reserved_ia32 __ro_after_init;
>
> You probably want a second __ro_after_init here.

Ooops.

Thanks for spotting it!

       tglx

