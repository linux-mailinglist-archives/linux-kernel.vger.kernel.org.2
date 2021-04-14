Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9335EA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbhDNCBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhDNCBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:01:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE33C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:01:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y32so13278435pga.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=KdzJGtbQKMM6WovwoQdkjGUf5Ve7opMXsRdxXEuGt3o=;
        b=aLI/RIROmUMi3ydioh2HN1kPYgyUQiUlXEBvMHyruO5qAy6N5m2O081qsEqViXebn8
         mtoUBuWkBGyj8c7eyh/iJOtZzrBfQiq2tb1mpjka66qO4C6xCHNyngpEIfG8bcewB17+
         2lGeYWO6FfDybSD+5UcHlvn+SVtLyMJRq0rVQmmPgjliU43e/wk+eMdbWzbCNr2MQgP+
         VoYAT+b+h8x17t4uavo5BxEZVjMTdf6/mXLbLZDFQ/IVHnJyHZqlPqN7FHQeGpcs7kSC
         hJtZm7hzP1v23afXdJAuUnOVOi/XIXu5J3zkjBG02zq+JGAS7KW3ZqY0ihXHoTf0dGEB
         JoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=KdzJGtbQKMM6WovwoQdkjGUf5Ve7opMXsRdxXEuGt3o=;
        b=fqXM3pW/UZB8oq83MGowVZP9/HauKmBsqA5xG7HYgmjOzMcHSjAaIluODCmeRkklUT
         a/ULduzMeMsBNiDBSiLWrDKjot0UX+5e+e5Lg+PTz7U1Z8NXUpA12T/H6us/PpocDM4S
         kCOBYjraJxfo0DcQgfSCYzSCH92ejTGU5uhYe1KuR9E8tku1hMczPKhiNWJojTceaHXQ
         5rnp/R2kId4cmL770a/rm3jG8YtfnpbhguVuoHq6/GMs9cPhvMbz36M7/Opj+aNSxP7M
         F5ZWumTvxPqcRQXuKgw59WNUjUMc61CACiBAfjBCnRFKrB6cYrXJk9YzUt0QVSfNUhE9
         WFpw==
X-Gm-Message-State: AOAM531CaYl+kRfEGwzireKu7HHvNyiMcpqlQpKfDXNQ9gFM3VzkLUBo
        o3wK0TGLGadonOZAYHZ8h/uSKtElYsY=
X-Google-Smtp-Source: ABdhPJyjMTVIofFw6yPVpUTmU6h8P2cKeEpO2QgNpRYonh3f5mixQfrTzTRCIRkV9uYgNRuKaM1Ixw==
X-Received: by 2002:a63:30c1:: with SMTP id w184mr34535722pgw.230.1618365686734;
        Tue, 13 Apr 2021 19:01:26 -0700 (PDT)
Received: from localhost (193-116-90-211.tpgi.com.au. [193.116.90.211])
        by smtp.gmail.com with ESMTPSA id i18sm5039212pfq.168.2021.04.13.19.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 19:01:26 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:01:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when
 possible
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu>
        <20210412215428.GM26583@gate.crashing.org>
        <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu>
        <20210413215803.GT26583@gate.crashing.org>
In-Reply-To: <20210413215803.GT26583@gate.crashing.org>
MIME-Version: 1.0
Message-Id: <1618365589.67fxh7cot9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Segher Boessenkool's message of April 14, 2021 7:58 am:
> On Tue, Apr 13, 2021 at 06:33:19PM +0200, Christophe Leroy wrote:
>> Le 12/04/2021 =C3=A0 23:54, Segher Boessenkool a =C3=A9crit=C2=A0:
>> >On Thu, Apr 08, 2021 at 03:33:44PM +0000, Christophe Leroy wrote:
>> >>For clear bits, on 32 bits 'rlwinm' can be used instead or 'andc' for
>> >>when all bits to be cleared are consecutive.
>> >
>> >Also on 64-bits, as long as both the top and bottom bits are in the low
>> >32-bit half (for 32 bit mode, it can wrap as well).
>>=20
>> Yes. But here we are talking about clearing a few bits, all other ones m=
ust=20
>> remain unchanged. An rlwinm on PPC64 will always clear the upper part,=20
>> which is unlikely what we want.
>=20
> No, it does not.  It takes the low 32 bits of the source reg, duplicated
> to the top half as well, then rotated, then ANDed with the mask (which
> can wrap around).  This isn't very often very useful, but :-)
>=20
> (One useful operation is splatting 32 bits to both halves of a 64-bit
> register, which is just rlwinm d,s,0,1,0).
>=20
> If you only look at the low 32 bits, it does exactly the same as on
> 32-bit implementations.
>=20
>> >>For the time being only
>> >>handle the single bit case, which we detect by checking whether the
>> >>mask is a power of two.
>> >
>> >You could look at rs6000_is_valid_mask in GCC:
>> >   <https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dblob;f=3Dgcc/config/rs6000=
/rs6000.c;h=3D48b8efd732b251c059628096314848305deb0c0b;hb=3DHEAD#l11148>
>> >used by rs6000_is_valid_and_mask immediately after it.  You probably
>> >want to allow only rlwinm in your case, and please note this checks if
>> >something is a valid mask, not the inverse of a valid mask (as you
>> >want here).
>>=20
>> This check looks more complex than what I need. It is used for both rlw.=
..=20
>> and rld..., and it calculates the operants.  The only thing I need is to=
=20
>> validate the mask.
>=20
> It has to do exactly the same thing for rlwinm as for all 64-bit
> variants (rldicl, rldicr, rldic).
>=20
> One side effect of calculation the bit positions with exact_log2 is that
> that returns negative if the argument is not a power of two.
>=20
> Here is a simpler way, that handles all cases:  input in "u32 val":
>=20
> 	if (!val)
> 		return nonono;
> 	if (val & 1)
> 		val =3D ~val;	// make the mask non-wrapping
> 	val +=3D val & -val;	// adding the low set bit should result in
> 				// at most one bit set
> 	if (!(val & (val - 1)))
> 		return okidoki_all_good;
>=20
>> I found a way: By anding the mask with the complement of itself rotated =
by=20
>> left bits to 1, we identify the transitions from 0 to 1. If the result i=
s a=20
>> power of 2, it means there's only one transition so the mask is as expec=
ted.
>=20
> That does not handle all cases (it misses all bits set at least).  Which
> isn't all that interesting of course, but is a valid mask (but won't
> clear any bits, so not too interesting for your specific case :-) )

Would be nice if we could let the compiler deal with it all...

static inline unsigned long lr(unsigned long *mem)
{
        unsigned long val;

        /*
         * This doesn't clobber memory but want to avoid memory operations
         * moving ahead of it
         */
        asm volatile("ldarx     %0, %y1" : "=3Dr"(val) : "Z"(*mem) : "memor=
y");

        return val;
}

static inline bool stc(unsigned long *mem, unsigned long val)
{
        /*
         * This doesn't really clobber memory but same as above, also can't
         * specify output in asm goto.
         */
        asm volatile goto(
                "stdcx. %0, %y1 \n\t"
                "bne-   %l[fail]        \n\t"
                : : "r"(val), "Z"(*mem) : "cr0", "memory" : fail);

        return true;
fail: __attribute__((cold))
        return false;
}

static inline void atomic_add(unsigned long *mem, unsigned long val)
{
        unsigned long old, new;

        do {
                old =3D lr(mem);
                new =3D old + val;
        } while (unlikely(!stc(mem, new)));
}

