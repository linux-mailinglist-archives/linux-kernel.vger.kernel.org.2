Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB173A0B13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhFIEWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:22:11 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41759 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhFIEWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:22:09 -0400
Received: by mail-pl1-f172.google.com with SMTP id e1so447824plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bs3uZdvOT93iM0KqnsTU8Lk1NN9d/mSLUz/TWZWlHps=;
        b=2HIDTC2aIjVjF002lGg1LYbJGbq5blVjuEVimngrdoPbkz78VePzpavmVuLJQSlDEs
         NZ+kJ4I7nfI6i3qqcuE5HxtEx/T0kZr36y/dkc/CBWoU9ElV1KFQkITENYkO0dRamI+r
         swwvl3VKlplTVGKqQsQQ9s/CAV96OO55YMm+Zuf4S/9N0eRmgjUB9QI2mO4DgCEoSxee
         uYo6zSdqDGs7/zzu/377BFES4eIUoUi70NlnoOgISr1glNigDhnegZ1nH6zdSYumsG59
         RjkDeu/ivBRGx8KK7+gB5/m5kFIA85fCeA90R3+eiXCarUV/ttxsjCmPRPChxMI5CYY0
         jq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bs3uZdvOT93iM0KqnsTU8Lk1NN9d/mSLUz/TWZWlHps=;
        b=obusxaNZebNcGiIln0zhWNnV8OHi5xyjtaoYw9fk9DB74PSsJlW8vxBI2z0NGVPFh6
         sDkepxSfBrlNlN7Z/l0XX50moHUtXxy7/MEl2dkOKbzurZ8NU9k4otjKR/fJ87PRhWMS
         ofvd+8d7Qa3Cw9fuCEby0Os7SSZ8cE8oxtIu7QQ7BXX4PCJfigrL9NBWgMfHlFpUp4/b
         ceMxKdD4OZvA0tQNMDUSMH8jgEfcYgST/Jq6ZIlhGlEQeT5A5ESS6SGZ4mN5PMMrhhLh
         XW8b+v3ydXORk25oSfKYvGDa7uF4sar/O4PosYj9Jw4MAgv7LuASv83bZCwhYH6IfUYe
         kKsA==
X-Gm-Message-State: AOAM530C8fAFYb9fOJK85d42ZVqznugu4pCydaomZcn94S+WsYaqXiCY
        RatY+Ic2h7jaSKtxNIK//MGkf3qeYIz59Bc8a+VChg==
X-Google-Smtp-Source: ABdhPJxi8t3fBRKgv8JuF+vtdRacsfcP1/kmJk/oPSw5AVexAI49bsHcn4oLO25NcUb5cD6/4Ju+OvGl7QJGp4S/rSA=
X-Received: by 2002:a17:90a:8589:: with SMTP id m9mr2131653pjn.168.1623212355561;
 Tue, 08 Jun 2021 21:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com> <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com>
In-Reply-To: <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 21:19:04 -0700
Message-ID: <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX guest
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 8:56 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 6/8/21 8:40 PM, Dan Williams wrote:
> > ..."KVM gets away with it" is not a justification that TDX can stand
> > on otherwise we would not be here fixing up ACPICA properly.
> >
> > How about:
> >
> > "TDX guests use standard ACPI mechanisms to signal sleep state entry
> > (including reboot) to the host. The ACPI specification mandates WBINVD
> > on any sleep state entry with the expectation that the platform is
> > only responsible for maintaining the state of memory over sleep
> > states, not preserving dirty data in any CPU caches. ACPI cache
> > flushing requirements pre-date the advent of virtualization. Given TDX
> > guest sleep state entry does not affect any host power rails it is not
> > required to flush caches. The host is responsible for maintaining
> > cache state over its own bare metal sleep state transitions that
> > power-off the cache. If the host fails to manage caches over its sleep
> > state transitions the guest..."
>
> >
> > I don't know how to finish the last sentence. What does TDX do if it
> > is resumed after host suspend and the host somehow arranged for dirty
> > TDX lines to be lost.
>
> TDX guest does not support S3. It will be disabled in ACPI tables. It
> is a TDX firmware spec requirement. Please check the following spec,
> sec 2.1
>
> https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.pdf

I'm not asking about TDX guest entering S3...

>
> In TDX guest, we encounter cache flushes only in shutdown and reboot path.
> So there is no resume path.

Host is free to go into S3 independent of any guest state. A hostile
host is free to do just enough cache management so that it can resume
from S3 while arranging for TDX guest dirty data to be lost. Does a
TDX guest go fatal if the cache loses power?
