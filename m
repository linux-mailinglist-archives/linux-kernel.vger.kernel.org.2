Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590F9432407
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhJRQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhJRQpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:45:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:43:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so42493328wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fLqIPEBaRNOdjfMHVTUzcLno6ImGHaWY2L/hpqGEyjA=;
        b=SXHO/6+HBY76BkVRUx+ROamghkp1ypDCJXpkFapzp7Nkt75GezNQ2L5j1s5tvVY3rw
         Se0818Htn0H6/jcAIkZzI7qP2OZXVmgCacJ22EaT8pBiNIkxoUrWXZdEJ/9qXllpYf4B
         eOr5rLOB5W1OtmlhnOfKI9+7/ihlslJTpoEK7/CVyqNS0l3KzfskEPQJbScdqjq+djPC
         QdaBgeNRcXzl0XY4vwOgrvSeivwVsHDoQd5ngw/q0gT2ei6NuE2lY2pByMTIipDLqlEb
         IjyO54PgFruxTUsm639OK2WIzRp6NMKVt519x4yCSJsc4C48OK6JLQXKh08CPcGMFqqS
         Tc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=fLqIPEBaRNOdjfMHVTUzcLno6ImGHaWY2L/hpqGEyjA=;
        b=G0nb9NpN8HfjiT+RF4mvVFiODH+vqsfvl9I8KjrRVC68QGT3YcFHJnwG9dZYMtanMl
         kweVIwNKqA5F9brfbU1s0gSo2V84xKHpDm/gm4tJfTo7A8JLbKhb6EM+8QjdcFoxoE+J
         AdFfvqIQRj8YOIA2c15HuMfhrWJTUcj1xRmaupxfpvew3qtD3psJc7GQ8zuds+nLiOqA
         3fW9hnN2CHaCqmxzX9yjeW14M6N/GoFwvg02W5ii+I3DiLjSQIFy12J7QHSa5dXzlGI2
         s3W1k9WC9CKq3TAhgAvHcaNzhyl0zTuSySGEa6nI7I2KXeuq1BGC359HgAzoWO5gccL3
         M/8g==
X-Gm-Message-State: AOAM533Fi6s1ZAqtcXgAd/ypm/kDbq9DN+NVeoy0h/NZ9Rm9tAMoQuh8
        aRNv32OtmDdCijOgTbx+KYMwvFsXDH2KgvijZ8U=
X-Google-Smtp-Source: ABdhPJxCbT5kbbmy0+um8u9ohZPNODeAZPAIJ29zM18tS0a7sFAa2/OOTjq+Eeb5h31Foo5Z4riAKQTMZI2IHswpaM4=
X-Received: by 2002:a5d:4281:: with SMTP id k1mr17827219wrq.89.1634575410730;
 Mon, 18 Oct 2021 09:43:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4385:0:0:0:0:0 with HTTP; Mon, 18 Oct 2021 09:43:30
 -0700 (PDT)
Reply-To: mrjoshuakunte@gmail.com
From:   Mr Joshua Kunte <kuntemrjoshua@gmail.com>
Date:   Mon, 18 Oct 2021 17:43:30 +0100
Message-ID: <CAFhr1xC4Lede1HJfM9fJ00cfBGveXpQZph3p3O5b_R7ifb4UCw@mail.gmail.com>
Subject: =?UTF-8?B?7JWI64WV7ZWY7Iut64uI6rmM?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrsp4Drgpwg7KO8IOyWtOuKkCDrgqAg64u57Iug7JeQ6rKMIOuplOydvOydtCDrsJzshqHr
kJjsl4jsirXri4jri6QuDQrri7nsi6Dsl5DqsozshJwg7ZqM7IugIOuplOydvOydhCDrsJvslZjs
p4Drp4wg64aA656N6rKM64+EIOuLueyLoOydgCDtmozsi6DtlZjsp4Ag7JWK7JWY7Iq164uI64uk
Lg0K7J6Q7IS47ZWcIOyEpOuqheydgCDtmozsi6Ag67aA7YOB65Oc66a964uI64ukLg0KDQrsoJXs
pJHtnogg64u57Iug7J2YLA0K7KGw7IqI7JWEIOy/pO2FjCDslKguDQo=
