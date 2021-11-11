Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142AE44D79E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhKKN5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 08:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKKN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 08:57:39 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F0FC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:54:50 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i13so4081483qvm.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=QXi5kHjHWd6fjjRgTXkyGAMS+MMuGm4cZgmMpd4J85s=;
        b=iQZAa9VL4jVrqs3JttRSqTFtpBwCwhZIiuf0juUtq4+0PMb+o+ZWar7Q7/RI/nXaMu
         7QCDUHJ9CRNsuvnoLQLCndLqbm4dkguTOpR3T2kcf+Pvqabp5sSdVQO6nJl+Dovwk/yt
         NnM2W/73g3PftX/FWG78Qr8QC4vXjbv6rsXQr9KkIC29AsJ2+jiCzVICc1GsFB7gAUSJ
         IPegGvPcJyOWL5jNWGbrvmv2KW1yF3FkM9UzW8SXwAF8OLy+moTIcqMGv87ovIHTzDGC
         1hNMZpxg3aYlchrARPmufEyJKbKDVgCNau1Kaz35/WYQkonyI0/VJYWpqecXE9nkRDFu
         j0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=QXi5kHjHWd6fjjRgTXkyGAMS+MMuGm4cZgmMpd4J85s=;
        b=MogfvjoD7deJD7I8dg243s+ACSt5ZQJB5P+GHQrEFHUKpl4pKf5lLszb2F5gW/X57U
         v1ZrojUSNZ1/eShpWuc1ZEChbALsPj1Y1j61y7Bbl8FYUTeWrUs3erKv7QUREYA0c2OJ
         Vf4Y2C0NLbb1zwX3CZeVGzNqve86aexQaddOqAwE2wanS9VJJI7ZtJrDxGlWgYGKScAj
         CtbmcHpahECDaUWVAx+dYfFEn6eyg8i8WjOUI4SsGttb+YDrvHuafYBItamP9XAoaD1L
         2v51ObOKT3Wbd4dil8v3VQ8VyHwPHOw3YqjZASEGjdbM0O2cMNe/gDx6oLwMtKRHCK3E
         dn5A==
X-Gm-Message-State: AOAM532NghnSKTMNlt+snQryLCNtZMUWWlPHdSBue6t+xFPh6EVdd15G
        PrQkob5xAdPmNOJTageK1SDIVLPAzDYBM93hga0=
X-Google-Smtp-Source: ABdhPJynw5H4Jaz+lI76M0l9sMhJSJca4+xEAwHODejjlGTtfC45NR0moCT9j+obK4sHmfTW+5uMnU94uWBu08sCc/g=
X-Received: by 2002:a05:6214:f09:: with SMTP id gw9mr6678652qvb.36.1636638889210;
 Thu, 11 Nov 2021 05:54:49 -0800 (PST)
MIME-Version: 1.0
Sender: reymonddennis@gmail.com
Received: by 2002:ac8:7d12:0:0:0:0:0 with HTTP; Thu, 11 Nov 2021 05:54:48
 -0800 (PST)
From:   "helen.carlsen" <helen.carlsen26@gmail.com>
Date:   Thu, 11 Nov 2021 14:54:48 +0100
X-Google-Sender-Auth: bur7Aj9tYLZ6tOuiZpAhSWjMy0k
Message-ID: <CAOOE2sGzasS8WR2LHr42-VTwyojBA7Dvg3i7=zAvQU7St67sqg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I sent this mail praying it will found you in a good condition of
health, since I myself are in a very critical health condition in
which I  sleep every night without knowing if I may be alive to see
the next day. I'm Mrs. Helen John carlsen, wife of late Mrs. Helen
John carlsen, a widow suffering from long time illness. I have some
funds I inherited from my late husband, the sum of($ 11.000.000,eleven
million dollars)my Doctor told me recently that I have serious
sickness which is cancer problem. What disturbs me most is my stroke
sickness.Having known my condition, I decided to donate this fund to a
good person that will utilize it the way i am going to instruct
herein. I need a very honest and God fearing person who can claim this
money and use it for Charity works, for orphanages, widows and also
build schools for less privileges that will be named after my late
husband if possible and to promote the word of God and the effort that
the house of God is maintained.

I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincerely and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

Best Regards,

Mrs. Helen John carlsen,
