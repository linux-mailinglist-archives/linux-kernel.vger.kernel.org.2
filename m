Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928993DDEFF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhHBSSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:18:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A1C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:18:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h13so9026219wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5UEHX1GPxXo0mX9O0yWJBVcub88a0F3dTrqasc3oC9M=;
        b=nrG9kyVip73alf3utgXb/9J/B5C0Hn4eBwPMbkS1azkK/eljVAl07hrtxETOeGu2Pt
         r8OoJ47QlZZ5Kuw3HaVawsygLefHksfxaoJvfQpRNf3a/fRO554sVvuuQYIr1hLXnf0Z
         nY3+aqvlMGCw8mxlAQP+S02Fq0ED73RDyvAC4+y4+EGQK5Gtrh1rIKtOuLgrU5Cv4y2w
         lmTLM2EoOFrAChMCG9s40Z1gweuTsdtgcv05RiWoCZ8BPswiZH67jg4p49xnC5j1CUjV
         uRBvdZIiUupg2f1Ezbh+InkhJosUwiDXRKUE5KqvH18tvXkl/dimw1CMRAnONYa2Cyn8
         wVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=5UEHX1GPxXo0mX9O0yWJBVcub88a0F3dTrqasc3oC9M=;
        b=uT998kRL1ccU2kW3PrXLJp7Bq29K8G7pAxuCIV6DToeXvh8B18MqCCh+JPPGhOJEEM
         6UooOBb1/Pv8kKdnQvgmADVhuj5S4dQPljQjotn32ui0cugXHS1UE2yVOkad6rB12vSJ
         rRFOKdb8fJUw7Yi8DxSvTeogjezfsDGqLZjPKDmEHD8Id8GftWbkFtt1gEepDQqgspxB
         AG3g8CQ7726nay9dmpgcvBD4GoY1F0KynSQm1Z0+T59dZnxgdIGWua0ls+sc9mZIys8V
         eUVI76jB7fi9+NvOrP/LkXXB8euDw9oMHyuZ5vH15DW5sKWx3zl2MuWf1DCr5e35uzrk
         k33g==
X-Gm-Message-State: AOAM531YVfLo7EWWrWqDbyRWr00QWA7NSIjRUYBzgw5Qo3M1SGSHvXL+
        Nq8OLlIOjAP9qUV7+/7WG0I/
X-Google-Smtp-Source: ABdhPJx9jITIgINkn6tqr7ffuE2X79x584EdbTUxiO/pNLFwBroNENulqBQp+YhIsI3lg1h+UZFIoQ==
X-Received: by 2002:a5d:4d85:: with SMTP id b5mr18670895wru.317.1627928281099;
        Mon, 02 Aug 2021 11:18:01 -0700 (PDT)
Received: from ?IPv6:2a02:8106:230:e200:3ecb:fd59:b1d1:461f? ([2a02:8106:230:e200:3ecb:fd59:b1d1:461f])
        by smtp.gmail.com with ESMTPSA id a16sm12251540wrx.7.2021.08.02.11.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 11:18:00 -0700 (PDT)
From:   Gabriel C <nix.or.die@googlemail.com>
X-Google-Original-From: Gabriel C <nix.or.die@gmail.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [pinctrl-amd] 5.14-rcX, d62bd5ce12d79bcd6a6c3e4381daa7375dc21158
 breaks poweroff/shutdown on ThinkPads
Message-ID: <8ee569d3-7fac-68c6-a1f7-f6457ce0343c@gmail.com>
Date:   Mon, 2 Aug 2021 20:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while doing S0ix testing on my P14s gen1 AMD I noticed the machine won't 
poweroff/shutdown anymore starting with 5.14-rc1,

it just reboots. The machine set to S3 in BIOS works as expected.

I have  confirmed the T14/T14s/X13 AMD gen1 models have the same problem 
so I've run a bisect.


