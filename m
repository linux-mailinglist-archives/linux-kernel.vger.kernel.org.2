Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9FB338840
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhCLJHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhCLJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:06:42 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:06:42 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id n79so23546995qke.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=CxDOIVo4z2AkWvsyRoRANvheNaYKezgIDa3komDdiYY=;
        b=RAYjdzpiqXK9db1JiUmMRpyUzhDEypIA5sepbSjsh8bQc0KOcUwYvgj6DbfuRNYSaW
         5Gz75RrKHhH1QBwiKnOFvamAG0uV792Vl8AgEs7TUqI1YGXvnp87iPMiX7RnDF5Qfz3j
         27hVc9twPtHt/et23KFAQe/r3OZfevpqPI6a/uIY3lxNtT2g4ioBsXjohr7WXrLLFf90
         Vu9ki4/EmqR3yBYL4v9NrRlAVEvWM+xWTGX1Wa5yJLGhbDAJ6zHjFAgwbQeZBFtbn784
         56GRPg/xERUs2Vz0WHYYvNTabSyiGCgjXVpzMYeIdojdL1b35OfWpB+vtR8nMiRXPO9V
         Nhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=CxDOIVo4z2AkWvsyRoRANvheNaYKezgIDa3komDdiYY=;
        b=IdsYfc8IzlzhRMUgJYP3K6EBnWbbCtv9Ev8ajTw0ldatNAKyyRqfbqZUNvkmaAJL+O
         AiWca3gPgoIQqzBHrCAzl9AO0Be484hcVQblXOscVCfN+ZpqTyQS9hCF4BWVRW5e/ykq
         fGJGH3o+y6vW2gN9mWBqK4XyhT+/AaoGFpmS+j/28zDXwT9Uo415GKMxmJGKY3Ob8CHX
         jiyHazNUAPH1nH3MVxwzdaLw9emv95b1Cd+EDMcPQA4gZp9Xd1pX7mmeC1YXjndPVrQx
         Ag8radJE14Vzf2egTvc3giAdTJb1JqEHgTtGzzTAPx2DkFjQmEQnwfGy2VXFQR2UqaAp
         jGCA==
X-Gm-Message-State: AOAM530tH1dDCUA92zpSJwD9cEJnBBlw9WCWj1iNRDLKEnEnW+f0IjIK
        SBZGb6CwoApvUfDDD5COI7t1qw==
X-Google-Smtp-Source: ABdhPJyGxnM7RYEuymWsOxQS55gLx3MlIZC7VQpeiFmtgLZynXM9K3GFCA800QAwIm1tCCnaHTmCBA==
X-Received: by 2002:a37:a2c2:: with SMTP id l185mr11372653qke.178.1615540001657;
        Fri, 12 Mar 2021 01:06:41 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id 6sm3585347qth.82.2021.03.12.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:06:41 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 'make O=' indigestion with module signing
In-Reply-To: <2026575.1615539696@warthog.procyon.org.uk>
References: <134696.1615510534@turing-police> <109018.1615463088@turing-police> <91190.1615444370@turing-police> <972381.1615459754@warthog.procyon.org.uk> <1486567.1615464259@warthog.procyon.org.uk>
 <2026575.1615539696@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1615539999_20296P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Mar 2021 04:06:39 -0500
Message-ID: <159991.1615539999@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1615539999_20296P
Content-Type: text/plain; charset=us-ascii

On Fri, 12 Mar 2021 09:01:36 +0000, David Howells said:

> Possibly I can add something like:
>
> 	clean-files := signing_key.pem x509.genkey
>
> inside the
>
> 	ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
> 	...
> 	endif

Would that remove them on a 'make clean', or only a 'make mrproper'?
The latter sounds like the correct solution to me, as the signing key should
have (roughly) the same lifetime rules as the .config file.

--==_Exmh_1615539999_20296P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYEsvHwdmEQWDXROgAQLT1hAAqElogf+x4dL5wZjQA17rrOdWngKF26C3
pYRmHsxNpnpauM4kfE8T8I7okmdV8Lmdunmo6bsrvlw/ppHxT0NBoq/UEgi9nAgE
rChAawMwfmrXZkNS+P2DN0mkvSyyBpDAmNrz3tp7RXYgkEaQJF9pXrvQjewQ0P93
6Vut217HV7bWptLkAVclx/oC26bBOKRgGRDgcJ0aaFNZPrbctzqlkC+QKvf0u9g0
eXFHaPbwnoVWj//O6TdY6zFkbmWjXyNqtTVAIdL4SqOf34I6vjaOQFhO2inuclxD
gqDHFPWEa2gezxSVPYFCznRAB5CQg0dALiMTkULKrM+ro7nLqHG8q/3rmpPSpNIU
UXt9RiAoL9ZmZtPVNzwlbYmWItMlT8mrI2gBk4eIdnisSYp7k/wZkYNVv01wlOLY
JLkSTqz/SJkNPu5RJvihiS/X1atsGzbFik3Ca5W/kB4ssms3XA0JtZ9n1Nava6mh
jqTc7tGAJNQqYo0BcTN73B7V1qxcrtSsRtH4+THaYKyOweaEsSd6SpCpN/nU8582
rgz5YeXX4je3/XHzMloGvMiJRECY87FaPwAMib638zLRYCpVm912N12p3DzW1/pp
SJacb1z8K13S1yDFSRbYJaKCqxGMEsMwM6S5piHxWn42T8CEkvA9Bm/OPEZh1BpJ
5zAlYF3r8ao=
=80QW
-----END PGP SIGNATURE-----

--==_Exmh_1615539999_20296P--
