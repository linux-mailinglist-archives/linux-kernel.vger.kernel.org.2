Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23CE3127F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 23:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhBGWqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 17:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 17:46:08 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B513C061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 14:45:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id g15so9017978pgu.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 14:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=V0uopCc+Y0QYk8iwQ9m6+FASFiFg80AicIAk+4GVhA4=;
        b=OuoHrdLNj1xzOmH/0X2jABl3LFXwoN1N8uC2wxTNrBak4c8wnDMmCgcrzW7F39Kw5Y
         I75KpRXclZJs5OxWQGk471VgdFlIa4Z4wIWWNlWY5aWIjqODOKwIZEc6DWI1Q/0jCKqR
         oRDKXY7GrVPCk8y+d/DSiBsHW2uM6TvaT/oDuB+DTbvoWbKwNbWkuAg7pzNCg0scAU07
         MPBKMt0Lxp3aUNlzP40hmCdvZdPj5FcoNH/txikY8PQZDnbU2zKRP9P3Z1x0hbgoQ9jd
         laFm+AgeZ/gdzE6BnPDVr+gJlTV+lwSjMdeZgwVWu4F347viA71cVm5P4+oJEWix65eg
         yhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=V0uopCc+Y0QYk8iwQ9m6+FASFiFg80AicIAk+4GVhA4=;
        b=UepJGSXgN3I6fjrYWNA+mb40rUUGz0aCPruZg9vvb2ZQCtkKqRLi8IyUV5i0PsVYu3
         TISTU9UC/J47FqljuoP5xIbF+hq0KpEIST5uAuEP8xS/cexVxYWlAJDAUKaNb62QTlY6
         ooJc1ogjPdm/1Pg8S2tgZZ9IL8fGWHWf2LbySql2gz2HFRO3OAPOCUsx2awPO1ADdqE2
         /sKhwSo9OabLKXEDrbOmtyaoqujkUSaNB5I8hdma7/W2Au+D+JYjfsuAqR+B7W2tOZFh
         xrb4kMosOLvwEiQRmjyP7yaJ/FWjTPH4Ug0GMsLvXUdSNkU8nTxIitLaBu6qPDfvAuZJ
         NDgA==
X-Gm-Message-State: AOAM531zUZWF+33qnvO4Gvv3h172Tpo1CqEz1TonaObuCXAVuST1UEqT
        ftiOCAKP4DLi/saOd27VhGpRkA==
X-Google-Smtp-Source: ABdhPJy72Bg2svmBHXxD0gTq2s8+vPaNzQd4gVbBa5VUcB1H6EPjFdKyxkpnF8r9Ci88GbhjuLK7ag==
X-Received: by 2002:a05:6a00:15d2:b029:1b7:30c1:8495 with SMTP id o18-20020a056a0015d2b02901b730c18495mr14853352pfu.32.1612737928063;
        Sun, 07 Feb 2021 14:45:28 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:95e2:2f3b:be35:8413? ([2601:646:c200:1ef2:95e2:2f3b:be35:8413])
        by smtp.gmail.com with ESMTPSA id y7sm978492pfl.127.2021.02.07.14.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 14:45:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
Date:   Sun, 7 Feb 2021 14:45:26 -0800
Message-Id: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
References: <f81afd12-91ed-27c9-58d6-e59e7e1178c0@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f81afd12-91ed-27c9-58d6-e59e7e1178c0@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 7, 2021, at 2:31 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 2/7/21 12:29 PM, Kirill A. Shutemov wrote:
>>> Couldn't you just have one big helper that takes *all* the registers
>>> that get used in any TDVMCALL and sets all the rcx bits?  The users
>>> could just pass 0's for the things they don't use.
>>>=20
>>> Then you've got the ugly inline asm in one place.  It also makes it
>>> harder to screw up the 'rcx' mask and end up passing registers you
>>> didn't want into a malicious VMM.
>> For now we only pass down R10-R15, but the interface allows to pass down
>> much wider set of registers, including XMM. How far do we want to get it?=

>=20
> Just do what we immediately need: R10-R15
> .
>=20

How much of the register state is revealed to the VMM when we do a TDVMCALL?=
  Presumably we should fully sanitize all register state that shows up in cl=
eartext on the other end, and we should treat all regs that can be modified b=
y the VMM as clobbered.=
