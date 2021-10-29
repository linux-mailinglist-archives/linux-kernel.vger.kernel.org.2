Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73BE43F702
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhJ2GNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 02:13:45 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhJ2GNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 02:13:44 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJnnV-1mMLPv3sQz-00K4cO; Fri, 29 Oct 2021 08:11:14 +0200
Received: by mail-wr1-f53.google.com with SMTP id r8so1656953wra.7;
        Thu, 28 Oct 2021 23:11:14 -0700 (PDT)
X-Gm-Message-State: AOAM531wqyIChk/sxuGZ66JwC5W8IUMBgJ81tRmI+FFZpVar+uOJI9pl
        FrQtcXk9lT6czsIthMHK58ySvdU5djpyfrKhKZA=
X-Google-Smtp-Source: ABdhPJwENl0lAWE/EeW7xF7c3aEbO+0aPjV25KNsBdVmMWadlEx46buYfEUwTdiI7NuHBxxiio4Gv7IDn9QC8meFjt0=
X-Received: by 2002:a05:6000:10cb:: with SMTP id b11mr241910wrx.71.1635487874204;
 Thu, 28 Oct 2021 23:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com>
 <20211028141938.3530-2-lukas.bulwahn@gmail.com> <CAK8P3a2UmTj2imJWdeLHX0TTV36Hk-Xx5c3j8cPe+Gk33-3Tyw@mail.gmail.com>
 <CAKXUXMzsEyqKs-OT6j3shTLY1pbS1z7O1GSn36+LxKRLQQPb+g@mail.gmail.com>
In-Reply-To: <CAKXUXMzsEyqKs-OT6j3shTLY1pbS1z7O1GSn36+LxKRLQQPb+g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Oct 2021 08:10:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Wd3Zq2-ufe9zfXrzSGOPe4mXNH+rTAnuL6sSTQF+EDA@mail.gmail.com>
Message-ID: <CAK8P3a3Wd3Zq2-ufe9zfXrzSGOPe4mXNH+rTAnuL6sSTQF+EDA@mail.gmail.com>
Subject: Re: [PATCH 01/13] arm: debug: remove obsolete debug code for DEBUG_ZTE_ZX
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2Mn50A+/PorcIdgwTtFLhB9qFqaocyL7d4CWoCl81uQCHhm+5ci
 Nz5VGxa4NvZ4buZtWl38Glf6IKczQuTgAqszGJ2TtsAIe09jwVWSO40jPI7KeYeowqBI6cR
 FNu5AQr9ICcv9sCUohj3Pob9PmSFjJUDFk6njGOCUDuUzTmZuPnmmVrS0zrgWRByt3pV8kw
 4+qaeEzJ2uOC42OHTgKoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U5UfpGl+df0=:4+Bg6MQ/6gVimUvDpwlA5L
 f7nLuW5+akQQam+yyxy7li6kpFKW2ykPqtIs/TjHv9vASpcrMo39BqdrhehyhyqsoAaEGxrF7
 8PyesT/VRRhFSLlq8U0BSEgSrE9sqoU0Mg+OydaPU5P6VUFVkI/ODJSRVRp+Uhf6flCdZDUMz
 /qKP8gyZZhchE/gC3luB2YAovbT8DkZ5kb6toV2yOqfb7m6JT1EZ2i7ItMCMUaBVyB9A9HHIZ
 7zqRKBsZcNdL8uZo6Cr4hgyfA2XZSfKchXwt9tS2/DEd5F8yhu8EVOR3IRsuDptHrjITQxdpl
 2CZM5G4diuFVqq3gO/FDWlYG9UyqDiPEChyYsz2pPQ4Ymrj4joP454hRXjY25Nq9TFo/PVvhZ
 zZipFrWP/VupeIUUyJoKxAj2EM5rH3vEKcaO0rQfIeFNluxehX6hz05M2YRxAxb2yQmmyuV33
 t25Tl/vBgfrO+V2R83yci/l4dV4iRh8jOxnr32Yneflb79e7d1wK4ZC4GoFchjkUKJ1iMq62y
 dWhWwZ1U6qLcy+3aEV6c5xaQ4fUdL7WCFAZbhjTd/K6MCJ8S8+GwSm8tr8unDkIXKeGESZrob
 sxBBzW4EmKBCRWr9s7TbidwXgLsulRo3QAGhqc5LioZkxoN7RXpxxtHMvpXsEUr5BXpX4LLeh
 E3+qg9fy4mFAkt74vDlzi40CHlvK4WzEBO3+kjeNqccgHuanqVKAc+c7JbZNeMZ6zGVXdy758
 fqHKX+4E+Y9+TcUuMhNcUavW4HH/bThwXbx98iJlQH9UAPIQHGbR6n2zq7+NRMO2MFQw7sEou
 l0LopkkdILju21vSWgbRmBwWpqKuT3V4Bx71toa0ofENFeXne0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 7:34 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> On Thu, Oct 28, 2021 at 4:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
>
> Arnd, did you have something like this---see below---for serial
> amba-pl011 in mind?
>
> Then, I would adjust the patch to remove all the zte_zx serial
> left-over in one commit.
>

Yes, looks good to me.

       Arnd
