Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1627440F2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhIQHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhIQHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:10:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA95C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:09:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v24so26284680eda.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aa8TKbuoE3CAfkZ0T3xzwkXoy8oT6VWQOZJa841ntng=;
        b=Q+wNYdX0QlpEV/x19DxYO1GPhk0kq6k1Q9xoQqb10sWFvOMgOOJPcyLM7e32YTeFgG
         pmNYwpOu10pQ9rAQyleyA9EM8uCbzPhKh4dw69qzFRmhSx1OzZ/+DS7L+yWrU6zATej7
         eCDMTPHZ5aDR0siT6onhzl7yQD+doqGXslKMGm2Wm1u+VnjNtxI/NKqKrtnPfuv0L6Tg
         m09eBCQ4lsLOU8oTSjy5MBzuoUBCAaxJMMoe0kZxOSw82LqKjWmEZKFxFI0ax/mR057q
         E//u2NkgFDPDuePTLvoiWrxYlxKZ8FXdclnSRioRsNfyVB/uI+pNPEuHb9Xo1XvCYARk
         4XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=aa8TKbuoE3CAfkZ0T3xzwkXoy8oT6VWQOZJa841ntng=;
        b=y9X56PO9qS1bbzpIy4IbiRgW2d7/wkI8GeD+UZXNRe0Ch0FBAATGQ+G53D7gkrSisn
         xS6vvpapCLbCowHloU5FbQttsh7rQBPiQwkwA9zAQIE/IE6NOa1d6qNfq18pbr0xmjyd
         BeJQ3Lj54G8fAoyuHLPpBKy6Ugtb/PLgrGmi3G+yINLvq4hBN9g668G3NLjHJonXxjVV
         RVyIRPPIn67jSzMXhhvtB6Mvatucx0pCk0O7K/FjHFU2J5v7gTz/Yn6TGrHrQq80C7VB
         E6EHmBXxdR+NHvClJwO7FOqBaJ4d6SlUAxo5W8jvw8DfGPXLRyXjmsjEroncrErSZ9tz
         IMaw==
X-Gm-Message-State: AOAM531BXWxOgXqsCqdhYteAwYSKjKV5qNwfZyaHT3yxpMrYou71OWQ9
        TISVcE5t9xp9mK1I5XXMbElIKIT4lkHEH7Valu8=
X-Google-Smtp-Source: ABdhPJzIQMLoh355s0CJi5xLIPXUj50riWFyjrfXj/I787evUC63mWqJ6goO9arwUnVL4W/TRdj2YzxPVYPMoKuMLqU=
X-Received: by 2002:a17:907:2658:: with SMTP id ar24mr11075734ejc.329.1631862558863;
 Fri, 17 Sep 2021 00:09:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3103:0:0:0:0:0 with HTTP; Fri, 17 Sep 2021 00:09:18
 -0700 (PDT)
Reply-To: www.ecobank6@gmail.com
From:   MESSI PETR <messip883@gmail.com>
Date:   Fri, 17 Sep 2021 07:09:18 +0000
Message-ID: <CAFuOU_THTskN0_cHAf7CCX4eSaeSFH-ZV8fOewH0A=zEbkS9OA@mail.gmail.com>
Subject: =?UTF-8?B?VVpNQU7EqkJV?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laipni l=C5=ABdzam SVF AWARD WASHINGTON DC
Es nos=C5=ABt=C4=ABju jums =C5=A1o v=C4=93stuli pirms m=C4=93ne=C5=A1a, bet=
 neesmu no jums
dzird=C4=93jis, es neesmu p=C4=81rliecin=C4=81ts, vai j=C5=ABs to sa=C5=86=
=C4=93m=C4=81t, un t=C4=81p=C4=93c es to
v=C4=93lreiz s=C5=ABtu. Pirmk=C4=81rt, es esmu Sharon wong kundze, =C4=A3en=
er=C4=81ldirektore
un Starptautiskais Val=C5=ABtas fonds. Paties=C4=ABb=C4=81 m=C4=93s esam p=
=C4=81rskat=C4=ABju=C5=A1i
visus =C5=A1=C4=B7=C4=93r=C5=A1=C4=BCus un probl=C4=93mas, kas saist=C4=ABt=
as ar nepabeigto dar=C4=ABjumu un
nesp=C4=93ju izpild=C4=ABt pret jums veikt=C4=81s p=C4=81rskait=C4=ABjuma i=
zmaksas. Lai ieg=C5=ABtu
iepriek=C5=A1=C4=93j=C4=81s p=C4=81rskait=C4=AB=C5=A1anas iesp=C4=93jas, l=
=C5=ABdzu, apmekl=C4=93jiet m=C5=ABsu vietni,
lai sa=C5=86emtu apstiprin=C4=81jumu 38 =C2=B0 53=E2=80=B256 =E2=80=B3 N 77=
 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 rietumu puses
M=C4=93s, Direktoru padome, Pasaules Banka un Starptautiskais Val=C5=ABtas =
fonds
(SVF) Va=C5=A1ingtona, DC, kop=C4=81 ar ASV Valsts kasi un da=C5=BE=C4=81m =
cit=C4=81m
atbilsto=C5=A1=C4=81m p=C4=93tniec=C4=ABbas a=C4=A3ent=C5=ABr=C4=81m =C5=A1=
eit Amerikas Savienotaj=C4=81s Valst=C4=ABs
esam pas=C5=ABt=C4=ABju=C5=A1i m=C5=ABsu maks=C4=81jumu p=C4=81rvedumu vien=
=C4=ABbas =C4=81rzemniekus, =C4=80frikas
Apvienot=C4=81 banka Lome Togo izsniegs ATM VISA karti, kur=C4=81 tiks iel=
=C4=81d=C4=93ts
asto=C5=86u simtu t=C5=ABksto=C5=A1u ASV dol=C4=81ru (800 000 000 USD) fond=
s, lai v=C4=93l=C4=81k
iz=C5=86emtu fondu. Izmekl=C4=93=C5=A1anas laik=C4=81 m=C4=93s ar satraukum=
u konstat=C4=93j=C4=81m, ka
korump=C4=93ti bankas darbinieki, kuri cen=C5=A1as novirz=C4=ABt l=C4=ABdze=
k=C4=BCus,
nevajadz=C4=ABgi kav=C4=93ja j=C5=ABsu maks=C4=81jumu. Un =C5=A1odien m=C4=
=93s jums pazi=C5=86oj=C4=81m, ka
j=C5=ABsu fonds ir ieskait=C4=ABts UBA bankas ATM VISA kart=C4=93 un ir gat=
avs ar=C4=AB
pieg=C4=81dei. Tagad sazinieties ar UBA bankas sekret=C4=81ri, vi=C5=86as v=
=C4=81rds ir
Sharon wong, pa e-pastu: (www.ecobank6@gmail.com) Nos=C5=ABtiet =C5=A1=C4=
=81du
inform=C4=81ciju, lai nog=C4=81d=C4=81tu j=C5=ABsu VISA akredit=C4=93to ban=
kom=C4=81ta karti l=C4=ABdz
galam=C4=93r=C4=B7im.
(1)-pilns nosaukums: ......................................
(2)-m=C4=81jas adrese: ..............................
(3) -valsts: .........................................
(4)-neder=C4=ABga pils=C4=93ta ...............................
(5)-tie=C5=A1ais t=C4=81lru=C5=86a numurs: ................
(6)-dzimums ...............................
(7)-vecums ...............................

Ar cie=C5=86u

Kundze: Sharon wong
