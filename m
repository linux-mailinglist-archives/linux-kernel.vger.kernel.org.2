Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89C33264E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZPp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:45:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhBZPpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:45:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC10064EC4;
        Fri, 26 Feb 2021 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614354310;
        bh=7NmQRozZ7mAFH/uNMd/JSu3yi3u2x2VT8yp7NbbnUk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l8BSnEdac0l0gTsTYEbTCnqAsifpK4+IY8Bk1E+xkmUgbTRcEkRg2qBGRnejOQWLt
         4Rat2AsIB24MkA1ycpik0yrmdkIup4vCf8F/wyqEtG94XM+P9bq8G6Z4N0A439L5KR
         Zm6GtPccNgIdyGTLfuU8/f2m+26A4Go1ZIYfgMsmGWVCgJinarSPf7qK2h82GDDGvQ
         ubu5doKep3hlBngF2scCNkV3eTtOBAYlwYQbmy0J68MS4653uHQ1VUA6aJggEDZFe6
         ErhHk1Qwn2xch6RplrdHpWDA4e1SA0Xs0JS7I1KBIEFXI+bhAbIZPvd9P5bPMzyqbE
         uxkWU/Z1Nb24Q==
Date:   Sat, 27 Feb 2021 00:45:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/21] x86/insn: Add an insn_decode() API
Message-Id: <20210227004506.2247a6709947977ee769755c@kernel.org>
In-Reply-To: <20210224110233.19715-5-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
        <20210224110233.19715-5-bp@alien8.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Wed, 24 Feb 2021 12:02:16 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Users of the instruction decoder should use this to decode instruction
> bytes. For that, have insn*() helpers return an int value to denote
> success/failure. When there's an error fetching the next insn byte and
> the insn falls short, return -ENODATA to denote that.
> 
> While at it, make insn_get_opcode() more stricter as to whether what has
> seen so far is a valid insn and if not.
> 

OK, but I think it should return -EINVAL or -EILSEQ for bad instruction.
And I found a bug.

[...]

> @@ -231,16 +243,25 @@ void insn_get_prefixes(struct insn *insn)
>   * If necessary, first collects any preceding (prefix) bytes.
>   * Sets @insn->opcode.value = opcode1.  No effect if @insn->opcode.got
>   * is already 1.
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error

OK, but

