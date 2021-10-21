Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0361243665C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhJUPgq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Oct 2021 11:36:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:36:45 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1x2P-1moGOA0wzx-012KP9; Thu, 21 Oct 2021 17:34:27 +0200
Received: by mail-wm1-f49.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so173819wme.0;
        Thu, 21 Oct 2021 08:34:27 -0700 (PDT)
X-Gm-Message-State: AOAM530w8UKJ/B+CltoUIV2kgLA8PlsL+Bjs374a3lsqTYbUQm1jya3n
        KrMkPxyMMckMLr3VZ0kWs45Q/+/wq0xqwBu0y3k=
X-Google-Smtp-Source: ABdhPJxXncWjnG0sJW6NQ2Y9XBmC9AcHboOLxbofUUlK3ALWGyEu4Nd9mK94PrbsNQQGlWRLZDhWj2rD2O1jkn6ZwhY=
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr21988450wmq.82.1634830466894;
 Thu, 21 Oct 2021 08:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211021151736.2096926-1-pan@semihalf.com> <20211021151736.2096926-2-pan@semihalf.com>
In-Reply-To: <20211021151736.2096926-2-pan@semihalf.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Oct 2021 17:34:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1i_23yBht0f86GoHUeef+XXPg_ahkMy6ndARHqcrhKWA@mail.gmail.com>
Message-ID: <CAK8P3a1i_23yBht0f86GoHUeef+XXPg_ahkMy6ndARHqcrhKWA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] dts: socfpga: Add Mercury+ AA1 devicetree
To:     =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        upstream@semihalf.com, Marcin Wojtas <mw@semihalf.com>,
        Konrad Adamczyk <ka@semihalf.com>,
        Jacek Majkowski <jam@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Alexandru Stan <amstan@google.com>,
        Joanna Brozek <jbrozek@antmicro.com>,
        Mariusz Glebocki <mglebocki@antmicro.com>,
        Tomasz Gorochowik <tgorochowik@antmicro.com>,
        Maciej Mikunda <mmikunda@antmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:cR51spLlB3Iw6O8Jegs6c+QUcGBJa0vPdLFRDNkM2/MxKghw70w
 bi0Avk+M/swyexM+K9901nInoj1wn230vn/ZTZUKjXegRfRQHYAwIJhH4qHBpkCVDULhRBS
 4qmoKcTznJmNH1nmBGRg8RIC7ezwE8z+dxCvHLXgcx5YeHeXD7urpnqDiA3RVP8Xik85XUn
 8L+0dMwFPD/yIEBntr5GA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wq6BAPyNOws=:YrWqV9tZHyr9SlSvSLJM2z
 Z0YWP3Zl0jNQ8yVmXTo7FUu13sjh6z8nm3gvarU6KHIPmlHC5WWJ/Ze91+jTeB3P7Qn6sdPme
 ntjAUJAdzKNM79kYdHL3XKhEpgMoE/W0E6OQy8xab/MeVpQTuAgaamtrnIETVAu2HQZbTA6Oq
 50oVF1qXJKqm1l6gc9dSx6JrAceWTkV8dPlQ/Egx/VUBlj54GSeuDjIiRPu5Z9RGEPNde03LT
 8JaHOBdYDuxIQObvAHFW53eQctS7G3MYJZsPKcOBd8aumQjTtsQi0RwW6n+mOzUdotVigEdb3
 jrH3QKHR2lcQaE1pXceL3LFvNMBv+N9a9u/AeFf0Ke89bf7D1W2q8hyxmBu1kmxwik3QWRk+B
 Hk86qu8f4kwXvbvoqFkizU9KTGtv1cPodwxi1ZHqmIDJ/cO7RKcqP6LwERmKeyhZuqlqbCNGN
 9giEdi3KJjnH1Oj6hcLxw739P+mxCC68BfY3D/k+p9UD6P9eQdWSmArYrBgUM+8M1TpFsM342
 shz3PbY8scC+FlsrBSheXzGSiUakNv6TVs8TpcggJ/E5YvX4J7yuP4nzniEOlRl//A7ccCPzG
 LHEHahW9DVopqLMJU214TkF6kOLJHgAlYIiDUOS5WwAAFG7O1+ik4UNdoQrGAioSDB35LA6fZ
 2ig+qvOe0Pljii5bKN4krZiO5cxBbVDmWFu8qLl9G3qriXjIkuHlJALWH1GyowqNnktMD3TJY
 irbgmJ0fEPbv1bbdlh1Pn5rKA4ftBvtwrvMYvavNYf2w3hH/daeN7Kwk9r8N6K9vZgl01P8kz
 KyhxUB3cvFwnBTEFJ9yLTi/P0D//9gV8h7Qr1uYRld8aPuzaoE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 5:17 PM Paweł Anikiel <pan@semihalf.com> wrote:
>
> Add support for the Mercury+ AA1 module for Arria 10 SoC FPGA.
>
> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
> Signed-off-by: Joanna Brozek <jbrozek@antmicro.com>
> Signed-off-by: Mariusz Glebocki <mglebocki@antmicro.com>
> Signed-off-by: Tomasz Gorochowik <tgorochowik@antmicro.com>
> Signed-off-by: Maciej Mikunda <mmikunda@antmicro.com>

Thank you for the respin, looks good to me now.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Dinh, are you planning to pick this up into your socfpga tree, or
should I apply it directly to the soc tree this time?

        Arnd
