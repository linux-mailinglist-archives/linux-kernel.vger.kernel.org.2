Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ECD36A2FE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 22:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhDXUig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 16:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhDXUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 16:38:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3950C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 13:37:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x11so52958522qkp.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=oW6fHo0XgbJMHm3nIz/zivLoyUK1+fsOgv+m//0Lr+Y=;
        b=j0jrGV9wWym3LHmXjyrGGAtHD+EPv6neXK4ZppbMcTIH1eCJUMTCIRM+y+pFFgoc+f
         uTBTKdZBkxlJ6CgH+KvKiObz61bGSzWDNz0JHysAtKftkTPEwCB0Tgiv8y+C2GsrXw80
         r9jxh9kK0hsVvhrdfsRlCFmC7TnOqeCLNWaG/7zgFTBH7Ikj0gKBn+vdCpIVsL2K3FSd
         4LkEI4d/Oyg/Nk7yUmjDTQxbnaCMMQg9w6+APcM5fpOGn8EuLfnaXsyqTwgAcxlLLC+U
         6/gSXh65lEvtNQJVp3U4unwP8tE0ggewPyYoSoAGpDrTtIu628A+h1vKoZf8fbmColM3
         AJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=oW6fHo0XgbJMHm3nIz/zivLoyUK1+fsOgv+m//0Lr+Y=;
        b=B5TsiABKTDWPTerN4stz5uaR+Lz2dJUBW6dl2+ElIJr4oqKn0cjGovNUVRHedzoOG2
         qWt4WrY/hRXXjR+kRnzGPwTH61EAp2JXmVdFQ99vDEJIEdNtxhpXeKg58FHzGTV1zoXQ
         k+lmUw8nI1Je/ySWIWlz+awdIwmPtgI6s/rtF2W36R5XXcbMSOG/ryiemPnRQYacsIly
         T7DKzs2yuc/Uollad4cAudHKD6q+UXKGfTdmPhOUJCdpYOyvImDhNnTP6Bp37HYfqKZo
         5WK98t4V4v8DgM+gnLpe9SL8h50g5umIlnbpxSR/QN8AH0ae2BYLUOLS6cU4sSld/wxq
         fzIA==
X-Gm-Message-State: AOAM531/+GKwxzXupzuQPGXZMyBU5fXmpUhnEb6qQZDHZLDC/DzF667i
        nxLTdk35HdzTinaZ3NESBhVwxA==
X-Google-Smtp-Source: ABdhPJyVq9Ibxe7BudPyDHcP2LR9YC3NDUzbDZpdyYnX8y8nb6U346ejzgVct+TFFz2/NUhwEnU9Iw==
X-Received: by 2002:a37:b807:: with SMTP id i7mr10172017qkf.126.1619296674918;
        Sat, 24 Apr 2021 13:37:54 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id a30sm7417609qtn.4.2021.04.24.13.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 13:37:54 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Anupama K Patil <anupamakpatil123@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, bkkarthik@pesu.pes.edu,
        gregkh@linuxfoundation.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] drivers: pnp: proc.c: Handle errors while attaching devices
In-Reply-To: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
References: <20210424194301.jmsqpycvsm7izbk3@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1619296672_197072P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 24 Apr 2021 16:37:52 -0400
Message-ID: <437247.1619296672@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1619296672_197072P
Content-Type: text/plain; charset=us-ascii

On Sun, 25 Apr 2021 01:13:01 +0530, Anupama K Patil said:
> Changed sprintf() to the kernel-space function scnprintf() as it returns
> the actual number of bytes written.

> +	if (!bus->procdir) {
> +		scnprintf(name, 16, "%02x", bus->number);

> +	scnprintf(name, 16, "%02x", dev->number);

Why do this when you don't *use* the number of bytes written, but instead ignore
the value returned?

For bonus points:  Given the %02x format, under what conditions can it
return a value other than 2?


--==_Exmh_1619296672_197072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBYISBoAdmEQWDXROgAQKzRA/+PJmouXYYzm0CMp+Zv8IbUmPXbjIeNsij
fiE4Qr0KeYkEoKquUxfeEPkSZ5UBDPajAgsbcwSO8dJtmzaD8+MPMPyNkDkNE7i6
vvIWfuernYrS5JLYIGx1Vg4bUAOodSOUIQSfkO8U2U1I4sQ4JBLQC54ea1vL+G2O
lgjNKsRtBW5o61ouJrW2kGGMzhdN179nIYNF7WspXB9twJClP+vVqk2h0fgtgu7H
SZ+bEF3Z+kMam/gHjbl2Y5N0+Ji5LX/SuXxb6rlq6l3Btb2Mj77LNt2FnK5OpDsp
K9Cdo5uLZu5cdJq7QDfLUgWf2WbIuUe/902VENkXLOOYQsnZhdVkMy3matZStpQW
Ovl57yuPj8T/3d4zvLhOTSlXUDobUvjOEZHZZEprNyd3ET20btsT1Ouv6/RgPwiu
Wg0/5EeTeV0E4cIrFgDSN7miIwpdiBtgQtvVGEuxwMF3gn0VJV7EMG2ISl70H15y
/eED5Z6PVDXx6fZYdxLmN9kJS/9wqpQzfyoRS34BM0GJhT6xZ1WfcADmZqPt3GbH
mtKzG1CQGxOqyr5BfH0K348+fm+HHpM6uZPIBYYgaMoAerMhLJHlmLWzaHovZEmg
xY3HbW/e7f82C32nkjjsvc6tFfwnCcst66vEPJ11UniXvv/3FW/xON8avRq8YaTf
osmvFBapi/s=
=c7CK
-----END PGP SIGNATURE-----

--==_Exmh_1619296672_197072P--