>   */
> -void insn_get_opcode(struct insn *insn)
> +int insn_get_opcode(struct insn *insn)
>  {
>  	struct insn_field *opcode = &insn->opcode;
> +	int pfx_id, ret;
>  	insn_byte_t op;
> -	int pfx_id;
> +
>  	if (opcode->got)
> -		return;
> -	if (!insn->prefixes.got)
> -		insn_get_prefixes(insn);
> +		return 0;
> +
> +	if (!insn->prefixes.got) {
> +		ret = insn_get_prefixes(insn);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* Get first opcode */
>  	op = get_next(insn_byte_t, insn);
> @@ -255,9 +276,13 @@ void insn_get_opcode(struct insn *insn)
>  		insn->attr = inat_get_avx_attribute(op, m, p);
>  		if ((inat_must_evex(insn->attr) && !insn_is_evex(insn)) ||
>  		    (!inat_accept_vex(insn->attr) &&
> -		     !inat_is_group(insn->attr)))
> -			insn->attr = 0;	/* This instruction is bad */
> -		goto end;	/* VEX has only 1 byte for opcode */
> +		     !inat_is_group(insn->attr))) {
> +			/* This instruction is bad */
> +			insn->attr = 0;
> +			return 1;

Here you return 1 for a bad opcode. 

> +		}
> +		/* VEX has only 1 byte for opcode */
> +		goto end;
>  	}
>  
>  	insn->attr = inat_get_opcode_attribute(op);
> @@ -268,13 +293,18 @@ void insn_get_opcode(struct insn *insn)
>  		pfx_id = insn_last_prefix_id(insn);
>  		insn->attr = inat_get_escape_attribute(op, pfx_id, insn->attr);
>  	}
> -	if (inat_must_vex(insn->attr))
> -		insn->attr = 0;	/* This instruction is bad */
> +
> +	if (inat_must_vex(insn->attr)) {
> +		/* This instruction is bad */
> +		insn->attr = 0;
> +		return 1;

Ditto.
Would you mean -EINVAL?

> +	}
>  end:
>  	opcode->got = 1;
> +	return 0;
>  
>  err_out:
> -	return;
> +	return -ENODATA;
>  }
>  
>  /**
> @@ -284,15 +314,25 @@ void insn_get_opcode(struct insn *insn)
>   * Populates @insn->modrm and updates @insn->next_byte to point past the
>   * ModRM byte, if any.  If necessary, first collects the preceding bytes
>   * (prefixes and opcode(s)).  No effect if @insn->modrm.got is already 1.
> + *
> + * Returns:
> + * 0:  on success
> + * < 0: on error



>   */
> -void insn_get_modrm(struct insn *insn)
> +int insn_get_modrm(struct insn *insn)
>  {
>  	struct insn_field *modrm = &insn->modrm;
>  	insn_byte_t pfx_id, mod;
> +	int ret;
> +
>  	if (modrm->got)
> -		return;
> -	if (!insn->opcode.got)
> -		insn_get_opcode(insn);
> +		return 0;
> +
> +	if (!insn->opcode.got) {
> +		ret = insn_get_opcode(insn);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (inat_has_modrm(insn->attr)) {
>  		mod = get_next(insn_byte_t, insn);
> @@ -302,17 +342,22 @@ void insn_get_modrm(struct insn *insn)
>  			pfx_id = insn_last_prefix_id(insn);
>  			insn->attr = inat_get_group_attribute(mod, pfx_id,
>  							      insn->attr);
> -			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr))
> -				insn->attr = 0;	/* This is bad */
> +			if (insn_is_avx(insn) && !inat_accept_vex(insn->attr)) {
> +				/* Bad insn */
> +				insn->attr = 0;
> +				return 1;

Here is another return 1. 

> +			}
>  		}
>  	}
>  
>  	if (insn->x86_64 && inat_is_force64(insn->attr))
>  		insn->opnd_bytes = 8;
> +
>  	modrm->got = 1;
> +	return 0;
>  
>  err_out:
> -	return;
> +	return -ENODATA;
>  }
>  
>  
> @@ -326,11 +371,16 @@ void insn_get_modrm(struct insn *insn)
>  int insn_rip_relative(struct insn *insn)
>  {
>  	struct insn_field *modrm = &insn->modrm;
> +	int ret;
>  
>  	if (!insn->x86_64)
>  		return 0;
> -	if (!modrm->got)
> -		insn_get_modrm(insn);
> +
> +	if (!modrm->got) {
> +		ret = insn_get_modrm(insn);
> +		if (ret)
> +			return ret;
> +	}
>  	/*
>  	 * For rip-relative instructions, the mod field (top 2 bits)
>  	 * is zero and the r/m field (bottom 3 bits) is 0x5.
> @@ -344,15 +394,25 @@ int insn_rip_relative(struct insn *insn)
>   *
>   * If necessary, first collects the instruction up to and including the
>   * ModRM byte.
> + *
> + * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
>   */
> -void insn_get_sib(struct insn *insn)
> +int insn_get_sib(struct insn *insn)
>  {
>  	insn_byte_t modrm;
> +	int ret;
>  
>  	if (insn->sib.got)
> -		return;
> -	if (!insn->modrm.got)
> -		insn_get_modrm(insn);
> +		return 0;
> +
> +	if (!insn->modrm.got) {
> +		ret = insn_get_modrm(insn);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (insn->modrm.nbytes) {
>  		modrm = (insn_byte_t)insn->modrm.value;
>  		if (insn->addr_bytes != 2 &&
> @@ -363,8 +423,10 @@ void insn_get_sib(struct insn *insn)
>  	}
>  	insn->sib.got = 1;
>  
> +	return 0;
> +
>  err_out:
> -	return;
> +	return -ENODATA;
>  }
>  
>  
> @@ -375,15 +437,25 @@ void insn_get_sib(struct insn *insn)
>   * If necessary, first collects the instruction up to and including the
>   * SIB byte.
>   * Displacement value is sign-expanded.
> + *
> + * * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.
>   */
> -void insn_get_displacement(struct insn *insn)
> +int insn_get_displacement(struct insn *insn)
>  {
>  	insn_byte_t mod, rm, base;
> +	int ret;
>  
>  	if (insn->displacement.got)
> -		return;
> -	if (!insn->sib.got)
> -		insn_get_sib(insn);
> +		return 0;
> +
> +	if (!insn->sib.got) {
> +		ret = insn_get_sib(insn);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (insn->modrm.nbytes) {
>  		/*
>  		 * Interpreting the modrm byte:
> @@ -426,12 +498,13 @@ void insn_get_displacement(struct insn *insn)
>  	}
>  out:
>  	insn->displacement.got = 1;
> +	return 0;
>  
>  err_out:
> -	return;
> +	return -ENODATA;
>  }
>  
> -/* Decode moffset16/32/64. Return 0 if failed */
> +/* Decode moffset16/32/64. Return a negative value if failed. */
>  static int __get_moffset(struct insn *insn)
>  {
>  	switch (insn->addr_bytes) {
> @@ -457,10 +530,10 @@ static int __get_moffset(struct insn *insn)
>  	return 1;
>  
>  err_out:
> -	return 0;
> +	return -ENODATA;

Also, __get_*() functions are expected to return bool (1/0)
for checking bad data. See insn_get_immediate() INAT_IMM_PTR case for example.

>  }
>  
> -/* Decode imm v32(Iz). Return 0 if failed */
> +/* Decode imm v32(Iz). Return a negative value if failed. */
>  static int __get_immv32(struct insn *insn)
>  {
>  	switch (insn->opnd_bytes) {
> @@ -480,10 +553,10 @@ static int __get_immv32(struct insn *insn)
>  	return 1;
>  
>  err_out:
> -	return 0;
> +	return -ENODATA;

Ditto.

>  }
>  
> -/* Decode imm v64(Iv/Ov), Return 0 if failed */
> +/* Decode imm v64(Iv/Ov). Return a negative value if failed. */
>  static int __get_immv(struct insn *insn)
>  {
>  	switch (insn->opnd_bytes) {
> @@ -507,11 +580,12 @@ static int __get_immv(struct insn *insn)
>  	insn->immediate1.got = insn->immediate2.got = 1;
>  
>  	return 1;
> +
>  err_out:
> -	return 0;
> +	return -ENODATA;

Ditto.

>  }
>  
> -/* Decode ptr16:16/32(Ap) */
> +/* Decode ptr16:16/32(Ap). Return a negative value if failed. */
>  static int __get_immptr(struct insn *insn)
>  {
>  	switch (insn->opnd_bytes) {
> @@ -534,25 +608,36 @@ static int __get_immptr(struct insn *insn)
>  	insn->immediate1.got = insn->immediate2.got = 1;
>  
>  	return 1;
> +
>  err_out:
> -	return 0;
> +	return -ENODATA;

Ditto.


Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
