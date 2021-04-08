Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203053588E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhDHPwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:52:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD23C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 08:52:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1620713pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zDL4gbMlOhM6foD6otNYvEI1m8ANr2uzTVEsHhxmkx8=;
        b=s6xxEG5HMFht7c4oS8fPe8DR6t3vfi+9GgLJLPJd0rNdtjQwdNz2VCKB5QIcXu0B3S
         Qgf0b058hTT8a9OmTQWIodk7fYFqiFn9PlBnghOYeND+Ds8wARtieyg/Vd2+IRwhs4Jh
         ZvxRFhren4wGBi97FNchxb7iWOBhBw25s2oTDMjsC/S4qAQ9G+i2rPIJgcSdD/VVYJpy
         PbEve41lfoigMI6WOlKuJDDD/uPFwS3eIoeh7aQK1pgj/B7kQzij77R6CBCxMnLnkVKz
         maqPORjzXTB+zqJe78sgw2Vl+Z9+goViuwRwaPPDyhBw4le1TxaRfM9uNFKCaxt9fX4C
         2cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zDL4gbMlOhM6foD6otNYvEI1m8ANr2uzTVEsHhxmkx8=;
        b=XH/gaBxSY5ksxrdYw9XJIhJusJhoncfDAob9zkusxcfNY6yB70+8jWeEd/fCR+Yixc
         0ytS4d0OwMst/v30/ADe+o7OxR70TkqSfZDsAEv5UBF1IRzotAL40ikd99JoxA1cduRB
         hgx/gyfcU0ixnbzdaQuz2LeZw0zhWgjU+AHOtDYT5G+zcMYcjCDwpM2SAr4111IHUknS
         wnr9u6SOMRYt+uActceRKWUwSlfSa0QHHWJ4vF3YMgXCHoolqh0aQY2jvrY6tWd+5waI
         C4fOHX3C9wb1UljoeZpmYLjDmIcQbQut76JKWatOj8dSCpNdK3bWODkAr4L4uFOhX4GH
         0EoQ==
X-Gm-Message-State: AOAM533ZFDwTZ++DrW4BM4BPMkjTPXoThxcOk/f+MK0BU3utZsiEHI+6
        R50DBzLrg2bqqFoKvjPbIf/oWg==
X-Google-Smtp-Source: ABdhPJyVTNwNqeJfyxpsTTxNGshEIh9WEdOYit3kJ6VRxmaXeiBzCO6OcF9PnZ/d8NABYBWaG6IdwA==
X-Received: by 2002:a17:902:a589:b029:e9:21cc:4aac with SMTP id az9-20020a170902a589b02900e921cc4aacmr8410862plb.21.1617897142708;
        Thu, 08 Apr 2021 08:52:22 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id t24sm7377370pgi.30.2021.04.08.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:52:22 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:52:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Keqian Zhu <zhukeqian1@huawei.com>
Cc:     Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        wanghaibin.wang@huawei.com
Subject: Re: [RFC PATCH] KVM: x86: Support write protect huge pages lazily
Message-ID: <YG8mslDJU8Br1UCx@google.com>
References: <20200828081157.15748-1-zhukeqian1@huawei.com>
 <107696eb-755f-7807-a484-da63aad01ce4@huawei.com>
 <YGzxzsRlqouaJv6a@google.com>
 <4fb6a85b-d318-256f-b401-89c35086885c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb6a85b-d318-256f-b401-89c35086885c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021, Keqian Zhu wrote:
> Hi Ben,
> 
> Do you have any similar idea that can share with us?

Doh, Ben is out this week, he'll be back Monday.  Sorry for gumming up the works :-/
