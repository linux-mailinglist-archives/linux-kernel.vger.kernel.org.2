Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B138B9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 00:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhETWtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhETWtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 18:49:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE11C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:47:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f12so21752267ljp.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MK6UuBIOW5R2C8Iik+b838Uyxt1hZt7UCg8fzYUlkJM=;
        b=Kbv1b3W4u6if/TbnXml6z6WLZX+vV6pJa2chv2sir1ieVIBNCwWC2xK0iKDDKHnvZR
         wqMFJJeDewYui9uxx85KPo3lNmuMvF0p+ctdANp7OEWGNaqzUfVagn2xRvEQaWdH54r9
         XFsF6j2e/O5g98r7P6HyCZn0nai5BKkY0FvEdvHzeYq5DAcicVkIm/uKbMtaBowQyfsK
         3ihSx9HueMCxrbBaHmrzYzwHg/rJCZpl5UsP89QoQu0U6RH+rVJvFI0jQix9Aiq4O0jF
         FuF/TYCL7gmKHm2J8wUK40GuhvB94v52P06n1qUCiieafFgDbW9ncNjHJc1OZRmm7Ikf
         qyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MK6UuBIOW5R2C8Iik+b838Uyxt1hZt7UCg8fzYUlkJM=;
        b=PDKYM5b/PW0tU9whlsH3Me6WwzHi02cHaEFI1nocneZJKy1S75YqFJHDMIGt6CbmVW
         pXRBU39g02lNhidh4f4VhmJ+pjAcJLwuj4U2oofUI9yupAqM0Vk4ep4cW0AHHPcZzgDw
         zw5WgsHhZNqygUFuETU+j5V9dOGlZUwuiQtm49VPw7g7n2Gt32vB33CRQoW3bZf73Bzp
         8QYxs2oneerr9bZg1lwPTum474OXZgKhI33PBTHqxgzX0B8nJRONhIqXPZ45kd8HXhnW
         oypXoJTQG7hTo+luz7gXmYiYL/dFYCcBmAfqDldfszTiP9jshES68+M6OmYUWe9N1pC9
         4YQw==
X-Gm-Message-State: AOAM531IlAMsbWW+hfpLVP/w3njNd/79RXFu/Tl1qmFK4RuOi6ul6/BV
        Qw6nq/Ss+ghKasCEaZZfWVYmUw==
X-Google-Smtp-Source: ABdhPJy1yWBktF2zEtLYvCS2iJbCI0D40LFFUKeD8jKIFoUzmWKkuQ+OrXTerLh10M0JuhL8Vf0SUA==
X-Received: by 2002:a2e:a373:: with SMTP id i19mr4523970ljn.49.1621550868249;
        Thu, 20 May 2021 15:47:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q15sm422512lfc.177.2021.05.20.15.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 15:47:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3989710174D; Fri, 21 May 2021 01:47:50 +0300 (+03)
Date:   Fri, 21 May 2021 01:47:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
Message-ID: <20210520224750.xjrf6zteya5qsnhk@box.shutemov.name>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <YKPo2Zde5b0QxIPJ@google.com>
 <d8c87904-d994-8a5a-c0e8-be861fcac6df@linux.intel.com>
 <YKQEoMau3ovCzJ1W@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKQEoMau3ovCzJ1W@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 06:17:04PM +0000, Sean Christopherson wrote:
> On Tue, May 18, 2021, Andi Kleen wrote:
> > > Why does this code exist at all?  TDX and SEV-ES absolutely must share code for
> > > handling MMIO reflection.  It will require a fair amount of refactoring to move
> > > the guts of vc_handle_mmio() to common code, but there is zero reason to maintain
> > > two separate versions of the opcode cracking.
> > 
> > While that's true on the high level, all the low level details are
> > different. We looked at unifying at some point, but it would have been a
> > callback hell. I don't think unifying would make anything cleaner.
> 
> How hard did you look?  The only part that _must_ be different between SEV and
> TDX is the hypercall itself, which is wholly contained at the very end of
> vc_do_mmio().

I've come up with the code below. decode_mmio() can be shared with SEV.

