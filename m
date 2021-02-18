Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D380D31EAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 15:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhBROJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 09:09:34 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:44999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhBRMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:23:28 -0500
Received: from [192.168.1.155] ([95.115.65.253]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuluP-1m3Ih90fXX-00rq93; Thu, 18 Feb 2021 13:19:12 +0100
Subject: Re: of overlay: how to insert new nodes with references to it
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <9b5a8e1f-6359-7658-4851-00d77d1cb8e5@metux.net>
Message-ID: <dddc18ad-24c3-013a-800a-b93ef1d679e6@metux.net>
Date:   Thu, 18 Feb 2021 13:19:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <9b5a8e1f-6359-7658-4851-00d77d1cb8e5@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:njEP9Y5KHZEd3a3joGYTYv+kI/TM1vVwJlRu2otXvWJHCebakCM
 2bzS79nvzubTFthEkHGN+r6gZt9r56FqoO5N8KI/hOWWwlMO8vOXT8fMu1AuoDK4BBqkI+2
 BgWT5Z5GLo2Cz39XxGLfZNNmxLfnJxYS5yQlh/IRBFZu6l/my52OtyjagcvVkPm0xx/I/vi
 7f9J1z7pHdh9fcGN17NOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NDczjYt0LL8=:waE07Y6wRrpADhmz7lGE6E
 b5IvdaMKAsn74tL8AXjPWS7r6Hl+UWWnlUo85BTwKGxYMruwwhgf1BIyvoFpvc965i7/reC8R
 DZy6AWoYWUgWJ1GSXQcNIDRBFoi/vqLQjGS3EgfZg5a4BgvLiMPDXH2aw3Bow1nwi5M1vnELG
 CMHsGM4Eqb+hBBLwMLXtAYbA29co6OhPGQ/zroXFG/JC79TwGm5TKGTZQ3cPegrM1F1oKfvDZ
 /9uCeLd4XT0gIoULANVEuSw+yed4Gf6YwvVoHdm7z3UIq4ES0vkda/ukd7d85JJdycqIk94sj
 JRfLhPwHRH6JDvUp2YTK5ypRJKzxdFlXvGd5dewSuwdDVSmTlmm+CATh6Yda+ovszhnLJvsCQ
 MGxG1HIlRA2jghMzcJ+pz0Lzp/B3Ge6q/uVcNnCDA9s94YSbY9rWzL0vi0tTG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.21 10:14, Enrico Weigelt, metux IT consult wrote:

Hi folks,


answering myself ;-)

> Problem: dtc adds my new 'gpio1' node to the __fixups__ list, which is
> used for resolving symbols against the live tree - obviously it can't
> exist there, since it's added by the overlay. Therefore applying the
> overlay fails:
> 
>      "OF: resolver: node label 'gpio1' not found in live devicetree
>       symbols table"
> 
> Shouldn't the symbol be added to __local_fixups__ instead of __fixups__
> ?
> How can I force dtc to do that ?

after playing around a while, found out that I need to use full path
references instead of labels or just node names, eg.

     gpios = <&{/fragment@0/__overlay__/gpio1} 0 GPIO_ACTIVE_HIGH>;


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
