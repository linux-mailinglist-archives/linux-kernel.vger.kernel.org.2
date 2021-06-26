Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE443B4F40
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFZPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFZPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 11:44:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AD5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 08:42:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so17794192edc.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+5FTyPYaW4NjywZOVuBjTuQbyk1VUZgyjReVq7CYHyI=;
        b=AX8Tg1sdlC+9W6/pwoFunOkxvV4UWIe4NwrL5EU5ZIKLY1/oVer3xutjvL3/erMiBC
         6ty0FZXpuEVgXSIc2UsABA4V46LVrv28UlX/sxZaL4EZVgTY0StWIB675gBD6F1MP6KB
         Exaw4cnpvhqmiCasDytTbB14az3Jxbk59jcRMZ+ww6T9gA0ukznD4Ceo/YCKmGkeCRjd
         ZZhW9x4FbCInzIj0pZKeUlWtNAapB4dnWPhMO6v8q/zfW2EEEYvfshV+u9HJwBqxm7PP
         7UYkzGSw4DnZHWgjl4ezE7YpEw3k7GbKEWy1FAEaFcY8sxASjhjlhAWi+OuxJEOQ72T0
         fAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+5FTyPYaW4NjywZOVuBjTuQbyk1VUZgyjReVq7CYHyI=;
        b=AwGuJl3ow7az87YHJFzK0b1CHt+phiVOknmZPIs4u8g/kgCvDsEU7tntM70cv7e7SC
         XeiRZmEHLXn6aYx1FyI/QsQOOBESgBaIf8UjsitHMe0weMhxYhp2XqmOaiQ4/I0t/IgY
         Bl1AhcGY2c62EBXsf5DhLlA7mo4kCYPj63cLCeUqcVjLsOFxAXgustsiIMpQIzlxBee/
         EO6PbzQ0ul9fhhJi3Yt1nIb5b2kz8cZBlHcZw7kDP3hxdyDmbq1/IzbXg3ktn2TXaHpB
         ka+ZKjQrHDrO3qv8lLtlErB51hZckaI3uC+gogbRhuco03ilxNJQhub6WZDO7XR5+1gU
         9dJA==
X-Gm-Message-State: AOAM530tKdKKr6LqadPFFI8NAp0yWV9oWkfciARUbNPTAdYhvJ8dANu+
        FzsJa1F/D1C0MVSuGP/NlRmtXRyYgF6+/Zi2+rUPlw==
X-Google-Smtp-Source: ABdhPJxtY9oKd8RlUsbpi3Q46U3CuIN1EWARLKb5YVv09Ynixv2fLyxTgf/1Vxbf6uIqTnonHZ1AuzHm3+FBbsZlGx0=
X-Received: by 2002:a05:6402:1716:: with SMTP id y22mr22628164edu.237.1624722138930;
 Sat, 26 Jun 2021 08:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFRkauB=0KwrJW19nJTTagdHhBR=V2R8YFWG3R3oVXt=rBRsqw@mail.gmail.com>
 <1624721638.7222.8.camel@richtek.com>
In-Reply-To: <1624721638.7222.8.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Sat, 26 Jun 2021 23:41:42 +0800
Message-ID: <CAFRkauAycP_8ThgJNOz18MnhYwAgYRgs-GqvA9cLqJ7aLKUbew@mail.gmail.com>
Subject: Re: regulator: rtmv20: Wrong mask for strobe-polarity-high/vsync-polarity-high?
To:     =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 2021=
=E5=B9=B46=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8811:34=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> Really typo for this. Too many properties.
> Due to the typo, i check for all properties again.
> Thanks.
>
> Do I need to send a patch to fix this?
Yes, please.

Axel
