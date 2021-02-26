Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C4D3269A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBZVh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBZVhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:37:25 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D50CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:36:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d12so4583807pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=george-graphics-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cRLodfWRnEjlTZrSBt6hDfYE5X58rZ2ErBl6zq1bcAc=;
        b=o6ymOXMItFTeRh+rc7ebXZfFwq8cwp52/KXjmElVgQZD/qUwcEc/LaffX4mnC6WgVn
         i0OnGDWEPfxaKuiRyc1E8daAbjQ0sJN8OTj4uLNpVYzBPICJjC6xpm3HMJHOqx3RTO43
         0zROfxsBbpjFT3Sr+rw+RK7TtdJ6Q3942lxxaBnaCWRYokcRwNsEwlwaqZUUyI8GUQsm
         jy0k5FagAlCRg04PFuwH50DEJXlv/mihnOnGLJ46tB6znP6MTOF3u5rSYa6kXPi9RfHi
         Pp7YQQ8bv7ydcU1Q0qwA1tn0cOJih3ARRxaZnfSXu5UMhvKoRdIOo/AshOxGD0HF3qvy
         avBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cRLodfWRnEjlTZrSBt6hDfYE5X58rZ2ErBl6zq1bcAc=;
        b=FgYqOvDY+bYyAILV0ICe633fSS/tpShsRb4zDXrmSt/+v4iz/iy+ntRiLV0JjMQHyq
         ojJDkrqWLZzrZ4EwXuBqZ7tXSlpD+aTVon+2B11v5iBs7r2UDVlUX5LDlH/OJwXZNEke
         FxTJC4PF2o8f5DaDWK6IetcLUOXY4higOxd7TEZWbQZnnanatwu1jonvLK2j2S/I7Pjc
         UsuokM1vB7tFat3bY+LXOxYj1vUMqkJc98Oftk4B2yWhL50rQxh/RCxEbarN3cydCP+a
         owvo+GaCMH6mJfwCzeVSbVQgPEV7DyLq6N0Rv0qjPpRya7llNqHX2idhUU3kuVa+WkvV
         zCcQ==
X-Gm-Message-State: AOAM5337bsxOc4sInZdMcZ86eAr2zI2vK73QqdYpKGu7Y5m8tlH79PVm
        GZxvCzbnap+s4qyKTOVVmdwboBIliatNan4UFhA=
X-Google-Smtp-Source: ABdhPJwxjF858MeTFv5S0/K4kufLD8+kXIoJgCdektiYqdnA+pdyvVPCJhl6odd99bScgjDs6D5XsA==
X-Received: by 2002:a62:b516:0:b029:1ea:34a:a70e with SMTP id y22-20020a62b5160000b02901ea034aa70emr5117459pfe.38.1614375404008;
        Fri, 26 Feb 2021 13:36:44 -0800 (PST)
Received: from ?IPv6:2601:602:8000:181:d8ec:3c42:2c25:f1d1? ([2601:602:8000:181:d8ec:3c42:2c25:f1d1])
        by smtp.gmail.com with ESMTPSA id 25sm10685597pfh.199.2021.02.26.13.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:36:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 2/2] midi streaming substream names from jack names A
 number of devices have named substreams which are hard to remember / decypher
 from <device> MIDI n names.  Eg. Korg puts a pass through on one substream
 and iConnectivity devices name the connections.
From:   George Harker <george@george-graphics.co.uk>
In-Reply-To: <20210226212617.24616-1-george@george-graphics.co.uk>
Date:   Fri, 26 Feb 2021 13:36:42 -0800
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE234989-046F-4E65-A574-25C79A8726D2@george-graphics.co.uk>
References: <s5hczwpucd3.wl-tiwai@suse.de>
 <20210226212617.24616-1-george@george-graphics.co.uk>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback, addressed in the two patches.  I=E2=80=99m not =
sure why it pulled the body up into the title.I=E2=80=99m sorry about =
that.  I can resubmit if that needs fixing.

George
