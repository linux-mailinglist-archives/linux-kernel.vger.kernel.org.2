Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B261744D590
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhKKLMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKKLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:12:19 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FBC061766;
        Thu, 11 Nov 2021 03:09:30 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p18so5426593plf.13;
        Thu, 11 Nov 2021 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e+WCiuNRSkk481YMnkbZWRCXjrJnRPSe0i90hEzEWPQ=;
        b=jU1zRcPgl+pNWcpgIA4xjJIRq8cKUbocnVbYLwb27bz8T2oS2S03flDr3BVkYRT2zM
         s+HbzqmsIUYBxF9F18qTzQ8/21gEm1upKDhtLD4NzyKC03sXq3ToUaEm+oNNn0MH8Xh2
         UTrGiHl8ptoP5ZIDxD4gFu6RMdLslD9toX/rCJDfQKKb7z27bq9Xjte3q49HjVXVvDkY
         0MYgI4l96W6zYV8NzuX/FKtGM0E9M383kAmScy7MSx3WDgyskjmAsWxwc+LDiWHFgixc
         rJgp53PsJwVotZbwAr9QhML7yzLD8tOJkvnXUzsqkWlIRxmYWkw6uPDLE07ahpUCnE06
         NFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e+WCiuNRSkk481YMnkbZWRCXjrJnRPSe0i90hEzEWPQ=;
        b=HEFBDLzX4cMuzNaFyDVSRDH9Xm7F14gh1pWluLhhugppHf9x1/TpkB+DBH7wkwyL7n
         ptD0gTOiJFq8F18ShhntOdswSjyOee+cOXEF/p+laoHXML8TT+ypTugWLqcwfpsK/TtG
         nM5Z0JKNtVWGwlmBp4Yyf69PVkLFbUBeSNHSlOefc2CF6yQxxxQac+oC35bb+kK2x247
         9spteE+BUFxCAmg6Jg/g8XZOE6O5p1JNxbSx+zjRWmKKcJ+xy9lGgR+ylltqTz1h3ZI4
         bv4sbvtPO2w14ae1bIiOXeOFo9ekkxri4MW+Rq63NOzaedp+2qV00x0AoxV/I2kvShYi
         crHQ==
X-Gm-Message-State: AOAM5322XbFYRRxAPbDolnhMEXogGw/TH4XHUd13bAB96jq+ZSdUI9lz
        yOOgmC+NqC9oKMDRxoxm+9InmeIGLEe+DJSwM/U=
X-Google-Smtp-Source: ABdhPJy+fGZ/wI41SiU2eEu31GRsOdAUtr3Z/EJMLoxpU11QXPp5WRgB0rpf6EQOzAGJhhWs2VCuq3d/dbocrKZwtOQ=
X-Received: by 2002:a17:903:248f:b0:143:8e81:4d7c with SMTP id
 p15-20020a170903248f00b001438e814d7cmr7014354plw.1.1636628970374; Thu, 11 Nov
 2021 03:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20211110120213.134313-1-alexs@kernel.org>
