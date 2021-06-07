Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB739DDE7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFGNnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:43:52 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:39881 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:43:51 -0400
Received: by mail-pj1-f47.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so11953879pjp.4;
        Mon, 07 Jun 2021 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TabZxb1NwLVIi4AmcGpz96U9X0thI3NBq2NIc46D/Mk=;
        b=g7/zXtMNiRVgyA3/TSPMreXeT57/rw163vuLVdt/yBW0GSVd64JP5NFGMCO60I/eCq
         sjp10OKVswAnMajtcdOx2olu64q1kP4c+F9kpG++dzteCUiNUEzo5C0+S+K8Fh/0YKsh
         usEC5pFWWE1Mhie+9IQF9+cVFjMRUXuSQND4HOTbAMeC+/AAxXAXeKlmstQYuuPMTILD
         bY4ZV3XfNLpmfSGfcuyeiYi0uvdctkYp0GnRAYWtdFWy9a+Zkd+AJlP2o8gYIF00xGdo
         4yMORoSCyOHzKjCcacOsmFq73Z06tLF3aOJ0pUBxMEXqTH+OX6lFO26ri8EH1tV1QWyb
         sOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TabZxb1NwLVIi4AmcGpz96U9X0thI3NBq2NIc46D/Mk=;
        b=Sx5kwonkxcdXIVBPl0TDDwAMLktIdwCnly3D4ixwbhXGkSst9P0El6uxb6MVDdlC3s
         uM+bAZ+faYokH4Qd3JO/WlMCvroK6uU2eQS0B1cUAfp/0QMitQnpKMQTUAEhEB8ogQ2e
         oIedwCQqZfY3Y+lF7pP+fH7lRh1KwJzIdDD//w0qPCOHUKClqg9nV+g6ocCaA31PT/MF
         PopePcZ5jdg4QwNAjRIxZMrXR/bNyyY3efVsdb3qQUPS1Uq26Il1MrEfZJseiYh6fkqr
         uAHb6hU//slAn3KQFc+Bxjcf/NuyZKd91FcLVHp5KaMpKZExQWK6ajrN+YysXWqXI3Mz
         crtQ==
X-Gm-Message-State: AOAM5306WRridNQ0+PM8/SJXoI53LaNtf0dvuGjH+Lnm0Ux3jl+CyZUS
        TcvQB0yj/6Ql3vgufKgp1OHriDHPjX0UYB7MGjE=
X-Google-Smtp-Source: ABdhPJzuRAF6GK8QdHeQ5JtaIsqPPo9mPq35fdUzWrrNp6TrNGpfLGxMTJQsdehZp9z7COz5J7WxBxcniS7I9+RCLho=
X-Received: by 2002:a17:90b:1888:: with SMTP id mn8mr33522785pjb.179.1623073259794;
 Mon, 07 Jun 2021 06:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210607093433.39160-1-src.res@email.cn>
In-Reply-To: <20210607093433.39160-1-src.res@email.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Mon, 7 Jun 2021 21:40:49 +0800
Message-ID: <CAMU9jJrkxTUgS0P3tpr-Udw9WqUgqCJ2D0G+ja5UX=B+4DRw7g@mail.gmail.com>
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

Q0Mgc2l5YW50ZW5nQGxvb25nc29uLmNuDQpIdSBIYW93ZW4gPHNyYy5yZXNAZW1haWwuY24+IOS6
jjIwMjHlubQ25pyIN+aXpeWRqOS4gCDkuIvljYg1OjM35YaZ6YGT77yaDQo+DQo+IFRoZSBvcmln
aW5hbCBmaWxlIGhhcyBhZGRlZCBhIGZvcm1lciBpbnRybyBpbiBjb21taXQgYjUxMjA4ZDQxYzZh
NGU3ZmMyZjANCj4gKCJkb2NzOiBUd2VhayB0aGUgdG9wLWxldmVsIFNwaGlueCBwYWdlIikgYW5k
IGhlbmNlIHVwZGF0ZSB0aGUgQ2hpbmVzZQ0KPiB2ZXJzaW9uIGZvciBpdC4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogSHUgSGFvd2VuIDxzcmMucmVzQGVtYWlsLmNuPg0KPiAtLS0NCj4gIERvY3VtZW50
YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdCB8IDUgKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
dHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25z
L3poX0NOL2luZGV4LnJzdA0KPiBpbmRleCAxZjk1M2QzNDM5YTUuLjAwMzEyNmFiYzBkNiAxMDA2
NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW5kZXgucnN0DQo+
ICsrKyBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL2luZGV4LnJzdA0KPiBAQCAt
MTcsNiArMTcsMTEgQEANCj4gICAgICoq57+76K+R6K6h5YiSOioqDQo+ICAgICDlhoXmoLjkuK3m
lofmlofmoaPmrKLov47ku7vkvZXnv7vor5HmipXnqL/vvIznibnliKvmmK/lhbPkuo7lhoXmoLjn
lKjmiLflkoznrqHnkIblkZjmjIfljZfpg6jliIbjgIINCj4NCj4gK+i/meaYr+WGheaguOaWh+ah
o+agkeeahOmhtue6p+ebruW9leOAguWGheaguOaWh+aho++8jOWwseWDj+WGheaguOacrOi6q+S4
gOagt++8jOWcqOW+iOWkp+eoi+W6puS4iuaYr+S4gOmhueatow0KaG93IGFib3V0Og0KDQrov5nm
mK/kuK3mloflhoXmoLjmlofmoaPmoJHnmoTpobbnuqfnm67lvZXjgIINCj4gK+WcqOi/m+ihjOea
hOW3peS9nO+8m+W9k+aIkeS7rOWKquWKm+WwhuiuuOWkmuWIhuaVo+eahOaWh+S7tuaVtOWQiOaI
kOS4gOS4qui/nui0r+eahOaVtOS9k+aXtuWwpOWFtuWmguatpOOAguWPpg0KPiAr5aSW77yM6ZqP
5pe25qyi6L+O5oKo5a+55YaF5qC45paH5qGj6L+b6KGM5pS56L+b77yb5aaC5p6c5oKo5oOz5o+Q
5L6b5biu5Yqp77yM6K+35Yqg5YWldmdlci5rZXJuZWwub3JnDQrkuK3mloflhoXmoLjmlofmoaPo
v5vooYzmlLnov5vvvJsNCj4gK+S4iueahGxpbnV4LWRvY+mCruS7tuWIl+ihqOOAgg0K5LiK55qE
bGludXgtZG9j6YKu5Lu25YiX6KGo77yM5YWI5pS56L+b5Y6f5aeL6Iux5paH5paH5qGj77yM5YaN
5bCG5YW257+76K+R5Li65Lit5paH5ZCO77yM5pu05paw55u45bqU55qE5Lit5paH5paH5qGj44CC
DQo+ICsNCj4gIOiuuOWPr+ivgeaWh+ahow0KPiAgLS0tLS0tLS0tLQ0KPg0KPiAtLQ0KPiAyLjI1
LjENCj4NCkJUVywgSSB0aGluayB0aGVzZSBhcmUgc2ltaWxhciB0byAiZGlzY2xhaW1lci16aF9D
TiIsIGJ1dCBub3QgYXMgZ29vZA0KYXMgdGhlIGxhdHRlci4NCg0KQWxleCBhbmQgWGlhbmdjaGVu
Zywgd2hhdCBkbyB5b3UgdGhpbms/DQoNClRoYW5rcywNCllhbnRlbmcNCg==
