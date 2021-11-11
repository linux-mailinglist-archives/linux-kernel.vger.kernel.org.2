Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234E344D2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhKKIN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKKIN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:13:57 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8DC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:11:09 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n8so5181139plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=yNSirYkAL0GzOeAjCmF42Cxqbkg2RfYhpsxeeXtqLVI=;
        b=YxQDvo5yFc90CR2Yr4v8J29xpd60ACrQ7o30IImtbzT1jzNeHqQVFCPFwpw2FMLuht
         dSkjp1L9TqDDfqI6N0VtElMy/1G//L/a3FJWQ+DK2W7C1kBwxxTp9S5+yytxXja0AhNw
         ZdCvPN6DiZ0Z9+6MXG33v7mDxdqXSlimO9IAJ1Xz9edFHYwZ3LBAEn6MGXB5/cBu1Lac
         ao+FUaAJX8nbzUYrv6laNFtbBDBmE66KSMzU3n+KIT7HcP12ZOitjEaYgY16qp1i65g/
         n0qN4tJNjEpE8vDj3yMQhuvJwai6Qx/eJ68bi38AXE4MYakUKcW2zsl5QiHQZm450nvz
         0jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=yNSirYkAL0GzOeAjCmF42Cxqbkg2RfYhpsxeeXtqLVI=;
        b=Bv/1VNu96hbwldDt0JjrAh/rXtJhOFFjex3zRwHIpnQ1PbVW5Ypsxj8do+6atHWY+F
         0ANTSjOsyZDJl9IJHwzmAKGARzcmity4iYcDVtaAjBgFS872I530mg5TWt3QfcchcIFH
         24Xi04lG7a3V5mDQ2TBCLOdbXHXYBMTFA9NNXHH8WGMj6TEYLJIJFNIRZtEWW6A1sWpS
         89ctJJqecuN9WYrn4tDIE2PkRNwRUiN1pRf6SmD1KXfdpLoAyvcNEOn5EEK1wCD/luK2
         VXrgqEZOTyKq9busUzuqqY2NMmgIlJZE5AhPTml8ITTIq9j95AnznU+S4gSWQgRUS7BF
         Qo5Q==
X-Gm-Message-State: AOAM531Ip6+FvpAGT9ZcCCYQTayp860BlbViEfl8vg7aQDKm+zpEfisu
        Zh1JBYD38PEOCPiKBV8hb0Q=
X-Google-Smtp-Source: ABdhPJzTziz7Ws17oXahqJmAwC6rIUPyhjace0Jhpsp8QVUq7otmp8ktJ7zMefh5iXpKNc/Wrls+Lw==
X-Received: by 2002:a17:90a:bb03:: with SMTP id u3mr14361249pjr.85.1636618268175;
        Thu, 11 Nov 2021 00:11:08 -0800 (PST)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id h3sm7598574pjz.43.2021.11.11.00.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 00:11:07 -0800 (PST)
Message-ID: <6ebbb5e0-c2bc-89ce-2cb8-4f537c5aea13@gmail.com>
Date:   Thu, 11 Nov 2021 17:11:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Subject: [PATCH v2 0/1] __asm_copy_to-from_user: Reduce more byte_copy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I tried building the kernel on both starlight and unmatched successfully
with v2.

---
v1 -> v2:

Fixed the kernel panic when the page was not allocated for the address of
REG_L and REG_S.

The REG_L is loading the data from main memory to register and REG_S is
storing the data in register to main memory. In these functions for copying
between kernel and user space, the kernel will not automatically trap and
recover the page faults. Adding macro for them.


Akira Tsukamoto (1):
  riscv: __asm_copy_to-from_user: Improve using word copy if size is <
    9*SZREG

 arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

-- 
2.17.1
