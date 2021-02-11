Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918033182A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 01:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhBKAaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhBKAag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:30:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF98FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:29:56 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r38so2414749pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=73zep3wYuHPlqFRaBwu8i/TF/0mKW1WjPZUjozHSNnU=;
        b=X7t9hlTcycAun/i9OmTo6U7rQ77H2P12uYeJ6blTCJqMdXU0OKr9uSE+BqvOvH7aAo
         yl32jZCnmWbzXDGzH3OEwTFandW4qFABfNpVZN3Bt579CCpx36oivZsGuuhziBNs0fIC
         y8FDW+anjw0Y1u09UriXfdOe+Kb8PPcM2cwsfH7j1C2DYtfgfu5elnuRu58wd13YFCvf
         lC4vII0Bgq7cSpICXSfZ5Gxnxz9b4/8CD0xulGE0xnKTjW9EcEYoODL2NFXUFEk+hZ+p
         FdDKB6dXe1bDN7Q+ARdwU2KIlCgGM58HHt4r0Jly1jOUAH8KEX563ry+wpoo6Qkqy9CU
         nNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=73zep3wYuHPlqFRaBwu8i/TF/0mKW1WjPZUjozHSNnU=;
        b=aQSEVcsuKmJ+iwZtc0u2YYh5qo3FizdphUwkpjLlXK+9GHg2RzMZGsP6+wm/PXBzsE
         pvmYFEsKe+f8MUf8/SPM9vCIkHPEnKwA1Qwci1b4KYoi3YQG9A63cA9bHhv1ysI4tim5
         OTid0B2Tk+WSlgHVgDN28JA1Y6X9uNf8PlL0Y3yox2IRrUjvfLdPHuBtjsYDE5hKTZ87
         GP4KA15oV3+ky+c2wHR7Hb/YAAhPKj35Ml5uCpFBO5tKorzrNm+eeHP/Bw+6oKf9eBzP
         jWwiLlbHfnyOwBBRKaXZCKhFVk1BQsXwT+PTP8kZYeI84rmsTRDB8ivCWUsKhO70Md1x
         +vkw==
X-Gm-Message-State: AOAM530Y1LGD/CiOdnNrlJuNvCMPnX5eI6bX+hH6iR+6m9EMflQTHm/w
        XVGJO1Z2ah9Gf0nV7EbhLuVZdw==
X-Google-Smtp-Source: ABdhPJyiFMkn9EROtYf/Lu0C+2So2cHjdwGcbXa4PQcRR5EbPEJoi7L2IPCLRcIriZS9CChv+I+0XQ==
X-Received: by 2002:a62:5344:0:b029:1c7:eeea:8bad with SMTP id h65-20020a6253440000b02901c7eeea8badmr5530204pfb.1.1613003396294;
        Wed, 10 Feb 2021 16:29:56 -0800 (PST)
Received: from [2620:15c:17:3:2904:7145:16e0:9c00] ([2620:15c:17:3:2904:7145:16e0:9c00])
        by smtp.gmail.com with ESMTPSA id z16sm3294795pgj.51.2021.02.10.16.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 16:29:55 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:29:54 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: minor coding style tweaks
In-Reply-To: <1612847403-5594-1-git-send-email-daizhiyuan@phytium.com.cn>
Message-ID: <5b584841-a05d-a942-aeb3-e1b9f597a464@google.com>
References: <1612847403-5594-1-git-send-email-daizhiyuan@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021, Zhiyuan Dai wrote:

> This patch adds whitespace to fix coding style issues,
> improve code reading.
> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>

Acked-by: David Rientjes <rientjes@google.com>
