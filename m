Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75045C71F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355356AbhKXOVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353564AbhKXOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:18:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A935C08EA49
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:31:38 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so3878060wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dxPp/WtiHTeu26kFxY/CqA8DC25wmdXqXW5larXxrrc=;
        b=hz8lAqGJncuJ9W5q2valzQ5lCzk+7eWbK4MiKI7Suf/dH7q/ByQTaccRF4uye1vxVG
         NDzKbHzc2g2k4I/xQ6fGs8EOFXhVeiSjVW0nai+Ic/8U1ZExQA/Dxl91Ino9pwrjKDFH
         3DB3Wz+SdZCJsGfuLUaMI51lxSCmk9nPaOTMdUSZDwGP2Zl/QorhLY0I/gewcTlFFwWk
         w7qduL6TgIUs+HzZOWVKFduZ6dqTbC/SJ+4tSKjNTj3Tf7Wg/AINaJi5x9qHds3SM7tq
         V5TdEFxH2ey+hZBlB9iL8Yy3r5XbiBOSRIW0Ps3at6MbTo7GaPfqHLABgwp58J6A6aLk
         dovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=dxPp/WtiHTeu26kFxY/CqA8DC25wmdXqXW5larXxrrc=;
        b=gCaeiwegwtl/GlKtraxsdL4QdDbxj61jb7bYOZ8Mnl8haEoccgIrgn+46q9Z8XKBGa
         DMHtgZaWN62rKfARz6+23zkYhNgwawige6pOXIPqCnASvluhugkqAOkdPQjPa/SwS8/a
         TtjKPEvnFCJYBRqz7LXt2jU4FPflO0Qfls2oarZLoo/MnWGgnOqzzeObo6QyYyBXVLL+
         IXsmOdLzl9sHEcW8oHnhEF4Xx64anC0kcswu3TL3nKaRMtJHwp5p1A7bTIdBjx/4tsy/
         HV+prO5igRzMnilF3OahyooBneaffSJyy3+lykprVx9tK+mNC5dDC5oXKSD9wwPvLDhy
         bLwA==
X-Gm-Message-State: AOAM533gsQ35Z1tNi6pGFzpLDQXH/WH9YC/drXdgubPTkVLvMQh2xho4
        2lMu4N2OEtjs/LbPiKmjx8LfEwHHh65a5XvQ+wo=
X-Google-Smtp-Source: ABdhPJwIKICGDmr26nrTCWB9JQAsdkeYKvDKsCC2cCmSILAtaAgSFyjzSdqNeMnk/TP0AapphvstpyAoLKn1iMT7IDY=
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr18495595wrz.76.1637757096629;
 Wed, 24 Nov 2021 04:31:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:e701:0:0:0:0:0 with HTTP; Wed, 24 Nov 2021 04:31:36
 -0800 (PST)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <paulj9311@gmail.com>
