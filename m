Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208FD30B907
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBBH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:57:56 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:43336 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBBH5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:57:54 -0500
Received: by mail-vs1-f49.google.com with SMTP id h11so10637260vsa.10;
        Mon, 01 Feb 2021 23:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0lZHuXu7pWNvv2BjdvH63uklWmKRl14BRUiRfYGOh0=;
        b=BjWc7UBX9cAhfhJg04y/rStYLn4DYHx3uo+fnTq5cS2zVYCj/mewE4apdBLrBYqm3p
         h5iFKkpeEYYwXaUIxmosnPiDPpi9G8l9wRJFyogArBHd8qSRBg1kYVqoPtNQlyxv56t9
         cXRabRGQgbz9WGiny4M1s9H0uREmjbcCUXy+rP5BsErXdX6Y5wjxStJs6ylPxQqy9LWg
         E7c9Lsv5DpMUmp9NtQlmO78UBkf/Hp3VoNI8SJy4pD/T0OlUnoUBnyZMbilK1hZil6bM
         ApP7xmWzv6QJqmG3xQ0tsqD63f9ZpIPdqNE8tsszcBR8caqco0TaAusMYdcmrsFGrqMK
         OyLg==
X-Gm-Message-State: AOAM531mvPk3NHoc36LE1+vhf6n9jswRDE4yNJppxtxSXt/m85mtn1Ws
        CuGireedhK/p5uf7gmrZzAjoD7AVll1wWg==
X-Google-Smtp-Source: ABdhPJz2alyk3kIW6tVwzoFxztK3sjDN82aEkf5YNJVr9GpkqT+fq5DcMpY+F2ReKoumCznpk96euA==
X-Received: by 2002:a67:f9c8:: with SMTP id c8mr11412770vsq.47.1612252633013;
        Mon, 01 Feb 2021 23:57:13 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id d200sm2429541vkd.54.2021.02.01.23.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 23:57:12 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id g5so6821840uak.10;
        Mon, 01 Feb 2021 23:57:11 -0800 (PST)
X-Received: by 2002:ab0:6496:: with SMTP id p22mr492388uam.23.1612252631684;
 Mon, 01 Feb 2021 23:57:11 -0800 (PST)
MIME-Version: 1.0
References: <20210127172500.13356-1-andre.przywara@arm.com> <20210127172500.13356-15-andre.przywara@arm.com>
In-Reply-To: <20210127172500.13356-15-andre.przywara@arm.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 2 Feb 2021 15:57:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v64p_NBVOBE1dsFXR3OOxZv21zaV5MUMRSJ35JQS9DFFqA@mail.gmail.com>
Message-ID: <CAGb2v64p_NBVOBE1dsFXR3OOxZv21zaV5MUMRSJ35JQS9DFFqA@mail.gmail.com>
Subject: Re: [PATCH v5 14/20] dt-bindings: bus: rsb: Add H616 compatible string
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 1:26 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> Add the obvious compatible name to the existing RSB binding, and pair
> it with the existing A23 fallback compatible string, as the devices are
> compatible.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
