Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBB3DAA07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhG2RYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2RYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:24:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340DC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:24:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l19so11367893pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UyLZCTHsatHuqAFk9aTjrEhu90sOUWwTWtZd1Iq4f8A=;
        b=vRyeljBdvOAc87+JulZNatFFqgcQea7LKW6iJgtLwps6le/AV75aUc+usZcl1lGS5i
         OWcTs3zfrmoOCahq+L7GZTosckzfprwbAaoJinp5DzoQTn2aZSqZIuiZ8lB8+Czolkz/
         6IvF+BbWZtN119p20ZhmFrLHJaVttHkjbBUEgT1duO0DnOa1n5WhNGlYBX5T3DyGoS4Y
         kby/a0ZoY6S+FjJDZquVB5mfm4Xv1Gz5xIWRbCoEdREzedcY92hOFWFVWZTbEyn30V0+
         Vb1nf9ujCeAv9UN4cTJSuLbzDdXsWkuhD+/JVAYcURTRHyEtbdfkNb4bzRvZbK+UNQ79
         bhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UyLZCTHsatHuqAFk9aTjrEhu90sOUWwTWtZd1Iq4f8A=;
        b=Rb/8wI3e2N48oxcBgStTD8SZlfSRIkGqiD+ggQbQ/vOLtN1OaNhWNQ4JV1HV4bZBtT
         BApNKQaCELlMqz9tQJ4md0rBAiltBY2R+oNWjcy+3xl6r61Es3kYvYohFVipNnvh8CBi
         AFJ51MyKBaDR7k3nM/RswBMX+7PT6DLTvDNQoIEMYJi0ti24WjzpLS/RGJiwGywgnIHg
         eVFSSJs6GXnBUBCKcfpnnUsA6Jv+XwhWWteilmsR8SlBAUFLWPdFHxQCgqfnPLPrXYpd
         PZDL0hCFihSbFt+36a3QWhE9Eg0Qm7ZoF55w6vHz+jDqVYlEka9Y6dfe7xRZOnKBek5m
         pOEQ==
X-Gm-Message-State: AOAM530tgyGdVoMjeWHy/5mRMli8CfkN/1UZ2EfQFPo6wzIuU0NTNgOL
        BBTLp7bmmC7pLkRrg9JbxT8=
X-Google-Smtp-Source: ABdhPJwWlSPheAjjqM8/wwkrrbc8MxFdov7oud5cyS7usBgxlgKW3sdQ6ktJ9X1WiJ0KWSANQ/F40A==
X-Received: by 2002:a05:6a00:14d5:b029:395:fa70:2525 with SMTP id w21-20020a056a0014d5b0290395fa702525mr6017184pfu.1.1627579454026;
        Thu, 29 Jul 2021 10:24:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9699])
        by smtp.gmail.com with ESMTPSA id h19sm4154036pfo.161.2021.07.29.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:24:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 29 Jul 2021 07:24:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] workqueue: Fix possible memory leaks in
 wq_numa_init()
Message-ID: <YQLkOCoTlt96SVul@mtj.duckdns.org>
References: <20210722030352.3966-1-thunder.leizhen@huawei.com>
 <20210722030352.3966-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722030352.3966-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:03:52AM +0800, Zhen Lei wrote:
> In error handling branch "if (WARN_ON(node == NUMA_NO_NODE))", the
> previously allocated memories are not released. Doing this before
> allocating memory eliminates memory leaks.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied to wq/for-5.15.

Thanks.

-- 
tejun
