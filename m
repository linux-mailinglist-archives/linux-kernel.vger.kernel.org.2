Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD039A9C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhFCSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:07:34 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:42659 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhFCSHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:07:21 -0400
Received: by mail-ej1-f54.google.com with SMTP id k25so5062838eja.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIjnUup0fgTpkPJTNgSG1C2yDBMs88vtIhRdFjYP7Bo=;
        b=t/J6HJpZcpZ7zxkShGZfzuNfkH/skQFwTTRebMnkBIsJi02H9YZnYNhhHJUWt3Y8T8
         WtF+YORYUKVYVvZ9MGoBmOSohE975AEQwytonsdBZUwVk7rBsQ9g7et1XDPqWE5VhPW7
         AlOTGXVlLdmr5PKfV2yao1+Oxrw4F7v2s3sLdND6Mq0mQQw/Xf0QBrLa8Gii91huOocM
         6rVSQJt2z6ww9mF3J1lxHt4hzgUmiqgZnlMmrlgj9WZfRwePfF/ZrSVvZ2LdKlqFG1er
         23gcUWqOtYsWClf0mRH4qySYC7KIsHIyGCb6JctmdeF4Hic1eOEi7kr2iTJ9AlH4daqR
         3XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIjnUup0fgTpkPJTNgSG1C2yDBMs88vtIhRdFjYP7Bo=;
        b=iwAu1wRhg4zjiuMEOGbgqMaU/feS0Ouv6cHEzr37hpHqHI/Th/rrMVeviP/LnWXbI4
         2HXmEGOg7m1fZBBX1bmvKX8PNuNpR5SX9GRulGcUS8npqS/rtUjc/HhKHK59ycjUWtDB
         oZ7B6UQxLIOS3T22zkst/o0cuBtk1gttJ/uXGc2Z5/Hxvbs6u65JZVDs3DPalYQkmHvO
         splVWonR4KBFGvkYNAOYjuyzhzCCnU2TezC1JtJniRa+Q9hD+DOS3JVa9vZDB0swRN56
         BHPlbe8J03EMefj8IZepDDQOkN1bk0s/ruCs7/gYV2l4stilqT8+ujlxuzZHBWkHxgrF
         zHEA==
X-Gm-Message-State: AOAM533QT+/oeyUHXZkCoLR9JMhaOvGxvD21e4LRjdWpLLyrqOE/Wfu8
        RyYTzNffuJqTGCJ85GFceBLNxiR0wC643cXmjum7ufAIYxQ=
X-Google-Smtp-Source: ABdhPJxPV8nOuGlZXmpjesweUFqflrhPmA0OpgH6//7OIzGs+Zak25/4RAljycFyu4M3WFajeRaIJQWV8ZtG6Ku6y8o=
X-Received: by 2002:a17:906:2481:: with SMTP id e1mr571618ejb.216.1622743395578;
 Thu, 03 Jun 2021 11:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210601090140.261768-1-narmstrong@baylibre.com> <20210601090140.261768-2-narmstrong@baylibre.com>
In-Reply-To: <20210601090140.261768-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 3 Jun 2021 20:03:04 +0200
Message-ID: <CAFBinCDR+6p4kTysimUVHg+VsvLnESotkmi1EV3g2kMWBUPAKQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: meson-sm1-odroid: add missing enable gpio
 and supply for tf_io regulator
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 11:01 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> As described in the schematics of Odroid-C4 and Odroid-HC4, the TF_IO regulator
> is enabled by the GPIOE_2 GPIO and gets it's supply from VCC_5V.
>
> Fixes: 88d537bc92ca ("arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
