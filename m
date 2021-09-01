Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C073FD79A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhIAKYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhIAKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:24:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148AFC061575;
        Wed,  1 Sep 2021 03:23:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s29so1665236pfw.5;
        Wed, 01 Sep 2021 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XvXMSHbU+THAhLHihGL5O8BC1MEnybNiRpWcJSnCFq8=;
        b=vCcdzsC5mN8BKv7yF05P9EC3GSgVwYy4A5BxE205tbJQ5TCC3VjLw63EPsxw208K6v
         g+Ou45q9vaMnVSYRUQ7xTqHpwpcdKqJfKvBXg+s6eYCpQ9Ok17IAs3QA2bVsq101rzmv
         xS7KpGXVkF5jVLThpdWuzqXMTnwhLh2dSWiOKzCNGVnG+DPzskYSSJLDmQ6/XAttr+oE
         upZriN68MTKOiNxJ8DyrFzTSwGceAehco+0BYG+g0zmf/LUvpg+CuxFVmO7vhZkFrDeC
         foCz6/TqvTeGkB0pECXwSofmsXlDWudN3fPgrwuDv7ww2lduC7EhQeiLE9jw+zxPOgEH
         6szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XvXMSHbU+THAhLHihGL5O8BC1MEnybNiRpWcJSnCFq8=;
        b=ATgkyzNDWZllLwO8ewSBom/KmnUQr2LkUpMxXi3jM2PrVdRHZraE3i1UkajRBCkeuM
         ArwsqtHB0YWXWs4iXk8sCxfppGAML7Jm/dfpSC9C8loHoaQDyzhx7LPRKvdo20iDrV8I
         1sa37LXuv7ETp7XrMIJT32qFYvK0jPr9w32HvwaHCOcjHyRvj/ihjbMce+ftA78Xvfss
         8xQHI3aYywLDz5JISHuDjrMvDXFr6RPWLdN7vY2mnUnbZ7ID93y3l8nhDNgbMt7++9L3
         bPT+h6vDX+iEBfnxFQonuE+VEkX/oqj39N35mi8SLtvu634lF5LX8EzQQPIuak5CZFMv
         nwSg==
X-Gm-Message-State: AOAM531WluzW1hLZz78TWPL2xREZA+1ctncWcpZEM0ggz6zdPNsOGvqo
        Ip4253aKT1uBabL27yABUxo=
X-Google-Smtp-Source: ABdhPJyFQWzVHq1SuxONZMLModl2znpRbEGYKPZ9VGNV3rN1VoslhuY0oD2x8DmHvm5c1RxbacG1Ig==
X-Received: by 2002:a65:620d:: with SMTP id d13mr31847979pgv.36.1630491823510;
        Wed, 01 Sep 2021 03:23:43 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m13sm5814363pjv.20.2021.09.01.03.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:23:43 -0700 (PDT)
To:     corbet@lwn.net, src.res@email.cn
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <87o89mljgn.fsf@meer.lwn.net>
Subject: Re: [PATCH 1/3] docs/zh_TW: add translations for zh_TW/arm64
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <150c0a8e-2254-10b4-a31f-35a70273afee@gmail.com>
Date:   Wed, 1 Sep 2021 19:23:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87o89mljgn.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 13:40:40 -0600, Jonathan Corbet wrote:
> Hu Haowen <src.res@email.cn> writes:
>=20
>> Create new translations for zh_TW/arm64 and link them to index.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> ---
>>  .../translations/zh_TW/arm64/amu.rst          | 104 ++++++++
>>  .../translations/zh_TW/arm64/booting.txt      | 251 +++++++++++++++++=
+
>>  .../translations/zh_TW/arm64/elf_hwcaps.rst   | 244 +++++++++++++++++=

>>  .../translations/zh_TW/arm64/hugetlbpage.rst  |  49 ++++
>>  .../translations/zh_TW/arm64/index.rst        |  23 ++
>>  .../zh_TW/arm64/legacy_instructions.txt       |  77 ++++++
>>  .../translations/zh_TW/arm64/memory.txt       | 119 +++++++++
>>  .../translations/zh_TW/arm64/perf.rst         |  88 ++++++
>>  .../zh_TW/arm64/silicon-errata.txt            |  79 ++++++
>>  .../zh_TW/arm64/tagged-pointers.txt           |  57 ++++
>>  Documentation/translations/zh_TW/index.rst    |   5 +
>>  11 files changed, 1096 insertions(+)
>>  create mode 100644 Documentation/translations/zh_TW/arm64/amu.rst
>>  create mode 100644 Documentation/translations/zh_TW/arm64/booting.txt=

