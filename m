Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19CB34E3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhC3I7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhC3I67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:58:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871A7C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:58:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c17so11704908pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:reply-to:accept-language:content-language
         :user-agent:content-id:content-transfer-encoding:mime-version;
        bh=y04XiC6ol6tzJ5IHQK7M4kEdNzxVBJ15iCqBuiSWGlE=;
        b=t/qe/jtbQ0yAHYCo99XsDEcODQCOgc+zFpc3fFMCHt04OQuaokSO6M0zHFEIMT0SYK
         nEyfkG6E1I6lQsCAHaqOh+NIKpDYMx/vSCbwB9FEi4YTg51G7/ttP77bTV2HTgmMW3a9
         quKxvXUYlULC/lSX0TsHh0jLO5Z6yK8cApv+wRl3vT1dXBfWIHRrIgmjXoVsS3bfQx4B
         XkoHdbBYeRimCXZEG+esGRxNsQ4bY0CgECxTo6xDL656UQJiw0+LkNS2e9q7HQr5Ep71
         ueZ9pOmYYZeRDU03TJjVYhK9Nz3NlF1Fhfr3DKxXeBzjK7yVLpXvI3ZWwhP5vu97DChQ
         In4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:reply-to:accept-language
         :content-language:user-agent:content-id:content-transfer-encoding
         :mime-version;
        bh=y04XiC6ol6tzJ5IHQK7M4kEdNzxVBJ15iCqBuiSWGlE=;
        b=q/42t6zA5wkFxEVAtTIIYHZUooTIfg+acFsomRPLBhQ3u79u+2R8V7Xneu/C1U2hqQ
         JhiPuC/FpFGPq8kbZu9sTnDSSrQQElKUsSRMXJKRy/YWSM9i5zQKTNUE7ymDZShbM2wN
         29LQRVgjg67M5Ckw/9wvU1rGZ2ZKPe812xAe2XdIZfhPRrpojiEs/4BPDRncI9L+e7s6
         s7NQydopFdBopPTRoCjUgSHP0DD9SPd6aNhE3mxd8l1OR2EFN84RnE6E08VyNQ1j4Jxb
         YCMCGEMYhRPMSBs6gkUdUSDf25uflMrR50GCBlskST9SninGR6A0F2mEFhuxRt6s4RTp
         q7xA==
X-Gm-Message-State: AOAM532g2rN3EQS7XymGm1eZX3aFphpLtOn7xxJDiq/O8aXVeXGFOwDj
        0sjX5USn2+zg31aVv4WDSse3ZA==
X-Google-Smtp-Source: ABdhPJyczBuC3m37/OJjS2Y+TevVGQD4Y0SY4eLLHSdwrkNvfcPJz6FEyKmEpILVkwhPf+DGh7xDmg==
X-Received: by 2002:a63:43c2:: with SMTP id q185mr26838243pga.41.1617094738991;
        Tue, 30 Mar 2021 01:58:58 -0700 (PDT)
Received: from PH0PR06MB7560.namprd06.prod.outlook.com ([2603:1036:30c:50::5])
        by smtp.gmail.com with ESMTPSA id g3sm17935250pfk.186.2021.03.30.01.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:58:58 -0700 (PDT)
