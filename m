Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1C375EA0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhEGB6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 21:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhEGB6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 21:58:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4CC061574;
        Thu,  6 May 2021 18:57:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x188so6523302pfd.7;
        Thu, 06 May 2021 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2mzA7gF1Q7faCMS5O8BSQKPR3vrskYvYkm8hbCQrDZQ=;
        b=FPMTec1yro60Vu29zJs8/9bwfJOH3lz9x5Kb/x1ecKiOIeNlczLzi7Ah7YK9g00SER
         kZc+/7/lu9QXZtWCbxVlx1iv+xo77dF35WuC32bsOhq3eXIciJi/LCk0dJw2gk9cDhE5
         sgrLJ/5Zz4uyW7Dtq2N8l4XXtAq+MhiKcO6gh0Tj0EQuVL6lfsMbaAdOKeWX1hEmpAS+
         ZkWFEAZ1lwnO9hnxxQrFdBaYNJkMn6JDdD0bpIaPezq/sZbEhsucqKiwhJLNeNmNERUn
         axH960u4Q4jyN05+AUFkIIR8riXgWHmeCp1jqPVqMU3bDvwDf5SS4E/RY9f0sEXWty4M
         JbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2mzA7gF1Q7faCMS5O8BSQKPR3vrskYvYkm8hbCQrDZQ=;
        b=mYFxiySejq8fadrEzTI8i5/PzbdTHY6k+uVaVIM+sr+5ewlKHn96n0cnV3HvrSOJkX
         tULM7aIHcpPao14gM41CnNSxpeTBB66adwfrdqW6/Okt50RT/Kv7pdYdukjsrXhAkCHF
         8GC2gaznKWlYjKk7j/NcLuInBXJNSP5FHhiZj8K9NcVde5K/2e9ZkaW+hs196gl0vsG1
         kpsWWjkLdjxcjrD9WtDy0FLJ8GkqRfX8FXl3epr6kWV6ph4VpmeWdVToN+t53I6hnTuM
         2WC+ma2FzM1XUWVaNRPP9rf3Ncp77e9DGa6u1DTJcNG5TDnYt4MsUuarq5ohGkiFZOv0
         JZ6g==
X-Gm-Message-State: AOAM533gw8QF2T/10FXure7yX2lYWFGGEYGVvmGphBKThqDawjWu6oqv
        o2ZeUJnNPVYRi7vtq3FJWjkx074dzZp4CdPUk0I=
X-Google-Smtp-Source: ABdhPJyduVZmx6+57ROgBsYpUkqxEggxoCj26rvRD9/OxGFoFfQZ8hRutLe79pcqpZlKGAkRxgeh3FBMDeFaK563AjI=
X-Received: by 2002:a62:7790:0:b029:27d:3aea:83e5 with SMTP id
 s138-20020a6277900000b029027d3aea83e5mr7525833pfc.78.1620352626752; Thu, 06
 May 2021 18:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210506083207.15705-1-wanjiabing@vivo.com>
