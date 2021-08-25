Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503803F7A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbhHYQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbhHYQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:32:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A509C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:31:23 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j2so10239826pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XJkAc9QmQEswaIUvQz6Upf/2ilMQ7WGC8GTDpVgEOXk=;
        b=aYURodus3dsc5aroLaWgMkC3f3F8qX2V+toSTyJs1kqGCXES5/gZleGG8eC3tteYlp
         0Af3Zq/nIvkJkSmmEAnLaOVYhe8eLKNwelyXSiBKk96W/k8j65upqn3KWze95OmLn3g/
         ajooETd09pd16QAS/ujr0PuBGDNMPY1aJtJ1ODrdGnbsUpZYuDq03hbeMkAad52iX9pM
         l7Nsy5Rm61aXMWBYfDdrXPY7MvCy/2o/NZQGNGebIbYuBGyCnCPf9bWgmCf2rt0xrkO8
         roFpfm+bsMO5HLfeajB4eBTOVihKdunVFxtkjr3+aD53A5YcurhYC3T4u7GpYjX/DdEm
         GMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XJkAc9QmQEswaIUvQz6Upf/2ilMQ7WGC8GTDpVgEOXk=;
        b=TWyL6DfsC0qsUW2kaUNz1BDIpHUAvSVw1DGrLQtMNeWwgT4cTSJcgDBuMPIEaGgkMV
         HbwLZIDf85OcRIfN0HvtYS8dfqclBTHQ5wobapB3vTKwdSAghek7hyOc1mXrExPO4PSc
         8itIKQQPNczmtXc58hepYW2tVsKaHTEpferXcqcpBxYsJwJw7AXGtjfHQ6gT/lCiaPJT
         M7O4ESfZigc0H9wKJT0+Nmpmf82HFVJITcm1S1Mtzb8oA/BXqS8nQNB/RoBYaskmxQrO
         JqkjF+jgAAzGj9oa2HffTVItV1nrHG3zEywHKfSHtVIP8Qa61vNT4H9KHK+yZVBbXJ//
         pZXA==
X-Gm-Message-State: AOAM530P2VLG0fJ4mh8EL0aaiZNQ7ppQartzZrnMeuOQYRc4qAdTt9HE
        Xkvb8jja8EEeepDQ7GtCni0=
X-Google-Smtp-Source: ABdhPJzaBjPTAJlgDbwfVWYZc0TGI0lgTxS+HjZIVFXZlhja8fXlrGnqzpU2aBlhdlO6AteBsn2PDQ==
X-Received: by 2002:a17:902:8685:b0:12d:7f02:f7a6 with SMTP id g5-20020a170902868500b0012d7f02f7a6mr38798442plo.49.1629909082617;
        Wed, 25 Aug 2021 09:31:22 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with UTF8SMTPSA id l6sm290590pff.74.2021.08.25.09.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:31:22 -0700 (PDT)
Message-ID: <2ffa7d65-21ef-433b-8a86-068df13950d2@gmail.com>
Date:   Wed, 25 Aug 2021 18:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 05/12] firmware: arm_scmi: Use new trace event
 scmi_xfer_response_wait
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-6-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> Use new trace event to mark start of waiting for response section.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Might be worth squashing into patch 4?

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
