Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8603D3E4F49
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhHIWcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhHIWcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:32:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861BC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:32:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so1407825pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nf05PhNuii64r/MVI66FLbx+assAs4SX7FBnKDKhMmI=;
        b=C9RS109JHF12UF1xKLr8AiP8HmjXdCA34ixW4rn/6Py+851YG1wExWbMai0b+E3Fk/
         /RMqjswaEnjLTVnIKIsZgXTbP8baf6gzk+SE4kDBfBa/u0QEbpKpCTdvUG6MCaKKrFeV
         1iVCtW2r1kvcfuWI/ACEb+azSEWjM+pqU4ugZM1GO2h7n0ez3xlZ9zpFLdRV6LCnymME
         Na+5Q6h1lN3+Cj5olq6VDdrbhQSh98jFN76xGeHjzi7eC7TziwF2z/C/tMOK0dGp6NTu
         huUGFZQrBJvk2Ucd+yP9QkGB5jW1n5rhm3FI3ewL92TZDC4yshmiWyl453QuzwCvAEKD
         oSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nf05PhNuii64r/MVI66FLbx+assAs4SX7FBnKDKhMmI=;
        b=PDICebX/mzBOGovNlLRqKFYtbFyu+NVsy3O5MBoCLIG1wRuXZLt6/ykqRNgNb8plQ3
         sTcZE/ag4J/Wvw1jRFe8pPotXx0vAw8PAUl6t6wyV2L5uZbJ/QoLOpGqajO0wsKOpOWC
         4QGGteWuGVNhXlkfP4ne0a2mx8UaEjmoekLMik+z74ns7AVBO4LBrSQE1aPbabvY06aX
         vzrYfl/c+xQJU0lKVYQHE/P3NB4zz7xe5b5DMRgJxsZN9TSe0pMyfHIpbneS5YYHu987
         MGOVhpwNzmqdI1n3fOzN2ldy5lvl1H20WvqJeRNTHF+LfQcn2cvvcSheBhZU8w1jinf8
         0LEQ==
X-Gm-Message-State: AOAM531b6MIcDXufi93W+1nEP7Pm/6YBo30aqebj1mue1xYw3Ya5vGe0
        LHQnmCWFJhDKI6chBRaH4es=
X-Google-Smtp-Source: ABdhPJz6p74sBmyxPf2veePnh7pIrK2oX0VkO+TtpWaULg/Ozfsg+UivDEo3OrJu/nAdNHbav9BUYQ==
X-Received: by 2002:a17:90b:2286:: with SMTP id kx6mr1418181pjb.11.1628548339740;
        Mon, 09 Aug 2021 15:32:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id 26sm25052153pgx.72.2021.08.09.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:32:18 -0700 (PDT)
Date:   Mon, 9 Aug 2021 12:32:14 -1000
From:   Tejun Heo <htejun@gmail.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Fix typo in comments
Message-ID: <YRGs7pj8vkqXfsgF@mtj.duckdns.org>
References: <20210731000129.647-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731000129.647-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 08:01:29AM +0800, Cai Huoqing wrote:
> Fix typo:
> *assing  ==> assign
> *alloced  ==> allocated

This is more abbreviation than a typo but it's fine either way.

> *Retun  ==> Return
> *excute  ==> execute
> 
> v1->v2:
> *reverse 'iff'
> *update changelog
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied to wq/for-5.15.

Thanks.

-- 
tejun
