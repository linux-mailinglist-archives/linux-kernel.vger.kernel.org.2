Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9734E36E446
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhD2EcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhD2EcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:32:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A5C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:31:16 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gv2so22685680qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=RB5kc9IKbmCeDriaGhlxOG+1StbExGw3h3p1/FmS/Is=;
        b=a3NnSFjNVU+caljK4pWab0swF/9ObxO4E9lt8wdlT3jZH0O12PVBmCMaXEgzCcYmET
         00re9IQzpVhA5LItOhrp6yUV66DGYtEwAs40DkEIrd/eAZJA4N2FuIZLBko7S/vTmDmL
         Fnpw0x8H8QlbGIdlnRgqHpRh/x2Rbk0UTf1BVj/+gFpYOkiC/C58uujnJ7rnLbnuPYbg
         0ZS2WmM9aUNoi/ZCz+ZhQp90LxBNzNWJrvODVB0KG3bHc0RnhjP1MloWGhlEcsfUr6M1
         cJhvDdSxfiobUPh8iWUKaEoE5xRfj6O1KSoPmGMklZPQpYu/z4OJ0hrdaRg+zUUpiZC6
         Xgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=RB5kc9IKbmCeDriaGhlxOG+1StbExGw3h3p1/FmS/Is=;
        b=gfffXFtZO0ZWb5ddE3ESZ3oxfQ1Q5qVo1f1rqH20K4CfhTJBGGp3gY3UANYNAbEEFE
         Bjc5DzLOKiFd5h2XXHZUUuSeIj/nn2dmtaobWz5xZgvsHbM/faE5BuiWVOpHqL8mz6lH
         UD6xkH9czzGE72EnD6VJrxe8OoVxy2JDAImKrfZPd3sA+VKQt7VPLEhJqLIDRrBI8e4Z
         c6VaMAZlfrnPu2Lvs11bTgmuLSiUx/jgu7GZ2BmV1AKFgyggnKttUFCQfjOyzDTkIMNe
         cjadeCe8xW9JqIXK31OuJNtDD1o1iKd8hgDWYUOnbuOH/gCTlNmnR40EBwieeZRT3z4l
         izXg==
X-Gm-Message-State: AOAM533H3+ZLDC4X1HxWufHMSD2VDs0T+nQU2vpirJOkkTYZSsnsqmDb
        yZYoQWuJ/S2fp3DMZIXX35Ry+A==
X-Google-Smtp-Source: ABdhPJwFB36RZUA9Sz9VJppLgGsiTMODOr0NrQ7oBaWjAgwldjkD9oVUxKiRIh1csxCKyBNW17cx/Q==
X-Received: by 2002:ad4:4c86:: with SMTP id bs6mr33749154qvb.39.1619670675551;
        Wed, 28 Apr 2021 21:31:15 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id a187sm1418590qkd.69.2021.04.28.21.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 21:31:14 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Leon Romanovsky <leon@kernel.org>
Cc:     bkkarthik <bkkarthik@pesu.pes.edu>,
        Anupama K Patil <anupamakpatil123@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching devices
In-Reply-To: <YIeSc1qePhuQ1XRK@unreal>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu> <YIZJwkux0ghJ8k9d@unreal> <20210426175031.w26ovnffjiow346h@burgerking>
 <YIeSc1qePhuQ1XRK@unreal>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1619670673_209619P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Apr 2021 00:31:13 -0400
Message-ID: <210271.1619670673@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1619670673_209619P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Apr 2021 07:26:27 +0300, Leon Romanovsky said:
> On Mon, Apr 26, 2021 at 11:20:32PM +0530, bkkarthik wrote:
> > These were only intended for a clean-up job, the idea of this function came from how PCI handles procfs.
> > Maybe those should be changed?
>
> Probably, the CONFIG_PROC_FS around pci_proc_*() is not needed too.

Will that actually build correctly if it's an embedded system or something build with
CONFIG_PROC_FS=n?  I'd expect that to die a horrid death while linking vmlinx due
to stuff inside that #ifdef calling symbols only present with PROC_FS=m/y.

In general, inline ifdef's are frowned upon, so if you come across one in the kernel
source, that's probably a *big* hint that either (a) refactoring the code to eliminate
an inline ifdef was just too ugly to be allowed to live or (b) you *have* to put a guard
around it because you're guaranteed a build failure otherwise.

--==_Exmh_1619670673_209619P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYIo2kAdmEQWDXROgAQLtVA/7BvMbjCP/xvK8WkA+Fk2QhCEVXOxBUGkH
n5t1+/k62wdCTY7EcqhNW5MQWu1VZ16aN0T1RHeTFX3rv7AmDxyXTVlf3ksyof4v
a1/oyPr5mEIzLXmpFjIkHICY2OysaUkLgeScwEOpfpkAAqGrx+DTblzEN08VVbTf
84/gwKgvb8CxU3D5MVpPFUbmDY9JXqJsK3/sPBNYseyXi76ypTSkaANNB8aY7HsZ
C43Qo7wqr8lwe2q/uKjE0Fw5bfPb2B/otaEgfABrRTLDiqyODvSKVdticcHUIWsg
GUpW3QPqYhttPRNjVy+vLQsAytSQVMBuSApoyplJ/ebZUrPRXophRE7WmxoW7q5X
yX/7rnuEB4aT0VeqIcL3LSiUJBGKptBgJiT9qsCYnYTMva0hMQjMKJRRZ1Xczrp7
NDxGMbkkPlre09Z2OsOQqJblQJHiztGTOA6fcXjnigThux5H5xXZCUUklinXcGO3
6jhx5qNOSJ+a5OeLrShSDvR9XuQPxIk8ql/qDs4wkcLb2YB/56d6Lr8reCdsce7n
dChAkKG5CugsOC/E7ZYLtzm8E6ezyiqDPCa+Z4yhdSNPtaxbBW6Ies+Dmkyj8MzO
ChgiQRW04BofS4dU5bF3LgRTuvAtlrKxB94qK+u8YkXYydgV2mfYmCo/Gd/Y62zt
iKcs8dUS/ko=
=MSZI
-----END PGP SIGNATURE-----

--==_Exmh_1619670673_209619P--
