Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC60376E27
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 03:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEHBw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 21:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhEHBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 21:52:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDC4C061574;
        Fri,  7 May 2021 18:51:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so6437455pju.2;
        Fri, 07 May 2021 18:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bMEi2UdeaBpXnOQzPwWeXd2k58Wc5f7vfGWac6Odqhg=;
        b=Edb9pCSykEsZKqy4v5BCAOG2Kq5OK1ad49tMdIRd/3HYogaaIWWmsAsdHis5T7mcou
         mB3Cm0FQfyfwjsljDBBOySK1ZBBX/dOjOcueqt6gizDXNixMDHqVcaoUqiJkuQ3Rt632
         unWP1+tGmTInRFf1a58oStPc6pv5jHn04PjxApsf3Ts7dgyEuaUqbxpHbrQ81vEoB4vu
         3pXT9vOSi3usXaFjhy+YxEjVHGxx2uZ+M66JRONi5XGPzYCf+kkS3fLnKKJF/s4WlmpC
         qJSo/BvAEzx5hANM+7jH3h5ae0Q6ozMDQxsqm/EQMyjCRGhkwkQ0qHlV36gezvIw8J3d
         soGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bMEi2UdeaBpXnOQzPwWeXd2k58Wc5f7vfGWac6Odqhg=;
        b=WoDLChXBYJGHihz3rPl5nccxMay6uuubCJSw7IXx5MwPHhz37Twb6IHEd08kmcoI0p
         +CM1vvpYGyL2NZVdfSwHaTmqbUBEqujEO8pjgt9Kx6oEA4q5/CBFp/T05ykz9W7jxdnI
         6f5cLMZZuPo73yE2mTIUUDFMmyLVe9gx51bmkL93TnQ02l5U8zzrb499XkE3UjF8BlEF
         3lwAu0rW76fyWOcB9JGg6EFFqQmFCNuHwBNjAK4p9klTC5Fi8wDI16N+a74lssiI7tC5
         QaiiGn1JvKIuStuKd+zRYLxckC5oYVqmDTL7mDwq0SOi7D4o45vQKb0ZJ8AV/cGY428C
         bupg==
X-Gm-Message-State: AOAM532pyfgMpxHeraNtRMMvpREZx8j//vIdiIcomDmOInQU9OdySpxM
        yi0kbn1ofWQnwxIUjF3nzkjnLqo5XVt+AT9TLjY=
X-Google-Smtp-Source: ABdhPJxsEqpFBFC+eWcE1Z9bf0EmWKsHcs2hRIO+ei2HlTK+gEVlWLssYz8mu5BKoomXloCzv/tuuTg176q/AOqHC2A=
X-Received: by 2002:a17:90b:3689:: with SMTP id mj9mr13261324pjb.62.1620438682503;
 Fri, 07 May 2021 18:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210506083207.15705-1-wanjiabing@vivo.com> <CAMU9jJqDDggxSz83XiqrBG_-_B9j6HEVJ0KgGBLuMERZziGOuw@mail.gmail.com>
 <20210507022416.GA20158@bobwxc.top>
