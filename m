Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0063C6061
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhGLQ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhGLQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:26:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CCC0613DD;
        Mon, 12 Jul 2021 09:23:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 017DD36E;
        Mon, 12 Jul 2021 16:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 017DD36E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626107018; bh=I5MmZkCWWrzX5ZoYDtzSKwxIieU8qmtuv+0xa/1bk8k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HVnG1QGeuAIiLlQQZP+W9n39bNmJHrMFdakP8rYcTHc7omWa0J+S21rCkTDBRSGnw
         t2jqtrzeNBuXW5t6WaGxBmsnttosGy0oJ09jK4CcDRmb1KFOR+txmtTQsfKufo5ygV
         X33HN7YGP72kyQcyeprIHsrMoNUaLjwCqqDetxKgNgZRitIMDa0digRWZ4VqE348HQ
         H7xWpaImKmKBlQKMdw8u/cs2SV/VmRidX4NgGfvoNuyDPa3ipybR26XKtS1IEYMCbl
         U06mrJFx/N6F33l/2veiC6ESPZBLbZ+DudZCxSPqmzUpGiaSe2NLJ3OKOXynkkvFHb
         rgdAdQy0f1Rdw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res@email.cn>, alexs@kernel.org
Cc:     bobwxc@email.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: add a missing space character
In-Reply-To: <20210620010444.24813-1-src.res@email.cn>
References: <20210620010444.24813-1-src.res@email.cn>
Date:   Mon, 12 Jul 2021 10:23:37 -0600
Message-ID: <87czrnqz5i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHUgSGFvd2VuIDxzcmMucmVzQGVtYWlsLmNuPiB3cml0ZXM6DQoNCj4gIkxpbnVzVG9ydmFsZHMi
IGlzIG5vdCBwcmV0dHkuIFJlcGxhY2UgaXQgd2l0aCAiTGludXMgVG9ydmFsZHMiLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBIdSBIYW93ZW4gPHNyYy5yZXNAZW1haWwuY24+DQo+IC0tLQ0KPiAgRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vzcy8yLlByb2Nlc3MucnN0IHwgNCAr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vz
cy8yLlByb2Nlc3MucnN0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vz
cy8yLlByb2Nlc3MucnN0DQo+IGluZGV4IDIyOTYyOWUzMDVjYS4uNGE2ZWQwMjE5NDk0IDEwMDY0
NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9wcm9jZXNzLzIuUHJv
Y2Vzcy5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vcHJvY2Vz
cy8yLlByb2Nlc3MucnN0DQo+IEBAIC00Nyw3ICs0Nyw3IEBADQo+ICDvvIjpobrkvr/or7TkuIDl
j6XvvIzlgLzlvpfms6jmhI/nmoTmmK/vvIzlkIjlubbnqpflj6PmnJ/pl7Tpm4bmiJDnmoTmm7Tm
lLnlubbkuI3mmK/lh63nqbrkuqfnlJ/nmoTvvJvlroPku6zmmK/nu48NCj4gIOaPkOWJjeaUtumb
huOAgea1i+ivleWSjOWIhue6p+eahOOAgueojeWQjuWwhuivpue7huaPj+i/sOivpei/h+eoi+ea
hOW3peS9nOaWueW8j+OAgu+8iQ0KPiAgDQo+IC3lkIjlubbnqpflj6PmjIHnu63lpKfnuqbkuKTl
kajjgILlnKjov5nmrrXml7bpl7Tnu5PmnZ/ml7bvvIxMaW51c1RvcnZhbGRz5bCG5aOw5piO56qX
5Y+j5bey5YWz6Zet77yM5bm2DQo+ICvlkIjlubbnqpflj6PmjIHnu63lpKfnuqbkuKTlkajjgILl
nKjov5nmrrXml7bpl7Tnu5PmnZ/ml7bvvIxMaW51cyBUb3J2YWxkc+WwhuWjsOaYjueql+WPo+W3
suWFs+mXre+8jOW5tg0KPiAg6YeK5pS+56ys5LiA5Liq4oCccmPigJ3lhoXmoLjjgILkvovlpoLv
vIzlr7nkuo7nm67moIfkuLo1LjbnmoTlhoXmoLjvvIzlnKjlkIjlubbnqpflj6Pnu5PmnZ/ml7bl
j5HnlJ/nmoTph4rmlL4NCg0KQXBwbGllZCwgdGhhbmtzLg0KDQpqb24NCg==