In-Reply-To: <20211110120213.134313-1-alexs@kernel.org>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Thu, 11 Nov 2021 19:09:19 +0800
Message-ID: <CAMU9jJr08+V7DiK140tgbLBc4WifgvcOJoDKjgq=wA8J+0y+fw@mail.gmail.com>
Subject: Re: [PATCH] doc/zh_CN: fix a translation error in management-style
To:     Alex Shi <alexs@kernel.org>
Cc:     Xinyong Wang <wang.xy.chn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PGFsZXhzQGtlcm5lbC5vcmc+IOS6jjIwMjHlubQxMeaciDEw5pel5ZGo5LiJIOS4i+WNiDg6MDPl
hpnpgZPvvJoNCj4NCj4gRnJvbTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+DQo+ICdU
aGUgbmFtZSBvZiB0aGUgZ2FtZScgbWVhbnMgdGhlIG1vc3QgaW1wb3J0YW50IHBhcnQgb2YgYW4g
YWN0aXZpdHksIHNvDQo+IHdlIHNob3VsZCB0cmFuc2xhdGUgaXQgYnkgdGhlIG1lYW5pbmcgaW5z
dGVhZCBvZiB0aGUgd29yZHMuDQo+DQo+IFN1Z2dlc3RlZC1ieTogWGlueW9uZyBXYW5nIDx3YW5n
Lnh5LmNobkBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggU2hpIDxhbGV4c0BrZXJu
ZWwub3JnPg0KUmV2aWV3ZWQtYnk6IFlhbnRlbmcgU2kgPHNpeWFudGVuZ0Bsb29uZ3Nvbi5jbj4N
Cg0KVGhhbmtzLA0KWWFudGVuZw0KPiBDYzogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5l
dD4NCj4gQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9D
Ti9wcm9jZXNzL21hbmFnZW1lbnQtc3R5bGUucnN0IHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy9tYW5hZ2VtZW50LXN0eWxlLnJz
dCBiL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3MvbWFuYWdlbWVudC1z
dHlsZS5yc3QNCj4gaW5kZXggYzZhNWJiMjg1Nzk3Li44MDUzYWU0NzQzMjggMTAwNjQ0DQo+IC0t
LSBhL0RvY3VtZW50YXRpb24vdHJhbnNsYXRpb25zL3poX0NOL3Byb2Nlc3MvbWFuYWdlbWVudC1z
dHlsZS5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vz
cy9tYW5hZ2VtZW50LXN0eWxlLnJzdA0KPiBAQCAtMzYsMTQgKzM2LDE0IEBAIExpbnV45YaF5qC4
566h55CG6aOO5qC8DQo+ICDmr4/kuKrkurrpg73orqTkuLrnrqHnkIbogIXlgZrlhrPlrprvvIzo
gIzkuJTlhrPnrZblvojph43opoHjgILlhrPlrprotorlpKfotornl5voi6bvvIznrqHnkIbogIXl
sLHlv4Xpobvotorpq5jnuqfjgIINCj4gIOi/meW+iOaYjuaYvu+8jOS9huS6i+WunuW5tumdnuWm
guatpOOAgg0KPg0KPiAt5ri45oiP55qE5ZCN5a2X5pivICoq6YG/5YWNKiog5YGa5Ye65Yaz5a6a
44CC5bCk5YW25piv77yM5aaC5p6c5pyJ5Lq65ZGK6K+J5L2g4oCc6YCJ5oup77yIYe+8ieaIlu+8
iGLvvInvvIwNCj4gK+acgOmHjeimgeeahOaYryAqKumBv+WFjSoqIOWBmuWHuuWGs+WumuOAguWw
pOWFtuaYr++8jOWmguaenOacieS6uuWRiuivieS9oOKAnOmAieaLqe+8iGHvvInmiJbvvIhi77yJ
77yMDQo+ICDmiJHku6znnJ/nmoTpnIDopoHkvaDmnaXlgZrlhrPlrprigJ3vvIzkvaDlsLHmmK/p
mbflhaXpurvng6bnmoTnrqHnkIbogIXjgILkvaDnrqHnkIbnmoTkurrmr5TkvaDmm7Tkuobop6Pn
u4boioLvvIwNCj4gIOaJgOS7peWmguaenOS7luS7rOadpeaJvuS9oOWBmuaKgOacr+WGs+etlu+8
jOS9oOWujOibi+S6huOAguS9oOaYvueEtuayoeacieiDveWKm+S4uuS7luS7rOWBmui/meS4quWG
s+WumuOAgg0KPg0KPiAg77yI5o6o6K6677ya5aaC5p6c5L2g566h55CG55qE5Lq65LiN5q+U5L2g
5pu05LqG6Kej57uG6IqC77yM5L2g5Lmf5Lya6KKr5pCe56C477yM5bC9566h5Y6f5Zug5a6M5YWo
5LiN5ZCM44CCDQo+ICDkuZ/lsLHmmK/or7TvvIzkvaDnmoTlt6XkvZzmmK/plJnnmoTvvIzku5bk
u6zlupTor6XnrqHnkIbkvaDnmoTmiY3mmbrvvIkNCj4NCj4gLeaJgOS7pea4uOaIj+eahOWQjeWt
l+aYryAqKumBv+WFjSoqIOWBmuWHuuWGs+Wumu+8jOiHs+WwkeaYr+mCo+S6m+Wkp+iAjOeXm+iL
pueahOWGs+WumuOAguWBmuS4gOS6m+Wwj+eahA0KPiAr5omA5Lul5pyA6YeN6KaB55qE5pivICoq
6YG/5YWNKiog5YGa5Ye65Yaz5a6a77yM6Iez5bCR5piv6YKj5Lqb5aSn6ICM55eb6Ium55qE5Yaz
5a6a44CC5YGa5LiA5Lqb5bCP55qEDQo+ICDlkozpnZ7nu5PmnpzmgKfnmoTlhrPlrprmmK/lvojl
pb3nmoTvvIzlubbkuJTkvb/mgqjnnIvotbfmnaXlpb3lg4/nn6XpgZPoh6rlt7HlnKjlgZrku4Dk
uYjvvIzmiYDku6XlhoXmoLjnrqHnkIbogIUNCj4gIOmcgOimgeWBmueahOaYr+WwhumCo+S6m+Wk
p+eahOWSjOeXm+iLpueahOWGs+WumuWPmOaIkOmCo+S6m+ayoeacieS6uuecn+ato+WFs+W/g+ea
hOWwj+S6i+aDheOAgg0KPg0KPiAtLQ0KPiAyLjI3LjANCj4NCg==