crazy@ThinkPad-P14s:~/Work/kernel/git/linux$ git bisect log
git bisect start
# bad: [e73f0f0ee7541171d89f2e2491130c7771ba58d3] Linux 5.14-rc1
git bisect bad e73f0f0ee7541171d89f2e2491130c7771ba58d3
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect good 62fb9874f5da54fdb243003b386128037319b219
# good: [e058a84bfddc42ba356a2316f2cf1141974625c9] Merge tag 
'drm-next-2021-07-01' of git://anongit.freedesktop.org/drm/drm
git bisect good e058a84bfddc42ba356a2316f2cf1141974625c9
# bad: [eed0218e8cae9fcd186c30e9fcf5fe46a87e056e] Merge tag 
'char-misc-5.14-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect bad eed0218e8cae9fcd186c30e9fcf5fe46a87e056e
# bad: [bd31b9efbf549d9630bf2f269a3a56dcb29fcac1] Merge tag 'scsi-misc' 
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad bd31b9efbf549d9630bf2f269a3a56dcb29fcac1
# bad: [406254918b232db198ed60f5bf1f8b84d96bca00] Merge tag 
'perf-tools-for-v5.14-2021-07-01' of 
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
git bisect bad 406254918b232db198ed60f5bf1f8b84d96bca00
# good: [e04360a2ea01bf42aa639b65aad81f502e896c7f] Merge tag 'for-linus' 
of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect good e04360a2ea01bf42aa639b65aad81f502e896c7f
# good: [b869d5be0acf0e125e69adcffdca04000dc5b17c] ipc/util.c: use 
binary search for max_idx
git bisect good b869d5be0acf0e125e69adcffdca04000dc5b17c
# good: [6495e762522d4cf73d0b339830091799881eb025] perf dlfilter: Add 
attr() to perf_dlfilter_fns
git bisect good 6495e762522d4cf73d0b339830091799881eb025
# bad: [a32b344e6f4375c5bdc3e89d0997b7eae187a3b1] Merge tag 
'pinctrl-v5.14-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad a32b344e6f4375c5bdc3e89d0997b7eae187a3b1
# bad: [897120d41e7afd9da435cb00041a142aeeb53c07] pinctrl: mcp23s08: fix 
race condition in irq handler
git bisect bad 897120d41e7afd9da435cb00041a142aeeb53c07
# bad: [8b4c397d88d97d4fd9c3f3527aa66688b1a3387a] dt-bindings: pinctrl: 
mt65xx: add mt8365 SoC binding
git bisect bad 8b4c397d88d97d4fd9c3f3527aa66688b1a3387a
# bad: [ef9385fbf30e9484e4291db76e000b8961419782] pinctrl: iproc-gpio: 
Remove redundant error printing in iproc_gpio_probe()
git bisect bad ef9385fbf30e9484e4291db76e000b8961419782
# bad: [969ef42b1ae094da99b8acbf14864f94d37f6e58] pinctrl: qcom: 
spmi-mpp: Add compatible for pmi8994
git bisect bad 969ef42b1ae094da99b8acbf14864f94d37f6e58
# bad: [d62bd5ce12d79bcd6a6c3e4381daa7375dc21158] pinctrl: amd: 
Implement irq_set_wake
git bisect bad d62bd5ce12d79bcd6a6c3e4381daa7375dc21158
# good: [ac5f8197d15cf37d7ae37ff5b6438abe6c8509a6] dt-bindings: pinctrl: 
convert Broadcom Northstar to the json-schema
git bisect good ac5f8197d15cf37d7ae37ff5b6438abe6c8509a6
# first bad commit: [d62bd5ce12d79bcd6a6c3e4381daa7375dc21158] pinctrl: 
amd: Implement irq_set_wake


Reverting d62bd5ce12d79bcd6a6c3e4381daa7375dc21158 fixes the problem.


Best Regards,


Gabriel C.

