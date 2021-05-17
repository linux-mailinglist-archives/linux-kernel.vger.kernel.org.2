Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F709383A36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244522AbhEQQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244292AbhEQQln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:41:43 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D1C043168
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:48:05 -0700 (PDT)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4FkNnZ1gxLz1y1G;
        Mon, 17 May 2021 17:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
        t=1621266482; bh=9pqQThWi/Y3AKPfKgdmvXWPImVDj773LTGqRMq0trVM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From:To:CC:
         Subject;
        b=EvK1WGSTJkU+WM30ocMOt2aAgmMRPA2Aeu8z3Ddd/pjWwp52Ms0gX8qRBbxkgtzSS
         pOHPVsqoVmMXPxuBV4LNB/kX1CZolaeFgRLa3vqB+9tyzaTd79w+WRBzSh5GXLhJOO
         0754IJHv45HY8JTNZLX8rEmbP2bso2dQCHDL4LqAQLTQFDfVg/iBznxNrTuRSEH1od
         nR57qqwcvPEKZAvETR3zb5S4bvNpsB4JPsHbpilk/IhoCUp9EgYYPw79Ugz306DQIL
         BjeanH+50HYO/II1+H3ykU/x8Btr8VPJOAYQRZqEX42CXB0qTUDzRUOO45/TZFMYwY
         dIu9is54566Gg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 93.238.10.8
Received: from [192.168.2.114] (p5dee0a08.dip0.t-ipconnect.de [93.238.10.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX188wS4LvBpAKACY8X69+vMtub4EsQXtDOw=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4FkNnW5v52z1xtS;
        Mon, 17 May 2021 17:47:59 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] objtool: include symbol value in check for contiguous
 objects
From:   Vanessa Hack <vanessa.hack@fau.de>
In-Reply-To: <20210503172814.suquyqr737ogn4ef@treble>
Date:   Mon, 17 May 2021 17:47:58 +0200
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Jonas Rabenstein <rabenstein@cs.fau.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEF166D9-6C75-4C54-8C6E-69FF730D8D2F@fau.de>
References: <20210428210408.4546-1-vanessa.hack@fau.de>
 <20210503172814.suquyqr737ogn4ef@treble>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

I think there might have been a problem with my mail client, so I=E2=80=99=
m sorry
if this has been sent twice.

> I believe add_jump_table() -- in addition to all the other jump table
> code -- assumes that reloc->sym is a section symbol (STT_SECTION),
> rather than a function symbol (STT_FUNC).  Was it an STT_FUNC symbol
> which caused the problem?

Indeed as you proposed it was a symbol with another type than =
STT_SECTION=20
that caused the problem. This resulted of our mistake of not having =
compiled=20
our code using -fno-pic and the fact, that it was i386 code as we are =
trying to=20
adapt objtool for our 32 bit operating system. Consequently, local =
labels for a=20
switch jump table were created, which the existing objtool code seems =
not to=20
be intended to handle.=20

> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5e5388a38e2a..4f30a763a4e3 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1344,6 +1344,10 @@ static int add_jump_table(struct objtool_file =
*file, struct instruction *insn,
> 		if (prev_offset && reloc->offset !=3D prev_offset + 8)
> 			break;
>=20
> +		/* Jump table relocs are always STT_SECTION: */
> +		if (reloc->sym->type !=3D STT_SECTION)
> +			break;
> +
> 		/* Detect function pointers from contiguous objects: */
> 		if (reloc->sym->sec =3D=3D pfunc->sec &&
> 		    reloc->addend =3D=3D pfunc->offset)

Your suggested patch would have helped us detecting the problem earlier =
and=20
seems like a good idea to check.

Regards,
Vanessa=
