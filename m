Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624B8396848
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEaTQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 15:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhEaTQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 15:16:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 12:14:53 -0700 (PDT)
Received: from zn.tnic (p200300ec2f080f00caafab4a831a2d08.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:f00:caaf:ab4a:831a:2d08])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 814481EC0570;
        Mon, 31 May 2021 21:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622488491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tzOm/G5qfBYV1P1hRsvP4m2wExoTfbnjW+M/2R/uxaM=;
        b=FWSJ2LNsRYwnvOTJbHXhOVfNDRR1506QAP7UysJLaeVjadc7DLZgICluyPUbaUcOLQcQJO
        K5YUEdtMy8KxcNuwXj+az0r/L6G2pqkHU8MyasRLtJbSnQrQndn0k7JBr/o5DQ4+aRWvXS
        KJ7nQc3q2B1Eax4/ZyLt37VB8g3YPiI=
Date:   Mon, 31 May 2021 21:14:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
Message-ID: <YLU1peNu/744jR/R@zn.tnic>
References: <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic>
 <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <YKgA1od/SqycWWds@zn.tnic>
 <86b4d995-9619-81fa-5ef4-86f48ab01e96@amd.com>
 <a94e1fb8-50bf-ef69-6553-237937029c5d@linux.intel.com>
 <YLT9AGodkvct8YTO@zn.tnic>
 <96a63ddf-98f9-7095-f7bb-100bf56a4d10@linux.intel.com>
 <YLUjCqdPu/8eWuB+@zn.tnic>
 <280669ec-d43a-83af-55ba-ad03411538b5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <280669ec-d43a-83af-55ba-ad03411538b5@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:45:38AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> We can also use protected_guest_has(VM_VIRTIO_SECURE_FIX) or something
> similar for this purpose. Andi, any comments?

protected_guest_has() is enough for that - no need for two functions.

> IMHO, its better to use above generic config option in common header
> file (linux/protected_guest.h). Any architecture that implements
> protected guest feature can enable it. This will help is hide arch
> specific config options in arch specific header file.

You define empty function stubs for when the arch config option is not
enabled. Everything else is unnecessary. When another architecture needs
this, then another architecture will generalize it like it is usually
done.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
