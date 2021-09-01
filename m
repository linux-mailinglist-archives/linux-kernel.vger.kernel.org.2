Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66553FE39A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbhIAUUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhIAUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:20:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E4BC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 13:19:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m21so823615qkm.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iDwVaPK9X9X7QqzlEWrxBrm4lRKmxDVWpkSHqBeXa6Q=;
        b=jb6vhiVbOjJj3RHow243t+jTzPnCGOtF1VUzxd+TY3SQLlY5yUtFL/+JWFWNjmoSaI
         r/1kcAwSP20TYzCHqIPofu02SV+6X1o96IZAcV4ySBuEtDqNPvBtd7woi2oWcPZvV7Jm
         3FxpoYzzrNVUn1E/N17S6loynm1JTrSa/j0HjSkMwItFCw0iR3/4go3v/ULTzcv7Mh95
         qKMYL3DxPb3M0unAGxe5cBW9yOtDMVYISOGbQKXIuyee90RnYkRCKzfIX4Uj5xJElK7y
         hNpxj7LQ6svkOT4Is9Y3vbru8IP/7Y1j0YG+s3PU20ufXINCLQ7QGoCTsy0lSH0D0vDN
         aMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iDwVaPK9X9X7QqzlEWrxBrm4lRKmxDVWpkSHqBeXa6Q=;
        b=IlhVeFwz7S4foeXXtf/y8gV2tWjy/aeiKFQnbG21YIP00xJIJpogR35NoG5m6Tm1rS
         OIBwtGRU/7/mMpH6kv4w849HVeBlvUvF7UQyj6WnUsVQsYIV+BV9Fgy/X/AW2wVlLfPt
         Ro7hxWd6xJjKlrJgP68kPrbdD5aJW6fDDYR3zwNZLG298zvwv09afYGsntsDJoL79V4s
         PVKuHhZeI1wa0a0ehTPhcYl8cNxCK292+qIW+Rwj901usRgbb+6mMPvYawgTC7BFVRxF
         uW9WfJA+My2pO2Obm6V023YXo2n1jzfxPJruUgz+m1TcMp+QMB4i+f7tWzJyw79Z0Buk
         porQ==
X-Gm-Message-State: AOAM5321N2GP3mBgA+xMTC6kVUSAa5e5oEgwrZG+x3FBVdcPj/1ty/yR
        Lvg3cmH9QYqltqxqOVLi2+ADklzgXKd1EQ==
X-Google-Smtp-Source: ABdhPJzvpjXETWwxlLwjFzzhQrEHOCRNK3UAY3FTqH8Sn4TtHSDf77Aabons5yT0/ngs+sKTkxi/ig==
X-Received: by 2002:a05:620a:b0f:: with SMTP id t15mr1470344qkg.352.1630527547450;
        Wed, 01 Sep 2021 13:19:07 -0700 (PDT)
Received: from [192.168.15.5] ([186.204.255.226])
        by smtp.gmail.com with ESMTPSA id 191sm472080qkh.81.2021.09.01.13.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 13:19:07 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Subject: VKMS: New plane formats
To:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <d1ceaa32-e143-8d3c-4bfb-7b31673cc76c@gmail.com>
Date:   Wed, 1 Sep 2021 17:19:03 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working to add new plane formats to vkms. But I don't know what 
should be the behavior in the situation that we received multiple planes 
with different formats from the users-space.

For example, if the user chooses:
- DRM_FORMAT_ARGB16161616 to the primary plane
- DRM_FORMAT_ARGB8888 to the cursor
- DRM_FORMAT_YUV42 to the overlay

What should be the output format that will be used to calculate the crc? 
DRM_FORMAT_ARGB16161616?

My idea was to convert all the planes to the primary, but I'm not sure 
if it is the right approach.

Best regards,
---
Igor M. A. Torrente