Date:   Wed, 24 Nov 2021 12:31:36 +0000
Message-ID: <CANaYuu6sDL5CTcx4H+DGJ18Ka0v4DkAAwO6gpNm3UUv_DFJThg@mail.gmail.com>
Subject: =?UTF-8?B?64KY66W8IOuPhOyZgOykhCDsiJgg7J6I64uIPw==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7IKs656R7ZWY64qUIOyXsOyduCwNCg0K7J206rKD7J2AIOuLueyLoOydtCDrsJvsnYAg6rCA7J6l
IOykkeyalO2VnCDsnbTrqZTsnbwg7KSRIO2VmOuCmOydvCDsiJgg7J6I7Jy866+A66GcIOyynOyy
nO2eiCDso7zsnZgg6rmK6rKMIOydveycvOyLreyLnOyYpC7soIDripQgQ3Jpc3RpbmENCkNhbXBi
ZWxsIOu2gOyduOyeheuLiOuLpC4g7KCA64qUIOuKpuydgCBFZHdhcmQgQ2FtcGJlbGzqs7wg6rKw
7Zi87ZaI7Iq164uI64ukLiDqt7jripQgU2hlbGwgUGV0cm9sZXVtDQpEZXZlbG9wbWVudCBDb21w
YW55IExvbmRvbuyXkOyEnCDsnbztlojsnLzrqbAg65iQ7ZWcIOuPmeyVhOyLnOyVhCDsp4Dsl63s
nZgg64W466Co7ZWcIOqzhOyVveyekC4g6re464qUIDIwMDPrhYQgN+yblCAzMeydvA0K7JuU7JqU
7J28IO2MjOumrOyXkOyEnCDsgqzrp53tlojsirXri4jri6QuIOyasOumrOuKlCDslYTsnbQg7JeG
7J20IDfrhYQg64+Z7JWIIOqysO2YvO2WiOyKteuLiOuLpC4NCg0K64u57Iug7J20IOydtCDquIDs
nYQg7J297Jy866m07IScIOuCmOuKlCDri7nsi6DsnbQg64KY66W8IOu2iOyMje2eiCDsl6zquLDs
p4Ag7JWK6riw66W8IOuwlOuejeuLiOuLpC4g7Jmc64OQ7ZWY66m0IOuCmOuKlCDrqqjrk6Ag7IKs
656M7J20IOyWuOygoOqwgOuKlCDso73snYQg6rKD7J2065286rOgDQrrr7/quLAg65WM66y47J6F
64uI64ukLiDrgpjripQg7Iud64+E7JWUIOynhOuLqOydhCDrsJvslZjqs6Ag7J2Y7IKs64qUIOuC
tCDrs7XsnqHtlZwg6rG06rCVIOusuOygnOuhnCDsnbjtlbQg7Jik656YIOqwgOyngCDrqrvtlaAg
6rKD7J2065286rOgIOunkO2WiOyKteuLiOuLpC4NCg0K7ZWY64KY64uY6ruY7IScIOyggOyXkOqy
jCDsnpDruYTrpbwg67Kg7ZG47Iuc6rOgIOygnCDsmIHtmLzsnYQg67Cb7JWE7KO87Iuc6riw66W8
IOuwlOudvOuKlCDrp4jsnYzsl5Ag7J6Q7ISg64uo7LK0L+q1kO2ajC/rtojqtZAv66qo7Iqk7YGs
L+yWtOuouOuLiCDsl4bripQg7JWE6riwL+yGjOyZuOqzhOy4tQ0K67CPIOqzvOu2gOyXkOqyjCDs
npDshKDsnYQg7ZWY6riw66GcIO2WiOyKteuLiOuLpC4g64KY64qUIOyjveq4sCDsoITsl5Ag7KeA
7IOB7JeQ7IScIO2VnOuLpC4g7KeA6riI6rmM7KeAIOyKpOy9lO2LgOuenOuTnCwg7Juo7J287KaI
LCDrhKTtjJQsIO2VgOuegOuTnCwg67iM65287KeI7JeQDQrsnojripQg66qH66qHIOyekOyEoCDr
i6jssrTsl5Ag64+I7J2EIOq4sOu2gO2WiOyKteuLiOuLpC4g7J207KCcIOqxtOqwleydtCDrhIjr
rLQg64KY67mg7IScIOuNlCDsnbTsg4Eg64KYIO2YvOyekCDtlaAg7IiYIOyXhuyKteuLiOuLpC4N
Cg0K7ZWc67KI7J2AIOqwgOyhseuTpOyXkOqyjCDrgrQg6rOE7KKMIOykkSDtlZjrgpjrpbwg7Y+Q
7IeE7ZWY6rOgIOqxsOq4sOyXkCDsnojripQg64+I7J2EIOykkeq1rSwg7JqU66W064uoLCDrj4Xs
nbwsIO2VnOq1rSwg7J2867O47J2YIOyekOyEoCDri6jssrTsl5Ag64KY64iE7Ja064us65286rOg
DQrsmpTssq3tlojsp4Drp4wg6re465Ok7J2AIOqxsOu2gO2VmOqzoCDrj4jsnYQg7Zi87J6QIOuz
tOq0gO2WiOyKteuLiOuLpC4g64K06rCAIOq3uOuTpOyXkOqyjCDrgqjqsqjrkZQg6rKD6rO8IOuL
pO2IrOyngCDslYrripQg6rKDIOqwmeycvOuLiCDrjZQg7J207IOBIOq3uOuTpOydhA0K66+/7Jy8
7Iut7Iuc7JikLiDslYTrrLTrj4Qg66qo66W064qUIOuCtCDrp4jsp4Drp4kg64+I7J2AIDYwMOun
jCDrr7jqta0g64us65+sKCQ2LDAwMCwwMDAuMDAp652864qUIOqxsOuMgO2VnCDtmITquIgg7JiI
7LmY6riI7Jy866GcLCDsnbQNCuq4sOq4iOydhCDsmIjsuZjtlZwg7YOc6rWtIOydgO2WieyXkCDs
nojsirXri4jri6QuIOydtCDquLDquIjsnYQg7J6Q7ISgIO2UhOuhnOq3uOueqOyXkCDsgqzsmqnt
lZjqs6Ag64u57Iug7J20IOynhOyLpO2VmOq4sOunjCDtlZjri6TrqbQg64u57Iug7J2YIOuCmOud
vOyXkOyEnCDsnbjrpZjrpbwNCuyngOybkO2VmOq4sOulvCDrsJTrno3ri4jri6QuDQoNCuuCmOuK
lCDsnbQg64+I7J2EIOyDgeyGjeuwm+ydhCDsnpDsi53snbQg7JeG6riwIOuVjOusuOyXkCDsnbQg
6rKw7KCV7J2EIOuCtOuguOyKteuLiOuLpC4g7KO97J2M7J20IOuRkOugteyngCDslYrsnLzrr4Dr
oZwg7Ja065SU66GcIOqwgOuKlOyngCDslZXri4jri6QuIOuCtOqwgCDso7zri5jsnZgNCu2SiOyX
kCDslYjquLgg6rKD7J2EIOyVleuLiOuLpC4g6reA7ZWY7J2YIO2ajOyLoOydhCDrsJvripQg7KaJ
7IucIOq3gO2VmOyXkOqyjCDsnYDtlokg7Jew65297LKY66W8IOygnOqzte2VmOqzoCDqt4DtlZjq
sIAg6reA7ZWY7J2YIOq1reqwgOyXkOyEnCDsnbQg7J6Q7ISgIO2UhOuhnOq3uOueqOydhA0K7KaJ
7IucIOyLnOyeke2VoCDsiJgg7J6I64+E66GdIOydtCDquLDquIjsnZgg7LWc7LSIIOyImO2YnOye
kOuhnOyEnCDqtoztlZzsnYQg67aA7Jes7ZWY64qUIOyKueyduOyEnOulvCDrsJztlontlZjqsqDs
irXri4jri6QuDQoNCuuCqOydhCDsnITtlbQg7IKwIOyCtuunjOydtCDqsIDsuZgg7J6I64qUIOyC
tuydtOuLpC4g64KY64qUIOuLueyLoOydtCDtla3sg4Eg64KY66W8IOychO2VtCDquLDrj4TtlbQg
7KO86riw66W8IOuwlOuejeuLiOuLpC4g64u57Iug7J2YIO2ajOyLoOydtCDriqbslrTsp4DrqbQg
7J20IOqwmeydgA0K66qp7KCB7J2EIOychO2VtCDri6Trpbgg7IKs656M7J2EIOyGjOyLse2VoCDs
l6zsp4DqsIAg7IOd6ri4IOqyg+yeheuLiOuLpC4g6rSA7Ius7J20IOyXhuycvOyLnOuLpOuptCDs
l7Drnb3rk5zroKQg7KOE7Iah7ZWp64uI64ukLiDrgrQg6rCc7J24DQrsnbTrqZTsnbwoY3Jpc3Rp
bmFjYW1wZWVsbEBvdXRsb29rLmNvbSnroZwg7Jew65297ZWY6rGw64KYIO2ajOyLoO2VoCDsiJgg
7J6I7Iq164uI64ukLg0KDQrqsJDsgqwg7ZW07JqULA0K7KeE7Ius7Jy866GcLA0K7YGs66as7Iqk
7Yuw64KYIOy6oOuyqCDrtoDsnbgNCuydtOuplOydvDsgY3Jpc3RpbmFjYW1wZWVsbEBvdXRsb29r
LmNvbQ0K
