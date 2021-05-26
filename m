Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A89D3913DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhEZJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhEZJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:38:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A0C061574;
        Wed, 26 May 2021 02:37:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p20so763893ljj.8;
        Wed, 26 May 2021 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QY59gu/K6cv665H2L4ZF23yAlmJGNMn4nEmUmUnVoqo=;
        b=cAuOgpVrvDU7qA6qaiwpZdBA+T24eO4LBcwMiZZuaP1l9FrjMxwtyYiC7ssSBK6Qdu
         0pvHunSvN+jFVApPxMPovNsP/YnkryfCsF1JXT77KdDEf4rv+OE2P1z6InKpZCIWum/h
         Hc5wwlpv8lc1i5yI2gyDho/seogANohUYVaeLbKWd5aQwrcrkwnsI7tGVnv5B7fS1XcB
         EjBjr8k64zZpEh1hYeSZ99DR6QJIe+yvanRv7fBBt3WQTYOnAk8iOiUrajemFAYWv6+D
         azmIDacxXNQLFzuakOnTGYIXieX9MrQhajvj9U82CRj+rjxNXE6ODTuwbUjRjW17fbpK
         ZSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QY59gu/K6cv665H2L4ZF23yAlmJGNMn4nEmUmUnVoqo=;
        b=InRHoAyIq+r7277JgeNxJuQBab3t63OhDqB/lC5V5awPSzCGlzfJ8rd7GCOJ4znyqV
         MyDc3SPe51INuHWbxqXppkNxdhybKjGPNZ/rihS2mujWNC9NT5hrkPw95auhyDCr8d+2
         KYfvqDxQ9dERDt/9oudsUg7bTgq+F46H3oUwCOUFBvNmEDgcburOvMMD7jQZM0sDOVp8
         LBqbiX1evmxxRTZBpVBikA05/EHUMWKgJhjrQtoLIBvC0j13UHMmoguORUVYCbhTnaol
         njhz2k1m5L88Urm2cC75yESI3JBLA6IHzBx4S+GggDqcYsZe+FmYXL8yBJQcJM6b/qpj
         fDJQ==
X-Gm-Message-State: AOAM530B1NfCMlcpoCN63M0tJpLaut4SrSBaxpWR35BfqzJVxknDQx2f
        XrV+g6nODZ+DZy68nCD3vgEnZw9dtXfQJ7yWHTU=
X-Google-Smtp-Source: ABdhPJy34On+WBqnHHGQ+ivhPXD0DjMBOaq7i2MAgIalo/Gje2sDu8zCvQgBXaQSgNLr59CQPFDOPczROtQa/oKlx9U=
X-Received: by 2002:a05:651c:b1e:: with SMTP id b30mr1519896ljr.141.1622021829863;
 Wed, 26 May 2021 02:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <1622009321-15157-1-git-send-email-u0084500@gmail.com>
In-Reply-To: <1622009321-15157-1-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 26 May 2021 17:36:58 +0800
Message-ID: <CADiBU3-P_b0TtVq=JkqXap8nh52cv1BtPtRHCkB8edH05YHuCw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] This patch series add Richtek RT6245 support
To:     lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        cy_huang <cy_huang@richtek.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please forget  it.
Not intend to send this patch series twice.
Just test the summary and forget to add the dry-run option.
Please use the latest mail to review.
Very sorry about this.

cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=8826=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:08=E5=AF=AB=E9=81=93=EF=BC=9A

>
> Richtek RT6245 is a high-performance, step-down converter that can suppor=
t
> up to 14A output current with the wide input voltage range from 4.5V to 1=
7V.
>