>>  create mode 100644 Documentation/translations/zh_TW/arm64/elf_hwcaps.=
rst
>>  create mode 100644 Documentation/translations/zh_TW/arm64/hugetlbpage=
=2Erst
>>  create mode 100644 Documentation/translations/zh_TW/arm64/index.rst
>>  create mode 100644 Documentation/translations/zh_TW/arm64/legacy_inst=
ructions.txt
>>  create mode 100644 Documentation/translations/zh_TW/arm64/memory.txt
>>  create mode 100644 Documentation/translations/zh_TW/arm64/perf.rst
>>  create mode 100644 Documentation/translations/zh_TW/arm64/silicon-err=
ata.txt
>>  create mode 100644 Documentation/translations/zh_TW/arm64/tagged-poin=
ters.txt

Hi Jon,

>=20
> I have gone ahead and applied this set.  I really do have to ask,
> though: is there really nobody with sufficient interest to review these=

> patches?  The zh_CN translators have done a good job of organizing
> themselves to review this work; could you please try to do the same?
> Otherwise I'm being asked to add lots of material that, as far as I can=

> tell, nobody has looked at...

I expected there would be some response from Haowen to your concern.
I'm an outsider of the zh_TW translation effort (except for the font
setting for pdfdocs) and does not read Chinese, but let me describe
my observation of what Haowen is up to in the hope of making you feel
better.
(I might be missing something important, though.)

The zh_TW work is not a direct translation from English documents,
rather, it is based on the zh_CN translations.

This is not explicitly mentioned in the change logs of Haowan's patch set=
s,
but if you compare the "Translator" fields under zh_TW to that of under
zh_CN, the chain of translation/conversion can be seen easily.

For example, the head of Documentation/translations/zh_CN/arm64/amu.rst
reads:

------
    .. include:: ../disclaimer-zh_CN.rst
   =20
    :Original: :ref:`Documentation/arm64/amu.rst <amu_index>`
   =20
    Translator: Bailu Lin <bailu.lin@vivo.com>
   =20
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    AArch64 Linux =E4=B8=AD=E6=89=A9=E5=B1=95=E7=9A=84=E6=B4=BB=E5=8A=A8=E7=
=9B=91=E6=8E=A7=E5=8D=95=E5=85=83
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
------

, while the head of Documentation/translations/zh_TW/arm64/amu.rst
reads:

------
    .. SPDX-License-Identifier: GPL-2.0
   =20
    .. include:: ../disclaimer-zh_TW.rst
   =20
    :Original: :ref:`Documentation/arm64/amu.rst <amu_index>`
   =20
    Translator: Bailu Lin <bailu.lin@vivo.com>
                Hu Haowen <src.res@email.cn>
   =20
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    AArch64 Linux =E4=B8=AD=E6=93=B4=E5=B1=95=E7=9A=84=E6=B4=BB=E5=8B=95=E7=
=9B=A3=E6=8E=A7=E5=96=AE=E5=85=83
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
------

My interpretation of above is that the zh_TW work is based on the
zh_CN translation by Bailu Lin, which has got proper reviews by
the zh_CN community.

IIUC, changes in zh_CN -> zh_TW are mostly "Simplified Chinese" ->
"Traditional Chinese" character substitutions.
They can be done semi-automatically based on a character mapping.
Exception is that some of the character mapping are one (SC) to
many (TC) [1].
And simply substituting characters might end up in unnatural wording
in the zh_TW documents due to vocabulary/convention differences.
This is where human intervention is required occasionally.

So, Huawen's patches can be regarded nearly as good as that of
the zh_CN counterparts even if they don't have anyone's
Reviewed-by tags, I suppose.

Of course, it would be much better to have regular reviewers.=20

Haowen, if I'm saying something far from reality, please let
me know.

[1]: https://en.wikipedia.org/wiki/Ambiguities_in_Chinese_character_simpl=
ification

        Thanks, Akira
=20
>=20
> Thanks,
>=20
> jon


