Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1431D2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBPWeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhBPWd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:33:57 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B6DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:33:17 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v3so8262977qtw.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=28kX1GxLg7lo1cpThqCrBTFpdtZ1SsRkJeYqDWMqVBk=;
        b=CAR3CWMPgdJpoBJljX9lQ5GTu0G3jbZhE01hUDySwZ6aS8QgQCkNsnwXYf+AkH/MkE
         bg+ayxCRFSMZzWz+f+KOG4+KXyTSMmj7Vpgpvrk4fKrs2fLFyQddOrUhE7v5NW8zX4Rb
         LRmQmNbYl+ZOgHcqFsHoIo0oPLQ7/Cod8PUfpbNsDFVAYh0dvbJ+NTqhG8ws2IhItLuj
         /AI+weXUcFhVnK+Jrkt6hQM6loWLkKsSe+Dawl5+Gl1m/7d+Ht9ZY/Tj6cKhUn+n81g5
         +E2U5Z1YW5HG5SsoJLzmGlMNditSBGExEbhqGk6uGmurCr2sOcWIhl/NS5QiP1hbnNkO
         S7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=28kX1GxLg7lo1cpThqCrBTFpdtZ1SsRkJeYqDWMqVBk=;
        b=jrkC/txsCaTrXYeRHaAuJ8Gx8ipoUHF7bPCDBL4Yz1UFi3Ds+0BLS8oQfhnnTklA3O
         Ild5WPLaVYIKBB2f2EWSuiHxCPvEXdhusQ+NSs0HpgBjXOEpxv2l2WFumY9ER0AEgIuL
         k6hJez7ZSgFrvVZ16RvLGIjfOMx8z6TtGTqnwrjBY/rE24xzNXP3t8pruRRy2fdrLzpc
         aWEmvVDI7GvZRKbuoabr0N2uPwAaubM7K3inKbidZNyTKl+cumX2/43kVSMLnZkGYkeV
         jqc/WakkjxYYK/m6qKqc91oNedCFwO8v4Bd41QbGkaKs8rMQ0B4QrO6rcnBGDNGIOdlk
         At0w==
X-Gm-Message-State: AOAM531Ub7E1U+oD21IOiufaihdpASkYbmgVsVwjtYYwGMaJWelHj8G5
        dN7Y99l0WW99wYrAQj7/Q3IWNA==
X-Google-Smtp-Source: ABdhPJzRuwOfmXFsjTP9J73NxK84ZiJCIXfrgr+kvoQFRqDyLOA8SXEs7Ww98LY7qA2dplFRQv9b9g==
X-Received: by 2002:ac8:149a:: with SMTP id l26mr20519528qtj.210.1613514796152;
        Tue, 16 Feb 2021 14:33:16 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id i6sm14169675qti.30.2021.02.16.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 14:33:15 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Tibor Bana <bana.tibor@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating 100% of my cpu?
In-Reply-To: <YCu8RuhvU1Env7OF@zx2c4.com>
References: <20190126200005.GB27513@amd> <12171.1548557813@turing-police.cc.vt.edu> <20190127141556.GB9565@techsingularity.net> <20190127160027.GA9340@amd> <13417.1548624994@turing-police.cc.vt.edu> <20190128091627.GA27972@quack2.suse.cz> <14875.1548810399@turing-police.cc.vt.edu> <9618.1548822577@turing-police.cc.vt.edu> <20190130104020.GE9565@techsingularity.net> <20210125195438.c8d0e7980da0c2931d4f3056@gmail.com>
 <YCu8RuhvU1Env7OF@zx2c4.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1613514794_34945P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Feb 2021 17:33:14 -0500
Message-ID: <35445.1613514794@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1613514794_34945P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Feb 2021 13:36:22 +0100, "Jason A. Donenfeld" said:

> Another anecdote: 5.11.0, 64 gigs of ram. If I run QEMU/KVM for a VM
> with 16 gigs at the same time as a VMware VM with 16 gigs of ram,
> kcompact goes wild and both VMs get really slow. The key here is running
> KVM at the same time as VMware.

Do things operated as expected if there are 2 KVM instances, or 2 VMware
instances?


--==_Exmh_1613514794_34945P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYCxIKQdmEQWDXROgAQK8uhAArgjA/4ordtEUP/P2ZzA+Qp428BusiOPI
EjX+g7Ljis8bOFD9zNxvXPU7VekrZ5svPUYUMoKaPKRnbxQi42UPIDZiBt5aI11B
yVNyfLZy/LkfV6fcXXZtg3yuldfTIM9ofGiA9WbPgQaneDNdAi79MrEohFmFCt4a
ov3NXcXbqOQ89O38veGI2vL7+S3xdmBKELlVcxxstWxJrTd0L2yy5QeZ6p2UvYtk
jypVywPv6ST+G9da5cVh6FSm5z0FvKNsmvy4pLLxobmEEdrLthKYKTZOfwdni6u0
Oa72lgXGUgLnQ6oZaSpaQn36CvAC1SxpTs94/X5c3lodfiUuxdOzx3qP9/ct0Ty+
vtoz84m5BUeQI48giJZXGmn5GZYfO/lfvA1vMXCkYcA/bzXjtMxq76SmjI5OPrK8
C4vkxYq439hxbnfxhxYMPqCXB4sR43yxoxpWoOv3p5TPB9oHfP4wmXjmVjZAEsx2
8MjDv3n0TwPg3gqFvUohE1AfFwkjtTwc1H5yc2FzxJ+n+sDlT+X43E257EGUNNgs
KvE2nHxacpWPNCwKAHzgDDcw/Ub3nyth2z91jvU06M/MNiI5hy9ILsZz0TOTqqiX
+OAfbiXqa2uXfDGzUOv33uLky4Sh3/TeVHA1bU5Ef7w/8Znc/XU5c0STN2dqcGeg
Qy6d49RMi28=
=vcZt
-----END PGP SIGNATURE-----

--==_Exmh_1613514794_34945P--
