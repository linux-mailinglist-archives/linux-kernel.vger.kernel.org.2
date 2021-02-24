Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55DA3237BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhBXHMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:12:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:40913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhBXHLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614150524;
        bh=JBUYayNy3evHFwEU8b+lYJeGEoEUDi/DNq0J8g+SPTM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=QZzTW3UNngrZnLn4yZutnsVTjjnrvfS8H/Lzl8DsGC3af1Y12hCQASjhsNzyk7xgS
         Anwy3KisJuAbTkjyv28cvjBoAd+VU5L3eaoaMq5IsuP/9ZLRJA+KdFqhNZjfAR6abM
         hnGZw3RmFeG4UcNCmeBqYJ4Z53IbSoIaxbkd/tOE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Valinor ([213.216.209.188]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1lT1DL3Vvg-00PPyQ; Wed, 24
 Feb 2021 08:08:44 +0100
Date:   Wed, 24 Feb 2021 09:10:27 +0200
From:   Lauri Kasanen <cand@gmx.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] sound: n64: Fix return value check in
 n64audio_probe()
Message-Id: <20210224091027.8d172c0b7aa4d6d651a3d34e@gmx.com>
In-Reply-To: <20210224013803.2146953-1-weiyongjun1@huawei.com>
References: <20210224013803.2146953-1-weiyongjun1@huawei.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w274xjZp7tauHIHUJ0KH48Knh/UIezK9ZJRHbL1UhsWlkDbMYnc
 m5LxWvYoIQVxD7tt/hQG1T2RMSUiltGCcDsgWmSJBhOCd0LlMFWbwMh4KTxlD9YzpLRdcsw
 63UJYw14WM9jrH1v2N7paD644KZ9jfmRnPHOAlmnZM9oWth2wlellsd5Yum6LKW9No3I7t3
 PmciFgLpu8J0yMHmm0zMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q/4/yVZPhN8=:Zifqb/WYYtNIwpWcDiD4vz
 ovz3Q+qneELNLKYHgnkcIJzlnspUZuN/iIQn3OYtD2OSoymtw0v9RQvUgi0a+3ntweQAC/x8F
 pzjQ65Pz0eEkCgSj72TtvF/plWVgdO+q0/jqkogChVKlTawPOXepVqJsLGZgUZsW7e5JoymXg
 e9cyq6iKsyd9iN6LD6KvSxhiblv4HWmChz7SyfT3rIZgRV8RrZTsRawWNrUUP1x8NDA3WXoSK
 99pNA1q9qIzM2poNj3snXa1XV6Y+c0G7sJp2UYZ5z/Y/RaytjhaBepdW99CNymVl66q5tiW4N
 gbcrTB7MloJrXhmH688atMbyvb1P4h1KlbYlr6f2bkMTcDMJ9MaVZ4snFd/dasdEWC/hpFR89
 PJj271hPyyfq35GZOrNlyVodU2OERlA/gHYqRPahqnAlCc6T5TzTqx/WnHuXomYU1ZSoxECOB
 0uCK7t9Gc30mxoY+fliY9CCjIJqkVwldAD6cX0iCQTQB4BxcACcRpHMPdcyjU9pXegvKdKekp
 iJIbddMkTVHokHNCxuT8YV6b2HecfCL63BJE3s1HGqo2MMHE6YhZW+Qx1MzdC5rw1S1a1kIk8
 +dC9GlOFeUy5rTz0hwu3q7V+mr8kaNlnobNtMLTr6cOMrOaV+h7Ov9taDMs+m59v8KBtY9V4s
 lpkgcirPNNllzF6NQLxxjnZPEjsfdPPzHoLn1mBjZfCj8dHfVObwZWpsZvQ9QtbuHlSjNBJbu
 pTxrmTGL3s5I6FYL2OfvEANL6Mqyq9AsVkQBIWvaLpLkUbk3ZEF+AOHUn99GENYOfq3JG3Kao
 ccPIYDCxxECYyVOJKrqI7dymWxvW4zAJVQ024d2G1qhS+NWWM2ng5cmeWnafV2IMs/BX53tFk
 bxQg3OJy3lZK112kPkcQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 01:38:03 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> In case of error, the function devm_platform_ioremap_resource()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
>
> Fixes: 1448f8acf4cc ("sound: Add n64 driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/mips/snd-n64.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Lauri Kasanen <cand@gmx.com>

- Lauri
