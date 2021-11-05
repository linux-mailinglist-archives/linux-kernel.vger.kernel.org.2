Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B90B446AF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhKEWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhKEWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:44:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F12C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:41:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 127so10129399pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RKFhKV3LHdn4kWJrl1IZufQaNytFJcypgLXt2t47CaE=;
        b=AFqc0U7z1fdj5Fc1F6jpUP7OMzpwvRabNaAKrNSmNaIOXCwF5Px19CeoDSsVsekX+H
         qGNq1bLpE7HU4u0jK8O0jpWcSMdustiZI69p1x8FR2Y4W7by/UQE/+kqCrTuRzbEkNV/
         nfq1gWgFw7NBJNUrjIOJ1ZeUrVP8peLWPL2GH8mNbHo3RvYbohLmsBh8BB+w8SXQ3G05
         iOcwBui9ZdOxmGb6T/nMW9HbmOX93tU86QN9V6l/Un4i0dxoffgRTAYSAn0AaIxe4M5N
         QiRrI5dyR3cJ5MSjsRZKqpVA27r8L7inC3TUP6wEwbaq3wN6Vq32+rRR7FdEL4vLWbju
         76bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RKFhKV3LHdn4kWJrl1IZufQaNytFJcypgLXt2t47CaE=;
        b=MqaYnmZUDUbfIw5AaAt/A5Ynfulmk4rRyrA4NYUmG7pKc55wnEMkbUTLrxoIMVoIo+
         0IMlY7ZoGRDd0AIfNwlTrz0RDP27oVVO5mdoXcW1cpa5WzNF2w4oisHqZQX3l3LTUarH
         T37CgsmyGL3yFF8yA0ckD9c9aS+S/hZd8m6t1dy2GVD6d5GkHXWvsxiybxj1yy6XOV5d
         eWGXY3syOfHzT7CZceGtu09v1zH6kb8g+HIH//XmgTzzDS/iuHDWbqSJ+PgQFLbF4iQ7
         SKLkc1ErDLA0g/YSlk2qbOgMg2SQlGAfBVEGdMUh7CU/MM7kfhT9+LtR2U9wQ/BwxBYY
         CXfA==
X-Gm-Message-State: AOAM533nqCrS+EKmla8+/G3NnSVh8603Gwu4XaRd/bfiYExMbmWBZF07
        RMfz22YFLUmziEHSKgjlP2QssQ==
X-Google-Smtp-Source: ABdhPJwwmnpJPkfeItkz37xqp2m5sS+LBml/avb8CRSmncJrbsFTSPsXq8Z176MHjopw3YcD297Fng==
X-Received: by 2002:a05:6a00:16cb:b0:44b:bd38:e068 with SMTP id l11-20020a056a0016cb00b0044bbd38e068mr62757719pfc.34.1636152080786;
        Fri, 05 Nov 2021 15:41:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u38sm3165193pfg.0.2021.11.05.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:41:20 -0700 (PDT)
Date:   Fri, 5 Nov 2021 22:41:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/10] x86/tdx: Handle in-kernel MMIO
Message-ID: <YYWzDKkH3ZDS1b2J@google.com>
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-10-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005204136.1812078-10-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
> @@ -207,6 +210,103 @@ static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
>  	}
>  }
>  
> +static unsigned long tdx_mmio(int size, bool write, unsigned long addr,
> +			      unsigned long *val)
> +{
> +	struct tdx_hypercall_output out = {0};
> +	u64 err;
> +
> +	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
> +			     addr, *val, &out);
> +	*val = out.r11;

Val should not be written on error, and writing it for "write" is also weird.

> +	return err;
> +}
> +
> +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	char buffer[MAX_INSN_SIZE];
> +	unsigned long *reg, val;
> +	struct insn insn = {};
> +	enum mmio_type mmio;
> +	int size, ret;
> +	u8 sign_byte;
> +
> +	if (user_mode(regs)) {
> +		ret = insn_fetch_from_user(regs, buffer);
> +		if (!ret)
> +			return -EFAULT;
> +		if (!insn_decode_from_regs(&insn, regs, buffer, ret))
> +			return -EFAULT;
> +	} else {
> +		ret = copy_from_kernel_nofault(buffer, (void *)regs->ip,
> +					       MAX_INSN_SIZE);
> +		if (ret)
> +			return -EFAULT;
> +		insn_init(&insn, buffer, MAX_INSN_SIZE, 1);
> +		insn_get_length(&insn);
> +	}
> +
> +	mmio = insn_decode_mmio(&insn, &size);
> +	if (mmio == MMIO_DECODE_FAILED)
> +		return -EFAULT;
> +
> +	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
> +		reg = insn_get_modrm_reg_ptr(&insn, regs);
> +		if (!reg)
> +			return -EFAULT;
> +	}
> +
> +	switch (mmio) {
> +	case MMIO_WRITE:
> +		memcpy(&val, reg, size);
> +		ret = tdx_mmio(size, true, ve->gpa, &val);
> +		break;
> +	case MMIO_WRITE_IMM:
> +		val = insn.immediate.value;
> +		ret = tdx_mmio(size, true, ve->gpa, &val);
> +		break;
> +	case MMIO_READ:
> +		ret = tdx_mmio(size, false, ve->gpa, &val);

val is never set, i.e. this is leaking stack data to the untrusted VMM.

> +		if (ret)
> +			break;
> +		/* Zero-extend for 32-bit operation */
> +		if (size == 4)
> +			*reg = 0;
> +		memcpy(reg, &val, size);
> +		break;
> +	case MMIO_READ_ZERO_EXTEND:
> +		ret = tdx_mmio(size, false, ve->gpa, &val);

And here.

> +		if (ret)
> +			break;
> +
> +		/* Zero extend based on operand size */
> +		memset(reg, 0, insn.opnd_bytes);
> +		memcpy(reg, &val, size);
> +		break;
> +	case MMIO_READ_SIGN_EXTEND:
> +		ret = tdx_mmio(size, false, ve->gpa, &val);

And here.

> +		if (ret)
> +			break;
> +
> +		if (size == 1)
> +			sign_byte = (val & 0x80) ? 0xff : 0x00;
> +		else
> +			sign_byte = (val & 0x8000) ? 0xff : 0x00;
> +
> +		/* Sign extend based on operand size */
> +		memset(reg, sign_byte, insn.opnd_bytes);
> +		memcpy(reg, &val, size);
> +		break;
> +	case MMIO_MOVS:
> +	case MMIO_DECODE_FAILED:
> +		return -EFAULT;
> +	}
> +
> +	if (ret)
> +		return -EFAULT;
> +	return insn.length;
> +}
> +
>  unsigned long tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out = {0};
> @@ -256,6 +356,14 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
>  	case EXIT_REASON_IO_INSTRUCTION:
>  		tdx_handle_io(regs, ve->exit_qual);
>  		break;
> +	case EXIT_REASON_EPT_VIOLATION:
> +		/* Currently only MMIO triggers EPT violation */
> +		ve->instr_len = tdx_handle_mmio(regs, ve);
> +		if (ve->instr_len < 0) {
> +			pr_warn_once("MMIO failed\n");

That's not remotely helpful.  Why not?

		if (WARN_ON_ONCE(ve->instr_len < 0))
			return -EFAULT;

> +			return -EFAULT;
> +		}
> +		break;
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return -EFAULT;
> -- 
> 2.25.1
> 
