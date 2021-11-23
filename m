Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5EC45AC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhKWT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhKWT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:26:29 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA43CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:23:21 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id w15so165546ill.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=OwGxrt5dxdLYQL4ucMdskFmZjKSpW7HApnLSDjm1cTc=;
        b=WMmIx4ja5FNguCxrH/RdHUAGTrcr4m2JmFdSIgDRDetksTmjmc22WGlUaCeVFvBObN
         ZhB79KDQFF06lNQpGAi18MxWXBBdadYbiW6Oa/YYL8GsKbyDe5SV/Y/3H+53R086EeaL
         X9srQPR+GEjkIUWVbYa6EidwCEMMGdknpfWUMBMjTCyENp08VcsLhQCpvOLU0BUti0ki
         QQwwgmxdqzr7JfuzXOruwW+DUxmFckRRqeNzlQKm5QeBD8tQ6DZkCxYEZ17z1Gvtyyre
         ytwHtyq47TjIYFuHANq5IbfSoS/eC02yPQ3jRkVvH7AYCMmq/keYa0cnv6A2rjk20cAO
         /U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OwGxrt5dxdLYQL4ucMdskFmZjKSpW7HApnLSDjm1cTc=;
        b=V1m916DkM85Q4bB+eAsvYiCc9RtUbYuynrK0znLxeA4v5OXGD3pv6CMJ+O5KjLWdak
         n42E5J/Oaz93jdqkKLfeRbyKO4uJ5vLPqbqevvtDcG7ymJvkxsxvVVGKE80D6HPwzVec
         nwdBVcJCVlJafNSI165jPtF4x1WNIVR6CluYwAuN0Z4JDHfk1imHhbSfahOCJrHSD6os
         6dOUwrYpdsB85bUN/6iG+rH6sjSI86Mf0cfbJ2foIRyFxtv0HWK2zHBz43ZmRNukQhV9
         HA6/cGDQAjbyPhj1QFerMEcv9SB86mPM0vVpWnGTpTaiY5eWmAGZukEDcmwwpp9dhW2j
         vfkw==
X-Gm-Message-State: AOAM533srYFPPaFwyAOLw7q70uE8ksEDTz+zITG3Z/FbVPXmkMz+eo5c
        /ZE5TeyqIubgtyDMepenY3klhw==
X-Google-Smtp-Source: ABdhPJxtbW/8yyjLd426tCzPFl3H9zt+TsXyBdhAKp482KoivCsmJ8ibnaRYb3FaZeXqw5VRUoX1Zg==
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr7867855ilv.23.1637695401064;
        Tue, 23 Nov 2021 11:23:21 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w19sm6241736iov.12.2021.11.23.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:23:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Cc:     kernel@vivo.com
In-Reply-To: <20211123063340.25882-1-guozhengkui@vivo.com>
References: <20211123063340.25882-1-guozhengkui@vivo.com>
Subject: Re: [PATCH] blk_mq: remove repeated includes
Message-Id: <163769540063.430590.3615645820510489074.b4-ty@kernel.dk>
Date:   Tue, 23 Nov 2021 12:23:20 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 14:33:40 +0800, Guo Zhengkui wrote:
> Remove a repeated "#include<linux/sched/sysctl.h>".
> 
> 

Applied, thanks!

[1/1] blk_mq: remove repeated includes
      commit: 5da93d507fb52342f1a3245803bc088ca245f5ef

Best regards,
-- 
Jens Axboe


