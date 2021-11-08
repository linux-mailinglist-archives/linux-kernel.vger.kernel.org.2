Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC1447A68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 07:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhKHGRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 01:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhKHGRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 01:17:31 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0DFC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 22:14:47 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id n15so14518318qkp.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 22:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oJCWAjGQk6SNImKaOFEws44W9FYCSU/8xgQ23THUzrw=;
        b=DeTy+xVhPF2G6QLxLn4UOX5rKG1GcSKRXz/2r9QAe23qELrDUD/9FCWjzBS1MRXbkW
         fJ1CiDxhv8r3yx8evwu0zcJM9SmDyU/KLJT4mi8OqUxlVbdQ0R9qMln4PteiTTGD+IBe
         j/CYzzabslQHOHFXDS5sqk03oSVM6okbkMPHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oJCWAjGQk6SNImKaOFEws44W9FYCSU/8xgQ23THUzrw=;
        b=x6EJRkGlFwPnE7yJOhBMobHNhBL8mwDWRm65fJhg1TKpFpNxHzQrumhEtSuRb9NO7o
         wZSsAA2IdBvKlxmiSMZY+NRvuGhrnXtemTpwIGskn328HwaAJBnZb12G8XtGz3Np0s4G
         LAWl422xQ3Y7x6cQ0AqOKQS0T32JNRin7MJS9atUhi2gSuWgVtcgyexHqNsgefOdChGq
         eTEOBEKM31TfHrTIUhuxNE5WQ1+EcsPtcDlzd6qSRpJ3TqDN5/zwL0C9C3qFV9IoPLEX
         odLMU/iZ85kUT2v1iiFBIWmM5XDr7US8rlNTDKqUmtU08LUHksuSWgumDKUEvfFg7bJG
         +j3Q==
X-Gm-Message-State: AOAM5334bRVrTSdGTuXkLwOD87rO35XWOV8+yF2GwS75VIvTu5ovX1sm
        MU7b98LP4yZJX78OQ+4Gts1wM9Z6UnUJOIueQnY=
X-Google-Smtp-Source: ABdhPJzRVLURyiXx05bhF47BecPBvTLB7+daIsFzTd2QtsMn9UhjPRaWMP//W1W5c8LxRc3TQYZOQA==
X-Received: by 2002:a05:620a:2443:: with SMTP id h3mr40503547qkn.299.1636352086403;
        Sun, 07 Nov 2021 22:14:46 -0800 (PST)
Received: from [152.23.88.220] (dhcp-152-23-88-220.wireless-1x.unc.edu. [152.23.88.220])
        by smtp.gmail.com with ESMTPSA id u11sm9657386qko.119.2021.11.07.22.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 22:14:46 -0800 (PST)
Message-ID: <de131144-b396-1f94-70ab-7d13dcd3a16f@cs.unc.edu>
Date:   Mon, 8 Nov 2021 01:14:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Input: elantench - Fix the firmware misreport coordinates
 for trackpoint occasionally.
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        jingle.wu@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw,
        phoenix <phoenix@emc.com.tw>
References: <20210729010940.5752-1-phoenix@emc.com.tw>
 <000001d79d99$53762dd0$fa628970$@emc.com.tw> <YS0+TU21/nok6Ge9@google.com>
 <3a98b10e-6b78-b769-e22d-2496d7bcd69d@cs.unc.edu>
 <YYi+ZoeGtFO+/HYO@google.com>
From:   Yufei Du <yufeidu@cs.unc.edu>
In-Reply-To: <YYi+ZoeGtFO+/HYO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

 > Sorry I lost track of this patch. Can I add your Tested-by to it before
 > applying?

Sure. Thanks!

Best,
Yufei
