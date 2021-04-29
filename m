Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8736E8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhD2K1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbhD2K1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:27:45 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9BC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:26:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r9so99086997ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yZo3c4iu2EX6TZmHWmdN/bchUwVgQC/t8mPnGi2lY+8=;
        b=asYj199e4vh8FlavBAH5k/G94BzWi//apRwryigJKVoeihByxxXc4AjDn3EIiuZs2a
         nPoiJXuZbTdj3YTzhnz856Pt+Xi7bE4XYXDakSyk1+Ai23+xCV6mH2+ngMp1AlSNW4r3
         8RPIlywJUWffgdM3U3R+L0x+lmB8h7+lvdHGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yZo3c4iu2EX6TZmHWmdN/bchUwVgQC/t8mPnGi2lY+8=;
        b=S3uxynAauD1CthPIpDCr6Tjx1VYeAwHcHEEw930qkVXeddk09vTmDFDgiHs5lRng02
         e/6YAKR48eOCBGbrdhhBVgwVgpeOkxFFadiHoMiDCouszy7so7+DlydR3t1xM0Jog3gY
         tzBMwizoPAHTWqqKslIKz8XtunupcUZv//c3Jdm9lbwucO4Q5/klt5OSy6U6+iCjcuIE
         8dEAe7IwJlwqiqVoT0KcZrsAXn8FSeDDWP+uxRPiZ9o1hWe58q+hh8xY33fccHTEfdd8
         6HlACOagYNv7WE/Dy5L+cmC8b+vja0peh4OdAd5D3+D3JzXlQ9JIc9DU7st05EfjFizy
         +4bw==
X-Gm-Message-State: AOAM530rXWuoi/5cKBIuyix4m8vdQEqNXy8PlRCqS/2368rflXkqm3pz
        lsbFtOPGhdJ9wtKyJ8LR5ov9TOKyPWBhZabC
X-Google-Smtp-Source: ABdhPJwTKmFNhcFlZ7zQTvxygaEsN+FUHDo/AoBXmroxGUTHNxHhDFLZZwHclU+Z/kdIKxzm7trtXw==
X-Received: by 2002:a17:906:b28e:: with SMTP id q14mr25743067ejz.528.1619692015592;
        Thu, 29 Apr 2021 03:26:55 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id kx3sm1533659ejc.44.2021.04.29.03.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 03:26:55 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RFC: collection of common distro configs?
Message-ID: <a7fac800-02ae-62d4-00d4-770facff4a7c@rasmusvillemoes.dk>
Date:   Thu, 29 Apr 2021 12:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Does anybody know of a place where one can find a collection of .configs
from various distros? I think it might be useful to be able to grep
around to see what features are actually enabled by which distros.

Based on the domain name, I hoped linuxconfig.org would be such a place,
if so I cannot find it.

If no such collection exists, do others agree it might be useful? If so,
I'll be happy to throw up a repo somewhere and start collecting them.

Thanks,
Rasmus
