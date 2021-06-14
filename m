Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1E3A6C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhFNQnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:43:01 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50839 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhFNQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:41:11 -0400
Received: from [192.168.1.155] ([95.115.71.85]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmU9R-1lS3ME4Bu5-00iRYW; Mon, 14 Jun 2021 18:38:24 +0200
Subject: Re: [PATCH v9 1/5] nvmem: prepare basics for FRAM support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-2-jiri.prchal@aksignal.cz> <YMMjbCFzsfiT8dMA@kroah.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <d5927cbf-2c92-d45e-9f47-3ad8b8b27436@metux.net>
Date:   Mon, 14 Jun 2021 18:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YMMjbCFzsfiT8dMA@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4n+TQ9WlLCMNimSNbLHKb/PrM8nvB/UpTdbGzmw+ota4zcTghY+
 We0B4CSY7/O5qfqACxBHlnwOe6SnWMcZ8JAKoGjVJ7l/WlQFV7gW+a29/K3KC5aTylVd7NT
 iYysQotin5Swv8R2wWdvovHwjvA9NM+Mx3rmMae5XgStjNDUYvayKmdYJ0jNfBWi5daLpgK
 M+QSecedSP1O9too4xNng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mi12Q0pxyAw=:/uChxz/zVF3Vwq9l+iMnE9
 YewNHrOls1NyXYW3q6Xp9CgL7qNGQiNQrMuvWo6wSepqb2yG4UT7/7czDqYGc+rBwq7PUWdKu
 4mWtE51PFbmHRF4wrOEhShZ+0O5b5Iq1rupEDPlkCKRG5hNNvt0AnGxe057XvctS9WjtV0Mct
 mdeQVy2qELn3DiNNYzZoBorzpB0VnpP7hwWbqZEmzIUfIl9EB9kvmUhRvl56K61nU/RMXqc1r
 r5qyyJ8X8++m6mNLvRLBkOT1vkDX5tuBp6ZgKeM4J8Qe8LMt+DomAkm74vMzMuK1i3MAqtNbm
 3ZRFtEBMx9c2dgVKI7yWLAkMsfe/8CO1Wp8SyivvdXdYXSOl87lcABp72bim5CTFF1BVLhkiN
 zjlX1j/Gwzbaab5/xfS0hZW4MjGrRiuyUuMU+IOmJRu6y/a+R9q5/f6UzlmxdRX6/BfcxVJ3B
 hRlTuB2P5W7gVHoPo3Ub+WI5Rc8FMSQ9aKWMnaBZnG1MYq/4ihTjjeSAAHDMEVtevftcmQs9L
 skqnLlvLaivhyDYDTDIdKs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.21 10:48, Greg Kroah-Hartman wrote:
> On Fri, Jun 11, 2021 at 07:26:48AM +0200, Jiri Prchal wrote:
>> Added enum and string for FRAM to expose it as "fram".
> 
> I have no idea what "FRAM" is, nor what "fram" is.

perhaps ferroelectric RAM ?

https://en.wikipedia.org/wiki/Ferroelectric_RAM


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
