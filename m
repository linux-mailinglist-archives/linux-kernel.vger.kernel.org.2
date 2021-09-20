Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5D41179C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhITOyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhITOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:54:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322BBC061760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:52:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y4so14956249pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdz88Zm4WEbtE1IfyklsAUW4ocVL7dpB+GFzyMWI5t8=;
        b=M33vtkFMPqwGndSGqOqdjoHCy3S1jLV/tX2XnNLyBS+0H4jVlK9lVI3YrhmQ4d4nup
         Vw+PCLCxaj9UBZlGZYJdqxxJatED8c5WLkwLX4Qi/UZ1owSns9u7odq2cfEaHedow5GS
         gj8mzyAe2TCnhgAOwEYNhGTBdkuaDUD21+vfzZRrfCZhkV8BKQGZjiRyaWk6WHlaLsfs
         mEdq+tLZLLGcchVXg3etQJ7mkfphqY7w9h2DH/1eC+3jfbYABQWbCpKo3wgRlGs507HC
         gEy2HmQGeE07TuSbCiMrsOuYiC+V74g7Y4A2f56WhCc3z/52GL3sgJ64eWYFHTMPVchM
         IAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdz88Zm4WEbtE1IfyklsAUW4ocVL7dpB+GFzyMWI5t8=;
        b=6hMwPz3XrTzZVQ520cn00ltRbATq7LeHKiTBAeqp2Se7DESvTAF/XnM4jTDNJeG/h/
         bc7eHP1NTo2/yxH+EcqGZyFj48fn2ge/CQ1K4FQWKCjz75Prz4Gpd1Ov59RZfG+MBS4g
         CPT3xGwbiPYfDGFJOZZggUX1JRRGjEuVVXtZcyYRbGHbur0eUacGiE/7SggABFVl62Sp
         4XPakkTAabvglzTmq+I09vcVdRBV+wxxq2YSkVIGmYCjXKeLmzGPdrrWW3K12sicax1D
         fazf3SzCusegXUaYRnQFBwefU/Y7zPLc9biSONZkiRyblT/CnuvaKTLQq1/2uTIulApx
         +ZNQ==
X-Gm-Message-State: AOAM533e7zzTuu68bsLpKvDwEYLRlNURPGpcCdlhfWCR/iCoTPKetEQJ
        BUM/h5m23UVUZYCCuhVZUP+yJw==
X-Google-Smtp-Source: ABdhPJxJQJi29JAY+MdQUcy5gsI30oApdiOFCqybl1lekSxLJT+gjVoRTKIpclgf5g0aizfS8oEwPw==
X-Received: by 2002:a63:391:: with SMTP id 139mr23904978pgd.410.1632149566474;
        Mon, 20 Sep 2021 07:52:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x1sm15157247pfc.53.2021.09.20.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 07:52:45 -0700 (PDT)
Date:   Mon, 20 Sep 2021 14:52:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: nVMX: Fix nested bus lock VM exit
Message-ID: <YUigOQ6wL/NSXqjO@google.com>
References: <20210914095041.29764-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914095041.29764-1-chenyi.qiang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021, Chenyi Qiang wrote:
> Nested bus lock VM exits are not supported yet. If L2 triggers bus lock
> VM exit, it will be directed to L1 VMM, which would cause unexpected
> behavior. Therefore, handle L2's bus lock VM exits in L0 directly.
> 
> Fixes: fe6b6bc802b4 ("KVM: VMX: Enable bus lock VM exit")

Cc: stable@vger.kernel.org

> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
