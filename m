Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4DB373CAF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhEENwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhEENwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:52:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E29C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 06:51:23 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620222680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/GpEF2bVEbo7bj/SJzowkKdzRgfe0IpPQJ2B862nEM=;
        b=Sdfnx0qT+frgFt3WojN//pyQPVdFA4i/5lN60UIdfGxKractshbvX5Xf6G9VxUplYoYZGu
        0oQ11vlS9ESYe9buWyHgqV5v4KK1zQknLDlOWitgOwktMF7SYJ8jQreHdY8qqRwRbNwSkD
        qRBEPAMp580HZGGXG9da8dSWczi0WOzyKLja8BJIvC8pwTS02lFu1rI0y+ep8l6pSXwaCb
        RgW47UFQSwQdHgMN+Onmmibz1SSEED2SYJnMDQZRcc99zaCDsQfwQinh0Gb1/xog3G4ifC
        3rT0TLx3kI78bVBnS/evqS+OU4QrZA1rtRssCJ0i30QGwS4cQs6DySHZjqgJoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620222680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/GpEF2bVEbo7bj/SJzowkKdzRgfe0IpPQJ2B862nEM=;
        b=+KZbvEO3QELFUwQ3py8+7t1a1IcV7Q+x27LyH9iEk9yWnZbUx5/os5+Sny7RRwAby3umCx
        akxCwAzjh7kdsVCQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [patch 0/6] futex: Bugfixes and FUTEX_LOCK_PI2
In-Reply-To: <YJKWt2vlr74WR5tx@hirez.programming.kicks-ass.net>
References: <20210422194417.866740847@linutronix.de>
 <YJKWt2vlr74WR5tx@hirez.programming.kicks-ass.net>
Date:   Wed, 05 May 2021 15:51:18 +0200
Message-ID: <87r1ilp9ux.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed May 05 2021, Peter Zijlstra wrote:
> It's all somewhat sad, but I don't see any other way out of this. Using
> LOCK_PI2 will be a fairly horrible pile of hacks on the userspace side
> of things given they need to first detect it's presence etc., but that
> seems unavoidable whatever we do :/

Well, that's the interesting point. I do have such horrible hacks for
glibc, which detect the presence of LOCK_PI2 at run time. However, the
glibc has also the notion of kernel features based on the Linux kernel
version. Then, it could be detected at compile time. At the end of the
day it depends on how this patch set is merged. I was hoping for the
glibc folks to share their opinion on this :-).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAmCSotYTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRB5KluBy5jwpkMYD/9qkV+sIhhArxSY4O1HZ+J+Ee80F5JB
HMPssquvl7wr7a3ghR5ri0xo0/3OkVoK4n7bJ6nr1I0aECvqfEz5ha319rbLtxgV
2MMu7OLJYKZY5Mnf3pXFwMOst4Vr8aSb31vAxccSLFttTMaq6RajsaMzl9Be33WH
yjv/qANort61mNn1VwjX89kzi/5joDItkGUenp3XDf1sj4yDZpXaXE2fULfakCV3
zyBiLMtboEyybyTxNzi3vo93bte4KCa68gq3F8YAac03eXXR4qy22pAQnodz1nQt
jNgMu29MgYoms0HmoOYZf2rRZRjaxVJyWINdcGYbSLUt2fmwlY542Dspk+Of7SDa
6SvqvLERk959fZSxl7NLl0YauNKatmif5uaj6ILzaPxqIuoqXLUOar/g99xNqZ9g
ENABEZI4FBMcamXI4MIOOdpqiTVJYJhAdO5q9CXfZxAolulWU8wMS0FeFGnY17FZ
T1x9i+Pmr7uFugIQCq1Wglgya/58YaO3DzmtDxZo01pN2bEk3x1lWWvDaGZSQHXd
X2EvzVb8yHpBCnpFtl7SM9ACq5onEKaKiGBRC5t+CcPJzlO9D8E30sLfD2cWNCgy
dC78eO+AN5VSLfDqw8BgDf8Z7y9dql3SWcECeluYziQ7I7+UxhXvmKAWslvRd5om
KfzStgm74Vc8tA==
=Lpy5
-----END PGP SIGNATURE-----
--=-=-=--