In-Reply-To: <20210506083207.15705-1-wanjiabing@vivo.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Fri, 7 May 2021 09:56:58 +0800
Message-ID: <CAMU9jJqDDggxSz83XiqrBG_-_B9j6HEVJ0KgGBLuMERZziGOuw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: make reporting-bugs.rst obsolete
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net, "Wu X.C." <bobwxc@email.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlhYmluZw0KDQpDQyBib2J3eGNAZW1haWwuY24NCg0KV2FuIEppYWJpbmcgPHdhbmppYWJp
bmdAdml2by5jb20+IOS6jjIwMjHlubQ15pyINuaXpeWRqOWbmyDkuIvljYg0OjMz5YaZ6YGT77ya
DQo+DQo+IEluIGNvbW1pdCBkMmNlMjg1Mzc4YjA5ICgiZG9jczogbWFrZSByZXBvcnRpbmctaXNz
dWVzLnJzdCBvZmZpY2lhbA0KPiBhbmQgZGVsZXRlIHJlcG9ydGluZy1idWdzLnJzdCIpLHJlcG9y
dGluZy1idWdzLnJzdCB3YXMgZGVsZXRlZCBhbmQNCj4gcmVwbGFjZWQgYnkgcmVwb3J0aW5nLWlz
c3Vlcy5yc3QuDQo+DQo+IEluIGNvbW1pdCBkYTUxNDE1N2M0ZjA2ICgiZG9jczogbWFrZSByZXBv
cnRpbmctYnVncy5yc3Qgb2Jzb2xldGUiKSwNCj4gaXQgbWFkZSByZXBvcnRpbmctYnVncy5yc3Qg
b2Jzb2xldGUgaW4gZG9jcy4NCj4NCj4gRml4IGl0IGluIGRvY3MvemhfQ04gdG8gbWFrZSByZXBv
cnRpbmctYnVncy5yc3Qgb2Jzb2xldGUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFdhbiBKaWFiaW5n
IDx3YW5qaWFiaW5nQHZpdm8uY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vdHJhbnNsYXRp
b25zL3poX0NOL1NlY3VyaXR5QnVncyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi90cmFuc2xhdGlvbnMvemhfQ04vU2VjdXJpdHlCdWdzIGIvRG9jdW1lbnRhdGlvbi90cmFu
c2xhdGlvbnMvemhfQ04vU2VjdXJpdHlCdWdzDQo+IGluZGV4IDJkMGZmZmQxMjJjZS4uYWRmNDA0
MmJhN2Y4IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9T
ZWN1cml0eUJ1Z3MNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vU2Vj
dXJpdHlCdWdzDQo+IEBAIC0zMSw5ICszMSw5IEBAIGxpbnV45YaF5qC45a6J5YWo5Zui6Zif5Y+v
5Lul6YCa6L+HZW1haWw8c2VjdXJpdHlAa2VybmVsLm9yZz7mnaXogZTns7vjgILov5nmmK8NCj4g
IOS4gOe7hOeLrOeri+eahOWuieWFqOW3peS9nOS6uuWRmO+8jOWPr+S7peW4ruWKqeaUueWWhOa8
j+a0nuaKpeWRiuW5tuS4lOWFrOW4g+WSjOWPlua2iOS4gOS4quS/ruWkjeOAguWuiQ0KPiAg5YWo
5Zui6Zif5pyJ5Y+v6IO95Lya5LuO6YOo5YiG55qE57u05oqk6ICF6YKj6YeM5byV6L+b6aKd5aSW
55qE5biu5Yqp5p2l5LqG6Kej5bm25LiU5L+u5aSN5a6J5YWo5ryP5rSe44CCDQo+ICDlvZPpgYfl
iLDku7vkvZXmvI/mtJ7vvIzmiYDog73mj5DkvpvnmoTkv6Hmga/otorlpJrlsLHotorog73or4rm
lq3lkozkv67lpI3jgILlpoLmnpzkvaDkuI3muIXmpZrku4DkuYgNCj4gLeaYr+acieW4ruWKqeea
hOS/oeaBr++8jOmCo+Wwseivt+mHjea4qeS4gOS4i2FkbWluLWd1aWRlL3JlcG9ydGluZy1idWdz
LnJzdOaWh+S7tuS4reeahOamgui/sOi/h+eoi+OAguS7uw0KPg0KPiAt5L2V5pS75Ye75oCn55qE
5Luj56CB6YO95piv6Z2e5bi45pyJ55So55qE77yM5pyq57uP5oql5ZGK6ICF55qE5ZCM5oSP5LiN
5Lya6KKr5Y+W5raI77yM6Zmk6Z2e5a6D5bey57uPDQo+IC3ooqvlhazluIPkuo7kvJfjgIINCj4g
K+aYr+acieW4ruWKqeeahOS/oeaBr++8jOmCo+Wwseivt+mHjea4qeS4gOS4i2FkbWluLWd1aWRl
L3JlcG9ydGluZy1pc3N1ZXMucnN05paH5Lu25Lit55qEDQoNCg0KIOmCo+Wwseivt+mHjea4qeS4
gOS4i2FkbWluLWd1aWRlL3JlcG9ydGluZy1pc3N1ZXMucnN077yI5Lit5paH77yadHJhbnNsYXRp
b25zL3poX0NOL2FkbWluLWd1aWRlL3JlcG9ydGluZy1pc3N1ZXMucnN077yJDQrmlofku7bkuK3n
moTmpoLov7Dov4fnqIsNClRoZSAicmVwb3J0aW5nLWlzc3Vlcy5yc3QiIGhhcyBiZWVuIHRyYW5z
bGF0ZWQgaW50byBDaGluZXNlLiBGb3IgdGhlDQpjb252ZW5pZW5jZSBvZiBkZXZlbG9wZXJzIHdo
byBwcmVmZXIgQ2hpbmVzZSwgSSBzdWdnZXN0IGluY2x1ZGluZyBhDQpsaW5rIHRvIHRoZSBDaGlu
ZXNlIGRvY3VtZW50YXRpb246LSkNCj4NCj4gK+amgui/sOi/h+eoi+OAguS7u+S9leaUu+WHu+aA
p+eahOS7o+eggemDveaYr+mdnuW4uOacieeUqOeahO+8jOacque7j+aKpeWRiuiAheeahOWQjOaE
j+S4jeS8muiiq+WPlua2iO+8jA0KPiAr6Zmk6Z2e5a6D5bey57uP6KKr5YWs5biD5LqO5LyX44CC
DQo+DQo+ICAyKSDlhazlvIANCg0KDQpUaGFua3PvvIwNCg0KWWFudGVuZyBTaQ0KPg0KPg0KPiAt
LQ0KPiAyLjI1LjENCj4NCg==
