Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBB418ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhIZTdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 15:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhIZTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 15:33:53 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB10C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:32:16 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso21361607otv.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dgpwPCQznEmVXGZRT9a+ot3RVGNTTHbl31G3nps7wKQ=;
        b=Nuttvio5I7iyRQF79fKuFBq+hY33WnsM7Su6aOciHJReK+Pp0OOfFQldrm+V+siWUp
         tRGpk6ZrhhoxLr2zpe7nsfqEKc5Mvv/mrAPnIziiPcBhAYirUnrIjOOghg9vMnl84fpF
         eqpe3tppOghniUBLDpfLjnejkNrBC+eFeXfl2EFJ3NyfWhT5+oB/fZyqbohFk096rIIT
         TEJ+qt1YPvgWIiXKU0MFcgJhTnWQ+YSl3uyzHxpQW9r8Q6NV3XJFWq6sMgiwyc/LFDcN
         NKXkt8I5CmUmtNw2TEgYltK+pmzOyIFeumS2M88a5sAkcaXJ/sBvG+2RUEqCiCVAaaCu
         l/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=dgpwPCQznEmVXGZRT9a+ot3RVGNTTHbl31G3nps7wKQ=;
        b=1Cd2b4wAHTMY1gnHcwjXYIKE9eu1/F1PjWV7EFkVEX/mFlZ+UgLj8TK8MoxMm17wMJ
         7/EpIQr+3OVGHnX57R47Hm/p5Ei+6d5T1AoJ4KhkWCILtXWUX80Gu+E0HUS03Bxk45Pr
         G5IJZaktIESuenucxldEIjPj9MlPgOUB6Bnj/NQH0a4U0N/afvyPHDK8Z/Xv0RiVxlRJ
         5IRYpQOHulYG0123pkzGO6q9pe/S0MNAM+l/UQkcLAe9GsMK1xrDPUvMyvmFPK6c9zxC
         el+Gk7YnNKAQ+K6kLPQNpjTjkS+KAl6xtgFkQnOPnGnQGsAjkwZPISk/zHgikIT5mj1N
         LBLQ==
X-Gm-Message-State: AOAM530vayO9+WBELSHlDhOcryg2MOhNJszobdS7DF3EgWq35+zYpGaj
        1sRtAMZmwkyCTQmrdkqpv9ncukRF71DqWzAIhbg=
X-Google-Smtp-Source: ABdhPJzDZ51JWjhuwJdX1VxXTeJ3lWyOB+4unVv89JXKW8Zp4n0uhU2hHi9NToRrNo3awqReL3PGIQU5hJm4Q9b8MtU=
X-Received: by 2002:a05:6830:25ca:: with SMTP id d10mr623522otu.27.1632684735832;
 Sun, 26 Sep 2021 12:32:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4614:0:0:0:0:0 with HTTP; Sun, 26 Sep 2021 12:32:14
 -0700 (PDT)
Reply-To: michaelrachid7@gmail.com
From:   Michael Rachid <geleanor650@gmail.com>
Date:   Sun, 26 Sep 2021 20:32:14 +0100
Message-ID: <CAD5dpsUE8JTS3ZA5abtZsyQgp8TFdt38HfxWvCA7b2GGuP7wPw@mail.gmail.com>
Subject: =?UTF-8?B?7KCc7JWIIGplYW4vUHJvcG9zYWw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7Lmc6rWs7JeQ6rKMLA0KDQrrgpjripQg64u57Iug6rO8IO2VqOq7mCDsspjrpqztlZjqs6Ag7Iu2
7J2AIOyCrOyXhSDsoJzslYjsl5Ag64yA7ZW0IOyVjOumrOq4sCDsnITtlbQg6riA7J2EIOyUgeuL
iOuLpC4NCjXsspzrp4wg64us65+s6rCAIO2IrOyeheuQqeuLiOuLpC4g66qo65OgIOqyg+ydtCDt
lanrspXsoIHsnbTqs6Ag7JyE7ZeY7ZWY7KeAIOyViuycvOuLiCDslYjsi6ztlZjsi63si5zsmKQu
DQrqtIDsi6zsnYQg7ZGc7Iuc7ZW0IOyjvOyLreyLnOyYpC4NCg0K66eI7J207YG0IOudvOyLnOuT
nC4NCg0KY2hpbmd1ZWdlLA0KDQpuYW5ldW4gZGFuZ3Npbmd3YSBoYW1ra2UgY2hlb2xpaGFnbyBz
aXAtZXVuIHNhLWVvYiBqZWFuLWUgZGFlaGFlDQphbGxpZ2kgd2loYWUgZ2V1bC1ldWwgc3NldWJu
aWRhLg0KNWNoZW9ubWFuIGRhbGxlb2dhIHR1LWliZG9lYm5pZGEuIG1vZGV1biBnZW9zLWkgaGFi
YmVvYmplb2ctaWdvDQp3aWhlb21oYWppIGFuaC1ldW5pIGFuc2ltaGFzaWJzaW8uDQpnd2Fuc2lt
LWV1bCBweW9zaWhhZSBqdXNpYnNpby4NCg0KbWFpa2V1bCBsYXNpZGV1Lg0KDQoNCkRlYXIgZnJp
ZW5kLA0KDQpJIHdyaXRlIHRvIGluZm9ybSB5b3UgYWJvdXQgYSBidXNpbmVzcyBwcm9wb3NhbCBJ
IGhhdmUgd2hpY2ggSSB3b3VsZA0KbGlrZSB0byBoYW5kbGUgd2l0aCB5b3UuDQpGaWZ0eSBtaWxs
aW9uIGRvbGxhcnMgaXMgaW52b2x2ZWQuIEJlIHJlc3QgYXNzdXJlZCB0aGF0IGV2ZXJ5dGhpbmcg
aXMNCmxlZ2FsIGFuZCByaXNrIGZyZWUuDQpLaW5kbHkgaW5kaWNhdGUgeW91ciBpbnRlcmVzdC4N
Cg0KTWljaGFlbCBSYWNoaWQuDQo=
