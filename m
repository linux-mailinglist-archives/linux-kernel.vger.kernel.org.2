Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390536CB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhD0Scd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbhD0Sca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:32:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC907C061574;
        Tue, 27 Apr 2021 11:31:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n2so90871909ejy.7;
        Tue, 27 Apr 2021 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yP8Pg85AED61BqhqzNQSCQ0faSITOU8hZLsSfGgXVOI=;
        b=Fy0hFkhHdXOk6yDtyoFq2hpSjC2aPWKhwCUYU4Ngri+zPpxVzbpyewbCqH3tjAkYbq
         5S8mka9eS6l+NXKKHoWG1iHDryXEx4R2QbJetJE5k6O50085xzoUwcNZOjri6P/lGsBs
         6JJ8Fzjavcm+8S/wfKBz13ODN4crmC4es63WQug0kl7D2TJeofmlbj5wLY5z1M5DqLIL
         SZG+sHGcDVqFrLEGGVrMOnW2Zrq9sX/NLH737S2vncdlREg0/yu2VD2zVNIJvATYEZeg
         vj3aOqpICxCKlUrUufYUBN99s7ux4VYxk3qk/km3vALkxhGTQVRYRD6S549mn9GBBYFR
         rMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP8Pg85AED61BqhqzNQSCQ0faSITOU8hZLsSfGgXVOI=;
        b=Kn1cHmQZElgBxwvaqupIJ97T8piNwkpjzh9/0erbecWNhG11n/w1aEjPkqTiGeeQnG
         utV5vxCM/ineUxwDL7GV0B+BRNO4Q8rVS1/Bfffp6R5XbLIt92usz8NKwn6pdoprwNUN
         Fk/zjeqme+IAmBQKLxpmisIj7aIAr4j29SAI33hmkNhyXVSWJWeyPMtdmeuA+15+DmVk
         JR82dM2djTiWgPJtm/CFl/+uyUtrEJnQjUaZjkgTiGVN+fc+7xP5uaH0ua/1cT2ioHEC
         NudjbAPJ7b+v+WjetL8d/fcO1xCrV0GDh+7MavhdjJGWEkaiMCtNv5Bb5PidSl9ftjwp
         1rxA==
X-Gm-Message-State: AOAM53027e+kgBv5x2sD+j4BOhCy2ljC8wHmICh9TFbJPY3JKaaMlyO5
        GW/NzFttDmzOIy7aKTdd7ub1XbGhnByZJcWVx9w=
X-Google-Smtp-Source: ABdhPJxt3MTXfyv2Bb27hy8HvPNMjivT0PcIdJJZ28HezJTgD7aAL2CIuSK4XOFdNJe4UW7aoMyJeUd6XUwDEuHlVuw=
X-Received: by 2002:a17:907:765b:: with SMTP id kj27mr9390423ejc.537.1619548304673;
 Tue, 27 Apr 2021 11:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210426101106.9122-1-colin.king@canonical.com>
In-Reply-To: <20210426101106.9122-1-colin.king@canonical.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Apr 2021 20:31:33 +0200
Message-ID: <CAFBinCBh1_s7NDpOZjuO3hKcvimwiD+2X15JY3CqeDKg8wemSQ@mail.gmail.com>
Subject: Re: [PATCH] serial: meson: remove redundant initialization of
 variable id
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 12:11 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable id being initialized with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed. Since id is just being used in a for-loop
> inside a local scope, move the declaration of id to that scope.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
