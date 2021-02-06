Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A095311E29
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBFO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhBFO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:56:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D6C0611C3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 06:56:12 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s11so12916649edd.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 06:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=mOQfS+Ay1su5EKkLaj5t0rufa8rO3057nIgkxnPY7Jbxfwafgqt/oojfe5UiKlL+v4
         BbmPPu/9pITdT4YlQYxCsNOtCxUZ40JKureXXWGpfXHZS6qWar+tXX8Bi/0pT5uD75fe
         koi6HDUiCBhCW+e69VeHi1sxMDEuFOsXCcDtfFdkynWrLLPNThPCkZjg1G8e6GwIEZi0
         x2dCMtA3bN2e70YbfMmlNYlSN7V2bgU+Wld33/Z9adV+4tbc1ggY6p2VmdUcNU8lJlgR
         OTzGn1g58Yxm7HKH/ln0cX9GsK5XGL+6/2FQzTR1s5jFYrrHIjkSo/lcNKoA5jTcVzXb
         oXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=WLfZhgMlWw58CB/hg5HjIbdSQmWec1lfaR54Kng8UKLxEbQy0O/gp+whTWMOnBpbgA
         t0cmn6rgKynqpn2q2TFuHjIHbxqcBi4giZWN1tCjFmti8d/XA3m3kXUB1fhHQAPQKjuq
         L3GAfeA5EY74AVBOcSdxEcfQKAJa41LcMWBptEnx56oYcmDqYtfyqMYWnxlTDFseKUJE
         BROIGov77qpPaoRrEg/aNjEuwixiIGZ37jyFrHjwW/DssQUS5hWOmSMLlxeuOFHf7gzO
         lK2CJCUuUjGr1UW2BZw2kXBgNfN7cxXrONKi6YHP74yqv9XggMabi5QoYnPC/QdajiL3
         /VXQ==
X-Gm-Message-State: AOAM531aosPXR92ETHOj2X3GyngyOxa+9xGtYi6DpkfjK3sP72dLGHdG
        /lBA7fAKxwD+2p3EfOCY0c5GVHlmVvRJr1ZdF1s=
X-Google-Smtp-Source: ABdhPJzUBkCIJKVOt066q6ODOccPF4RO1NTjM/hd9TBUiYSytX6D0Bmy6JdPjVGpzfKiIR2f4+clik7IzUyCSKo6NK0=
X-Received: by 2002:a05:6402:149:: with SMTP id s9mr8664658edu.247.1612623370852;
 Sat, 06 Feb 2021 06:56:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:56:10
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:56:10 +0100
Message-ID: <CAGSHw-AL4CZNhyu2sH2K3hoR=1qqeb6W_jqGZU4K5JTrHK51yg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
