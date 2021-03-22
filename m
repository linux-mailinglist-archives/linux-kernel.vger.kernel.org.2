Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038C33435E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 01:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCVAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 20:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCVANu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 20:13:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C0C061574;
        Sun, 21 Mar 2021 17:13:50 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hq27so18429939ejc.9;
        Sun, 21 Mar 2021 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2KNRfgbZd3TXnOKyTWrt+VJiQLIR6v7NDCEvKaim3hA=;
        b=L5ikW4dhAK4qmR7Rz+yFifRkQvaUoQt7YFQRwUV8iiZepYbWgLvMwLtLjOTzv8rmT3
         i/5lIN8g3rReuWUjawD7Ax+0UnVxin3Flr1fAMXmvvxwfnqc0GDuRF0wt5RmiEfyucsB
         lKriO2L8R3tp8BLADyvOxTYoEPfbVUE2N1MXVrSlTSibmx7E1eKqU5Qj5etkUNvUyoww
         7tbc6lPy03eClrRLlliVDbmA3SQcu/wUAJqaisTHakBwCDHVvWoNH0G2GuPyEm/c8878
         ZZkgf+LjV+Re0jRAeYjuA0dYJLpg5X/QPZcKgkyxVFcBZyXTFKWsI5WgaRLhEBkFLzBX
         5V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2KNRfgbZd3TXnOKyTWrt+VJiQLIR6v7NDCEvKaim3hA=;
        b=O2kjqzGo8HjGAaoOCMbOaje04DzNzgC1+/j5cCBXw71mE3oSWVn0l1EfwhpeRcKUVo
         xxV7cD9ot4soNQQ0QgHMMfWOjV1/cDQyA7AeD9NY0mqaRhK34NTBERaclCD3e+DWI3iW
         V1X6FJVyZXdteGrujQTBvbZzP8zJesrB/NsjNsCmkdCivOEV9B7C/6cd46CTvoKeIqB1
         dilzRilEC/fONFgNqytv85Cj8ECx6QlsbQKS8b1lrhlg5syLzjI0ALzHBWlz7S+Jb/ip
         dTFtizneZtH85CL2MxQUpSQw5Wb3Z8IUKIVRlhZZmoJIHpFVzSBT1Qvr8D5vA73cbSO4
         dwVw==
X-Gm-Message-State: AOAM531L9JfxxffDeIvX/8K5SPbccxFkJ8Jy8/qNzAezI1JnvO9lm3XC
        nqesSuQsYioo55fkxJe0WJgfvxfF+9/m+2mUaTzZEuFCtNb8fw==
X-Google-Smtp-Source: ABdhPJx78oLgDdi7xq3IDiLu4z0Z4stBNF8JOmWpizUBs61bN3cVAvXuUGcMy0OgtuAADDT6XnEMBcPxn6rfbyDyIiE=
X-Received: by 2002:a17:906:9bdb:: with SMTP id de27mr5529710ejc.459.1616372028797;
 Sun, 21 Mar 2021 17:13:48 -0700 (PDT)
MIME-Version: 1.0
From:   Joshua Abraham <j.abraham1776@gmail.com>
Date:   Sun, 21 Mar 2021 19:13:37 -0500
Message-ID: <CAMmOe3SaBn9+XzjhZC8QxmZnHQkvB0R=nV4NaRRyMRF6EfcvvA@mail.gmail.com>
Subject: drivers/char/rust_example fails to load
To:     ojeda@kernel.org, alex.gaynor@gmail.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am building Rust-for-Linux at commit
e9b9c0ef1e7040a3c3dc2232d5fd64999eba61a0 with "make CC=clang-11" and
the built kernel fails to load rust_example.ko with the following
error:

[ 1653.507602] module: rust_example: Unknown rela relocation: 9

Looking at elf.h shows this relocation is type GOTPCREL:
#define R_X86_64_GOTPCREL 9 /* 32 bit signed PC relative offset to GOT */

Sure enough rust_example.ko contains a few of these entries, and no
other kernel module does:
000000000a51 008800000009 R_X86_64_GOTPCREL 0000000000000000
_RNvXsb_NtCshGpAVYOtgW - 4
000000000f15  008700000009 R_X86_64_GOTPCREL 0000000000000000
_RNvXs2_NtNtNtCshGpAVY - 4
000000001307 005300000009 R_X86_64_GOTPCREL 0000000000000000
_RNvXs6_NtNtNtCshGpAVY - 4

I assume that this is an issue with my rust toolchain, however I'm
reporting it here since it might be helpful to update documentation or
(unlikely) add support for this relocation type in the kernel.

Host/environment info:
$ uname -a
Linux pop-os 5.8.0-7642-generic #47~1614007149~20.04~82fb226-Ubuntu
SMP Tue Feb 23 02:56:27 UTC
$ rustup show active-toolchain
nightly-x86_64-unknown-linux-gnu (default)
$ rustc --version
rustc 1.52.0-nightly (61edfd591 2021-03-20)
$ clang-11 --version
Ubuntu clang version 11.0.0-2~ubuntu20.04.1
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin


-- 
Respectfully,
Josh Abraham
