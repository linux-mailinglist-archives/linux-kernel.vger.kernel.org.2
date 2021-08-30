Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C756F3FBABE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhH3RTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3RTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:19:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EB2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:18:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3b00d8cdf5b388faf601.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3b00:d8cd:f5b3:88fa:f601])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 514381EC0372;
        Mon, 30 Aug 2021 19:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630343902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EF59Jr9JFL0YZdk5cuPM1SZMACu1YSWUDCPD4wfWTRg=;
        b=obbQagMQlvy3HZhShbpEWRm7kXJyjc9+kZszTnkThlsin0qNSS0QttEZRYX6QArYBUXONu
        FZ1NbgMt9OoxLP52SudebTi9CHleOwKoeHKlvAGgWtXL85U6i5/Qj4OBl7iTXyQq3RCOPo
        ogUcaJ5hK7Q7RiPVTfcplE4TYwvRTjg=
Date:   Mon, 30 Aug 2021 19:18:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 10/26] x86/fpu/xstate: Update the XSTATE buffer
 address finder to support dynamic states
Message-ID: <YS0TA5FlI9nDfV8+@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-11-chang.seok.bae@intel.com>
 <YRzwB+fAEotDf4d7@zn.tnic>
 <E134A33E-C6B0-4325-A852-E426F305F387@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E134A33E-C6B0-4325-A852-E426F305F387@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 07:47:04PM +0000, Bae, Chang Seok wrote:
> It was refactored to use in the new helper to find feature_nr’s start point.

Which new helper?

> If the size is added up here, it is not ‘i’'s start point anymore.

Yeah, sorry, I have only a very slight idea what you mean here - you'll
have to try again.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
