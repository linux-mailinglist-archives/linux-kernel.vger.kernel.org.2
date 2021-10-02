Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBCB41FBC9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhJBMhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhJBMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 08:37:18 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6247C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 05:35:31 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 71so26433804ybe.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=HO7UaKavBCU4G9TsxrFHymYV8AfA1mKx9sn0m38IslI=;
        b=EnCTrAT2CJOGbkIJMvHFysNAoyJF+IMrzpcxIT0VWKE2Ua3LpbarJ8j6DddmoJjVEo
         GjoOwW28hY4BB1qMPTjt8ZnNMrpJ4IPENhnl15NCsqn8vG/PzHDPlyFtCjL7I5z/GfBw
         fvTnoo3sSR/WFq/JZaDBU27PNsj/Qm/gBzAd56dKPrfdx5aYwVlzjgIWI1KG2v1irS+N
         UEqGIcokMHN4fwZ33z/W2WHbpnhNHFbsxHBpKUlQSQncqElESC5rOpngDiHM/9DRGe0s
         KYzRSpjxqk4kJMPBDpk+QyVzoFWTfOqWtpcKsTUt2M4hZR4art8kyL6Qw87F5yJdZzvZ
         Q5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=HO7UaKavBCU4G9TsxrFHymYV8AfA1mKx9sn0m38IslI=;
        b=XIClBATg87+gzWJsjg9lnOxPdP5GT3wx6uzM1kwgi31Xhny6d+XDkbIkW93Mle9vX1
         W5WKAzmL+gzSF7vQHUJ/9573P9xL/DHxFWR4Cg0XKYi4V+jWEkgo2EV9zVlZenMsWBUD
         3JhXsbuse1ZbBX80HIytt/GLCuN6weDrXV+K8ILslEoizStdmMunmZvmMStFzMviUbmR
         uBlaIGE42quRAcQW4TLgNAm+/PMjPsl/2d9AxnY88RNybEJ4z/TgpCLAKOJpyVJ7f4pW
         X0Qcyqs0DPKN65VVYm9qxbqHTIIGyRWKvYiR/e0AHyl7uUzifagvbNvXDEmdEkhVPOw/
         iTQg==
X-Gm-Message-State: AOAM532p7I9pcK7kewY4rMNuUWcYRkfdK2JGiJqWnPYcIJjJ9XIciR7H
        MfA/hwCLLMuvnLALt8UtxZiHGxCi3MMuSR754JM=
X-Google-Smtp-Source: ABdhPJwLt+K2U/NS79pOqJuVmu9urGgTJjhKIpDp1fLZqx1FEuUUhSIR27nU3tHRLYNfPRxtoc3BD4rFNYMXRF6lVUc=
X-Received: by 2002:a25:3142:: with SMTP id x63mr3194198ybx.99.1633178130906;
 Sat, 02 Oct 2021 05:35:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:11c4:b0:5f:c18b:9903 with HTTP; Sat, 2 Oct 2021
 05:35:30 -0700 (PDT)
Reply-To: mllchrist703@gmail.com
From:   Christiane <haidarmarina66@gmail.com>
Date:   Sat, 2 Oct 2021 14:35:30 +0200
Message-ID: <CAKZ+pTMyQ8USBbhFBnuiGC8uXbwrQ6+UTvs=cgKixAmJ8bzaGw@mail.gmail.com>
Subject: Message from hospital
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 


Dearest

I have to apologize for sending you an unwelcomed message because I
know this is not a predictable way to encourage communication with a
stranger at the same time, forgive me for contacting you without
knowing you personally.

In any case, I am writing to you from the hospital where I have been
hospitalized for esophageal cancer over the past six months. In fact,
I have performed many unsuccessful surgeries in the past and recently
my doctor told me that I only have a few periods to live because of
the cancer damage.

After learning that I had a 10% chance to survive another surgery, and
a short period of life gave me a lot of worries because I am a
66-year-old widow with no children.

Initially, I wanted to create a charity project to fulfill the wish of
my late husband, but my current health condition will not allow me to
implement the project myself.

I decide to call you until I make you the beneficiary of the fund that
I inherited from my late husband so that you can create a charitable
project that benefits street children and orphans in the meantime when
you accept this offer, 70% of the fund will be used for the project
and 30% to you.
I hope to hear from you
Thank you very much
