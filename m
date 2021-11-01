Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB88B44126A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 04:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhKADf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 23:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhKADf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 23:35:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC34C061714;
        Sun, 31 Oct 2021 20:33:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 75so16047025pga.3;
        Sun, 31 Oct 2021 20:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=sharXBBWNJQME5ykY3LH+Wuf67MVUTp15Nj0dIthtu4=;
        b=YNKZPhGxufB1MqdoLMpX2GgiBUoek9Je1+IUYEEe+W4RTQ8dKyjs4HuwkJDE7WItU8
         5QLRMEeeJeH93IAEB7FtpD189DdiqLNtLPZAPIJ6s3l+Q0Rfoe+gWBbkYk8Y5ik2kbPx
         vvyC0IhJcKsDZ1NviSWRTTT20o3MBTlqL12HK97h5FLU6FALN1bmMp84dyrOxwUWvPm8
         Bj2epbaPGN0MvVij0J8ZR79dAqcCEiLSzkPvXz7DcInYAl4IepwXKJ79Gqur4ScbDShR
         CwUutsvEfXZu9KUyzx7n0eRtUbsR3TnVd/veVNIoq5YArKI8wKpqZJ+ySxlXMVmu7rSu
         jvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=sharXBBWNJQME5ykY3LH+Wuf67MVUTp15Nj0dIthtu4=;
        b=bs8NVgwCpLUun6ejIcM0hr37GhyQ3+iH6dUuXyH5LT1VrDVHea4bvJ2VoNhptCpCRd
         GalJxWi7jsIm6cM4QGI+eaXR0kkcNLv9tMlfq9QycUGH/tnBxN0fLlo0MQEEJg6tRy7b
         qfSfikg04Lh5rguJzIA86VWcBRMG4g81G4fq11T/1o0dqyjDQ6RT8i/B+8Sz4xhcEOd6
         cRtudhsBPCWO2oiPf4qZStuuQggVdcNuAyvGwLDYeQ9TevTXda9gCSrethgq88/4Qdch
         99Obta8Xpwa6feA//45WDFIlvvTsp2+9WSNi29q2lbgi1a9dXiBJezRewbq3COUtt8uj
         mFEg==
X-Gm-Message-State: AOAM532IkByg2PXF5l/pz4sVXbWpmMl/myO8VsMSDKPbIMMOAYmgbeRX
        kpP36Q/8780zHgCEamBnyZo=
X-Google-Smtp-Source: ABdhPJyMvgiysaFFd7vJTxWh3eDoFfSzoDu6orq/3c+qmlVO4XLL+lpJqF+q+5V6CjZ2MHarSBDLDQ==
X-Received: by 2002:a05:6a00:22cb:b0:47e:5755:7d86 with SMTP id f11-20020a056a0022cb00b0047e57557d86mr23342419pfj.78.1635737603550;
        Sun, 31 Oct 2021 20:33:23 -0700 (PDT)
Received: from [192.168.50.189] (67.218.130.61.16clouds.com. [67.218.130.61])
        by smtp.gmail.com with ESMTPSA id h11sm15364884pfh.162.2021.10.31.20.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 20:33:23 -0700 (PDT)
Message-ID: <c639c965-5231-b745-7b59-476877202e0c@gmail.com>
Date:   Mon, 1 Nov 2021 11:33:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
To:     chunfeng.yun@mediatek.com
Cc:     eddie.hung@mediatek.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org,
        matthias.bgg@gmail.com, nishadkamdar@gmail.com,
        stern@rowland.harvard.edu
References: <1618017645-12259-1-git-send-email-chunfeng.yun@mediatek.com>
Subject: Re: [PATCH v2] usb: core: reduce power-on-good delay time of root hub
Content-Language: en-US
From:   "Walt Jr. Brake" <mr.yming81@gmail.com>
In-Reply-To: <1618017645-12259-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three month ago, My USB 3.1 device cannot be detected after upgrade 
kernel from version 5.10.41 to 5.10.42.

And I found some other people ran into the same issue:

https://forum.manjaro.org/t/kernel-5-10-59-doesnt-detect-a-connected-usb-external-disk/79320

https://forum.manjaro.org/t/how-to-make-active-usb-hub-work-in-manjaro/84548

Two days ago, I try to fix the issue myself, and I found out that it was 
cause by this patch. After revert this patch, my USB 3.1 device can be 
detect again.

I have already file a bug on here: 
https://bugzilla.kernel.org/show_bug.cgi?id=214875.


