Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00E31E8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBRKbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:31:21 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:47541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhBRJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:16:47 -0500
Received: from [192.168.1.155] ([95.115.65.253]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwPfX-1m2q222N1x-00sLew; Thu, 18 Feb 2021 10:14:03 +0100
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: of overlay: how to insert new nodes with references to it
Message-ID: <9b5a8e1f-6359-7658-4851-00d77d1cb8e5@metux.net>
Date:   Thu, 18 Feb 2021 10:14:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7Vkdq4ls2WKZE4Oh7wDHJ3PoBDx+sg+pliid5nWmTuwXzAXZ3Dy
 i0+7nzlKsHnvjRSQAXOG/+GA7UULk4Ic8KADp6BhM3hlLSUU8tGOfVPRxyAivPOM2cpGPOK
 ZtwEchLMFVHCwqisyMl7+ABh/5kRTQXFXeo0ljMpPAmvVDGfnVl//MCrgimraZhg8vCwk63
 TxN22XgApXGP3LVUct9Sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NQkpasjr68s=:nL2BOtcHme9oDxzxH73ixx
 qgx8LYsWRqqqPIwqhK/zAdzUTsD9SdNlRNU6nW2xTMLCKBSMjWTR1gvKlxYXA2naJiGMgIO6v
 eRs9PdIB9KzAFE6ONo3YpPvl9mlHPZvvJdW7/0LpftpGDPR0catO4otO4JbtLvicDP6rEwZzc
 1bdQmcCP1fwEOOz5gS6k01JMEa1euwQFY9kKfv3FfYqoLNjIuaJga2AXl3IN43jvnmI/ivFfA
 dZMvB5M3O9bSK6snlQ2irsgbUDzKGXpd6jfSrSNaiVh8ApqokgCicR6fdwzm+XBw7Nt5Ta3zO
 HSJit2vmOizrn6HdLTqouMuCkfZgoRL7E0tYC07L7BCsZ9ofbqzAZ6HyaK2JkofDtVk542xgT
 yAE3f5VkQj29LEMI8J2XxycdtgvsfbGSqYIPz8GuXbiWXxzLvMT2sEfJEadI0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


I'm trying to use an overlay to add several new nodes with references
between them (eg. a gpio controller and devices using the gpios).

Problem: dtc adds my new 'gpio1' node to the __fixups__ list, which is
used for resolving symbols against the live tree - obviously it can't
exist there, since it's added by the overlay. Therefore applying the
overlay fails:

     "OF: resolver: node label 'gpio1' not found in live devicetree
      symbols table"

Shouldn't the symbol be added to __local_fixups__ instead of __fixups__
?
How can I force dtc to do that ?


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
