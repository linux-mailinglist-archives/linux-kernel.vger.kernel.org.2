Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECE234687D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhCWTFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhCWTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:05:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F90FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:05:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g25so11704063wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zfTKyuyptfdK7Fjb1pdXihHAu9GKw1GPuZw+980nY/8=;
        b=iPKbGcVHzbVWxIhpBUXt727J3UEhP5SCCdIPcpdGuFZ5kOyS46/S4FJ6ZNlnaFFIUr
         gBlL5AybNZ7l6iIaIrvyeEU0tzH+xZa6I8CpjnoqtQS0rdpRTMONW9kBCEXXOwux0HMd
         HiZREmba6uMPpmhqKrbCJtafuPjADlX0nwFQDKRPtHd3/s0f6T+trHg6NgciXlLpj6Kb
         52f/Tt+8nj5XTysA3UJeJw2qkixBkuV6Ap5jbMsQF3nV0GWALtj0CgTj7waHCtQmOF8+
         A7AOVudgATxxVA9/AsyK0SWPiVLvINW2DtDFEFEomGqlff9VqzoDZBSPjMEWvXJdDBGy
         uiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zfTKyuyptfdK7Fjb1pdXihHAu9GKw1GPuZw+980nY/8=;
        b=FRQvryx7fLBerq4Le3TgCb0/3D5GrqBU8nekdEHghX66At7JmiV09M3gB8XKaHfUzV
         jr0LCvSOs1y6+4bIp67nL7SfHHDRID530aZkwq9E7axMscPPbPcCUpOl3dtMoELC/xM+
         rblIN+JymTiM5l6Td3BBj8jLtiZNT0VtOqIcPtfAEcbo0JVEBI5dVi+dNpslSGjlvLs8
         iYk0TQdrxLKjpNOPg0+sRLL2hgl4Rdm9symrEjteVss8utFs+DnAL/wAufqOKc6oEH3N
         W7J6Eg9DZjFvl3QRSnuCiQIFIBLirtfhZd6crLPkBrUE1UivUzKQpvz+KAb2bP9NJgUk
         C/Pw==
X-Gm-Message-State: AOAM5337T4232Pt6rE5WDZF2PaAY0C+41Nlx1JlCSEVIYjl8V+wej1W+
        RNvYpZOj6+VUW3/kB8V7+YU=
X-Google-Smtp-Source: ABdhPJwYRrRK6MbY08/6eajJTLh8jyOSH2/AUx6MVUzlpVGF//KLP6MAt+fCt1bU2Ravfvi/OrVTZA==
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr4732349wma.80.1616526307452;
        Tue, 23 Mar 2021 12:05:07 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id w6sm23880473wrl.49.2021.03.23.12.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 12:05:07 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] Revert "mremap: don't allow MREMAP_DONTUNMAP on
 special_mappings and aio"
To:     Brian Geffon <bgeffon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
References: <20210303175235.3308220-1-bgeffon@google.com>
 <20210323182520.2712101-1-bgeffon@google.com>
 <20210323182520.2712101-2-bgeffon@google.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <558d3b1d-b783-5368-8600-40568c434dcf@gmail.com>
Date:   Tue, 23 Mar 2021 19:05:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323182520.2712101-2-bgeffon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 6:25 PM, Brian Geffon wrote:
> This reverts commit cd544fd1dc9293c6702fab6effa63dac1cc67e99.
> 
> As discussed in [1] this commit was a no-op because the mapping type was
> checked in vma_to_resize before move_vma is ever called. This meant that
> vm_ops->mremap() would never be called on such mappings. Furthermore,
> we've since expanded support of MREMAP_DONTUNMAP to non-anonymous
> mappings, and these special mappings are still protected by the existing
> check of !VM_DONTEXPAND and !VM_PFNMAP which will result in a -EINVAL.
> 
> 1. https://lkml.org/lkml/2020/12/28/2340
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks,
Dmitry
