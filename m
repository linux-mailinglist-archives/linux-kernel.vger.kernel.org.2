Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9533E88D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhHKDe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhHKDeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:34:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7946C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:34:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bo18so1355788pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=m6CXaNqtRLHnClh51em5VXaRltlyHBjfVA0SbTkGniM=;
        b=jad795R/giqx2OsIdRjkwKtgm0giTnxaDbCT3VT9yFTfUP/k3gLoHwlLyPXz6OVbhg
         OLzqxquD1JK2WMEMi+Vh5rTN2MO7wNDBiAmY+Alo2XLsh9rJ7iS6UKQkgUguSYo3yRKp
         HS2uVGAF9LSmYjEnMLCVQd1VeeOktb116TYYrgkZdXHaZDapNqXtcxJRgXJdCQBPo7qN
         TvueySgj81xZ5iPHJseIM6tpaFH/LopvFkTlf6yHIr44+XoI8oBTpHaY8UThu6r+Aewz
         C7jh4bFm+DMedm7ocGOe7zfiq17fNZpvU+f8eHEt6zmsmLClP7JmSkkau5v1xEavRqlh
         v0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=m6CXaNqtRLHnClh51em5VXaRltlyHBjfVA0SbTkGniM=;
        b=JyCIvOcnIGf8QFCWbQrGjoxysrvF0lKMTfEAKzFnp9R5eMI22YTzu5x6Lh2XRUT3ts
         jmnntLM/LuD+ay8e+bPKsIT/kt618lKMiE4xLHRHxAY+HUcntrlJPsxr4uC9uJUVVCjW
         cM+BGtrRPiX3DSqAW541jc+3lTOCDQQf0E9qKzhzP0axRNS1uyDPvdYBxMVLr+PVIlnH
         GXR6e/O5Bqs7eeZGshlSC7uxV3raZg5CDCunayMr6ZF0e7H4njHyTMklNF6qqzr/BjRA
         HmCw8dQ3lw+EaP1Px37I+R8w2rpFJ2Piu1bhT2ixBrFGbVKuI9/iAxIsVgCdMZVM1toV
         LiCg==
X-Gm-Message-State: AOAM533bGrmXfGbdl5lDxQn+t/+c5wHCmZIhW2yt4PJ82KgI9EeMJI5e
        pzEuOjFzz0paQipMnGcD/8w=
X-Google-Smtp-Source: ABdhPJzWJwpud25p45iHCCPjvKh3LtcAdaaJ1vu//greJ4qXp1F4M6T5UOfnv2V19XQijt2f8tk3Fg==
X-Received: by 2002:a17:902:7008:b029:12c:ec3e:3952 with SMTP id y8-20020a1709027008b029012cec3e3952mr2443860plk.35.1628652841209;
        Tue, 10 Aug 2021 20:34:01 -0700 (PDT)
Received: from [10.178.0.78] ([85.203.23.37])
        by smtp.gmail.com with ESMTPSA id d5sm6841587pju.28.2021.08.10.20.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 20:34:00 -0700 (PDT)
To:     gregkh@linuxfoundation.org, will+git@drnd.me,
        davidsondfgl@gmail.com, zhaoxiao@uniontech.com,
        dan.carpenter@oracle.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
From:   Tuo Li <islituo@gmail.com>
Subject: [BUG] staging: rtl8192e: possible null-pointer dereference in
 rtllib_wx_set_encode()
Message-ID: <a86f508c-84b0-3523-2a8e-6710e35e5bb3@gmail.com>
Date:   Wed, 11 Aug 2021 11:33:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Our static analysis tool finds a possible null-pointer dereference in 
rtllib_wx.c in Linux 5.14.0-rc3:

The variable (*crypt)->ops is checked in:
342:    if (*crypt && (*crypt)->ops && strcmp((*crypt)->ops->name, 
"R-WEP") != 0)

This indicates that it can be NULL. If so, null-pointer dereferences 
will occur:
389:    (*crypt)->ops->set_key()
400:    len = (*crypt)->ops->get_key()

I am not quite sure whether this possible null-pointer dereference is 
real and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
