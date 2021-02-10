Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACA315D43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhBJC2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhBJB61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:58:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F899C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 17:57:47 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so246241pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 17:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=oLW+n5w0pghmkNj2ep8nCPeAU0s26nQfvVVpmEbyunM=;
        b=lOPNp9fFMtEacEN782fXGeE95Kdh37rGdiUidWXHnY98Nrevlcw+Efy/0o211FTwMz
         1/kFVmyhObSCsMwK6dLGptAylcMJt4OpAvCw4NY8eYpiVQtloRdNjN3G5Qq0S7a4qOny
         vVoK+GoBEkiZm3n7N5h1ts/Kqn+0ExSl9hpvJ5EIIZzW8McWqME5U8Yf0FEMs+v7YvDB
         O8N153T+UN6Nuz80eM6/cXYdu2S1YbU2cmkczrjRlPjt8kIIDMEnWYIyqvn/EWWYTkCo
         S2G0EQzENA+dvh7xLhfgUDDFj5HddiRjZPMsIvn63nJgsJjGDn+T4QNlMlnKfyILkeMA
         kPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=oLW+n5w0pghmkNj2ep8nCPeAU0s26nQfvVVpmEbyunM=;
        b=NIqzGTUm8DWrCPxYHiQkmWKJ4I7Mu1bg3yZZCniLJywK7JIMZ+x/KXDE3HaBuTARwd
         ZdWJt1V5gaRJf8rqgKB3wVa4DkdGTJmpOliVoq6VS4H7I+JiWEwkZnhPPxmQYBScIJGg
         BEBx83z9PdacGJrj8SrGfTStVLVwtqHo1/CWWjEfV60sVBMsSbfjU54dIDlD4xAjF6Mw
         hnw+jIG+rA4sdLmRh7Kn//ANobOYVj/z1Tr2vEnUKDlpz8sxDkGBsNT/SjrzxR9+Pdji
         Q7dkcH7dURmNY7kE4se7vOfJXaiuZ9qjnvTMOiK2LDJAsKNlfHcg3ijQDdQd7EeK58Fa
         lYkQ==
X-Gm-Message-State: AOAM533ZvZFQ9O88MiXliNOIyBoanbYJVAATWvHjeD1IJcuJc3y3kcOk
        Ad016nevabr1lHbs9i/dgKw=
X-Google-Smtp-Source: ABdhPJzN+0Dc764xEdE636nOl2URQeFOcnQuIGS2ucB0THifofkFPCwdFUff0eCkTGWMDmfv5U+lWA==
X-Received: by 2002:a17:902:a5cb:b029:de:cd0b:1424 with SMTP id t11-20020a170902a5cbb02900decd0b1424mr647751plq.63.1612922266884;
        Tue, 09 Feb 2021 17:57:46 -0800 (PST)
Received: from localhost (14-201-150-91.tpgi.com.au. [14.201.150.91])
        by smtp.gmail.com with ESMTPSA id b14sm185543pfi.74.2021.02.09.17.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 17:57:45 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:57:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 18/22] powerpc/syscall: Remove FULL_REGS verification
 in system_call_exception
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <6bef4d9ba0cba50160d13e344ee4627ebdf801dc.1612796617.git.christophe.leroy@csgroup.eu>
        <1612836023.l122pe2n2b.astroid@bobo.none>
        <cc1a35a4-07c3-9e64-18d6-57e497f56e33@csgroup.eu>
In-Reply-To: <cc1a35a4-07c3-9e64-18d6-57e497f56e33@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612922197.2b51jxzeqs.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 10, 2021 12:31 am:
>=20
>=20
> Le 09/02/2021 =C3=A0 03:02, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
>>> For book3s/64, FULL_REGS() is 'true' at all time, so the test voids.
>>> For others, non volatile registers are saved inconditionally.
>>>
>>> So the verification is pointless.
>>>
>>> Should one fail to do it, it would anyway be caught by the
>>> CHECK_FULL_REGS() in copy_thread() as we have removed the
>>> special versions ppc_fork() and friends.
>>>
>>> null_syscall benchmark reduction 4 cycles (332 =3D> 328 cycles)
>>=20
>> I wonder if we rather make a CONFIG option for a bunch of these simpler
>> debug checks here (and also in interrupt exit, wrappers, etc) rather
>> than remove them entirely.
>=20
> We can drop this patch if you prefer. Anyway, like book3s/64, once ppc32 =
also do interrupt=20
> entry/exit in C, FULL_REGS() will already return true.

Sure let's do that.

Thanks,
Nick

