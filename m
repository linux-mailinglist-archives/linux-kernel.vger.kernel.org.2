Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BFC3D36A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhGWHpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhGWHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:45:02 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB1C061757
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 01:25:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s5so812983ild.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=8Fh1AmsX8lTEP6wAub3MAWGaox9nC2Imv6c0kMa0AgI=;
        b=MNTcpAYtMHz3mWuwqP8A85+5WSKFHBAu/cC3a07veDqS5/P7/tLOIWBZ2Qp61/jwkm
         ttl4VpeJUdOH0gPCH0mbqvssBd7dJ33ndZ85sGi8mHHrVDmORSAao84x9BgG65LkGaSv
         vN4dUL53DEZhmcZL4y/A0n6xeeOTysmEzWpDUlocdZyd6f8TNdNk+2/54FU1T5wFPOsx
         AzencyIxbM2+MUcqtGLz8ngbZ9kzcB+d15VGChdEUUNSYJsgduD+vVVgqI0NErSNhK80
         BOe0+tbSH5UC3QXYhjsg+2pmarDz+xk66f9+jFRKjSLz1c/DFE2SLRbFOddQ1bSio2mX
         CiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=8Fh1AmsX8lTEP6wAub3MAWGaox9nC2Imv6c0kMa0AgI=;
        b=XwSj6QiXcG9KnZCM29pK6qAkBykBOJAkgirugZH4Eyls1Q6S19avBKK48ae6b7Y8zp
         UuJIMaqz/vRw6JSQ7u7VE6uHbVoYc7Q0I8Omo9VQjc+wByt9mCZaeKtWrR3BcGnjOgat
         0+q0RFkcT2uuVbMRMmGpBk1oBnqptsyXxwBnsCgITylCIiVD6o4caE3DSoJr1C3uPaZC
         8d2nczgoQCzdyfq3qe9M3BFmLXhfzdwkZmEQqc1MUE1PYlZ3Acwb9pStA1/iEp3YAWQq
         4Tr4w/5fw5ITi6uC/je2IHjYUkGao+45+p8Z+B07OL30IFoUwBMB30MXrkD0X9jDaPFQ
         LgOQ==
X-Gm-Message-State: AOAM533D2NCxfSdi4SqcjMFWteIvctlzW4Osy1qPkc1cIq3Pnsp++0iX
        gvGHmVshDq4HEvI44yXZP9RpX0eRXOiFOLZwLE4=
X-Google-Smtp-Source: ABdhPJwvODM8LImX7csZ3G2roUS6vmfW6mVkC2ADPGYkwWT1LvY5Sc1uqTIB7jL65/nfOykKbRwxuJjM1IGEQKe5kyI=
X-Received: by 2002:a92:1e03:: with SMTP id e3mr2901966ile.264.1627028735331;
 Fri, 23 Jul 2021 01:25:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: jabbarqasim39@gmail.com
Sender: parrickmark99@gmail.com
Received: by 2002:a05:6602:2117:0:0:0:0 with HTTP; Fri, 23 Jul 2021 01:25:34
 -0700 (PDT)
From:   Jabbar Qasim <jabbarqasim673@gmail.com>
Date:   Fri, 23 Jul 2021 08:25:34 +0000
X-Google-Sender-Auth: jTX-N6hwMUESL48P9C0a1UYJFkg
Message-ID: <CAEDe2oW0TsEgsCf4v3HtDEc1k+KE37AmzN2zKV1xC9wx6FBKNA@mail.gmail.com>
Subject: Reply me very urgent
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I know that this mail will come to you as a surprise as we have never
met before, but need not to worry as I am contacting you independently
of my investigation and no one is informed of this communication. I
need your urgent assistance in transferring the sum of $13,300,000.00
USD immediately to your private account.The money has been here in our
Bank lying dormant for years now without anybody coming for the claim
it.

Best Regards,

Mr.Jabbar Qasim
