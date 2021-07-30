Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED63DB99E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbhG3NvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhG3NvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:51:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A6C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:51:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a20so11228336plm.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Fg+J3oW692Mh3cj6C7vQfzGK/Q/IMQA26Bq+Duy+a4w=;
        b=VmcZG1GRWJrPQtzy+TCHvuVNPKTGa+BsqIntwj6ttKUN/bSbXgL70/Xodxa74Ma4p0
         rwxlQt0RRyaJZejJxeJi8BBKEbUuPiOrHslCY+HUINYp1SJ1iolaJkON0f5eGEMyYsC/
         9Le3jMLov9yMGz2bDatl71kjesThyRzy7wewQhjnsafaTOnUnYfbwd438/L0Nt4KgTZW
         4qC6zQI1wNFf7sWKkZnojJgg6pzBK8eaPLVoFKzn7plTdUfqYk/mAYEF6HOxS0z93kjj
         AFO9Vm2OULZA9T1QhehMkU7M6O8/p3OGEGYzj+dKxhpXYdHjwzpHkLvzGv3XAxEKXoR7
         cyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fg+J3oW692Mh3cj6C7vQfzGK/Q/IMQA26Bq+Duy+a4w=;
        b=j3lFpHmMjcmH63eWR9YRdu8y3vSJ7SJkogtdmYRj/jIumYOuxn4c56uKiRa5Q+hAig
         Gyel8OuQ6P3twpLJ3KAtJWOeIgmgZM+yNYNOCQYVDKlnCIaBSl8Dk31JAWz8fgeQ9GjV
         j2zfQp/DUaYGqZNZ6OGv/5me9g/eHe4bGxVoHnw2UabsFqoSjmdLqt+hfjvInggQd4xm
         q/AiR9H0wXkYbCfTEIbn/CGD0+aUfHHC3gjI1+VxUuKnDNl77hT+2IOqLrP1YEJ2GkW/
         CuMoBf63Qh17vQXg1dF9AQ3VHYs7OBolRdVy7I4c+ETNxT8hGZclBlgHzYi/8+yU33+v
         DUMQ==
X-Gm-Message-State: AOAM53236jzujDhllr5t1Kqk3qlRBW3usvSf+zneM15aXaLEXbuEjlao
        nbB0Yy4Iw/YGRzOkwtPGph+HaE8sZKxL6A==
X-Google-Smtp-Source: ABdhPJw0kB2BBs33d+TllZbOUWcOrwfM9KEon9kLTtG4TWSRM1Sy3r6nfGeaiiH6RDmPosurY61KYg==
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr3212973pjt.14.1627653059822;
        Fri, 30 Jul 2021 06:50:59 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id n5sm2534471pfv.29.2021.07.30.06.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:50:59 -0700 (PDT)
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Subject: [PATCH 0/1] __asm_copy_to-from_user: Reduce more byte_copy
Message-ID: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
Date:   Fri, 30 Jul 2021 22:50:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding none unrolling word_copy, which is used if the size is smaller
than 9*SZREG.

This patch is based on Palmer's past comment.
> My guess is that some workloads will want some smaller unrolling factors,

It will reduce the number of slow byte_copy being used when the 
size is small.

Have tested on qemu rv32, qemu rv64 and beaglev beta board.

In the future, I am planning to convert uaccess.S to inline assembly 
in .c file. Then it will be easier to optimize on both in-order core and
out-of-order core with #ifdef macro in c.

Akira Tsukamoto (1):
  riscv: __asm_copy_to-from_user: Improve using word copy if size <
    9*SZREG

 arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

-- 
2.17.1