In-Reply-To: <20210507022416.GA20158@bobwxc.top>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Sat, 8 May 2021 09:51:14 +0800
Message-ID: <CAMU9jJoov7=XZQ7n5RC5EYSxzw_uJTMBRH98AEPqO9-BQpx47w@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: make reporting-bugs.rst obsolete
To:     "Wu X.C." <bobwxc@email.cn>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3UgWC5DLiA8Ym9id3hjQGVtYWlsLmNuPiDkuo4yMDIx5bm0NeaciDfml6XlkajkupQg5LiK5Y2I
MTA6MjTlhpnpgZPvvJoNCj4NCj4gT24gRnJpLCBNYXkgMDcsIDIwMjEgYXQgMDk6NTY6NThBTSAr
MDgwMCwgdGVuZyBzdGVybGluZyB3cm90ZToNCj4gPiBIaSBKaWFiaW5nDQo+ID4NCj4gPiBDQyBi
b2J3eGNAZW1haWwuY24NCj4gPg0KPiA+IFdhbiBKaWFiaW5nIDx3YW5qaWFiaW5nQHZpdm8uY29t
PiDkuo4yMDIx5bm0NeaciDbml6Xlkajlm5sg5LiL5Y2INDozM+WGmemBk++8mg0KPiA+ID4NCj4g
PiA+IEluIGNvbW1pdCBkMmNlMjg1Mzc4YjA5ICgiZG9jczogbWFrZSByZXBvcnRpbmctaXNzdWVz
LnJzdCBvZmZpY2lhbA0KPiA+ID4gYW5kIGRlbGV0ZSByZXBvcnRpbmctYnVncy5yc3QiKSxyZXBv
cnRpbmctYnVncy5yc3Qgd2FzIGRlbGV0ZWQgYW5kDQo+ID4gPiByZXBsYWNlZCBieSByZXBvcnRp
bmctaXNzdWVzLnJzdC4NCj4gPiA+DQo+ID4gPiBJbiBjb21taXQgZGE1MTQxNTdjNGYwNiAoImRv
Y3M6IG1ha2UgcmVwb3J0aW5nLWJ1Z3MucnN0IG9ic29sZXRlIiksDQo+ID4gPiBpdCBtYWRlIHJl
cG9ydGluZy1idWdzLnJzdCBvYnNvbGV0ZSBpbiBkb2NzLg0KPiA+ID4NCj4gPiA+IEZpeCBpdCBp
biBkb2NzL3poX0NOIHRvIG1ha2UgcmVwb3J0aW5nLWJ1Z3MucnN0IG9ic29sZXRlLg0KPiA+ID4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdhbiBKaWFiaW5nIDx3YW5qaWFiaW5nQHZpdm8uY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vU2VjdXJp
dHlCdWdzIHwgNiArKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBUaGlzIGlzIGEgdHJhbnNsYXRpb24gbGVmdCBvdmVyIGZy
b20gaGlzdG9yeS4NCj4gV2UgaGF2ZSBhIG5ldyBvbmUgYXMNCj4gICAgIERvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL2FkbWluLWd1aWRlL3NlY3VyaXR5LWJ1Z3MucnN0DQo+DQo+IE1h
eWJlIGJldHRlciB0byBkcm9wIGl0Lg0KQWdyZWUuDQpKaWFiaW5nLCB5b3UgY2FuIGp1c3QgcmVt
b3ZlIHRoYXQuDQoNClRoYW5rc++8jA0KDQpZYW50ZW5nDQo+DQo+IFRoYW5rcywNCj4NCj4gICAg
IFd1IFguQy4NCj4NCj4NCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMvemhfQ04vU2VjdXJpdHlCdWdzIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vU2VjdXJpdHlCdWdzDQo+ID4gPiBpbmRleCAyZDBmZmZkMTIyY2UuLmFkZjQwNDJi
YTdmOCAxMDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NO
L1NlY3VyaXR5QnVncw0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vU2VjdXJpdHlCdWdzDQo+ID4gPiBAQCAtMzEsOSArMzEsOSBAQCBsaW51eOWGheaguOWuieWF
qOWboumYn+WPr+S7pemAmui/h2VtYWlsPHNlY3VyaXR5QGtlcm5lbC5vcmc+5p2l6IGU57O744CC
6L+Z5pivDQo+ID4gPiAg5LiA57uE54us56uL55qE5a6J5YWo5bel5L2c5Lq65ZGY77yM5Y+v5Lul
5biu5Yqp5pS55ZaE5ryP5rSe5oql5ZGK5bm25LiU5YWs5biD5ZKM5Y+W5raI5LiA5Liq5L+u5aSN
44CC5a6JDQo+ID4gPiAg5YWo5Zui6Zif5pyJ5Y+v6IO95Lya5LuO6YOo5YiG55qE57u05oqk6ICF
6YKj6YeM5byV6L+b6aKd5aSW55qE5biu5Yqp5p2l5LqG6Kej5bm25LiU5L+u5aSN5a6J5YWo5ryP
5rSe44CCDQo+ID4gPiAg5b2T6YGH5Yiw5Lu75L2V5ryP5rSe77yM5omA6IO95o+Q5L6b55qE5L+h
5oGv6LaK5aSa5bCx6LaK6IO96K+K5pat5ZKM5L+u5aSN44CC5aaC5p6c5L2g5LiN5riF5qWa5LuA
5LmIDQo+ID4gPiAt5piv5pyJ5biu5Yqp55qE5L+h5oGv77yM6YKj5bCx6K+36YeN5rip5LiA5LiL
YWRtaW4tZ3VpZGUvcmVwb3J0aW5nLWJ1Z3MucnN05paH5Lu25Lit55qE5qaC6L+w6L+H56iL44CC
5Lu7DQo+ID4gPg0KPiA+ID4gLeS9leaUu+WHu+aAp+eahOS7o+eggemDveaYr+mdnuW4uOacieeU
qOeahO+8jOacque7j+aKpeWRiuiAheeahOWQjOaEj+S4jeS8muiiq+WPlua2iO+8jOmZpOmdnuWu
g+W3sue7jw0KPiA+ID4gLeiiq+WFrOW4g+S6juS8l+OAgg0KPiA+ID4gK+aYr+acieW4ruWKqeea
hOS/oeaBr++8jOmCo+Wwseivt+mHjea4qeS4gOS4i2FkbWluLWd1aWRlL3JlcG9ydGluZy1pc3N1
ZXMucnN05paH5Lu25Lit55qEDQo+ID4NCj4gPg0KPiA+ICDpgqPlsLHor7fph43muKnkuIDkuIth
ZG1pbi1ndWlkZS9yZXBvcnRpbmctaXNzdWVzLnJzdO+8iOS4reaWh++8mnRyYW5zbGF0aW9ucy96
aF9DTi9hZG1pbi1ndWlkZS9yZXBvcnRpbmctaXNzdWVzLnJzdO+8iQ0KPiA+IOaWh+S7tuS4reea
hOamgui/sOi/h+eoiw0KPiA+IFRoZSAicmVwb3J0aW5nLWlzc3Vlcy5yc3QiIGhhcyBiZWVuIHRy
YW5zbGF0ZWQgaW50byBDaGluZXNlLiBGb3IgdGhlDQo+ID4gY29udmVuaWVuY2Ugb2YgZGV2ZWxv
cGVycyB3aG8gcHJlZmVyIENoaW5lc2UsIEkgc3VnZ2VzdCBpbmNsdWRpbmcgYQ0KPiA+IGxpbmsg
dG8gdGhlIENoaW5lc2UgZG9jdW1lbnRhdGlvbjotKQ0KPiA+ID4NCj4gPiA+ICvmpoLov7Dov4fn
qIvjgILku7vkvZXmlLvlh7vmgKfnmoTku6PnoIHpg73mmK/pnZ7luLjmnInnlKjnmoTvvIzmnKrn
u4/miqXlkYrogIXnmoTlkIzmhI/kuI3kvJrooqvlj5bmtojvvIwNCj4gPiA+ICvpmaTpnZ7lroPl
t7Lnu4/ooqvlhazluIPkuo7kvJfjgIINCj4gPiA+DQo+ID4gPiAgMikg5YWs5byADQo+ID4NCj4g
Pg0KPiA+IFRoYW5rc++8jA0KPiA+DQo+ID4gWWFudGVuZyBTaQ0KPiA+ID4NCj4gPiA+DQo+ID4g
PiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0K
