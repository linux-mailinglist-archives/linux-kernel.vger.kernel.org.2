Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C453AB281
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhFQL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhFQL1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:27:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8198C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:25:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y15so4774117pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=BtihkO7CCaTLPgwW0rcMA1QMgMvGSscuXR6fI3BnW8o=;
        b=F4KIQ7i4XRRvpgPQztzr1LqA3qBv/beuqleCgOOaz5eCl9kcl3VWkcZ/u8dMGmAU0q
         CQ7Bmd/t86J+OTlGWm9P4fu39wsXecmswHqNBSjIqzQlXOUOroZXkmr0ohcY9o+sAtlK
         d63vC0sWIAbMjTWBPTLEV+WxnAw9k7Sm4rP6w/DOfrGki1s2A+k7F2weMCyxWUjSkyd1
         4FVUuVMTLkOL62pgkk++i/WIJunDb4LQUf/Fhm+EQyDEqYXX8qSdw6Oi89S1bmxNsM2U
         C74Ol8/2CYO0IVq49btY+vzoDh1Lx3M7JyNq/Zae1/jXfnlET7Vj0pEscCTraGLXrn6u
         cu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=BtihkO7CCaTLPgwW0rcMA1QMgMvGSscuXR6fI3BnW8o=;
        b=k505ikxwI7qDFLKopXCOZKNlgnTH7cifaxNbLuRD9dfF3ry8m6qZ548CEAgOeXz/0T
         8CWswMcTz6GpB4oULKLRKx2JhKV/rsD5PDQgq85QscM7y++6L3rCuCJjjDo7pYBajlkF
         z/wyDLBHpkNMbkE1V2NsgD19gBS+qk57owgXOEf2SeBwKyl+YjVmiFnKmrOt+sZbvDH9
         salBTnasNOPf75gfhinS28tks1UpH1zIS7H35GV2ipfjjUiMSyl/cw4MbMmdqtk5jUAk
         mlgdoyrSCRosropmVqj8DnQJQ9f2knzLR186XYRX3qFPMytd5MZ2Y9Ket4OrmGuOeA0E
         KS5A==
X-Gm-Message-State: AOAM532vbx9PAGKhjm4DpZWJks+Lo4mLTBGVEH8EzTGp6L2xxijfR6wv
        zxU+CXYKyC3SOjEwP3BJ+nA=
X-Google-Smtp-Source: ABdhPJzc5zKeYQpcP+dAPsUVBEwyYkcz5l2dKfrt1FcvMGZkAMWl+rU3G+HkeF4kZOCDbB6hfX+kMA==
X-Received: by 2002:aa7:92c6:0:b029:2f1:3fbb:3171 with SMTP id k6-20020aa792c60000b02902f13fbb3171mr5059860pfa.0.1623929146339;
        Thu, 17 Jun 2021 04:25:46 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id g17sm5503175pgh.61.2021.06.17.04.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:25:46 -0700 (PDT)
Date:   Thu, 17 Jun 2021 21:25:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 1/5] powerpc/interrupt: Rename and lightly change
 syscall_exit_prepare_main()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1623929016.jy0026dpmc.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of June 15, 2021 6:33 pm:
> Rename syscall_exit_prepare_main() into interrupt_exit_prepare_main()
>=20
> Make it static as it is not used anywhere else.
>=20
> Pass it the 'ret' so that it can 'or' it directly instead of
> oring twice, once inside the function and once outside.
>=20
> And remove 'r3' parameter which is not used.
>=20
> Also fix a typo where CONFIG_PPC_BOOK3S should be CONFIG_PPC_BOOK3S_64.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This series applies on top of Nic's series speeding up interrupt return o=
n 64s
>=20
>  arch/powerpc/kernel/interrupt.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 74c995a42399..ba2d602d2da6 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -243,11 +243,10 @@ static notrace void booke_load_dbcr0(void)
>  #endif
>  }
> =20
> -notrace unsigned long syscall_exit_prepare_main(unsigned long r3,
> -						struct pt_regs *regs)
> +static notrace unsigned long
> +interrupt_exit_user_prepare_main(struct pt_regs *regs, unsigned long ret=
)

Hmm, I tried switching the order of the arguments thinking it would=20
match caller and return registers better but didn't seem to help
generated code. Yet I think I will make that change to your patch if
you don't mind.

Thanks,
Nick
