Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F526449BA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhKHSaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:30:13 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:45145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhKHSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:30:11 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MQMmF-1n5p7N11Q9-00MH2N for <linux-kernel@vger.kernel.org>; Mon, 08 Nov
 2021 19:27:24 +0100
Received: by mail-wm1-f47.google.com with SMTP id 133so13831456wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:27:24 -0800 (PST)
X-Gm-Message-State: AOAM5318KosHTd4csGNYbBZvtVPT+yGZctpshs48x4g6EG8t1tF9c8Qd
        jtXoYVUooex+pUas6NOfQDwtf89pikg3Z9V+vaA=
X-Google-Smtp-Source: ABdhPJwkTbO1R9kx/uKUQ7NwsrD32We6bxw6wl1kPg/VbQlHV5IqkF8wGtaAkNYTeA3NX09CM7zYMXfJ82gm+8Vr2jw=
X-Received: by 2002:a1c:2382:: with SMTP id j124mr323305wmj.35.1636396043838;
 Mon, 08 Nov 2021 10:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20211028134922.3965612-1-ralph.siemsen@linaro.org> <20211108181627.645638-1-ralph.siemsen@linaro.org>
In-Reply-To: <20211108181627.645638-1-ralph.siemsen@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Nov 2021 19:27:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a08uZecGy+YcpwGUuQNZ0sn_g1EpeCL6sz+L+H8Y97wSw@mail.gmail.com>
Message-ID: <CAK8P3a08uZecGy+YcpwGUuQNZ0sn_g1EpeCL6sz+L+H8Y97wSw@mail.gmail.com>
Subject: Re: [PATCH v2] nvmem: eeprom: at25: fix FRAM byte_len
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
        jiri.prchal@aksignal.cz, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:MIsbbUxSJe2uSQnnHvhe4y+H0Snci3wPs43JJHHbWz6VsWFpQ7C
 1owwtC+Dw8SXlvy002yVoDb7Y18GELTBSOzTER1Ys/I4Q4PCcshNhhBVHNbr5WZ/MskESkc
 gg1Nk+A+jFnXJ82fGk36j9psJAF2Vb9nMUPgqeWP3fqIIScciaSxz2wnPzad0ECT8GT7+pC
 I0QxRncYvYAkHqlYsNQAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DHJvi3YDY7w=:v19Je8oXwd5+h+nB3npXgI
 hynu1ERPUr3zp0hEKSkaVXuoe5KCjo6VPhBa7H+GJpQY690np8PQv/yU02m8vAaP+/5pexY8o
 EUWLv2CGUMOCgZvZfdFDXQ+CQ1yLznR5BzM+w4kBNZTCq82loHhe9JxzakF9UL1KV1oBBrdHq
 6oDeW5BNsjfQSDVoRo/ez75nCW/y0LMzWT9EkUD0kkUEX9nv+t7IRcrVgsbqHo0YpN+qqcVOY
 mBHNkqFwED5yiLvhem60r5hL4caUKpP4B30PvBwgIRDg5Ozdy21vHosCYbbp8URLArQEpxfDP
 NMfEBuU7TMBNGYbet6YD/TcSx9sGq2/V88VUq3c7EyejEKPJ0YQs2vxjzrgP8RRQI3UR/H7w/
 sQ2s7SA8H4VnwSMOkv64D6cThIV5gIPiVCqMq9yBY1KbI45zexbNHFzXkacG1F9bPNEKsLN3/
 iyT1A5izcInD1E5eRjZMhdZuLDACAP7KVwzxFC+w7g6k54+JxmgDXhZ1VAAEl/X2cXYU6Vk4g
 k8vURs83uh8BNjcCCvH/zeYdCiwUo9u9zIT8IAStohMrmQM8hCfBG7orw/G2n45x5ypcEtx4t
 EL/q/4vmlKVHxAewD+LePSq3IR1aINMa8b9DumigqMjU0Ig7vWIYDaoJmCS8pW18iJM/KD1WC
 MfDhWedKeIk+WHBq4AGQMJkkipbOQB6TyIYgR2dQRJLh3HrE3h6tPF0NY8Tr0/6muvjE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 7:16 PM Ralph Siemsen <ralph.siemsen@linaro.org> wrote:
>
> Commit fd307a4ad332 ("nvmem: prepare basics for FRAM support") added
> support for FRAM devices such as the Cypress FM25V. During testing, it
> was found that the FRAM detects properly, however reads and writes fail.
> Upon further investigation, two problem were found in at25_probe() routine.
>
> 1) In the case of an FRAM device without platform data, eg.
>        fram == true && spi->dev.platform_data == NULL
> the stack local variable "struct spi_eeprom chip" is not initialized
> fully, prior to being copied into at25->chip. The chip.flags field in
> particular can cause problems.
>
> 2) The byte_len of FRAM is computed from its ID register, and is stored
> into the stack local "struct spi_eeprom chip" structure. This happens
> after the same structure has been copied into at25->chip. As a result,
> at25->chip.byte_len does not contain the correct length of the device.
> In turn this can cause checks at beginning of at25_ee_read() to fail
> (or equally, it could allow reads beyond the end of the device length).
>
> Fix both of these issues by eliminating the on-stack struct spi_eeprom.
> Instead use the one inside at25_data structure, which starts of zeroed.
>
> Fixes: fd307a4ad332 ("nvmem: prepare basics for FRAM support")
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
