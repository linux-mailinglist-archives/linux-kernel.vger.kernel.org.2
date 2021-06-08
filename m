Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED62D39EB98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFHBoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:44:38 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:33323 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhFHBoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:44:38 -0400
Received: by mail-pl1-f169.google.com with SMTP id c13so9775773plz.0;
        Mon, 07 Jun 2021 18:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PfXqzz4sMmnIIeJlTbdp97TxIJoZmr301IeumzQVHiI=;
        b=KdSiPZo5+dJYJpHvjKkOa8cWg9Y+We/1nkLe2+QXGhDiNuGGL1CkN7zAJrIHZt2B4m
         zbF05BC+bqRnuJglRceg4qk+DdPiUnNMqAN/PmiEpTLln3oFEdOYbD16xrPQBJULbyZD
         6+cRYCk0KSOJZ2U02/s+nFr63CjjIT85OTArabvezz0b3A36BfNXYmtwlJz3w9XsQIUo
         A8l+aXUKpM4tJaS3UPlC17R5c5rlVjhcvmijONR2RdL3DRHL/QjtJ8vsWkAwb4xabqko
         ldMxfJxQRnYdoH80Jf95UpZZTlzbm4L/T2ixm1RIUkxaQqubQHuZRUWrTNMYVzvNG+4Z
         Bwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PfXqzz4sMmnIIeJlTbdp97TxIJoZmr301IeumzQVHiI=;
        b=DWSEQhHn6jGiLXhl1FdE+OSytmTokO8urCGsAVZ7sysR2VpntcDYCaOxVUv3B6htsv
         133Q4Zp/5Ef3PAI87HQ1nGiLXfxm83JPBykqLG0ifqN+s1QnQbBOXLSgqjVY/Ufi194v
         yKTeX7jSqGIPGTHUFTAykBu3Z680I5e1L/+W+/ftUM00RkHvccSUqiqLXJt+HJi9uEvZ
         77vxirvaYEHdPs8bUJQMFKve/zwPnP/ZtZn6u1DGWb42g/yaF0SDc31uvS4dda6IuwOX
         jYyGLOzOsDdaBdhaBEerX9uNgBTWt0BfoCQkYi3d6PRXErajw88+tcjc6yBABXfP1AC2
         IT2g==
X-Gm-Message-State: AOAM531kqrpHav6xDyiof822SA5m2nTxXuw33DsNXvkKyY/YZLYg2MHf
        NPy6/8dSIG9MhrMmUln9f1e/vQwR649HmC8P5fTx1aeukN5bWBlle60=
X-Google-Smtp-Source: ABdhPJz3pbX+sJbviVNBvQS+Bn4x7mKUXkFeD5pgkYvCvR7fLJBE9WO0b8AoSMY6T1rja4HCxv5HVGNNd6cIB0eWTJs=
X-Received: by 2002:a17:902:f688:b029:112:7c0e:d027 with SMTP id
 l8-20020a170902f688b02901127c0ed027mr7877565plg.34.1623116492873; Mon, 07 Jun
 2021 18:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210607093433.39160-1-src.res@email.cn> <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
 <f9418c90-fe60-b26c-18d3-ecd3e9c506ab@email.cn>
