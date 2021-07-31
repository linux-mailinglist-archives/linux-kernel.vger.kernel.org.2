Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D133DC312
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 06:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhGaEF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 00:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhGaEFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 00:05:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 21:05:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k4-20020a17090a5144b02901731c776526so23571626pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 21:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=VFXOOTn/Vn4wZYYve4ASVb/HHzXMtsmmCHHBTxOGsvA=;
        b=sLP19dreR3fqB84FUJE8d2g6cKKyeCBFloWtY579h/6SgMebVOowmEV4wiedpKaRVs
         cS8qMrRmvv0IwGaeuvEmNrNDVHyARI8tBPM/HjVKUo1dv9CEKmZZ8RJCWzM1VkqtrhNo
         Y9/q+zdJeQbJl+gcod8zZLVlnDOUC7oLOD122eRZ9gK4l5r89UeqvTP+kDL4luB0TdYA
         pIzBwG8ASjM9fg/Ibmx7hrr2b4BS/urcpsGYos5Aa5/VzJvR99PTU8hQueXVdZjZSQXz
         3GsFeuawMS5FjY47pwATwFNmbLCBI7OZRd19gYWz5Cj6AhQmFlYngLiMBrZjNVuYoV5z
         rLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=VFXOOTn/Vn4wZYYve4ASVb/HHzXMtsmmCHHBTxOGsvA=;
        b=X29ikFlNhgxxLpRebxXXEzKr+YDDesLBK1WW66ufKyhDlthXY4lt6edQYc3JYfUC+V
         B4xsCR70QXPSzYaU5wdf9TEM4zQtibQtZgfpSyg6WMgJY4AAqdwa5uf8T2aP+n3vlhgc
         lx4vOa/sXuRilyJs5bBa98YrKt67Axf1J852YC6HgeZefGaz8lsGUBCvpyM5L9a5+BPf
         vBHE83pdIcSltpc1AxGteyvyLkMql48P6i2eeZfNQ1z4AoxKFwNq1xAiOvD+RySmVuAH
         mB9yc71kX/6NS94mIQ0CeN0Ki4mMywdMQih3qotmjIH9Kc9ySu3FEIqHPvAGK14nAhYe
         iYGQ==
X-Gm-Message-State: AOAM530uzhMl90uhYVAhQm8IkBcU/55QxgOyGDmke1dD452+xhvw6kJP
        m81O7PRxavKTYY6e0EXTwbM=
X-Google-Smtp-Source: ABdhPJzaAo2Op1LNut0Z98WmyNuIKcEFNkrZ5JV3ZnBHASVQBzU/8t+3IAryF8kG1yC3vJT2e68O5Q==
X-Received: by 2002:a62:7b86:0:b029:32b:364a:e7e4 with SMTP id w128-20020a627b860000b029032b364ae7e4mr5848448pfc.49.1627704348615;
        Fri, 30 Jul 2021 21:05:48 -0700 (PDT)
Received: from [10.106.0.50] ([45.135.186.29])
        by smtp.gmail.com with ESMTPSA id h16sm3564511pfn.215.2021.07.30.21.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 21:05:48 -0700 (PDT)
To:     dwmw2@infradead.org, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
From:   Li Tuo <islituo@gmail.com>
Subject: [BUG] jffs2: possible null-pointer dereference in
 jffs2_scan_dirty_space()
Message-ID: <c5849781-7fb9-28ca-03dd-fdd6e240c5bb@gmail.com>
Date:   Sat, 31 Jul 2021 12:05:47 +0800
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
the jffs2 driver in Linux 5.14.0-rc3:

The variable jeb->last_node is checked in:
673:    if (jeb->last_node && ref_obsolete(jeb->last_node))

This indicates that jeb->last_node can be NULL.
If so, the function jffs2_link_node_ref() is called with the argument jeb:
685:    jffs2_link_node_ref(c, jeb, ofs, size, NULL);

In the called function, jeb->last_node is assigned to the pointer ref, 
which means ref is also NULL.
However, the possible NULL pointer ref is dereferenced in some 
statements such as:
597:    dbg_noderef("Last node at %p is (%08x,%p)\n", ref, 
ref->flash_offset, ref->next_in_ino);
600:    while (ref->flash_offset != REF_EMPTY_NODE)

I am not quite sure whether this possible null-pointer dereference is 
real and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
