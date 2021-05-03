Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8DC372099
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhECTjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:39:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BBC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:38:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x7so6806923wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t/AEjsZE4NO5K2DLzzEEoapPRpudiJgSyBNJ3p+XGN8=;
        b=MEpg0yrTRzBlOtBm+yIZUmZHoWPamkR8QHjENRamuGK3Y0mGLjDpI+K3YGj9rRFAli
         eYj20PPXDURi0npbsmk0pepfzgbvw7/AZz2jgxef5fFyI4ibfyPp6emMZIrvSL4AuSv/
         DOcVuYjHqh7lYBJ7Nrmxin18pAlV9vZqIJH/3Ca1WIQqPG6l3+YJIoYWS2XqedG6mxup
         vMMlHzPke6gQ8GkuGxwHkhdSKseuxaZ2g0CNv81nKp9rOweJQeDMI9XfJZeBy06tWLZh
         yaFZxbX898YH5tUbaesTbuL1Yi7HWY+5J9S8Mdaxl9pROaAFAXFsLD00rd3uYvD631h7
         DYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t/AEjsZE4NO5K2DLzzEEoapPRpudiJgSyBNJ3p+XGN8=;
        b=eAcCp2veAK6yQaq5l5xDICjcRk/WsvHVdis8cRriS84D+COOwynf9Ejie8R5W8faj/
         baEZHVpwJW8ULHwb0/fXn6sdQhroY2LqFX+3pe9KrdfnHTf/ObHR36dNAMNVrkM307hl
         P3BWbHgMldILc+YRfzzJWnELWq6ADwgTct2pBGjf5ZE+kOIgQT9FpVCLlfRftraniXHk
         dt6V4DTsH38wY2HBrOSfRXlvKfh7JudGeJwIAdzA/wUsc9cz7+fllGotbBMrzpvuvc+B
         rhmAiT0oQwpWhfANb0obvuXXJzjSaBpodLKL/O0+OilCNJyXq9VAbcxWuQJeoptYXymj
         jXjA==
X-Gm-Message-State: AOAM532wmfyhwlqT+iB8f3q+4o9Id5DRsuc6E5JaXShMhxamA8i/IPe6
        74FFghIix71OLgcZtn9Cbsnn2FHM61xfMQ==
X-Google-Smtp-Source: ABdhPJxYunYu1cSEBM6t+XNecB7PppyiugIubIO5AajMay5gglvvyR2lqdGz1Zn9CvvO2N8AhAv2Sw==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr9502403wry.367.1620070695919;
        Mon, 03 May 2021 12:38:15 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:915c:8fda:c2d8:722c? (p200300ea8f384600915c8fdac2d8722c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:915c:8fda:c2d8:722c])
        by smtp.googlemail.com with ESMTPSA id l18sm13415221wrx.96.2021.05.03.12.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 12:38:15 -0700 (PDT)
To:     Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] x86/e820: Use pr_debug to avoid spamming dmesg log with
 debug messages
Message-ID: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
Date:   Mon, 3 May 2021 21:38:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e820 emits quite some debug messages to the dmesg log. Let's restrict
this to cases where the debug output is actually requested. Switch to
pr_debug() for this purpose and make sure by checking the return code
that pr_cont() is only called if applicable. This would currently fail
if dynamic debugging is enabled because dynamic_pr_debug() has no
return value. So let's change this first.

Heiner Kallweit (2):
  dyndbg: add pr_debug return value if dynamic debugging is enabled
  x86/e820: Use pr_debug to avoid spamming dmesg log with debug messages

 arch/x86/kernel/e820.c        | 27 ++++++++++++++++-----------
 include/linux/dynamic_debug.h | 14 +++++++++++---
 lib/dynamic_debug.c           |  7 +++++--
 3 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.31.1

