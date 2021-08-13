Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02B03EAFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhHMGIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhHMGIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:08:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6771EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 23:08:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso231269pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 23:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=y/Yk8YaH+hTJlWcCeGvVXq52ODnqI3NXn4zIBzX7oxg=;
        b=uKLO8MOUt1OUX7uUZxQwPr+QQ6VYxJDTRerIf6mKoWVMQGgpQHYuf4U97OsWaX+jgo
         rWlivfvphw7Uie7j+h7fAYpiVUkp+Vm8zwf7B9lAddq0DqUW2rzWnkDqwpeTHVDLPWRO
         eQUz+srZX/dDc78qSLDFPgDaIUe95I8mKNy3Oedpawxq8Lxdh+BCcosVZpGNMwlwEYgD
         EMTuZEyim2odjXJcBT4vB88HkZKsx6Cq86s13hqwNvxYA1mz3NS2oa2cSKTl2qnT35kh
         uBizJNt4ttrSqgR/uDN1LlWOom/5x3VJvGo1unaHRhxBSAI98VTaqspk21FSVarFNvq0
         7l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=y/Yk8YaH+hTJlWcCeGvVXq52ODnqI3NXn4zIBzX7oxg=;
        b=j/ufl3YVpQVz46k31fueHs7GaOJFJB8S3pF1kZYFbwCxchKR0Sa09o4Zq0/SDsFG5+
         7e6Ih3NHQOX7lRPo66vREk8bX786VaiLl9IUmbNXuesb6rpg0CSQkNrXC8XwG6jIf7XI
         UOq1ylGpcLFuEWfDDbXIPP4YPBeLiQ49wLBpU1pISjeDM49sgpAkzwGB9psYAM3RJDRO
         PBpT5/E7HTw2rIM+6mE0NWNpJ1q0NfAv6pWXpIPNzkiiw4PumYohtUnHQanLs2XDPEiN
         iKblQAV2z2IIkNZyrvkXl76lqJBrjQ+jX++D8jMstfzH0cK+aQIvLgQDkj8xZPIcv8TP
         1htg==
X-Gm-Message-State: AOAM533Wo+qKpbap6LrF9e5PxWnQchlrEphMRGqL8kMOA0YTvalnnUsC
        /m02iYDfLF23E90iGDETVuc=
X-Google-Smtp-Source: ABdhPJzqOd4EHmaiF4TDTBzVusj3PIytJNEp2iPSiOJYW5EA9MN6Q5yyD1nUdENg1j1LONS80+Qp5Q==
X-Received: by 2002:a17:90b:3754:: with SMTP id ne20mr1011910pjb.15.1628834898891;
        Thu, 12 Aug 2021 23:08:18 -0700 (PDT)
Received: from localhost (60-242-208-220.static.tpgi.com.au. [60.242.208.220])
        by smtp.gmail.com with ESMTPSA id l185sm776962pfd.62.2021.08.12.23.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 23:08:18 -0700 (PDT)
Date:   Fri, 13 Aug 2021 16:08:13 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and
 WARN_ON() on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1628834356.pr4zgn1xf1.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of April 14, 2021 2:38 am:
