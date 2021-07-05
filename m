Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762403BC3D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhGEWMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGEWMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 18:12:17 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB5C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 15:09:39 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id z1so18620815ils.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4WozBVZzyk1lBEbGC2n9wCY9l6DjmuOhvC82QU50fjU=;
        b=T/cbkLTa3MFtB0QE2qgK09v0gl2juSpm5dmis6O2XeoblaAnil9r3xtnLQ8JZmbBfB
         1b75q2bnD4BNr/UUw4Y2u8HqbkVsB7erQ4lqsxp0XxcZful45i5tzHZtPl/DVrT8Klom
         pvmtY+JNYWsxoy1gLylLG0N9dKKRb0LcecO6X6bwv6aetBXD0LdH05T9/8N0JGPoA4p7
         lzb2IQX4/Vgnf+vbX4xi8K5vSK+yjkbgsZwBcim1mkx6+4cMLQfcgen+bPZLYmRDIIGw
         dagqN4ylrFO2QCKAjk42OOD+q5xEp3+YHY7giaJiiWHGoaWe0BPwJgs8RfXtIT6D4TOC
         z5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4WozBVZzyk1lBEbGC2n9wCY9l6DjmuOhvC82QU50fjU=;
        b=a6yaNwZg8iSMkJ3fG9PhY1u+y3UuA7tzmZoqyGms3aWCtyldBs0oABaFn5+lYA7Nwu
         YwH89WrSYKjPyrNXVlInhmP7JLK9owDGKpbcNQKPb7AdcEtSQHFfW2FZKVZVVDS7fuz9
         I+4Lnyb3963g66XUKwEjo16OOjhCBCK8ZV+VlHx+Bxr5p1sVS3HOaVpt8eZhzYZN+FYA
         Zm58Wc11XjJdy3cNScPPrOTJOF8iK3P8E5x4ZsNDgwXOOoY5TApGAT+y3Z7H2fnktMfQ
         BIBJ28JSvu8jmV8+UC4CqOjxIzaepRPjRjUFHCY3hGobPpZvzk9GFhZd766C0aw52OqB
         tEHg==
X-Gm-Message-State: AOAM531MQst8SQosRUQvNLVDSYeKHMl8g3pgxW2BdyaBD2gW6AG1MEg8
        VAjVw0znb+AKgQQqHTECbaM4aPucgehoPq6/fzRKBuEjRk/ulA==
X-Google-Smtp-Source: ABdhPJyxCLzqynZlK3774Z9LgHjwJZ6/7KaVyWzZ9gZ9OXmlwpCz5d2MEGCoZ4kB2GUJrwIg5biRRpLZDHKL9roaOp4=
X-Received: by 2002:a92:c7c7:: with SMTP id g7mr12503492ilk.216.1625522978274;
 Mon, 05 Jul 2021 15:09:38 -0700 (PDT)
MIME-Version: 1.0
From:   Sunip Mukherjee <sunipkmukherjee@gmail.com>
Date:   Mon, 5 Jul 2021 18:09:28 -0400
Message-ID: <CADLJR24hQya0MkJhdDAJ0KO4MG+Fj4tRU5dNrbNdD9DMG_gLHg@mail.gmail.com>
Subject: Char Driver for Silicon Labs Si446x Transceivers
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am very new to the kernel community; this is my first message in the
LKML so my apologies if I am doing things wrong.

I have been using an Si4463 transceiver for UHF communication with a
cubesat I developed. I could not find any code to control the
transceiver on Linux. The closest thing I could find was an AVR
implementation by Zak Kemble
(https://blog.zakkemble.net/si4463-radio-library-avr-arduino/).
I followed the API docs and rewrote the whole thing at first for
userland only (can be found here:
https://github.com/SPACE-HAUC/si446x_linux/releases/tag/v3.1), and
then I decided it would be a great learning opportunity for me to port
it to the kernel.

The kernel port has gone mostly smoothly. The transceiver communicates
with the host MCU over SPI, and requires a pin for RESET, and another
pin for IRQ.
I have implemented the driver to provide a char device (/dev/si446x#)
to the userland for open, read, write, poll and ioctl.
I had initially set up a pull request for the driver and the device
tree overlay to the Raspberry Pi kernel community. They have agreed to
accept the device tree overlay for the device, however the driver
needs to be included by the Linux Kernel community. I want to use this
opportunity to find some people who have access to a Si446x
transceiver and a Raspberry Pi, so that the code I have can be tested,
and if deemed worthy, included in the kernel tree.

My code is hosted here: https://github.com/sunipkmukherjee/silabs.git

Any suggestions/criticisms are welcome.

Thanks,

Sunip Mukherjee,
PhD Candidate,
University of Massachusetts, Lowell

Email: sunip_mukherjee@student.uml.edu | sunipkmukherjee@gmail.com
