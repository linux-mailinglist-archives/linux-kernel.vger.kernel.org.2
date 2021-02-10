Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCBE315D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhBJCas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhBJCBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:01:08 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43209C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 18:00:27 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t29so246354pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 18:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=icHSuqxAvuWfZWaEB0lhER40wxcGWM6Tp4PSAF9+5DQ=;
        b=FDHREfY0VXhgjJOhLgHfv5ShwcRdfxXeAJRh5S/joH+Msw7q8diCNwoaVAJBUELFPI
         LeISdvoT1hwpj/q+giSa3GCvSiCUy0fhjNgIG1SKOBM6gHwKVh9mRrOuoda4sPW81/Qm
         NK0RbbbQYWfhkoGNbyILwWw1Se0Pez1NcKUex9A8LArkheJK7E6mE8VqEpnTL7sICutU
         e6svUy0Zvg1xyWvZ8eEJ9JmXK4tbJt4Da+4W1EqLD1hP8CHFZ8NrwxlpeWEqYdbC+LgQ
         rGPEEcDrCLp9Rc1Z8ff6wS+xHwqAO6a3LZz26p1d/rJrr1BAxRQGc0heL2NIS5fz9zfw
         wBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=icHSuqxAvuWfZWaEB0lhER40wxcGWM6Tp4PSAF9+5DQ=;
        b=IyYzrphHtuvQPGf9HrmNWfOVx0U6hBG2ZTr/7bajcrhDh6x0U2R3dvTIY5kUgMVpKT
         uMoq2P4gsufwC1Mqzd5MdFrXiOXbdNKCQMZx/uk1g77jtPJO5J4Q8CdEEjltH1cT+nuP
         UaNJ44+SGQ9xHC54F7cxrJuaYMRrZvA/TuNo43AUWCwp2Bt9yZm3sNJKPNRp58030htc
         M+pMBzP2UJdLHuODpZZfyLWj4VIyR7i6ICeUOyjqeTwQdHLfqJKdxDHb6O3abgIfDUjO
         KnOiS/Ls0h41YQsI5t5uUiQgUvWIRue7TfM6rJJusgGEoF42MLHeoK1qVVO/jpFCEWhL
         ta2g==
X-Gm-Message-State: AOAM533EmJRpDD5NmC0pmELJLrlKvOrv0xw+46nCKkzKAien6gst++pW
        FXjExPzPt58n1mnrDo+VU0Bg7ZdFQ20=
X-Google-Smtp-Source: ABdhPJyIYczqEkDX2r5WQ4N4yzbWuk+ClEAtgeLyp6JmAEF8e5YJBF8YleZRoI0Q0Hcl8sbjrylhiQ==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr829133pgg.196.1612922426770;
        Tue, 09 Feb 2021 18:00:26 -0800 (PST)
Received: from localhost (14-201-150-91.tpgi.com.au. [14.201.150.91])
        by smtp.gmail.com with ESMTPSA id o76sm187378pfg.164.2021.02.09.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:00:25 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:00:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 20/22] powerpc/syscall: Avoid storing 'current' in
 another pointer
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Laight <David.Laight@ACULAB.COM>,
        'Segher Boessenkool' <segher@kernel.crashing.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
        <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu>
        <1612838134.rvncv9kzls.astroid@bobo.none>
        <20210209135053.GD27854@gate.crashing.org>
        <d35cc46eca474b2c9f94a4de269321e7@AcuMS.aculab.com>
        <f6ae2e77-3a89-c294-9a6e-58d84fbb46b1@csgroup.eu>
In-Reply-To: <f6ae2e77-3a89-c294-9a6e-58d84fbb46b1@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612922312.mnpowzgd0r.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of February 10, 2021 3:03 am:
>=20
>=20
> Le 09/02/2021 =C3=A0 15:31, David Laight a =C3=A9crit=C2=A0:
>> From: Segher Boessenkool
>>> Sent: 09 February 2021 13:51
>>>
>>> On Tue, Feb 09, 2021 at 12:36:20PM +1000, Nicholas Piggin wrote:
>>>> What if you did this?
>>>
>>>> +static inline struct task_struct *get_current(void)
>>>> +{
>>>> +	register struct task_struct *task asm ("r2");
>>>> +
>>>> +	return task;
>>>> +}
>>>
>>> Local register asm variables are *only* guaranteed to live in that
>>> register as operands to an asm.  See
>>>    https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html#Loc=
al-Register-Variables
>>> ("The only supported use" etc.)
>>>
>>> You can do something like
>>>
>>> static inline struct task_struct *get_current(void)
>>> {
>>> 	register struct task_struct *task asm ("r2");
>>>
>>> 	asm("" : "+r"(task));
>>>
>>> 	return task;
>>> }
>>>
>>> which makes sure that "task" actually is in r2 at the point of that asm=
.
>>=20
>> If "r2" always contains current (and is never assigned by the compiler)
>> why not use a global register variable for it?
>>=20
>=20
>=20
> The change proposed by Nick doesn't solve the issue.

It seemed to change code generation in a simple test case, oh well.

>=20
> The problem is that at the begining of the function we have:
>=20
> 	unsigned long *ti_flagsp =3D &current_thread_info()->flags;
>=20
> When the function uses ti_flagsp for the first time, it does use 112(r2)
>=20
> Then the function calls some other functions.
>=20
> Most likely because the function could update 'current', GCC copies r2 in=
to r30, so that if r2 get=20
> changed by the called function, ti_flagsp is still based on the previous =
value of current.
>=20
> Allthough we know r2 wont change, GCC doesn't know it. And in order to sa=
ve r2 into r30, it needs to=20
> save r30 in the stack.
>=20
>=20
> By using &current_thread_info()->flags directly instead of this intermedi=
aite ti_flagsp pointer, GCC=20
> uses r2 instead instead of doing a copy.
>=20
>=20
> Nick, I don't understand the reason why you need that 'ti_flagsp' local v=
ar.

Just to save typing, I don't mind your patch I was just wondering if=20
current could be improved in general.

Thanks,
Nick
