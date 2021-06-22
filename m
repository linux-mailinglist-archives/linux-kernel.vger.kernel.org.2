Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAC3AFFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFVI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:57:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:55:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ji1so27226333ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QNv8ctZHL3I0Bdx3jfIEMpEIo4PzBtM6ldvPOtODEsc=;
        b=Zlp6O7cHMai+Zxr953kkw/Q5oB73aktnr0pCVPE2jrHox9K/rha+/a33PjGASHV0Bo
         67baSeWKzP6XMjZAXFSLup+lRXOs2t+p2uV7tzKLNaELQcV2NvvLhrPz93p/pmJeZaZs
         CqGwgngsEb0EtnElgF/xA5tnkMIhhh2zJZNNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QNv8ctZHL3I0Bdx3jfIEMpEIo4PzBtM6ldvPOtODEsc=;
        b=T98f3hePnLVnhvPo1y7xGUc0zyxIdEpQI0+tsNo356QiWdP0vF7KquPl8H6Bw43XZt
         GzOu3jOm7PVGN2L6iR0PDxaQnjXtAY0qznW05tDdPv6uLq17m9HNN8BkhzIi34jCI7ut
         QoEkvWiPePw1Qjk2rzGwVYROwVGljsjXmXewk8nIB9Jy57CvjNfg4TFiABt/jftVXxIa
         xemUkkWK1RBG00hrMsYhfZnGbVP1EosMKPdwPPcpgOWloYzVK0QPSmYMalDodhYaLmgD
         kdNJvsbhF1wkkoWLDfO1lLe3qzeuGaptsQLmN9+a9w0Jsb3BCjwnLeYLVIWx/IdK/ezc
         H2MA==
X-Gm-Message-State: AOAM532+h+X6QNWZSqE11NL45n9mAgrAqIWGV/8AtNcmtZlYIq+NQYFN
        Ig8olMdPGzifHR7CJDEhIDfV9A==
X-Google-Smtp-Source: ABdhPJxBRq70yBv9Yg9ALotw2ABIGCn6WPamqtFqas0QX6t9fGtCxfyOXaWeblhAH9L5QWAaS0FPfA==
X-Received: by 2002:a17:907:2651:: with SMTP id ar17mr2852614ejc.135.1624352106079;
        Tue, 22 Jun 2021 01:55:06 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id o20sm11676602eds.20.2021.06.22.01.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 01:55:05 -0700 (PDT)
Subject: Re: [RFC 0/3] mtd: spi-nor: dealing with reused JEDEC id c22016
To:     linux-mtd@lists.infradead.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <590b0adb-612e-c20d-4c86-cb7dbb16d346@rasmusvillemoes.dk>
Date:   Tue, 22 Jun 2021 10:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2021 17.23, Rasmus Villemoes wrote:
> We use the Macronix chip mx25l3233f in a number of
> products.
> 
> Unfortunately, it has the same JEDEC id as another chip which is
> already listed in macronix_parts[]. Since that other one does not
> support SFDP, and its data sheet warns against issuing commands not
> explicitly listed, we can't just do RDSFDP anyway and decide that it's
> an mx25l3205d when the chip returns garbage.
> 
> For lack of better alternative, start allowing multiple entries with
> the same JEDEC id in the parts tables. That allows a correctly written
> device tree to specify the right chip, without being overruled by the
> "JEDEC knows better" heuristic, while being backwards-compatible (as
> long as new chips with recycled ids get added after the existing
> ones).
> 
> While a step forward, this isn't quite a complete solution for our case:
> 
> Some of our platforms are based on LS1021A, thus using the
> spi-fsl-qspi driver. Back in the 4.19 kernel, when the driver was
> fsl-quadspi, we couldn't get the flash recognized unless we
> monkey-patch-replaced the mx25l3205d entry with the mx25l3233f one
> (i.e. added the SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ bits) - we'd
> fail in spi_nor_select_read() because
> shared_hwcaps&SNOR_HWCAPS_READ_MASK would be empty. In contrast, with
> current master, the chip works with or without the third patch in this
> series, i.e. whether it is detected as a mx25l3205d or mx25l3233f. But
> the read performance is ~3 times worse than in our patched 4.19 - I
> haven't quite figured out why quad read doesn't seem to be used or
> work.

Sorry about that last part, that's a PEBKAC. Adding proper
spi-rx-bus-width = <4> properties to DT got the performance back to what
it used to be.

However, I still do need the flashes to be recognized as mx25l3233f and
not mx25l3205d.

Rasmus
