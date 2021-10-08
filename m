Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA3F426209
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 03:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhJHBbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 21:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJHBbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 21:31:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E954C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 18:29:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m14so6810563pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 18:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WtHRg9pE0seuBB0ZG+GOfqW0Lt5umZXuKqLtBMykH80=;
        b=Py38WVG6evZxTgbhtQhoj3yPWvrjQoA0BU1h9uNK/hr9cl8RFxQWrKLw34xpnThEG0
         klI6GH7xt/dyjOl6vKJ/+uqNoFRQR5VTBhfce7zL1CDLMYkkRxn7vKyJ5G2OarXIonGN
         SrMTwr87YxIkSK4U4VGIDb71ve5wWtv+axm0rWWkoKWR9BHWRH7s+t5TSM1igiXofeZf
         8ECbHfYgLFSW2Hfkj+oN3qycwBORzeS0lX1ZCp62xxNkBqA81K/nfF9c6WEdlRwp9iJh
         gsrCmt3+SVk4BlntQ1rjigO5ZiyDUCTj1MwehB5lPZvAzDzuWHJyTY3iuVQwmKVRpSff
         UGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WtHRg9pE0seuBB0ZG+GOfqW0Lt5umZXuKqLtBMykH80=;
        b=hiClGWV7pwSAKsWwnFFccbNV0ALxSjPoqBkOCCFi4+L16l1930Iu0SdboqzDNLtidN
         Sm8etcku9X1xJah8BqtjE4zI5IgqYQqyA9yMazMYQUjLoDWSaPABdJZPThsSMLDjqJTA
         glyTzEa/FrMDAlv4whSiimoryCBsrOj3HD2IdreSgAMwO2DRxNoae7ZMB1Ev5zEvLYhL
         9/zfbYvmZzcKeUeKL/uhcWh5e37Mn3pag83hHB2f2ye/YPPet/4B1wteCuU4URM78E2d
         H14awCtvR59BZnur194/WSsLLU7RJjRt63ifwj8HxnGCjw/Y6lnuPfRSXWHxNOEiRDaR
         U26A==
X-Gm-Message-State: AOAM531R+gQOr97H5qKMVTiWQWZt7Gb6T4xwgat/MLvjp3wuqXgxxowQ
        OY41kriaf4XT6w/sQ8EMQtU0Ng==
X-Google-Smtp-Source: ABdhPJxKIyBEk/ExdyYLGRv9pO7zazoYAulMHHBsViB3AH1uRol820KvNN1onfoc9AFMNMN5/tyBjA==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr2349033pgj.263.1633656557550;
        Thu, 07 Oct 2021 18:29:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g10sm582784pfv.109.2021.10.07.18.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 18:29:17 -0700 (PDT)
Date:   Thu, 07 Oct 2021 18:29:17 -0700 (PDT)
X-Google-Original-Date: Thu, 07 Oct 2021 18:28:59 PDT (-0700)
Subject:     Re: [PATCH] dt-bindings: clock: fu740-prci: add reset-cells
In-Reply-To: <YUyydGrDNzISu6JX@robh.at.kernel.org>
CC:     krzysztof.kozlowski@canonical.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, Paul Walmsley <paul.walmsley@sifive.com>,
        sboyd@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@canonical.com, robh@kernel.org
Message-ID: <mhng-b9e6d8f9-b9be-4651-9649-3378d227eae1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 09:59:32 PDT (-0700), robh@kernel.org wrote:
> On Mon, 20 Sep 2021 16:49:44 +0200, Krzysztof Kozlowski wrote:
>> The SiFive FU740 Power Reset Clock Interrupt Controller is a reset line
>> provider so add respective reset-cells property to fix:
>>
>>   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml: clock-controller@10000000:
>>     '#reset-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../devicetree/bindings/clock/sifive/fu740-prci.yaml          | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

For some reason I thought these went through your tree, LMK if you were 
planning on having me take it through mine.

Thanks!
