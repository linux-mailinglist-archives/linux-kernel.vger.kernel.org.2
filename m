Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9483D36FC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhD3Om5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhD3Om4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:42:56 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF86C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:42:06 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id dl3so2219672qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=Oi7QuYoVpkckRDLbY1jEPH0cB2iAdS8yGwTIyJKz/hI=;
        b=iRrhDC4OVkCL63311ThWgLTjC961g9wxj1E6V4cmMI1URotwmd3hFFJ0R2XMRyQpJF
         R5bjBbUonPTT0puEwgiKZsQ1o0jKQi54MtKjyhPtD+sEbytoZ5njD5jyTJOCo0L7t+pd
         G560IdIvH2Tu6jPvlYjJz/jqMcJ3F7Ho+WcMJAPkz3XTiUZXkdeFilWRn9LEQih3J+wQ
         JPHcHYq89Djik1hipyzbumGODyItyH9LN8PFYHyE1RIm1WVbDwduhwUK1NAoDZtvo1gf
         sdxVJ3ZexFw6qtQ/pP8gs7tLvsEiA7NY6DhWFhnNu7bLBLeA2Dn01IdqLPCbpW+Hnak3
         IpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Oi7QuYoVpkckRDLbY1jEPH0cB2iAdS8yGwTIyJKz/hI=;
        b=avGxjUBOgPTQXrnT32FThkO6X/VXe9H/Lii570Gq/h/DlT3X93Uz4II+gkEH28PDCg
         qBxkXYgGms2C6uKD5LeghJuNrosCNDAUA+KmDdJZYNC1cixH3tcMYr0C8mM5DLHrQg1y
         vXiqwKQdNcAweF7ZCWn4RAeYE6H7rsDNTF/BjGJwj0bP4v/7m4QK+dwUDtLRspvcRifm
         GnUgyP2OMMTF20y581Fbp6ehu9cgScGQmQeP9/NMu8IWA/yEu/G0n0NpgkvqgisE8lgq
         9AQi2+qS4wgRz9mVnv2ROanoWrA56xP+avftzz2QWwWxmNobfF/XLtpnmBTlDAa+ZZ7z
         +Z/w==
X-Gm-Message-State: AOAM533aSPcVlptwGUW7ypvlUEKYIKq/oaQEdR2OIf+MuVAtpTWwlGm5
        ILY/h4yxdY/ku+yCdLA0Lhg=
X-Google-Smtp-Source: ABdhPJzQTFz7FuFvopRcGCrsZbrAiq7Pk3GuRgEXaeMjtXUT8jIzwIQlsZqybs2+vOSi1PUpo5F9sA==
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr5525924qvw.35.1619793725519;
        Fri, 30 Apr 2021 07:42:05 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id x13sm2387967qtf.32.2021.04.30.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:42:05 -0700 (PDT)
Message-ID: <90ce7c8849c1a1c1c42ec2901d1c3b689846f6c7.camel@gmail.com>
Subject: Re: [PATCH v2 0/3] powerpc/mm/hash: Time improvements for memory
 hot(un)plug
From:   Leonardo Bras <leobras.c@gmail.com>
To:     avid Gibson <david@gibson.dropbear.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Apr 2021 11:41:59 -0300
In-Reply-To: <20210430143607.135005-1-leobras.c@gmail.com>
References: <20210430143607.135005-1-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: David Gibson

http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=241574&state=%2A&archive=both

