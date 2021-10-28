Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB74A43E479
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhJ1PBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:01:36 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhJ1PBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:01:31 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Msqty-1mvQnW0MtU-00tAYh; Thu, 28 Oct 2021 16:59:02 +0200
Received: by mail-wr1-f46.google.com with SMTP id d13so10704486wrf.11;
        Thu, 28 Oct 2021 07:59:01 -0700 (PDT)
X-Gm-Message-State: AOAM532SwI6udJz6WZLv67lJt5mtcN2AsgaRV25SarliJ1L/wZrQ6Yn4
        ksVXtEIsZGBcXLDYMHlOJbRowBHAn9lhxY8I2o8=
X-Google-Smtp-Source: ABdhPJw1mral72Qddmd3GHMk122V+V5lr3a2+Rc1twCjQmgIEQujpYyDHdDkNkrUj9xJwnLyI7GiYnIxws+p/FRx9Gw=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr6244203wrq.411.1635433141663;
 Thu, 28 Oct 2021 07:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-14-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-14-lukas.bulwahn@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Oct 2021 16:58:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a33cMrabWU7i=cT7qVJui2--VkNr2rx2BmKX5qSyfpGpg@mail.gmail.com>
Message-ID: <CAK8P3a33cMrabWU7i=cT7qVJui2--VkNr2rx2BmKX5qSyfpGpg@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm: pgtable: refer to intended CONFIG_ARM_LPAE in comment
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2/+7UmnatUJXWnHAJa13tySNx5MdO+XhZAMXq6vAd/7Y+XG6D4u
 ybcnF8mPiuEMkps4vtWF+fE4e7riUbjAUxLxCLMNAOhCxzfCCnMiabl6GKpdiSF19yoS1gb
 QlsXCiwd1rrGda4NriR5rPI00DdfMXjr23MD5WR/122DAJN8K0Rj0lJgXyVK7wOyWKP0M8/
 F7jjCGHx2oJ9nFVkESDZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zDzVpMcYESQ=:jOLa73LwPcVO+JcvBiJ8FS
 cblIUIJM6ocecSP/RvJzcaP/Er2jA4kgOp+JKVzuAupJ/eh3fEhhpWFG3RuWxZ7tx/q2RpYxj
 fhMMLMFDY3WGXps7O0qcVVVHBgeeq3EGt+CBIwrIs5AXPKAdJhVuffzMJzIcTYAyjOdGhSn2l
 UjhI/0R1SB6JTE9McDOieSjBnk2mVcQg4Lp3ql8/Cf51KWIcGAdigqUguEW7U3V+aL5NYYzdL
 wJ/aDHVK8d36Wn7qliFujTBC+rb3FeRwXJxGjM2/l9hyP7QYh3H1gTALqYQAVFdcHMZ1hK5oe
 kXzGjfGVz+KbSeqJXzUEYEt2iawkZqER0m5AU/fAlPftdh+vIU8/qY5xapVTewFqKdGbyAiY3
 IX6riq3mASjG3viQ03+hGrx+xLlxx6dlSU3bt3BMPzxj1SELQK69BE3XSo9E2zcW7566RURq3
 z6b2pT8r34qkJAdRB0hCGCtR41m+aBbBX/7SQymJKxcV89plc6LeviHVdh2vLdjNQGT0g4v1G
 L6KUN+xpteuYlQoX2tdRBH2c5pLmArYmoeqDdGB/VyMyzBadbOkw+bzXo91GjOmBEnEtZbzSl
 74jFv2Y4qTSycAPkYr6Z9Ji2jGbCvp6HJNzRGeOF+cGmGtynzCQ2H8xYWXJUkkenkji32ezqO
 mEjzH8X/y0t4J4OZdjOFPw6NUXVSTdDHfUwQWYIQQfGyqKu10pURjnBFb95gQDMOQoTrCilmr
 920x3wOR9UDWQhOJy5CS91KutvkPWpZY1QrtOlL4USMdNkchlkLwY0eRQKaJMMpK5hoJ/WnDA
 iZa8QGTp+XjftlU5NeN2GX4fXso/9zJOxQPWfbTiL2KmXSFF4V3D/gBKQ+qko2d+8MokzMSj5
 I8jGEKBRW/e6SMn9zLbWVu47hEAB8o1IQJk3xjmpbxSkUR2f7d1ijlgLs1XqvZc+0zDLxFAKn
 FqSXwLhXqzQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:19 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 5615f69bc209 ("ARM: 9016/2: Initialize the mapping of KASan shadow
> memory") adds some nested ifdef's in ./arch/arm/mm/pgd.c, and follows the
> good practice to annotate the endif's with a comment to indicate the
> corresponding ifdef condition.
>
> One comment annotation refers to CONFIG_LPAE, whereas the config is
> actually called CONFIG_ARM_LPAE. That imprecision in a comment is probably
> tolerable for all human readers.
>
> However, the script ./scripts/checkkconfigsymbols.py, which checks the
> kernel tree for references to non-existing Kconfig symbols, identifies and
> reports that the reference to CONFIG_LPAE is invalid.
>
> The script ./scripts/checkkconfigsymbols.py has been quite useful to
> identify a number of bugs with Kconfig symbols and deserves to be executed
> and checked regularly.
>
> So, repair the comment to reduce the reports from this script and simplify
> to use this script, as new issues are easier to spot when the list of
> reports is shorter.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
