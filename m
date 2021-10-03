Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1237742005C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhJCGt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhJCGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 02:49:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20948C061780
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 23:47:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a13so13099062qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 23:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MIlI/WQkwPpdmPLTKH138J1xzqOq2TNXP4QRduXN8Vw=;
        b=l9fv3An1OZtM4yoLpki23bpZ32SOEocP4RUbkPgIVeuT45EeiRld1CZx49ijLBpxnT
         ypHkMyfWlAxCTKaEcy2k6rM0kPuIc1XwkUsZLLbxi7n4H+fXLynIHmY+uZHpeiaNDW0O
         6zLw543AtV0rWPcwcqSPn7475dsL98XyrLw9Inz8X3b6RvvP+eUEhNOYJwaibgXFcFQi
         brY/VTCxcaDvAJs7x/cRVrjPb0rDXf1Q6hEEZv+Ij61mRr8JaOwupuZhAC6YmmgmBEsu
         1igMqpsiG/ZE8RZ711AZ2aLnPHilwjlNxwosNAGBNAdxPGfKcXM37Giei+Yx7zREQ6h2
         6wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=MIlI/WQkwPpdmPLTKH138J1xzqOq2TNXP4QRduXN8Vw=;
        b=vfwq+ZYz0CHdipeVkqIcthEYbjg7hierZ3flCf2A5Kug49nXiGMQgQZt+zanspBEHg
         TgVVWDdelAwzaRaxWyZVlb5LgREzCyoYsT35iYvgs5IDtA8hPLJ+shoW0HDr+IT5AHQ0
         Ttbji5KOZMSZYqQcUfIPRxVmVW/pTrnmuDl3wHFK1d0UG7LlrTi9ZqMQ+sb7KO5lTrrb
         APuNpHMmfQBCXNJ08486twSmx6qqSiZwzX55l7tnVHLgKXCOIDEBE0zPDSg1xpzGK74L
         LqlT1Ng11TJ9Vw/+BpPAGN5Pq0kWOdbjzH+WtmJhY3MQqsdAYZJU+rzqgNTVxcW1O+gB
         ls+w==
X-Gm-Message-State: AOAM532YzgIph9QyHzohNaaUbmRjRGKaKbK+AeDKeUPHRiA1qlIWIN5c
        blIZWtqKfQ7510zmb0CDn9gIGSStT1evBf+muA0=
X-Google-Smtp-Source: ABdhPJzbJIs2LkFG/iTKk7xwueTfCuuELU58rET42hPgmgPEF4VY3/Ny0mrwyDDD7WPZvc6WMfG7lSF3Fblqq4eWvKU=
X-Received: by 2002:ac8:5617:: with SMTP id 23mr7084377qtr.257.1633243658210;
 Sat, 02 Oct 2021 23:47:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:620a:4d9:0:0:0:0 with HTTP; Sat, 2 Oct 2021 23:47:37
 -0700 (PDT)
