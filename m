Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6043E026E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhHDNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:51:17 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38759 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbhHDNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:51:16 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MoOpq-1mvLZO0uSG-00oobu; Wed, 04 Aug 2021 15:51:02 +0200
Received: by mail-wm1-f51.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso4020518wms.0;
        Wed, 04 Aug 2021 06:51:02 -0700 (PDT)
X-Gm-Message-State: AOAM530PmxCTTuHVC5UOsZvTJr2nLKlZ7fb2w0Bm4285dO1wUGlty/1U
        Ti5ajmsX8Oydl87DQ4WhML2irZoQf0sI5wc/15g=
X-Google-Smtp-Source: ABdhPJyNFXrQChPOLZS9aAXYYL1omRQ7dj4KugUgr5B6iGIyUO+NAtViqzCeM3ydmA0f6eM1ScWfqCiaf+g9Xa3Yeew=
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr9756314wmm.120.1628085061870;
 Wed, 04 Aug 2021 06:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210803124506.23365-1-patrice.chotard@foss.st.com>
In-Reply-To: <20210803124506.23365-1-patrice.chotard@foss.st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Aug 2021 15:50:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a06_vUXghtvp4jTMEc4jV7RW8XmbUmgfrsoH_BSZ+awJQ@mail.gmail.com>
Message-ID: <CAK8P3a06_vUXghtvp4jTMEc4jV7RW8XmbUmgfrsoH_BSZ+awJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: dts: sti: remove clk_ignore_unused from bootargs
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:frLBf9x2o+kfql5pBavIFUHAETAwWb6nqbcy6V7fNiVPrxPBsg1
 IR4m9kE5pWzO+yewKxCSgIGeOub/b9c0lKhq99/Vw0GjjNkyguvnBEjPmyeZ4OcuCWG8fUF
 qmjfQrSPHuzt96p8746sPy2zSCJTbGhrJ6lzsXWSZgKX4cn0E2Kr5qtzB5YKgXOlTcPZsxJ
 NjPqtZ07Z/tOHXHTNlyOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JQiVNUwaNE8=:7GSQo8ZXcJEaSmeZx/DDhV
 5f3ugmUyuQCbo6ByX5st7NSm+TXad/a/x1gtK7mTnV/EgrK5U/O3iyeFnZjXGZA6VfdvTCjeh
 9YRqLqI1ma/P3OPcvw+JcVrlzJ+nx+Isg0k4YU3WuQViBhUY8c0Y5+t6wtotGAqJ5BwfCpYja
 AszS2/NNM8ZhxV7EvDRL+KK/7RRkuVyWTXTz+0s1uWau4iI4TgC/k2S93kPQs1mpd3Udxc7i5
 vVA7f2wzXs1i9JWYJIclR0+hUtIVBO1LeaV474Q/uIiyMHUzoPHBX/vdCEOJ5tjm9aNyqJ9un
 lciCckAffyh26IBEh7Ofkm6Ew7A7/BqtZDzJLN+4faquMLedLpusen74zYrAJ5TIHJ69c6o9A
 OOIGu5kBugCXzdfVacUMDnMnG2nNCLMQv2Hjsd707z7sSiwLgkG9V9GbxpW8S6ZvqF+/NbzqT
 7t3oxZzxz4XioPtMmgB2O/QJEG3rrrRO2onnnOB2xtJIpojIB65pCcX/aclBIlVqdwHi1hxX2
 oBzlPEvwOIhNteX7viASDndQ+jlZn3I9iqwmqyo3lTtn1wL7G3c2GaTjnK+7IQpcAJm57BKU7
 UMSUiwys8d3SYnyAiASeabvvrwcf2MkLcgCzaUfv4ZVrvwyDnltes/o35/nO2aqorCwVRL0la
 h+N5532m+j7qhJEgDraWslv4T9riW/PmmgspBqFM080zBkvDfwratHG1x+FxynJlpHJRRWkrw
 sOJCmrm0i775V+QqKuh7Mi+Yo3FKJn0zzUIuPM+A2yKe2NC+V892+MjkeoiT8hHskq5HmQCdS
 6EAKcCd+snRPOAOeWNZkcMajmt+bP/f1+HXNMc97SdeD6W7zghSikg2Mz/DqT8aRP/APr5J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 2:45 PM <patrice.chotard@foss.st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>
> Remove clk_ignore_unused from bootargs from STi boards DT.

The patches look good to me, but I'm not sure what you expect me to do
here, as you have added soc@kernel.org to Cc:, and other addresses to To:

I have dropped them from patchwork for the moment. When you want
them to be applied to the soc tree, please resend or send a pull request
to:soc@kernel.org, until then, please leave out that address so it does
not get into patchwork.

      Arnd