I don't have a testing setup for AMD. I can do a blind patch, but it would
be much more productive if someone on AMD side could look into this.

Any opinions?

enum mmio_type {
	MMIO_DECODE_FAILED,
	MMIO_WRITE,
	MMIO_WRITE_IMM,
	MMIO_READ,
	MMIO_READ_ZERO_EXTEND,
	MMIO_READ_SIGN_EXTEND,
	MMIO_MOVS,
};

static enum mmio_type decode_mmio(struct insn *insn, struct pt_regs *regs,
				  int *bytes)
{
	int type = MMIO_DECODE_FAILED;

	*bytes = 0;

	switch (insn->opcode.bytes[0]) {
	case 0x88: /* MOV m8,r8 */
		*bytes = 1;
		fallthrough;
	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
		if (!*bytes)
			*bytes = insn->opnd_bytes;
		type = MMIO_WRITE;
		break;

	case 0xc6: /* MOV m8, imm8 */
		*bytes = 1;
		fallthrough;
	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
		if (!*bytes)
			*bytes = insn->opnd_bytes;
		type = MMIO_WRITE_IMM;
		break;

	case 0x8a: /* MOV r8, m8 */
		*bytes = 1;
		fallthrough;
	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
		if (!*bytes)
			*bytes = insn->opnd_bytes;
		type = MMIO_READ;
		break;

	case 0xa4: /* MOVS m8, m8 */
		*bytes = 1;
		fallthrough;
	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
		if (!*bytes)
			*bytes = insn->opnd_bytes;
		type = MMIO_MOVS;
		break;

	case 0x0f: /* Two-byte instruction */
		switch (insn->opcode.bytes[1]) {
		case 0xb6: /* MOVZX r16/r32/r64, m8 */
			*bytes = 1;
			fallthrough;
		case 0xb7: /* MOVZX r32/r64, m16 */
			if (!*bytes)
				*bytes = 2;
			type = MMIO_READ_ZERO_EXTEND;
			break;

		case 0xbe: /* MOVSX r16/r32/r64, m8 */
			*bytes = 1;
			fallthrough;
		case 0xbf: /* MOVSX r32/r64, m16 */
			if (!*bytes)
				*bytes = 2;
			type = MMIO_READ_SIGN_EXTEND;
			break;
		}
		break;
	}

	return type;
}

static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
{
	int size;
	unsigned long *reg;
	struct insn insn;
	unsigned long val = 0;

	kernel_insn_init(&insn, (void *) regs->ip, MAX_INSN_SIZE);
	insn_get_length(&insn);
	insn_get_opcode(&insn);

	reg = get_reg_ptr(&insn, regs);

	switch (decode_mmio(&insn, regs, &size)) {
	case MMIO_WRITE:
		memcpy(&val, reg, size);
		tdg_mmio(size, true, ve->gpa, val);
		break;
	case MMIO_WRITE_IMM:
		val = insn.immediate.value;
		tdg_mmio(size, true, ve->gpa, val);
		break;
	case MMIO_READ:
		val = tdg_mmio(size, false, ve->gpa, val);
		/* Zero-extend for 32-bit operation */
		if (size == 4)
			*reg = 0;
		memcpy(reg, &val, size);
		break;
	case MMIO_READ_ZERO_EXTEND:
		val = tdg_mmio(size, false, ve->gpa, val);

		/* Zero extend based on operand size */
		memset(reg, 0, insn.opnd_bytes);
		memcpy(reg, &val, size);
		break;
	case MMIO_READ_SIGN_EXTEND:
		val = tdg_mmio(size, false, ve->gpa, val);

		/* Sign extend based on operand size */
		if (val & (size == 1 ? 0x80 : 0x8000))
			memset(reg, 0xff, insn.opnd_bytes);
		else
			memset(reg, 0, insn.opnd_bytes);
		memcpy(reg, &val, size);
		break;
	case MMIO_MOVS:
	case MMIO_DECODE_FAILED:
		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) ve->gla);
		return 0;
	}

	return insn.length;
}

-- 
 Kirill A. Shutemov