In-Reply-To: <f9418c90-fe60-b26c-18d3-ecd3e9c506ab@email.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Tue, 8 Jun 2021 09:41:22 +0800
Message-ID: <CAMU9jJq95fasAjbosE23gziHNL5zAcC-OUe-=uqDMefXCif-rw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: add a translation for index
To:     Hu Haowen <src.res@email.cn>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHUgSGFvd2VuIDxzcmMucmVzQGVtYWlsLmNuPiDkuo4yMDIx5bm0NuaciDfml6XlkajkuIAg5LiL
5Y2IOTo1MuWGmemBk++8mg0KPg0KPg0KPiDlnKggMjAyMS82Lzcg5LiL5Y2IOTo0MCwgdGVuZyBz
dGVybGluZyDlhpnpgZM6DQo+ID4gQ0Mgc2l5YW50ZW5nQGxvb25nc29uLmNuDQo+ID4gSHUgSGFv
d2VuIDxzcmMucmVzQGVtYWlsLmNuPiDkuo4yMDIx5bm0NuaciDfml6XlkajkuIAg5LiL5Y2INToz
N+WGmemBk++8mg0KPiA+PiBUaGUgb3JpZ2luYWwgZmlsZSBoYXMgYWRkZWQgYSBmb3JtZXIgaW50
cm8gaW4gY29tbWl0IGI1MTIwOGQ0MWM2YTRlN2ZjMmYwDQo+ID4+ICgiZG9jczogVHdlYWsgdGhl
IHRvcC1sZXZlbCBTcGhpbnggcGFnZSIpIGFuZCBoZW5jZSB1cGRhdGUgdGhlIENoaW5lc2UNCj4g
Pj4gdmVyc2lvbiBmb3IgaXQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEh1IEhhb3dlbiA8
c3JjLnJlc0BlbWFpbC5jbj4NCj4gPj4gLS0tDQo+ID4+ICAgRG9jdW1lbnRhdGlvbi90cmFuc2xh
dGlvbnMvemhfQ04vaW5kZXgucnN0IHwgNSArKysrKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL3poX0NOL2luZGV4LnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3po
X0NOL2luZGV4LnJzdA0KPiA+PiBpbmRleCAxZjk1M2QzNDM5YTUuLjAwMzEyNmFiYzBkNiAxMDA2
NDQNCj4gPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0
DQo+ID4+ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdA0K
PiA+PiBAQCAtMTcsNiArMTcsMTEgQEANCj4gPj4gICAgICAqKue/u+ivkeiuoeWIkjoqa2VybmVs
J3MgZG9jdW1lbnRhdGlvbioNCj4gPj4gICAgICDlhoXmoLjkuK3mlofmlofmoaPmrKLov47ku7vk
vZXnv7vor5HmipXnqL/vvIznibnliKvmmK/lhbPkuo7lhoXmoLjnlKjmiLflkoznrqHnkIblkZjm
jIfljZfpg6jliIbjgIINCj4gPj4NCj4gPj4gK+i/meaYr+WGheaguOaWh+aho+agkeeahOmhtue6
p+ebruW9leOAguWGheaguOaWh+aho++8jOWwseWDj+WGheaguOacrOi6q+S4gOagt++8jOWcqOW+
iOWkp+eoi+W6puS4iuaYr+S4gOmhueatow0KPiA+IGhvdyBhYm91dDoNCj4gPg0KPiA+IOi/meaY
r+S4reaWh+WGheaguOaWh+aho+agkeeahOmhtue6p+ebruW9leOAgg0KPg0KPg0KPiBCdXQgdGhl
IEVuZ2xpc2ggdmVyc2lvbiBzYXlzICJrZXJuZWwncyBkb2N1bWVudGF0aW9uIi4gSXQgc2VlbXMg
dGhhdCB3ZQ0KPiBzaG91bGQgYWRkIGFuIGV4cGxhbmF0aW9uIGZvciByZWFkZXJzIGluIG9yZGVy
IHRvIGRyYWcgdGhlbSBvdXQgb2YgdGhlDQo+IGRpbGVtbWEgb24gd2hldGhlciBoZSBvciBzaGUg
c2hvdWxkIHVwZGF0ZSBFbiB2ZXJzaW9uIGF0IGZpcnN0LCBhcyB5b3VyDQo+IHRob3VnaHQgcGlj
a2luZyBpZGVhcyBmcm9tICJkaXNjbGFpbWVyLXpoX0NOIi4NCj4NCj4gV2hhdCdzIHlvdXIgb3Bp
bmlvbiwgbWFpbnRhaW5lcnM/DQpXaGVuIHRoZSBvcmlnaW5hbCBkb2N1bWVudGF0aW9uIGlzIHVw
ZGF0ZWQsIHRoZSBDaGluZXNlIGRvY3VtZW50YXRpb24NCmhhcyB0byBmb2xsb3cuIEkgdGhpbmsg
d2UgaGF2ZSByZWFjaGVkIGEgY29uc2Vuc3VzIG9uIHRoaXMgcG9pbnQuDQpIb3dldmVyLCB0aGlz
IGZpbGUgaXMgZGVzY3JpYmVkIGluIHRoaXMgZGlyZWN0b3J5IGFzIHpoX0NOLCBzbyBJIHRoaW5r
DQppdCBuZWVkcyB0byBiZSBsb2NhbGl6ZWQuIEJ1dCB0aGUgbG9jYWxpemF0aW9uIHdpbGwgY29u
ZmxpY3Qgd2l0aA0KImRpc2NsYWltZXItemhfQ04iLg0KDQpUaGFua3MsDQpZYW50ZW5nDQo+DQo+
DQo+ID4+ICvlnKjov5vooYznmoTlt6XkvZzvvJvlvZPmiJHku6zliqrlipvlsIborrjlpJrliIbm
laPnmoTmlofku7bmlbTlkIjmiJDkuIDkuKrov57otK/nmoTmlbTkvZPml7blsKTlhbblpoLmraTj
gILlj6YNCj4gPj4gK+Wklu+8jOmaj+aXtuasoui/juaCqOWvueWGheaguOaWh+aho+i/m+ihjOaU
uei/m++8m+WmguaenOaCqOaDs+aPkOS+m+W4ruWKqe+8jOivt+WKoOWFpXZnZXIua2VybmVsLm9y
Zw0KPiA+IOS4reaWh+WGheaguOaWh+aho+i/m+ihjOaUuei/m++8mw0KPiA+PiAr5LiK55qEbGlu
dXgtZG9j6YKu5Lu25YiX6KGo44CCDQo+ID4g5LiK55qEbGludXgtZG9j6YKu5Lu25YiX6KGo77yM
5YWI5pS56L+b5Y6f5aeL6Iux5paH5paH5qGj77yM5YaN5bCG5YW257+76K+R5Li65Lit5paH5ZCO
77yM5pu05paw55u45bqU55qE5Lit5paH5paH5qGj44CCDQo+ID4+ICsNCj4gPj4gICDorrjlj6/o
r4HmlofmoaMNCj4gPj4gICAtLS0tLS0tLS0tDQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuMjUuMQ0K
PiA+Pg0KPiA+IEJUVywgSSB0aGluayB0aGVzZSBhcmUgc2ltaWxhciB0byAiZGlzY2xhaW1lci16
aF9DTiIsIGJ1dCBub3QgYXMgZ29vZA0KPiA+IGFzIHRoZSBsYXR0ZXIuDQo+ID4NCj4gPiBBbGV4
IGFuZCBYaWFuZ2NoZW5nLCB3aGF0IGRvIHlvdSB0aGluaz8NCj4gPg0KPiA+IFRoYW5rcywNCj4g
PiBZYW50ZW5nDQo+DQo=