Received: from [10.0.0.17] (218.80.79.188) by
 HK2PR0302CA0019.apcprd03.prod.outlook.com (2603:1096:202::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.14 via Frontend Transport; Tue, 30 Mar 2021 08:41:14 +0000
From:   Haojian Zhuang <haojian.zhuang@linaro.org>
To:     Hao Fang <fanghao11@huawei.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>
Subject: Re: [PATCH] ARM: hisi: use the correct HiSilicon copyright
Thread-Topic: [PATCH] ARM: hisi: use the correct HiSilicon copyright
Thread-Index: AQHXJTGHBS0j5VptG0K8/HzHGUbzhqqcNnmA
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 30 Mar 2021 08:41:17 +0000
Message-ID: <PH0PR06MB7560EC4141C22D2F0F4D68F2977D9@PH0PR06MB7560.namprd06.prod.outlook.com>
References: <1617087100-20949-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1617087100-20949-1-git-send-email-fanghao11@huawei.com>
Reply-To: "haojian.zhuang@linaro.org" <haojian.zhuang@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 06
X-MS-Exchange-Organization-AuthSource: PH0PR06MB7560.namprd06.prod.outlook.com
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id: e3e6c8c4-9561-4180-1218-08d8f357953d
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-clientproxiedby: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To PH0PR06MB7560.namprd06.prod.outlook.com
 (2603:10b6:510:50::12)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
x-tmn:  [XF2QjoSM+Cwa+UYdtT6cxoyuQyI/lo+E]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BBD7636921D614C88FCDFE82385FE2C@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zMC8yMSAyOjUxIFBNLCBIYW8gRmFuZyB3cm90ZToNCj4gcy9IaXNpbGljb24vSGlTaWxp
Y29uLw0KPiBJdCBzaG91bGQgdXNlIGNhcGl0YWwgUywgYWNjb3JkaW5nIHRvDQo+IGh0dHBzOi8v
d3d3Lmhpc2lsaWNvbi5jb20vZW4vdGVybXMtb2YtdXNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SGFvIEZhbmcgPGZhbmdoYW8xMUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBhcmNoL2FybS9tYWNo
LWhpc2kvaGlzaWxpY29uLmMgfCA0ICsrLS0NCj4gICBhcmNoL2FybS9tYWNoLWhpc2kvaG90cGx1
Zy5jICAgfCAyICstDQo+ICAgYXJjaC9hcm0vbWFjaC1oaXNpL3BsYXRtY3BtLmMgIHwgMiArLQ0K
PiAgIGFyY2gvYXJtL21hY2gtaGlzaS9wbGF0c21wLmMgICB8IDIgKy0NCj4gICA0IGZpbGVzIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLWhpc2kvaGlzaWxpY29uLmMgYi9hcmNoL2FybS9tYWNoLWhpc2kvaGlz
aWxpY29uLmMNCj4gaW5kZXggMDdlYTI4Yi4uYjhkMTRiMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9h
cm0vbWFjaC1oaXNpL2hpc2lsaWNvbi5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtaGlzaS9oaXNp
bGljb24uYw0KPiBAQCAtMSw4ICsxLDggQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vbmx5DQo+ICAgLyoNCj4gLSAqIChIaXNpbGljb24ncyBTb0MgYmFzZWQpIGZs
YXR0ZW5lZCBkZXZpY2UgdHJlZSBlbmFibGVkIG1hY2hpbmUNCj4gKyAqIChIaVNpbGljb24ncyBT
b0MgYmFzZWQpIGZsYXR0ZW5lZCBkZXZpY2UgdHJlZSBlbmFibGVkIG1hY2hpbmUNCj4gICAgKg0K
PiAtICogQ29weXJpZ2h0IChjKSAyMDEyLTIwMTMgSGlzaWxpY29uIEx0ZC4NCj4gKyAqIENvcHly
aWdodCAoYykgMjAxMi0yMDEzIEhpU2lsaWNvbiBMdGQuDQo+ICAgICogQ29weXJpZ2h0IChjKSAy
MDEyLTIwMTMgTGluYXJvIEx0ZC4NCj4gICAgKg0KPiAgICAqIEF1dGhvcjogSGFvamlhbiBaaHVh
bmcgPGhhb2ppYW4uemh1YW5nQGxpbmFyby5vcmc+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLWhpc2kvaG90cGx1Zy5jIGIvYXJjaC9hcm0vbWFjaC1oaXNpL2hvdHBsdWcuYw0KPiBpbmRl
eCA1YzVmMjU1Li5jNTE3OTQxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWhpc2kvaG90
cGx1Zy5jDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtaGlzaS9ob3RwbHVnLmMNCj4gQEAgLTEsNyAr
MSw3IEBADQo+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiAg
IC8qDQo+ICAgICogQ29weXJpZ2h0IChjKSAyMDEzIExpbmFybyBMdGQuDQo+IC0gKiBDb3B5cmln
aHQgKGMpIDIwMTMgSGlzaWxpY29uIExpbWl0ZWQuDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTMg
SGlTaWxpY29uIExpbWl0ZWQuDQo+ICAgICovDQo+ICAgDQo+ICAgI2luY2x1ZGUgPGxpbnV4L2Nw
dS5oPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1oaXNpL3BsYXRtY3BtLmMgYi9hcmNo
L2FybS9tYWNoLWhpc2kvcGxhdG1jcG0uYw0KPiBpbmRleCBmMTU1ZTMyLi45NmE0ODQwIDEwMDY0
NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNoLWhpc2kvcGxhdG1jcG0uYw0KPiArKysgYi9hcmNoL2Fy
bS9tYWNoLWhpc2kvcGxhdG1jcG0uYw0KPiBAQCAtMSw3ICsxLDcgQEANCj4gICAvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICAgLyoNCj4gICAgKiBDb3B5cmlnaHQg
KGMpIDIwMTMtMjAxNCBMaW5hcm8gTHRkLg0KPiAtICogQ29weXJpZ2h0IChjKSAyMDEzLTIwMTQg
SGlzaWxpY29uIExpbWl0ZWQuDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTMtMjAxNCBIaVNpbGlj
b24gTGltaXRlZC4NCj4gICAgKi8NCj4gICAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiAgICNp
bmNsdWRlIDxsaW51eC9zbXAuaD4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtaGlzaS9w
bGF0c21wLmMgYi9hcmNoL2FybS9tYWNoLWhpc2kvcGxhdHNtcC5jDQo+IGluZGV4IGRhN2EwOWMu
LmE1NmNjNjQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtaGlzaS9wbGF0c21wLmMNCj4g
KysrIGIvYXJjaC9hcm0vbWFjaC1oaXNpL3BsYXRzbXAuYw0KPiBAQCAtMSw3ICsxLDcgQEANCj4g
ICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ICAgLyoNCj4gICAg
KiBDb3B5cmlnaHQgKGMpIDIwMTMgTGluYXJvIEx0ZC4NCj4gLSAqIENvcHlyaWdodCAoYykgMjAx
MyBIaXNpbGljb24gTGltaXRlZC4NCj4gKyAqIENvcHlyaWdodCAoYykgMjAxMyBIaVNpbGljb24g
TGltaXRlZC4NCj4gICAgKiBCYXNlZCBvbiBhcmNoL2FybS9tYWNoLXZleHByZXNzL3BsYXRzbXAu
YywgQ29weXJpZ2h0IChDKSAyMDAyIEFSTSBMdGQuDQo+ICAgICovDQo+ICAgI2luY2x1ZGUgPGxp
bnV4L3NtcC5oPg0KPiANCg0KQWNrZWQtYnk6IEhhb2ppYW4gWmh1YW5nIDxoYW9qaWFuLnpodWFu
Z0BsaW5hcm8ub3JnPg0K
