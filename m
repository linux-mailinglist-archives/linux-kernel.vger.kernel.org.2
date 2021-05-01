Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C03708EA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 22:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhEAU3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhEAU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 16:29:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B476C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 13:28:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 12so2239693lfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=kJRt3oIELhiKOtTf1e5zCqCfRgFzhZO/Pp3LtvIXKzxcjfCqhF9T44yTkiFH7Gju2w
         hl48IIxphykP60D3NCk/+8X2FIpW30FwlqsTOsUCeDif87VAS+NS3NlPPWFMMnnhHAsZ
         J9FmDXSTtdFd3gwGUU97Av2iS2oSNj28rO0qbjFFpufn0Iw34UxNSKVyqeYtYu0sU4HR
         TNTMeis7a2Eq85u00g+eN8sttSJE7RNM9msZ6UDtre2I89aMECHIaeBlSS95yfOHGOJo
         J0UZulxJiLprG8xPQEm2E4US7LdoHJ2HS/ywk76JvBpFrqZlQ4Xx6yZRT+tmB2aqolcA
         0eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=dE3HA7/GC0e9OAgDvfx9pQ5Xv0WjSPOOJaxVX8q7sEl2FZp2dzr+6eHiomouIyml3/
         DzVberGavXOp2gz9VauTz39x2fDssIXAxgnEHhnZIyBgnIcKR+KJf0h0MKO6fukoDmdp
         o4o6DRNM5PhdAzJtt4yEl5XAnRaLTpw9Uf1rp782qO8d7EUUZH0Ds9kPzLI32bZ5mrQS
         qHO/euqK0H++dVz1f4KtuwmAqklluRXRRs2ZqCcV7TFA76IzHnigVWy8VwEw2TqSOOI7
         LmdnF+QVYyoWkWS5YBkLx3bMv/P3ivUpR9ExIUg9Ghk3UbJAus6C2RsTbz/lpWSTx6i1
         /Izw==
X-Gm-Message-State: AOAM5311sdvNWZiTX4brBe6F01xn0+Gpudynz3jeA79Oi+AI7R1hCjuv
        hULtZUDlxNYr/APB8yjshQ0LLh/iPt8t+78DNBU=
X-Google-Smtp-Source: ABdhPJyksYWeCmtXDHAqO1Zlgns7Wkc/Qdf6EDD1/nydMVo+/Yjq4ucQnyUrrsG4Fr1nfzKzo7HfIFvi3VBh2gJlNlM=
X-Received: by 2002:a05:6512:3130:: with SMTP id p16mr7601824lfd.83.1619900927603;
 Sat, 01 May 2021 13:28:47 -0700 (PDT)
MIME-Version: 1.0
Sender: patriciahorohoxx77@gmail.com
Received: by 2002:a2e:b0e9:0:0:0:0:0 with HTTP; Sat, 1 May 2021 13:28:47 -0700 (PDT)
From:   Kayla manthey <sgtmanthey1@gmail.com>
Date:   Sat, 1 May 2021 20:28:47 +0000
X-Google-Sender-Auth: bRZJRxY_Gb2V0QdBPhD8qYkLR5s
Message-ID: <CACEPQGfzNOiYjGsSoFLecQDH1jPRvBTvCmuKcnoABPWcqr0uFA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K=C3=A9rem, szeretn=C3=A9m tudni, hogy megkapta-e az el=C5=91z=C5=91 =C3=BC=
zeneteimet.
