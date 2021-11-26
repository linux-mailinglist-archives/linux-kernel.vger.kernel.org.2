Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7746A45E41A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbhKZBky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 20:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343810AbhKZBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:38:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90667C061574;
        Thu, 25 Nov 2021 17:35:41 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x131so7337347pfc.12;
        Thu, 25 Nov 2021 17:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BC6SGqll2uc/Zv/S1kgQ3STL+1ZHDPjKpDU0asoxWCM=;
        b=TnDzylDFZtfPCO+3RZNOIlB4jX60ZxezOab4G01BceqytfGO0wR2P54JICIVdeIPXa
         qCU3gY7aynOiJuPmybr/4VnDE7oHFSktcMjW0hg0k5cngqDeBCi10XOJCEtITFk/Y1uy
         jl33CWtTi2Ek1Y760ObcfgxljT14/crK2Q4J33MpAvRo9ccy9sM97vIkXEf6P5jTOEyT
         n7o4Idjsf4x1a3m0MDtEIX2/lHosYXN8lbXU0gSbhPeqEsoA2SI9JwXsMgRn0mzjph7D
         gU8NwYofoEYaaNIcV5fiH6q7XkJa+7o9F75Y6255tUplTCGVy82OiE+Hd2T1hZwjU1o1
         rEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BC6SGqll2uc/Zv/S1kgQ3STL+1ZHDPjKpDU0asoxWCM=;
        b=eRt77qRkTS/RSCsjjwL98B4KRRTr+lRvqX4sUF7OoqY6AsnkCawzSoPKyho/BiwY3s
         qiUcCDDvz4ydevh8kVH9qaHbk6wH37INJySR/GFoqjz6NkLJATciKer9tw6rc63RY55U
         mAli++XWhCHl0A7HujsIcgvvBpo10kG3/GSugGMO2c/q0FgnYfaXAE13T2NImQQhfiiZ
         yehYYxOc3zm7cg2Or54MbqGe3Z6olTnNKU5vOGyjtfCbXpaNb1kaR6IXsCfe16zG2A6m
         XT1abgr4OgwphdMZZ9s/1ZihXbt8NR/ufxzxFjumCfPGoHt4nAcSTGYbBpSKz3HaXLgQ
         +44w==
X-Gm-Message-State: AOAM5324OgK5cfdAZpdbQNKpjhXaOI1CZ3/yOHko+/RaPN/Hq/uRRPmP
        O0qQ5bNZi9dj4XJEj+DdgmjY3ay2e2g=
X-Google-Smtp-Source: ABdhPJxxhoRPWvSi7qP2HqlGcwQFPXdVX9wsMvQJG2frSrOtm2O9eiZy7JM9XwabCs3MJc/F9lkLkw==
X-Received: by 2002:a63:145d:: with SMTP id 29mr18972313pgu.264.1637890541142;
        Thu, 25 Nov 2021 17:35:41 -0800 (PST)
Received: from localhost ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id d10sm4772832pfl.139.2021.11.25.17.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 17:35:40 -0800 (PST)
Date:   Fri, 26 Nov 2021 09:35:36 +0800
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: kmemleak: alloc gray object for reserved region with
 direct map.
Message-ID: <YaA56JVYPfzCsawG@debian>
References: <20211123090641.3654006-1-calvinzhang.cool@gmail.com>
 <YZ/FQXS3gWZ2xfEy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/FQXS3gWZ2xfEy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 05:17:53PM +0000, Catalin Marinas wrote:
>On Tue, Nov 23, 2021 at 05:06:41PM +0800, Calvin Zhang wrote:
>> Reserved regions with direct mapping may contain references to other
>> regions. CMA region with fixed location is reserved without creating
>> kmemleak_object for it.
>> 
>> So add them as gray kmemleak objects.
>
>Do you get any kmemleak false positives without this patch? It would be
>good to include them in the commit message.

Sorry, no. I thought it was possible before I saw this commit:
620951e27457 ("mm/cma: make kmemleak ignore CMA regions"). 

>
>Without seeing a false positive caused by this, I'm not convinced it is
>the right approach. You mentioned CMA but telling kmemleak about the
>whole CMA region is a pretty big hammer. I'd rather add individual
>kmemleak_alloc_*() calls in cma_alloc().

Yeah, I agree.

--
Calvin

