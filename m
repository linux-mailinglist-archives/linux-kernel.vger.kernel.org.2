Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D774169DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbhIXCMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbhIXCMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:12:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0DEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:10:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso6410247pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sf+K5ftwjM7G1SXP3n6mL8ZVon/UaLc7wK06ppTU7uk=;
        b=V0/otrIzyfMLg7DqeExqO6yLKVG+RutyM83s4x3enYma2JnY2actev9HonDVAf+Tdg
         3yns8kJwkOmMPEBIoh/LwJMgbIAjqtZT3TcKhWQow3JIN/Buczq8lJ18CcLOSa/WTOER
         Ncl6sGATyuR2/Ez2vx6YLaE3TIVmtM64yPCkW02lsrZHIpWlmIu+w798/X3J6o0s0dDV
         GpwufQ90wg2yGQjLn3B2fT1GmMOb1Aj8jIFTVAuZTtfxpcdBgQy7uKOFD59zN0bNAn1H
         4TI32PMcwBjkdv60FC0heJFp8d/vqYhdnBWf4Ev0GyMdFva1NujqxvlQGQeF4sBQi/08
         rmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sf+K5ftwjM7G1SXP3n6mL8ZVon/UaLc7wK06ppTU7uk=;
        b=WBjhE8XP2d1lZaIi0WRctN03FyHDAzem91gmOwg09ARA8yQWxFL6wRnJCGwEjDUCpd
         HL82wO1uO3gw54q4i0tWnuyH5lccTAzj8kurW4WMIs3JjH/sz9iho5LlrmPkJo5pL8KJ
         YqZXSsFSR3L/ylTKHBSNsjQf4Rab0hs3HgKoqxYrUmpPNDTD8dseofsQc1gW5oIi7LWL
         DGTgc8DJY2v2SCQC3zMaiwofOoW7a6pfc68qrf5dyfKaALk9tRi/XJ7NqiUPjEPa2gF1
         luOSs6zJmty1xuz7+2sIiWT5Nbxdb0jTIS8yJYYRoq/G/s/mKBtfcmKuT6ismmv7lBFC
         kujQ==
X-Gm-Message-State: AOAM530jnGDF5WLhE5i93aGLfvCl4GPHPGa7TaJ9vNkSzv7FYbDYcH0l
        cxwPQ8UDaTd0+YK7bv7xiYs=
X-Google-Smtp-Source: ABdhPJzNevQju5Rfk3/AOIiShW4E4gpWjMAFhfRIjwzwPNXpfp0aXVSuX4wtPzgKYPeLrM7Kgn/RlA==
X-Received: by 2002:a17:902:da91:b0:13d:de94:2c63 with SMTP id j17-20020a170902da9100b0013dde942c63mr4680148plx.49.1632449439920;
        Thu, 23 Sep 2021 19:10:39 -0700 (PDT)
Received: from [192.168.1.121] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id y13sm7896579pgc.46.2021.09.23.19.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 19:10:39 -0700 (PDT)
Message-ID: <b12029dd-3ad4-a3cc-8d79-189fb7583c6e@gmail.com>
Date:   Thu, 23 Sep 2021 19:10:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] phy: broadcom: Kconfig: Add configuration menu for
 Broadcom phy drivers
Content-Language: en-US
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210923025013.189-1-caihuoqing@baidu.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210923025013.189-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/2021 7:50 PM, Cai Huoqing wrote:
> Adding a configuration menu to hold many Broadcom phy drivers
> helps to make the menu display more concise.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
