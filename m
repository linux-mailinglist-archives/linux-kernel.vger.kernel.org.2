Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0C32649A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhBZPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:20:57 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6C0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:20:17 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id cw15so3871450qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=P/8RMJyGWzscGfxMrmWB+AnrYYzGJxyd3TDU4Bp8pPY=;
        b=EBS5mZF1duUz/+S31JOxdd1Oeev+oc78O9x4DGLMUvML0l2W4zF12X8VeVd0yaCkBM
         BEAn1gMnB+b6uqpThXnUFEe9RwrBmKIChHueyazRZNpbgaMNDEmmPAkHtd1Oy3+4FVO2
         U/UH+lqjzGhsi2o8WJT6EUv+xkYdr8rFT2yEI8XtDRzFG0hYmO2G++zSvJBgaT85l0Hk
         0GJLOnOgK8+itu/h8txsbcD+9ASoI7ITKAhBW3DRZNxRua9sIjUshUmoWjQnmcfnJznf
         rEU0rqY0litQa65FH52mXb5XLi1xV2OA9e5lc99DXYefnreSMeL50IiSOQnKKKlEG9Qb
         t0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=P/8RMJyGWzscGfxMrmWB+AnrYYzGJxyd3TDU4Bp8pPY=;
        b=ndAlAak/q9gz2Pr+IsGjEKCNZjruJw3If1RCwpMCPjgkjyCVjfKDd1K253B1WTr5wH
         /8MgWepaB08fpf/WT13Ifvwcbm8C8IA3iFVi3tDdkg9s/p8l3RVhgJ9Y+An0HG5djETu
         xqedZNglQoxl7iAOITSZjuwPtBM7ZbCseAKqa3k6fQ+Ui1BJJSEMO854rF6HxZQScNrh
         b5TRZM9xKUnVpbKjRHDa1dAA04NgqKTFVAfUYy0Y5D8BFU27Bn92v/A83azF24q5XGkj
         Hrr4aZmGtXoLUzoBvc3FKsVhq5kiCNh3TZkuqVAl4ketvquVhEdi90duueIayq66/xU/
         4RZA==
X-Gm-Message-State: AOAM533Q0qo32ahQ3FwDGDpr1mJdtkFqWhdZRKr9qeWwe4Krj9uhfl80
        Ou35TnKLFhQH3Cfralee9Xr0ZVJRv936oQ==
X-Google-Smtp-Source: ABdhPJzT8/scoNcvl4n3rGgyELMGhJxNgva824zfu1CseVgkn0j9BXC+QOD2lnKL2+iIS6IwpoVlMg==
X-Received: by 2002:a05:6214:1c47:: with SMTP id if7mr3236889qvb.50.1614352810070;
        Fri, 26 Feb 2021 07:20:10 -0800 (PST)
Received: from [10.1.1.149] (pool-71-179-59-207.bltmmd.fios.verizon.net. [71.179.59.207])
        by smtp.gmail.com with UTF8SMTPSA id v35sm749258qtb.20.2021.02.26.07.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 07:20:09 -0800 (PST)
Message-ID: <8a037d87-5ace-36af-29eb-77a4f8c6df98@gmail.com>
Date:   Fri, 26 Feb 2021 10:20:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
From:   hanasaki-gmail <hanasaki@gmail.com>
Subject: linux kernel 5.10.x to 5.11.x : boot FB switch VT is black after EFI
 VGA FB changed to CPU FB
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@vger.kernel.org

previous kernel 5.10...

current kernel 5.11.4

After moving to 5.11, can no longer switch to VT's.  The boot sequence 
shows as far as

fb0: switching to inteldrmfb from EFI VGA

...

Console: switching to colour dummy device 80x25

and then goes black and unresponsive.  the ^Alt-VT# keys do switch 
between X and the VT except the VT is black and unresponsive.  Booting 
to recovery mode, or just the console (uninstalled X) gets to the same 
"it appears to hang" point, although it may just be an unresponsive FB.



