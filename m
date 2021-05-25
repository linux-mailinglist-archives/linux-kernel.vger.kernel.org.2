Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4075B38FD08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhEYIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:44:17 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:42045 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232034AbhEYIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:44:13 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 04:44:13 EDT
Received: from iva6-d2c82ec8bc26.qloud-c.yandex.net (iva6-d2c82ec8bc26.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:610c:0:640:d2c8:2ec8])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 31A505982168;
        Tue, 25 May 2021 11:36:12 +0300 (MSK)
Received: from iva8-174eb672ffa9.qloud-c.yandex.net (iva8-174eb672ffa9.qloud-c.yandex.net [2a02:6b8:c0c:b995:0:640:174e:b672])
        by iva6-d2c82ec8bc26.qloud-c.yandex.net (mxback/Yandex) with ESMTP id AAOT3RcoLW-aBJqKqj6;
        Tue, 25 May 2021 11:36:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1621931772;
        bh=12uVRu8JzMyWgiKvh9pJQymNMwsozrDOyh51/FHzUeY=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=pW4xZ27q8iusqcVWe4iYSGmTkTFmzm65s6AWt6zyHHhuTPlXydwplZ3lyTzb7rD7X
         5BNST3JVkFyZHPEBm7+1OSO5E+7wymAhtkYFr5vh7eEJrB52SHCy+zc0eFT2F/LKxv
         g8HFiyGtdnN8zlD67IrxNqXz0syWC1WEAdCv7uWE=
Authentication-Results: iva6-d2c82ec8bc26.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva8-174eb672ffa9.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 7BolJOt5tl-aALqoftv;
        Tue, 25 May 2021 11:36:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/1] ep93xx: clock: convert in-place
Date:   Tue, 25 May 2021 11:33:38 +0300
Message-Id: <20210525083340.27722-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

In continuation of
https://lore.kernel.org/linux-gpio/1042421616413081@mail.yandex.ru/

Alexander please look at provided patch, the size goes from

```
   text    data     bss     dec     hex filename
4491689  920748   92840 5505277  5400fd vmlinux
```

to with patch applied:

```
   text    data     bss     dec     hex filename
4534485  927424   90304 5552213  54b855 vmlinux
```

If this is not acceptable to you, than it's perfectly fine, i'll 
finish (actually only gpio left to rework to DT) and stash my rework 
somewhere and can send link or patches to all interested.

But still if you have possibility to test clocks for video and I2S
it would be nice.

Otherwise i can proceed to multiarch and try to make it possible to
compile with or without multiarch support.