> powerpc BUG_ON() and WARN_ON() are based on using twnei instruction.
>=20
> For catching simple conditions like a variable having value 0, this
> is efficient because it does the test and the trap at the same time.
> But most conditions used with BUG_ON or WARN_ON are more complex and
> forces GCC to format the condition into a 0 or 1 value in a register.
> This will usually require 2 to 3 instructions.
>=20
> The most efficient solution would be to use __builtin_trap() because
> GCC is able to optimise the use of the different trap instructions
> based on the requested condition, but this is complex if not
> impossible for the following reasons:
> - __builtin_trap() is a non-recoverable instruction, so it can't be
> used for WARN_ON
> - Knowing which line of code generated the trap would require the
> analysis of DWARF information. This is not a feature we have today.
>=20
> As mentioned in commit 8d4fbcfbe0a4 ("Fix WARN_ON() on bitfield ops")
> the way WARN_ON() is implemented is suboptimal. That commit also
> mentions an issue with 'long long' condition. It fixed it for
> WARN_ON() but the same problem still exists today with BUG_ON() on
> PPC32. It will be fixed by using the generic implementation.
>=20
> By using the generic implementation, gcc will naturally generate a
> branch to the unconditional trap generated by BUG().
>=20
> As modern powerpc implement zero-cycle branch,
> that's even more efficient.
>=20
> And for the functions using WARN_ON() and its return, the test
> on return from WARN_ON() is now also used for the WARN_ON() itself.
>=20
> On PPC64 we don't want it because we want to be able to use CFAR
> register to track how we entered the code that trapped. The CFAR
> register would be clobbered by the branch.
>=20
> A simple test function:
>=20
> 	unsigned long test9w(unsigned long a, unsigned long b)
> 	{
> 		if (WARN_ON(!b))
> 			return 0;
> 		return a / b;
> 	}
>=20
> Before the patch:
>=20
> 	0000046c <test9w>:
> 	 46c:	7c 89 00 34 	cntlzw  r9,r4
> 	 470:	55 29 d9 7e 	rlwinm  r9,r9,27,5,31
> 	 474:	0f 09 00 00 	twnei   r9,0
> 	 478:	2c 04 00 00 	cmpwi   r4,0
> 	 47c:	41 82 00 0c 	beq     488 <test9w+0x1c>
> 	 480:	7c 63 23 96 	divwu   r3,r3,r4
> 	 484:	4e 80 00 20 	blr
>=20
> 	 488:	38 60 00 00 	li      r3,0
> 	 48c:	4e 80 00 20 	blr
>=20
> After the patch:
>=20
> 	00000468 <test9w>:
> 	 468:	2c 04 00 00 	cmpwi   r4,0
> 	 46c:	41 82 00 0c 	beq     478 <test9w+0x10>
> 	 470:	7c 63 23 96 	divwu   r3,r3,r4
> 	 474:	4e 80 00 20 	blr
>=20
> 	 478:	0f e0 00 00 	twui    r0,0
> 	 47c:	38 60 00 00 	li      r3,0
> 	 480:	4e 80 00 20 	blr

That's clearly better because we have a branch anyway.

>=20
> So we see before the patch we need 3 instructions on the likely path
> to handle the WARN_ON(). With the patch the trap goes on the unlikely
> path.
>=20
> See below the difference at the entry of system_call_exception where
> we have several BUG_ON(), allthough less impressing.
>=20
> With the patch:
>=20
> 	00000000 <system_call_exception>:
> 	   0:	81 6a 00 84 	lwz     r11,132(r10)
> 	   4:	90 6a 00 88 	stw     r3,136(r10)
> 	   8:	71 60 00 02 	andi.   r0,r11,2
> 	   c:	41 82 00 70 	beq     7c <system_call_exception+0x7c>
> 	  10:	71 60 40 00 	andi.   r0,r11,16384
> 	  14:	41 82 00 6c 	beq     80 <system_call_exception+0x80>
> 	  18:	71 6b 80 00 	andi.   r11,r11,32768
> 	  1c:	41 82 00 68 	beq     84 <system_call_exception+0x84>
> 	  20:	94 21 ff e0 	stwu    r1,-32(r1)
> 	  24:	93 e1 00 1c 	stw     r31,28(r1)
> 	  28:	7d 8c 42 e6 	mftb    r12
> 	...
> 	  7c:	0f e0 00 00 	twui    r0,0
> 	  80:	0f e0 00 00 	twui    r0,0
> 	  84:	0f e0 00 00 	twui    r0,0
>=20
> Without the patch:
>=20
> 	00000000 <system_call_exception>:
> 	   0:	94 21 ff e0 	stwu    r1,-32(r1)
> 	   4:	93 e1 00 1c 	stw     r31,28(r1)
> 	   8:	90 6a 00 88 	stw     r3,136(r10)
> 	   c:	81 6a 00 84 	lwz     r11,132(r10)
> 	  10:	69 60 00 02 	xori    r0,r11,2
> 	  14:	54 00 ff fe 	rlwinm  r0,r0,31,31,31
> 	  18:	0f 00 00 00 	twnei   r0,0
> 	  1c:	69 60 40 00 	xori    r0,r11,16384
> 	  20:	54 00 97 fe 	rlwinm  r0,r0,18,31,31
> 	  24:	0f 00 00 00 	twnei   r0,0
> 	  28:	69 6b 80 00 	xori    r11,r11,32768
> 	  2c:	55 6b 8f fe 	rlwinm  r11,r11,17,31,31
> 	  30:	0f 0b 00 00 	twnei   r11,0
> 	  34:	7d 8c 42 e6 	mftb    r12

This one possibly the branches end up in predictors, whereas conditional=20
trap is always just speculated not to hit. Branches may also have a
throughput limit on execution whereas trap could be more (1 per cycle
vs 4 per cycle on POWER9).

On typical ppc32 CPUs, maybe it's a more obvious win. As you say there
is the CFAR issue as well which makes it a problem for 64s. It would
have been nice if it could use the same code though.

Maybe one day gcc's __builtin_trap() will become smart enough around
conditional statements that it it generates better code and tries to
avoid branches.

Thanks,
Nick