Reply-To: Evelynscott20211@gmail.com
From:   Richard smith <rw4577778@gmail.com>
Date:   Sun, 3 Oct 2021 06:47:37 +0000
Message-ID: <CAAcs34x+W3H3S8hL0ifT=qKet8GLUfaF9+0t83R7rhPU393uJQ@mail.gmail.com>
Subject: HI
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpHw7PDsGFuIGRhZywgdmludXIgbWlubiwNCg0KR8Ozw7BhbiBkYWdpbm4gZWxza2FuIG3D
rW4sIGh2ZXJuaWcgZXJ0dSDDrSBsYW5nYW4gdMOtbWE/IMOJZyBlciDDoW7DpmfDsHVyIG1lw7AN
CnVwcGzDvXNhIMO+aWcgdW0gw6FyYW5ndXIgbWlubiB2acOwIGHDsCBmw6Egw75lc3NhciBhcmZs
ZWlmw7BhcnNqw7PDsGlyDQpGbHl0amEgbWXDsCDDvsOhdHR0w7ZrdSBuw71ycmEgc2Ftc3RhcmZz
YcOwaWxhIGZyw6EgQ2hpbGUuIE7Dug0Kw4lnIGVyIGHDsCBnZXJhIGVybGVuZGlyIGZqw6FyZmVz
dGluZ2FydmVya2Vmbmkgw6EgSW5kbGFuZGkgbWXDsCBlaWdpbiBobHV0ZGVpbGQgw60NCkdyYW5k
IHNhbXRhbHMsIGVuIMOpZyBoZWYgZWtraSBnbGV5bXQgdmnDsGxlaXRuaSDDvmlubmkgb2cgcmV5
bnQgc3ZvIGxhbmd0Lg0KdGlsIGHDsCBoasOhbHBhIG3DqXIgYcOwIGZseXRqYSDDvsOhIGFyZmxl
aWbDsGFyc2rDs8OwaXIsIGphZm52ZWwgw77Ds3R0IMO+YcOwIHbDpnJpDQpFaW5odmVybiB2ZWdp
bm4gdMOza3N0IGVpbmh2ZXJuIHZlZ2lubiwgaGFmw7B1IHNhbWJhbmQgdmnDsCByaXRhcmEgbcOt
bmEgw60NCkxvbcOpIFTDs2fDsywgVmVzdHVyLUFmcsOta3UsDQpIw7puIGhlaXRpciBmcsO6IEV2
ZWx5biBTY290dCwgw60gdMO2bHZ1cMOzc3RpIGhlbm5hci4NCkhlaW1pbGlzZmFuZyAoRXZlbHlu
c2NvdHQyMDIxMUBnbWFpbC5jb20pIEJpZGR1IGhlbm5pIGHDsCBzZW5kYSDDvsOpcg0KZnVsbGEg
dXBwaMOmw7BpbmENCmFmICgkIDk1MC4wMDAuMDApLCBuw611IGh1bmRydcOwIGZpbW10dSDDvsO6
c3VuZCBCYW5kYXLDrWtpbg0KRG9sbGFyYSBzZW0gw6lnIGjDqWx0IGZ5cmlyIGLDpnR1ciDDvsOt
bmFyIGZ5cmlyIGFsbGEgZnlycmkgdmnDsGxlaXRuaSDDvsOtbmENCk9nIHJleW5kdSBhw7AgaGrD
oWxwYSBtw6lyIHZpw7AgdmnDsHNraXB0aW4uIMOJZyDDvmFra2Egdmlya2lsZWdhDQpWacOwbGVp
dG5pIMO+w61uYSBhZnR1ciDDvsOhLiBTdm8gZWtraSBoaWthIHZpw7Agb2cgaGFmw7B1IHNhbWJh
bmQgdmnDsCByaXRhcmENCm3DrW5hIGZyw7ogRXZlbHluIFNjb3R0IG9nIHNlZ8OwdSBoZW5uaSBo
dmFyIMOhIGHDsCBmw6EgaHJhw7BiYW5rYWtvcnRpw7AgYWYNCkdyYW5kIFRvdGFsICgkIDk1MC4w
MDAuMDApLiBWaW5zYW1sZWdhc3QgbMOhdHR1IG1pZyB2aXRhIHN0cmF4IGVmIMO+w7oNCkbDoSDD
vmHDsCDDvmFubmlnIGHDsCB2acOwIGdldHVtIGRlaWx0IGdsZcOwaSBlZnRpciBhbGxhIMO+asOh
bmluZ3VuYQ0Kw75ldHRhIHNraXB0aSAuDQpOw7puYSBlciDDqWcgbWrDtmcgdXBwdGVraW5uIGjD
qXIgdmVnbmEgZmrDoXJmZXN0aW5nYXJ2ZXJrZWZuYS4NCnNlbSDDqWcgaGVmIG1lw7AgbsO9amEg
bWFrYSBtaW5uLiBBw7AgbG9rdW0gYcOwIG1pbm5pciDDvmlnIMOhIGHDsCDDqWcgaGFmw7BpDQpM
ZWnDsGJlaW5pbmdhciBzZW5kYXIgdGlsIHJpdGFyYSBtaW5uYXIgZnlyaXIgw77DrW5hIGjDtm5k
IHRpbCBhw7AgbGV5c2Egw7pyDQpIcmHDsGJhbmthIGtvcnQsIHN2byBla2tpIGhpa2EgdmnDsCBh
w7AgaGFmYSBzYW1iYW5kIHZpw7AgZnLDuiBFdmVseW4gU2NvdHQsIGjDum4NClZpw7AgbXVudW0g
c2VuZGEgw77DqXIgdXBwaMOmw7BpbmEgw6FuIHRhZmFyLg0KDQpNZcOwIGt2ZcOwanUsDQpSaWNo
YXJkIFNtaXRoLg0K
