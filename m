Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27E389EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhETHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:12:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETHME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:12:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621494642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0BTMhddbZGyn/pTsLIp/5Yi+WfBfms4m42j5DDjw4g=;
        b=3DcmYUSvdb+aniXYdKdQcDEb6L/X+wCJ00GqDCvR5xe71cAmhEl/y+ftskeeNywb2gPJQ9
        HmVf2RW4hf0aUfsU32cXH7aSlLkYnnEkcnzp1HYgtj5Ab9oUZYVFh9aFdKFMMxvjag1G+s
        1AEQvNsODcnr9bTecDuTwIffUGZcqRAydlpSubpeXSlnNmPqCSCUVxxekda1judHqAKBx8
        P7BrGkaLdPrgkKDlufi980DBgKr4gsl6seD6moNTUC1zfRjqkArHtoYmQz3x+ScauvX76q
        qg1UYTTrtwBK9jwhsQnBUEOIWRmrtcF3IjfmYO1cEqUnBNMl9fcI6Dk/lhrkCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621494642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0BTMhddbZGyn/pTsLIp/5Yi+WfBfms4m42j5DDjw4g=;
        b=yb5aO5z9VFViCGIdSngIq+SO+r9S0A2wtwjfhGqEL1BflhPkTEs8gJvVkeRR8UEdJk2uFj
        QKnb1QKMbwRqAIBw==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
In-Reply-To: <E1F71F76-747B-4A22-98A2-5FBF17B83A1A@zytor.com>
References: <20210519212154.511983-1-hpa@zytor.com> <20210519212154.511983-2-hpa@zytor.com> <87bl96cqqy.ffs@nanos.tec.linutronix.de> <E1F71F76-747B-4A22-98A2-5FBF17B83A1A@zytor.com>
Date:   Thu, 20 May 2021 09:10:41 +0200
Message-ID: <878s49dgni.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19 2021 at 15:24, H. Peter Anvin wrote:

  A: Because it messes up the order in which people normally read text.
  Q: Why is top-posting such a bad thing?

  A: Top-posting.
  Q: What is the most annoying thing in e-mail?

  A: No.
  Q: Should I include quotations after my reply?

> On May 19, 2021 3:17:57 PM PDT, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Wed, May 19 2021 at 14:21, H. Peter Anvin wrote:
>>> The x86 architecture supports up to 32 trap vectors. Add that
>>> constant to <asm/trapnr.h>.
>>
>> Where is that actually used?
>
> It is not right now, but it will be used in the FRED enabling patchset
> at the very least (since the number of exception vectors and
> FIRST_EXTERNAL_VECTOR are not necessarily the same anymore.)

Then add it with FRED. Defining unused stuff will just result in cleanup
patches which removed unused defines...

Thanks,

        tglx
